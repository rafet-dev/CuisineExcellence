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
    public IActionResult Index(string? terme)
    {   
        List<Recettes> recettes = new List<Recettes>();
        // Vérifie que l'utilisateur a saisi un terme de recherche. La condition est fausse si "terme" est null, vide
        // ou contient uniquement des espaces.
        if (!string.IsNullOrWhiteSpace(terme))
        {   
            // Recherche dans la table Recettes de PostgreSQL.
            // Where() filtre les recettes selon une condition & r représente chaque recette examinée.
            // Contains(terme) vérifie si le nom contient le texte recherché.
            // ToList() exécute la requête et récupère les résultats sous forme d'une liste d'objets Recettes.
            // EF.Functions.ILike() = permet de rendre la recherche insensible à la casse.
            recettes = _context.Recettes
                    .Where(r => EF.Functions.ILike(r.nom, $"%{terme}%"))
                    .ToList();
        }
        // Transmet la liste des recettes à la vue Razor.
        return View(recettes);
    }

}