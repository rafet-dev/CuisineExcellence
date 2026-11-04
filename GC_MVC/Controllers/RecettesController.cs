using GC_MVC.Data;
using Microsoft.AspNetCore.Mvc;
using GC_MVC.Models;
using GC_MVC.ViewModels;
using Microsoft.AspNetCore.Authorization;
using System.Security.Claims;
using Microsoft.EntityFrameworkCore.Metadata.Internal;
using Microsoft.EntityFrameworkCore.Storage;
using System.Security.Cryptography;
using Npgsql;

namespace GC_MVC.Controllers
{
    public class RecettesController : Controller
    {
        private readonly GCContext _context;
        private readonly ILogger<RecettesController> _logger;
        private readonly IWebHostEnvironment _environment;

        public RecettesController(GCContext context, ILogger<RecettesController> logger, IWebHostEnvironment environment)
        {
            _context = context;
            _logger = logger;
            _environment = environment;
        }

        public IActionResult Detail(int id)
        {
            // Recherche la recette avec son id.
            Recettes? recette = _context.Recettes.FirstOrDefault(recette => recette.id_recette == id);
            if (recette == null)
            {
                return NotFound();
            }
            
            // Recherche l'utilisateur ayant créé la recette.
            Utilisateurs? createur = _context.Utilisateurs.FirstOrDefault(utilisateur => utilisateur.id_utilisateur == recette.createur);

            // Recherche les ingrédients de la recette concernée.
            List<IngredientQuantiteViewModel> ingredients = (
                from ingredient in _context.Ingredients
                join association in _context.Ingredients_Recettes
                on ingredient.id_ingredient equals association.id_ingredient
                where association.id_recette == id
                
                select new IngredientQuantiteViewModel
                {
                    Nom = ingredient.nom,
                    Quantite = association.quantite
                }
            ).ToList();

            List<Etapes> etapes = (
                from etape in _context.Etapes
                where etape.id_recette == id
                orderby etape.numero_etape 

                select etape
                 
            ).ToList();

            List<AvisUtilisateurViewModel> avisUtilisateurs = (
                from avis in _context.Avis
                join utilisateurs in _context.Utilisateurs
                on avis.id_utilisateur equals utilisateurs.id_utilisateur
                where avis.id_recette == id

                select new AvisUtilisateurViewModel
                {
                    Pseudo = utilisateurs.identifiant,
                    Note = avis.note,
                    Commentaire = avis.commentaire
                }
            ).ToList();

            double moyenne = 0;

            if (avisUtilisateurs.Count > 0)
            {
                moyenne = avisUtilisateurs.Average(avis => avis.Note);
            }

             // Regroupe les données récupérées pour les transmettre à la vue.
            RecetteDetailViewModel vm = new RecetteDetailViewModel
            {
                Recette = recette, // je donne à la propriété Recette la valeur de la variable recette.
                Createur = createur,
                Ingredients = ingredients,
                // Ingredients : la propriété de notre classe RecetteDetailViewModel.
                // ingredients : la variable locale contenant les résultats de notre requête LINQ.
                Etapes = etapes,
                Avis = avisUtilisateurs,
                Moyenne = moyenne
            };
            return View(vm);
        }

        [Authorize]
        public IActionResult MesRecettes()
        {
            string? utilisateurId = User.FindFirstValue(ClaimTypes.NameIdentifier);

            if(!int.TryParse(utilisateurId, out int id))
            {
                return Unauthorized();
            }

            List<Recettes> mesRecettes = _context.Recettes
                        .Where(recette => recette.createur == id)
                        .ToList();

            return View(mesRecettes);
        }
        
        [Authorize] // Autorise uniquement les utilisateurs connectés.
        [HttpGet] // Indique que cette action répond aux requêtes HTTP GET.
        public IActionResult CreerRecette()
        {
            // Création d'une nouvelle instance du ViewModel de création de recette.
            RecetteCreationViewModel model = new RecetteCreationViewModel();
            // Récupère toutes les catégories enregistrées dans la base de données.
            List<Categories> categories = _context.Categories.ToList();
            // Affecte les catégories récupérées depuis la BDD au ViewModel.
            model.CategoriesDisponibles = categories;

            List<Ingredients> ingredients = _context.Ingredients.ToList();
            model.IngredientsDisponibles = ingredients;

            // Affiche la vue CreerRecette.cshtml.
            return View("CreerRecette", model); 
        }

