using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace GC_MVC.Models;
[Table("etapes")]
public class Etapes
{
    public int id_recette {get; set;}
    public int numero_etape {get; set;}
    public string texte {get; set;} = string.Empty;
}