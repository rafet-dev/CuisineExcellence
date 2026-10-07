using Microsoft.AspNetCore.Mvc;

namespace GC_MVC.Controllers;

public class SaisonController : Controller
{
    public IActionResult Index()
    {
        return View();
    }
}