using GC_MVC.Data;
using Microsoft.AspNetCore.Mvc;
using GC_MVC.Models;

namespace GC_MVC.Controllers
{
    public class CategoriesController : Controller
    {
        private readonly GCContext _context;

        public CategoriesController(GCContext context)
        {
            _context = context;
        }
        public IActionResult Index()
        {
            List<Categories> categories = _context.Categories.ToList();
            
            return View(categories);
        }

        public IActionResult Recettes(int id)
        {
            // Récupère les associations appartenant à la catégorie sélectionnée.
            List<Categories_recettes> associations = _context.Categories_recettes
                .Where(cr => cr.id_categorie == id)
                .ToList();

            // Jointure entre recettes et categories_recettes. On relie les deux tables grâce à id_recette.
            List<Recettes> recettes =
            (
                from recette in _context.Recettes
                join association in _context.Categories_recettes
                    on recette.id_recette equals association.id_recette

                // On garde uniquement les recettes appartenant à la catégorie sélectionnée.
                where association.id_categorie == id

                // On retourne les objets Recettes trouvés.
                select recette
            ).ToList();

            return View(recettes);
        }      
    }
}

