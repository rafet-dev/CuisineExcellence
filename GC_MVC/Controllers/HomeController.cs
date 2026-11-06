using Microsoft.AspNetCore.Mvc;
using GC_MVC.Data;
using GC_MVC.Models;

namespace GC_MVC.Controllers;

public class HomeController : Controller
{
    private readonly GCContext _context;
    public HomeController(GCContext context)
    {
        _context = context;
    }
    
    public IActionResult Index()
    {
        List<int> recettesALaUne = new List<int> { 6, 8, 17 };

        List<Recettes> recettes = _context.Recettes
            .OrderByDescending(r => r.id_recette)
            .Where(r => recettesALaUne.Contains(r.id_recette))
            .Take(3)
            .ToList();

        return View(recettes);
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