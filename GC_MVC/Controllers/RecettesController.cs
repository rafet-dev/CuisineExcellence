using GC_MVC.Data;
using Microsoft.AspNetCore.Mvc;
using GC_MVC.Models;

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
            Recettes? recette = _context.Recettes.FirstOrDefault(recette => recette.id_recette == id);
            if (recette == null)
            {
                return NotFound();
            }
            return View(recette);
        }
    }
}