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
    }
}

