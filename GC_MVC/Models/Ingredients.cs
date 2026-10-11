using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace GC_MVC.Models
{
   // Associe ce modèle à la table PostgreSQL "ingredients".
    [Table("ingredients")]
    public class Ingredients
    {
        // Indique la clé primaire de la table.
        [Key]
        public int id_ingredient { get; set; }
        public string nom { get; set; }  = string.Empty; 
        // string.Empty; pour initialiser nom et éviter un avertissement de nullabilité.
        public decimal? prix_reference { get; set; }
        public decimal? quantite_reference { get; set; }
        public string? unite_reference { get; set; }
    } 
}
