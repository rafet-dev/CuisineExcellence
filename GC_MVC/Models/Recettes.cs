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
        public string nom {get; set;}
        public string photo {get; set;}
        public TimeSpan temps_cuisson {get; set;}
        public TimeSpan temps_preparation {get; set;}
    }

}
