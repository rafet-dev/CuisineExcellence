using Microsoft.AspNetCore.Mvc;

namespace GC_MVC.Controllers;

public class AccueilRecetteController : Controller
{
    public IActionResult Index()
    {
        return View();
    }

}
