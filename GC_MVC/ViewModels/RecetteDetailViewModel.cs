using GC_MVC.Models;

namespace GC_MVC.ViewModels
{
    public class RecetteDetailViewModel
    {
        internal object avisUtilisateur;

        public Recettes? Recette { get; set; } 
        public Utilisateurs? Createur { get; set; }
        public List<IngredientQuantiteViewModel> Ingredients { get; set; } = new List<IngredientQuantiteViewModel>();
        public List<Etapes> Etapes { get; set;} = new List<Etapes>();
        public List<AvisUtilisateurViewModel> Avis { get; set; } = new List<AvisUtilisateurViewModel>();
        public double Moyenne { get; set;}
    }
}