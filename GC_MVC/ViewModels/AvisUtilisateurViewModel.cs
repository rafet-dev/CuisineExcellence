using GC_MVC.Models;

namespace GC_MVC.ViewModels;

public class AvisUtilisateurViewModel
{
    public string Pseudo { get; set; } = string.Empty;
    public short Note { get; set; }
    public string Commentaire { get; set; } = string.Empty;
}