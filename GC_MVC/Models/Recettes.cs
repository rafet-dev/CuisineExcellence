using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace GC_MVC.Models
{
    [Table("recettes")]
    public class Recettes
    {
        [Key]
        public int id_recette {get; set;}
        public int createur {get; set;}
        public int difficulte {get; set;}
        [Required(ErrorMessage ="Le titre de la recette est obligatoire.")]
        public string nom {get; set;} = string.Empty;
        public string? photo {get; set;}
        public TimeSpan temps_cuisson {get; set;}
        public TimeSpan temps_preparation {get; set;}
        public int? nombre_personnes { get; set;}
    }
}
