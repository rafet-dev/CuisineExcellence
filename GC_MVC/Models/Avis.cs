using System.ComponentModel.DataAnnotations.Schema;

namespace GC_MVC.Models;
[Table("avis")]
public class Avis
{
    public int id_recette {get; set;}
    public int id_utilisateur {get; set;}
    public string commentaire {get; set;} = string.Empty;
    public short note {get; set;}
}