        [ValidateAntiForgeryToken]
        [Authorize]
        [HttpPost]
        public IActionResult CreerRecette(RecetteCreationViewModel model)
        {
            // vérification de la présence et de la taille du fichier
            if (model.PhotoFichier is not null)
            {
                const long TailleMaximale = 5 * 1024 * 1024;

                string Extension = Path.GetExtension(model.PhotoFichier.FileName).ToLowerInvariant();

                string[] ExtensionsAutorisees =
                {
                    ".jpg",
                    ".jpeg",
                    ".png",
                    ".webp"
                };

                string[] TypesAutorises =
                {
                    "image/jpeg",
                    "image/png",
                    "image/webp"
                };

                if (model.PhotoFichier.Length == 0 ||
                    model.PhotoFichier.Length > TailleMaximale)
                {
                    ModelState.AddModelError(
                        "PhotoFichier",
                        "L'image doit avoir une taille supérieure à 0 et ne pas dépasser 5 Mo."
                    );
                }

                if (!ExtensionsAutorisees.Contains(Extension))
                {
                    ModelState.AddModelError(
                        "PhotoFichier",
                        "Seules les images JPG, PNG et WebP sont autorisées."
                    );
                }

                if (!TypesAutorises.Contains(model.PhotoFichier.ContentType))
                {
                    ModelState.AddModelError(
                        "PhotoFichier",
                        "Le type de fichier sélectionné n'est pas autorisé."
                    );
                }

                if (model.PhotoFichier.Length > 0 && model.PhotoFichier.Length < 12)
                {
                    ModelState.AddModelError(
                        "PhotoFichier",
                        "Le fichier est trop court pour être une image valide."
                    );
                }
                else if (model.PhotoFichier.Length >= 12 && model.PhotoFichier.Length <= TailleMaximale)
                {
                    using Stream FluxImage = model.PhotoFichier.OpenReadStream();

                    byte[] Signature = new byte[12];
                    FluxImage.ReadExactly(Signature);

                    byte[] SignaturePNG =
                    {
                        0x89, 0x50, 0x4E, 0x47,
                        0x0D, 0x0A, 0x1A, 0x0A
                    };

                    bool EstPNG = Signature.Take(8).SequenceEqual(SignaturePNG);
                    bool EstJPEG = Signature[0] == 0xFF && Signature[1] == 0xD8 && Signature[2] == 0xFF;

                    byte[] DebutWebP = Signature.Take(4).ToArray();
                    byte[] FinWebP = Signature.Skip(8).Take(4).ToArray();
                    bool EstRIFF = DebutWebP.SequenceEqual(System.Text.Encoding.ASCII.GetBytes("RIFF"));
                    bool EstWEBP = FinWebP.SequenceEqual(System.Text.Encoding.ASCII.GetBytes("WEBP") );
                    bool EstWebP = EstRIFF && EstWEBP;

                    bool PNGValide = Extension == ".png"
                    && model.PhotoFichier.ContentType == "image/png"
                    && EstPNG;

                    bool JPEGValide = (Extension == ".jpg" || Extension == ".jpeg")
                    && model.PhotoFichier.ContentType == "image/jpeg"
                    && EstJPEG;

                    bool WebPValide = Extension == ".webp"
                    && model.PhotoFichier.ContentType == "image/webp"
                    && EstWebP;

                    bool ImageValide = PNGValide || JPEGValide || WebPValide;

                    if (!ImageValide)
                    {
                        ModelState.AddModelError(
                            "PhotoFichier",
                            "La signature du fichier ne correspond pas à un format d'image autorisé."
                        );
                    }
                }
            }

            if (ModelState.IsValid)
            {
                // création du chemin d'enregistrement de l'image
                string CheminWebRoot = _environment.WebRootPath;
                Console.WriteLine("Dossier wwwroot utilisé : " + CheminWebRoot);

                string CheminDossier = Path.Combine(
                    CheminWebRoot,
                    "img",
                    "recettes"
                );

                string? NomFichier = null;
                string? CheminFichier = null;

                if (model.PhotoFichier is not null)
                {
                    string Extension = Path.GetExtension(model.PhotoFichier.FileName).ToLowerInvariant();
                    NomFichier = Guid.NewGuid().ToString() + Extension;
                }

                // Création d'une nouvelle recette
                Recettes NouvelleRecette = new Recettes();
                // Récupération du nom depuis le ViewModel
                NouvelleRecette.nom = model.Nom;

                // Convertit les minutes saisies en durée TimeSpan
                NouvelleRecette.temps_preparation = TimeSpan.FromMinutes(model.TempsPreparation);
                NouvelleRecette.temps_cuisson = TimeSpan.FromMinutes(model.TempsCuisson);

                NouvelleRecette.difficulte = model.Difficulte;
                // Récupère le nombre de personnes prévu pour la recette.
                NouvelleRecette.nombre_personnes = model.NombrePersonnes;

                // OBJ : Récupérer l'identifiant du créateur depuis les informations de l'utilisateur authentifié côté serveur.
                string? IdentifiantUtilisateur = User.FindFirst(ClaimTypes.NameIdentifier)?.Value;
                bool ConversionReussie = int.TryParse(IdentifiantUtilisateur, out int IdCreateur);

                if (ConversionReussie)
                {
                    // Associe la recette à l'utilisateur authentifié.
                    NouvelleRecette.createur = IdCreateur;
                }

                else
                {
                    // Interrompt le traitement si l'identifiant est invalide.
                    return Unauthorized();
                }

                try
                {
                    // 1-1 boucle : vérifier que chaque catégorie existe dans PostgreSQL avant la transaction
                    foreach(int id_categorie in model.CategoriesSelectionnees)
                    {
                        bool categorieExiste = _context.Categories.Any(categorie => categorie.id_categorie == id_categorie);

                        if (!categorieExiste)
                        {
                            ModelState.AddModelError("CategoriesSelectionnees", "Une catégorie sélectionnée n'existe plus.");
                            model.CategoriesDisponibles = _context.Categories.ToList();
                            model.IngredientsDisponibles = _context.Ingredients.ToList();
                            return View("CreerRecette", model);
                        } 
                    }

                    // 2-1 boucle : vérifier que chaque ingrédient existe dans PostgreSQL avant la transaction
                    foreach (IngredientRecetteViewModel ingredient in model.IngredientsSelectionnes)
                    {
                        bool ingredientExiste = _context.Ingredients.Any(
                            ingredientBDD => ingredientBDD.id_ingredient == ingredient.IdIngredient
                        );

                        if (!ingredientExiste)
                        {
                            ModelState.AddModelError("IngredientsSelectionnes", "Un ingrédient sélectionné n'existe plus.");
                            model.CategoriesDisponibles = _context.Categories.ToList();
                            model.IngredientsDisponibles = _context.Ingredients.ToList();

                            return View("CreerRecette", model);
                        }
                    }
                }

                catch(NpgsqlException ex)
                {
                    _logger.LogError(ex, "une erreur PostreSQL est survenue."); 
                    Response.StatusCode = 500;
                    return View("~/Views/Shared/ServiceIndisponible.cshtml");
                }

                catch (Exception ex)
                {
                    _logger.LogError(ex, "Erreur lors de la vérification des catégories");
                    Response.StatusCode = 500;
                    return View("~/Views/Shared/ServiceIndisponible.cshtml");

                }
                
                IDbContextTransaction? transactionNouvelleRecette = null;
                bool CommitTente = false;
                
                try
                {
                    // Création du dossier des images si nécessaire
                    Directory.CreateDirectory(CheminDossier);

                    if (NomFichier is not null && model.PhotoFichier is not null)
                    {
                        CheminFichier = Path.Combine(CheminDossier, NomFichier);
                        using (FileStream FluxFichier = new FileStream(CheminFichier, FileMode.CreateNew))
                        {
                            model.PhotoFichier.CopyTo(FluxFichier);
                        }

                        NouvelleRecette.photo = NomFichier;
                    }

                    // préparation de la transaction pour valider l'ajout d'une nouvelle recette
                    transactionNouvelleRecette = _context.Database.BeginTransaction();
                    // Prépare l'insertion de la nouvelle recette.
                    _context.Recettes.Add(NouvelleRecette);
                    // Enregistre les modifications dans PostgreSQL, ici recette
                    _context.SaveChanges();

                    // 1-2 boucle : créer les associations entre les catégories et la nouvelle recette pendant la transaction 
                    foreach(int id_categorie in model.CategoriesSelectionnees)
                    {
                        Categories_recettes NouvelleAssociation = new Categories_recettes
                        {
                            id_categorie = id_categorie,
                            id_recette = NouvelleRecette.id_recette
                        };

                        _context.Categories_recettes.Add(NouvelleAssociation);
                    }

                    // boucle 2-2 : Associations entre les ingrédients et la recette
                    foreach (IngredientRecetteViewModel ingredient in model.IngredientsSelectionnes)
                    {
                        Ingredients_recettes NouvelleAssociationIngredient = new Ingredients_recettes
                        {
                            id_ingredient = ingredient.IdIngredient,
                            id_recette = NouvelleRecette.id_recette,
                            quantite = ingredient.Quantite
                        };

                        _context.Ingredients_Recettes.Add(NouvelleAssociationIngredient);
                    }

                    // Enregistrement des étapes de préparation
                    for (int i = 0; i < model.Etapes.Count; i++)
                    {
                        Etapes NouvelleEtape = new Etapes
                        {
                            id_recette = NouvelleRecette.id_recette,
                            numero_etape = i + 1,
                            texte = model.Etapes[i]
                        };

                        _context.Etapes.Add(NouvelleEtape);
                    }
                    // Enregistre les modifications dans PostgreSQL, ici categories                    
                    _context.SaveChanges();
                
                    CommitTente = true;
                    transactionNouvelleRecette?.Commit();
                    TempData["MessageSucces"] = "Votre recette a bien été enregistrée !";
                    return RedirectToAction("Index", "Compte");
                }   
                
                catch (Exception ex)
                {
                      // Première erreur : l'enregistrement a échoué.
                    _logger.LogError(ex, "Erreur lors de la création d'une recette");

                    bool AnnulationReussie = false;

                    try
                    {
                        if (transactionNouvelleRecette is not null)
                        {
                            transactionNouvelleRecette.Rollback();
                            AnnulationReussie = true;
                        }
                    }
                    catch (Exception exRollback)
                    {
                        _logger.LogError(exRollback, "Erreur lors de l'annulation");
                    }

                    try
                    {
                        if (!CommitTente
                            && (transactionNouvelleRecette is null || AnnulationReussie)
                            && CheminFichier is not null
                            && System.IO.File.Exists(CheminFichier))
                        {
                            System.IO.File.Delete(CheminFichier);
                        }
                    }
                    catch (Exception exSuppression)
                    {
                        _logger.LogError(exSuppression, "Erreur lors de la suppression de la photo");
                    }
                                        
                    ViewData["ValidateMessage"] = "Une erreur est survenue lors de l'enregistrement de la recette. Veuillez réessayer.";
                    model.CategoriesDisponibles = _context.Categories.ToList();
                    model.IngredientsDisponibles = _context.Ingredients.ToList();
                    return View("CreerRecette", model);
                }

                finally
                {
                    // libère les ressources de la transaction 
                    transactionNouvelleRecette?.Dispose();
                }                  
            }
            else
            {
                ViewData["ValidateMessage"] = "La recette n'est pas valide.";
                model.CategoriesDisponibles = _context.Categories.ToList();
                model.IngredientsDisponibles = _context.Ingredients.ToList();
                return View("~/Views/Recettes/CreerRecette.cshtml", model);
            }
        }

