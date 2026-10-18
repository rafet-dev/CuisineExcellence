using System.ComponentModel.DataAnnotations;
namespace GC_MVC.ViewModels;

public class InscriptionViewModel
{
    public required string Email { get; set; }
    public required string Identifiant { get; set; }
    public required string MotDePasse { get; set; }
    [Required(ErrorMessage = "Veuillez confirmer votre mot de passe.")]
    [Compare("MotDePasse", ErrorMessage = "Les mots de passe ne correspondent pas.")]
    public required string ConfirmationMotDePasse { get; set; } = string.Empty;
}