using GC_MVC.Models;
using GC_MVC.ViewModels;
using GC_MVC.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System.Security.Claims;

namespace GC_MVC.Controllers;

[Authorize]
public class CompteController : Controller
{
    // Service permettant d'accéder aux données des utilisateurs.
    private readonly UserService _userService;

    /// <summary>
    /// Constructeur du contrôleur.
    /// Le service est fourni par injection de dépendances.
    /// </summary>
    /// <param name="userService">
    /// Service de gestion des utilisateurs.
    /// </param>
    public CompteController (UserService userService)
    {
        _userService = userService;
    }

    /// <summary>
    /// Récupère les informations du compte de l'utilisateur connecté.
    /// </summary>
    /// <returns>
    /// Les informations du compte ou une réponse HTTP adaptée si l'utilisateur ne peut pas être identifié.
    /// </returns>
    public IActionResult Index()
    {
        // Récupération de l'identifiant de l'utilisateur stocké dans les claims lors de sa connexion.
        string? utilisateurId = User.FindFirstValue(ClaimTypes.NameIdentifier);

        // Conversion de l'identifiant en entier : Si la conversion échoue, l'accès est refusé.
        if (!int.TryParse(utilisateurId, out int id))
        {
            return Unauthorized();
        }        
        
        // Recherche de l'utilisateur dans PostgreSQL à partir de l'identifiant de sa session.
        Utilisateurs? utilisateur = _userService.GetUserById(id);

        // Si aucun utilisateur ne répond à cet identifiant : reponse 404
        if (utilisateur == null)
        {
            return NotFound();
        }
        
       // Préparation des données destinées à la vue Razor. Seules les infos nécessaires sont transmises.
       CompteViewModel model = new CompteViewModel
       {
           IdUtilisateur = utilisateur.id_utilisateur,
           Identifiant = utilisateur.identifiant,
           Email = utilisateur.email
       };

       // Transmission du viewModel à la vue
       return View(model);
    }
}
