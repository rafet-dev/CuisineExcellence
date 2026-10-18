namespace GC_MVC.ViewModels;

/// <summary>
/// Représente les informations du compte utilisateur destinées à être affichées dans la vue Razor.
/// Objectif : séparer les deux responsabilités : 
/// Utilisateurs représente les données provenant de PostgreSQL
/// CompteViewModel représente les informations nécessaires à l'affichage du compte
/// </summary>
public class CompteViewModel
{
    /// <summary>
    /// Identifiant unique de l'utilisateur en base de données.
    /// </summary>
    public int IdUtilisateur { get; set; }

    /// <summary>
    /// Nom d'utilisateur choisi lors de l'inscription.
    /// </summary>
    public string Identifiant { get; set; } = string.Empty;

     /// <summary>
    /// Adresse e-mail associée au compte.
    /// </summary>
    public string Email { get; set; } = string.Empty;
}