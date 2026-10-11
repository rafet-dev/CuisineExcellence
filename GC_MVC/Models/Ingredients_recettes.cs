using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace GC_MVC.Models
{
   // Associe ce modèle à la table PostgreSQL "ingredients_recettes".
    [Table("ingredients_recettes")]
    public class Ingredients_recettes
    {
        public int id_ingredient {get; set;}
        public int id_recette {get; set;}
        public string quantite {get; set;} = string.Empty;
        // string.Empty; pour initialiser nom et éviter un avertissement de nullabilité.
    } 
}
