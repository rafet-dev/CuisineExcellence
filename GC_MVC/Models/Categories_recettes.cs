using System.ComponentModel.DataAnnotations.Schema;

[Table("categories_recettes")]
public class Categories_recettes
{
    public int id_categorie {get; set;}
    public int id_recette {get; set;}
}