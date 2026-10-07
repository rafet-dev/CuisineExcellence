using Microsoft.AspNetCore.Mvc;

namespace GC_MVC.Controllers;

public class AccueilActualiteController : Controller
{
    public IActionResult Index()
    {
        return View();
    }

}
