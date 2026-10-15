using Microsoft.EntityFrameworkCore;
using Microsoft.AspNetCore.Mvc;
using GC_MVC.Data;
using GC_MVC.Models;

//GCContext représente notre contexte Entity Framework Core.
// _context permettra d'accéder aux tables de PostgreSQL.
// Le constructeur reçoit automatiquement une instance de GCContext grâce à l'injection de dépendances configurée 
// dans ASP.NET Core.
namespace GC_MVC.Controllers;

public class RechercheController : Controller
{
    private readonly GCContext _context;
    
    public RechercheController (GCContext context)
    {
        _context = context;
    }
    // méthode pour afficher la page de recherche
    public IActionResult Index(string? terme, int? categorie)
    {   
        IQueryable<Recettes> requete = _context.Recettes.AsQueryable();
        ViewBag.RechercheEffectuee = !string.IsNullOrWhiteSpace(terme) || categorie != null;

        if (!string.IsNullOrWhiteSpace(terme))
        {
            requete = requete.Where(r =>
                EF.Functions.ILike(r.nom, $"%{terme}%"));
        }

        if (categorie != null)
        {
            requete = requete.Where(r =>
                _context.Categories_recettes.Any(cr =>
                    cr.id_recette == r.id_recette &&
                    cr.id_categorie == categorie));
        }

        List<Recettes> recettes = requete.ToList();
        List<Categories> categories = _context.Categories.ToList();
        ViewBag.Categories = categories;
        // Transmet la liste des recettes à la vue Razor.
        return View(recettes);
    }

    // méthode pour répondre aux requetes Fetch
    public IActionResult Resultats(string? terme, int? categorie)
    {
        IQueryable<Recettes> requete = _context.Recettes.AsQueryable();

        if (!string.IsNullOrWhiteSpace(terme))
        {
            requete = requete.Where(r => EF.Functions.ILike(r.nom, $"%{terme}%"));
        }

        if(categorie != null)
        {
            requete = requete.Where(r =>
             _context.Categories_recettes.Any(cr =>
                cr.id_recette == r.id_recette &&
                cr.id_categorie == categorie));
        }

        List<Recettes> recettes = requete.ToList();
        return Json(recettes);
    }

}