        [Authorize]
        [HttpGet]
        public IActionResult ModifierRecette(int id)
        {
            // Recherche de la recette à modifier.
            Recettes? recette = _context.Recettes.FirstOrDefault(r => r.id_recette == id);

            // Vérifie que la recette existe.
            if (recette == null)
            {
                return NotFound();
            }

            // Récupère l'identifiant de l'utilisateur connecté.
            string? utilisateurId = User.FindFirstValue(ClaimTypes.NameIdentifier);

            if (!int.TryParse(utilisateurId, out int idUtilisateur))
            {
                return Unauthorized();
            }

            // Vérifie que l'utilisateur est bien le créateur.
            if (recette.createur != idUtilisateur)
            {
                return Forbid();
            }
            
            RecetteCreationViewModel model = new RecetteCreationViewModel();

            model.IdRecette = recette.id_recette;
            model.Nom = recette.nom;
            model.TempsPreparation = (int) recette.temps_preparation.TotalMinutes;
            model.TempsCuisson = (int) recette.temps_cuisson.TotalMinutes;
            model.Difficulte = recette.difficulte;

            if (recette.nombre_personnes == null)
            {
                model.NombrePersonnes = 1;
            }
            else
            {
                model.NombrePersonnes = recette.nombre_personnes.Value;
            }

            List<int> mesCategoriesRecettes = (
                from association in _context.Categories_recettes
                where association.id_recette == id
                select association.id_categorie
            ).ToList();

            model.CategoriesSelectionnees = mesCategoriesRecettes;

            List<Categories> categories = _context.Categories.ToList();
            model.CategoriesDisponibles = categories;

            List<Ingredients> ingredients = _context.Ingredients.ToList();
            model.IngredientsDisponibles = ingredients;

            List<IngredientRecetteViewModel> mesIngredientsRecette = (
                from association in _context.Ingredients_Recettes
                where association.id_recette == id
                select new IngredientRecetteViewModel
                {
                    IdIngredient = association.id_ingredient,
                    Quantite = association.quantite
                }
            ).ToList();

            model.IngredientsSelectionnes = mesIngredientsRecette;

            // Le formulaire de modification sera ajouté ensuite.
            return View("ModifierRecette", model);
        }

