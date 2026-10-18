using System.ComponentModel.DataAnnotations;
using GC_MVC.Models;

namespace GC_MVC.ViewModels
{
    public class RecetteCreationViewModel
    {
        [Required]
        [StringLength(100, MinimumLength =3, ErrorMessage ="Le titre doit contenir entre 3 et 100 caractères.")]
        public string Nom { get; set; } = string.Empty;
        [Range(1, 600, ErrorMessage = "Le temps de préparation doit être compris entre 1 et 600 minutes.")]
        public int TempsPreparation { get; set; }
        [Range(0, 600, ErrorMessage = "Le temps de cuisson doit être compris entre 0 et 600 minutes.")]
        public int TempsCuisson { get; set; }
        [Range(1, 5, ErrorMessage ="La difficulté doit être comprise entre 1 et 5 toques.")]
        public int Difficulte { get; set; }
        [Range(1, 20, ErrorMessage = "Le nombre de personnes doit être compris entre 1 et 20.")]
        public int NombrePersonnes { get; set; }
    }

}