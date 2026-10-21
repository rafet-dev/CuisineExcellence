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

        public RecettesController(GCContext context, ILogger<RecettesController> logger)
        {
            _context = context;
            _logger = logger;
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
            if (ModelState.IsValid)
            {
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
                    // 1re boucle : vérifier que chaque catégorie existe dans PostgreSQL avant la transaction
                    foreach(int id_categorie in model.CategoriesSelectionnees)
                    {
                        bool categorieExiste = _context.Categories.Any(categorie => categorie.id_categorie == id_categorie);

                        if (!categorieExiste)
                        {
                            ModelState.AddModelError("CategoriesSelectionnees", "Une catégorie sélectionnée n'existe plus.");
                            model.CategoriesDisponibles = _context.Categories.ToList();
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
                
                try
                {
                    // préparation de la transaction pour valider l'ajout d'une nouvelle recette
                    transactionNouvelleRecette = _context.Database.BeginTransaction();
                    // Prépare l'insertion de la nouvelle recette.
                    _context.Recettes.Add(NouvelleRecette);
                    // Enregistre les modifications dans PostgreSQL, ici recette
                    _context.SaveChanges();

                    // 2nde boucle : créer les associations entre les catégories et la nouvelle recette pendant la transaction 
                    foreach(int id_categorie in model.CategoriesSelectionnees)
                    {
                        Categories_recettes NouvelleAssociation = new Categories_recettes
                        {
                            id_categorie = id_categorie,
                            id_recette = NouvelleRecette.id_recette
                        };

                        _context.Categories_recettes.Add(NouvelleAssociation);
                    }
                    // Enregistre les modifications dans PostgreSQL, ici categories                    
                    _context.SaveChanges();

                    transactionNouvelleRecette?.Commit();
                    TempData["MessageSucces"] = "Votre recette a bien été enregistrée !";
                    return RedirectToAction("Index", "Compte");
                }   
                
                catch (Exception ex)
                {
                      // Première erreur : l'enregistrement a échoué.
                    _logger.LogError(ex, "Erreur lors de la création d'une recette");

                    try
                    {
                        // On essaie d'annuler la transaction
                        transactionNouvelleRecette?.Rollback();
                    }

                    catch (Exception exRollback)
                    {
                        // Deuxième erreur : l'annulation a échoué.
                        _logger.LogError(exRollback, "Erreur lors de l'annulation");
                    }
                    
                    ViewData["ValidateMessage"] = "Une erreur est survenue lors de l'enregistrement de la recette. Veuillez réessayer.";
                    model.CategoriesDisponibles = _context.Categories.ToList();
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
                return View("~/Views/Recettes/CreerRecette.cshtml", model);
            }
        }
    }
}

