using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using GC_MVC.ViewModels;
using GC_MVC.Services;
using System.Security.Claims;
using GC_MVC.Models;

namespace GC_MVC.Controllers;

public class AccessController : Controller
{
    private readonly UserService _userService;
   
    public AccessController(IConfiguration configuration)
    {
        _userService = new UserService(configuration);
    }

    [HttpGet]
    public IActionResult Inscription()
    {
        return View("~/Views/Inscription/Index.cshtml");
    }
    [HttpPost]
    [ValidateAntiForgeryToken]
    public IActionResult Inscription([FromForm] InscriptionViewModel model)
    {
        if (!ModelState.IsValid)
        {
            ViewData["ValidateMessage"] = "Les données saisies ne sont pas valides.";
            return View("~/Views/Inscription/Index.cshtml", model);
        }

        if (_userService.EmailExists(model.Email))
        {
            ViewData["ValidateMessage"] = "Cet email est déjà utilisé.";
            return View("~/Views/Inscription/Index.cshtml", model);
        }

        int userId;
        if (!_userService.CreateUser(model, out userId))
        {
            ViewData["ValidateMessage"] = "Erreur lors de l'inscription. Veuillez réessayer.";
            return View("~/Views/Inscription/Index.cshtml", model);
        }

        TempData["ValidateMessage"] = "Inscription réussie ! Vous pouvez maintenant vous connecter à votre compte GC.";
        return RedirectToAction(nameof(Connexion));
    }

    [HttpGet]
    public IActionResult Connexion()
    {
        return View("~/Views/Connexion/Index.cshtml");
    }

    [HttpPost]
    [ValidateAntiForgeryToken]
    public async Task<IActionResult> Connexion([FromForm] ConnexionViewModel model)
    {
        if (!ModelState.IsValid)
        {
            ViewData["ValidateMessage"] = "Identifiant, adresse e-mail ou mot de passe erroné.";
            return View("~/Views/Connexion/Index.cshtml", model);
        }

        Utilisateurs? user = _userService.GetUserByIdentifiantOuEmail(model.IdentifiantOuEmail);

        if (user == null)
        {
            ViewData["ValidateMessage"] = "Identifiant, adresse e-mail ou mot de passe erroné.";
            return View("~/Views/Connexion/Index.cshtml", model);
        }

        var passwordHasher = new PasswordHasher<string>();
        var result = passwordHasher.VerifyHashedPassword( user.identifiant, user.password, model.MotDePasse);

        if (result == PasswordVerificationResult.Failed)
        {
            ViewData["ValidateMessage"] = "Identifiant, adresse e-mail ou mot de passe erroné.";
            return View("~/Views/Connexion/Index.cshtml", model);
        }

        var claims = new List<Claim>
        {
            new Claim(ClaimTypes.Email, user.email),
            new Claim(ClaimTypes.NameIdentifier, user.id_utilisateur.ToString())
        };

        var claimsIdentity = new ClaimsIdentity(claims, CookieAuthenticationDefaults.AuthenticationScheme);
        var authProperties = new AuthenticationProperties { AllowRefresh = true };

        await HttpContext.SignInAsync(
            CookieAuthenticationDefaults.AuthenticationScheme,
            new ClaimsPrincipal(claimsIdentity),
            authProperties);

       if (Request.Form.TryGetValue("ReturnURL", out var returnUrl)
            && Url.IsLocalUrl(returnUrl.ToString()))
        {
            return LocalRedirect(returnUrl.ToString());
        }

        return RedirectToAction("Index", "Compte");
    }
    
    [Authorize]
    [HttpPost]
    [ValidateAntiForgeryToken]
    public async Task<IActionResult> Deconnexion()
    {
        await HttpContext.SignOutAsync(
            CookieAuthenticationDefaults.AuthenticationScheme
        );

        return RedirectToAction(nameof(Connexion));
    }
}