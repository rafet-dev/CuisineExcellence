using GC_MVC.Data;
using Microsoft.AspNetCore.Mvc;
using GC_MVC.Models;
using GC_MVC.ViewModels;

namespace GC_MVC.Controllers
{
    public class RecettesController : Controller
    {
        private readonly GCContext _context;

        public RecettesController(GCContext context)
        {
            _context = context;
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
    }
}

