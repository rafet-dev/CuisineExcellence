using Microsoft.AspNetCore.Mvc;

namespace GC_MVC.Controllers;

public class ConnexionController : Controller
{
    public IActionResult Index()
    {
        return View();
    }
}