        [Authorize]
        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult ModifierRecette(int id, RecetteCreationViewModel model)
        {
            Recettes? recette = _context.Recettes.FirstOrDefault(r => r.id_recette == id);

            if (recette is null)
            {
                return NotFound();
            }

            string? utilisateurId = User.FindFirstValue(ClaimTypes.NameIdentifier);

            if (!int.TryParse(utilisateurId, out int idUtilisateur))
            {
                return Unauthorized();
            }

            if (recette.createur != idUtilisateur)
            {
                return Forbid();
            }

            // Vérification de la présence d'au moins une catégorie
            if (model.CategoriesSelectionnees == null || model.CategoriesSelectionnees.Count == 0)
            {
                ModelState.AddModelError(
                    "CategoriesSelectionnees",
                    "Veuillez sélectionner au moins une catégorie."
                );
            }

            // Vérification de la présence d'au moins un ingrédient
            if (model.IngredientsSelectionnes == null || model.IngredientsSelectionnes.Count == 0)
            {
                ModelState.AddModelError(
                    "IngredientsSelectionnes",
                    "Veuillez sélectionner au moins un ingrédient."
                );
            }

            if (!ModelState.IsValid)
            {
                model.CategoriesDisponibles = _context.Categories.ToList();
                model.IngredientsDisponibles = _context.Ingredients.ToList();

                return View("ModifierRecette", model);
            }

            // Vérification de l'existence des catégories
            foreach (int idCategorie in model.CategoriesSelectionnees!)
            {
                bool categorieExiste = _context.Categories.Any(
                    categorie => categorie.id_categorie == idCategorie
                );

                if (!categorieExiste)
                {
                    ModelState.AddModelError("CategoriesSelectionnees", "Une catégorie sélectionnée n'existe plus.");

                        model.CategoriesDisponibles = _context.Categories.ToList();
                        model.IngredientsDisponibles = _context.Ingredients.ToList();

                        return View("ModifierRecette", model);
                }
            }

            foreach (IngredientRecetteViewModel ingredient in model.IngredientsSelectionnes!)
            {
                bool ingredientExiste = _context.Ingredients.Any(
                    ingredientBDD => ingredientBDD.id_ingredient == ingredient.IdIngredient
                );

                if (!ingredientExiste)
                {
                    ModelState.AddModelError("IngredientsSelectionnes", "Un ingrédient sélectionné n'existe plus.");

                        model.CategoriesDisponibles = _context.Categories.ToList();
                        model.IngredientsDisponibles = _context.Ingredients.ToList();

                        return View("ModifierRecette", model);
                    }
                }

            IDbContextTransaction? transactionModificationRecette = null;

            try
            {
                // début de la transaction de modification d'une recette
                transactionModificationRecette = _context.Database.BeginTransaction();
                
                // 1. modification des propriétés de la recette
                recette.nom = model.Nom;
                recette.difficulte = model.Difficulte;
                recette.nombre_personnes = model.NombrePersonnes;
                recette.temps_preparation = TimeSpan.FromMinutes(model.TempsPreparation);
                recette.temps_cuisson = TimeSpan.FromMinutes(model.TempsCuisson);

                // récupération des anciennes associations
                List<Categories_recettes> anciennesAssociations = _context.Categories_recettes
                    .Where(association => association.id_recette == id)
                    .ToList();

                // supprimer les anciennes associations
                _context.Categories_recettes.RemoveRange(anciennesAssociations);

                // Enregistrer les suppressions
                _context.SaveChanges();

                // création des nouvelles associations
                foreach(int idCategorie in model.CategoriesSelectionnees)
                {
                    Categories_recettes nouvelleAssociation = new Categories_recettes
                    {
                        id_recette = id,
                        id_categorie = idCategorie,
                    };
                    
                    // Ajout de la nouvelle association
                    _context.Categories_recettes.Add(nouvelleAssociation);
                }

                // 2. Récupération des anciennes associations d'ingrédients
                List<Ingredients_recettes> anciensIngredients = _context.Ingredients_Recettes
                    .Where(association => association.id_recette == id)
                    .ToList();

                // Suppression des anciennes associations
                _context.Ingredients_Recettes.RemoveRange(anciensIngredients);

                // Enregistrement des suppressions
                _context.SaveChanges(); 

                // Création des nouvelles associations d'ingrédients
                foreach (IngredientRecetteViewModel ingredient in model.IngredientsSelectionnes!)
                {
                    Ingredients_recettes nouvelleAssociationIngredient = new Ingredients_recettes
                    {
                        id_ingredient = ingredient.IdIngredient,
                        id_recette = id,
                        quantite = ingredient.Quantite
                    };

                    _context.Ingredients_Recettes.Add(nouvelleAssociationIngredient);
                }

                // Enregistrement des nouvelles associations
                _context.SaveChanges();

                // Validation de la transaction
                transactionModificationRecette.Commit();

                // Redirection vers la recette modifiée
                return RedirectToAction("Detail", new { id = id });
            }

            catch (Exception ex)
            {
                // Journalisation de l'erreur initiale
                _logger.LogError(ex, "Erreur lors de la modification d'une recette.");

                try
                {
                    // Tentative d'annulation de la transaction
                    transactionModificationRecette?.Rollback();
                }
                catch (Exception exRollback)
                {
                    // Journalisation d'une éventuelle erreur d'annulation
                    _logger.LogError(exRollback, "Erreur lors de l'annulation");
                }

                return StatusCode(500, "Une erreur est survenue lors de la modification de la recette.");
            }

            finally
            {
                transactionModificationRecette?.Dispose();
            }
        }  
    }
}


