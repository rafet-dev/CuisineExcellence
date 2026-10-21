using GC_MVC.Models;

namespace GC_MVC.ViewModels
{
    public class IngredientRecetteViewModel
    {
        public int IdIngredient { get; set; }
        public string Quantite { get; set; } = string.Empty;
    }
}