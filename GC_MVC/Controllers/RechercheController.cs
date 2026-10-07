using Microsoft.AspNetCore.Mvc;

namespace GC_MVC.Controllers;

public class RechercheController : Controller
{
    public IActionResult Index()
    {
        return View();
    }

}