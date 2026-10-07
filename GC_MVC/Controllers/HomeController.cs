using Microsoft.AspNetCore.Mvc;

namespace GC_MVC.Controllers;

public class HomeController : Controller
{
    public IActionResult Index()
    {
        return View();
    }

}


 
/*

private readonly string _connexionString;

    public HomeController(IConfiguration configuration)
    {
        _connexionString = configuration.GetConnectionString("GestionBibliotheque")!;

        if (_connexionString == null)
        {
            throw new Exception("Error : Connexion string not found ! ");
        }
    }

    */