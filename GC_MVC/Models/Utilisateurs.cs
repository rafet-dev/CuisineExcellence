using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace GC_MVC.Models;

 // Associe ce modèle à la table PostgreSQL "utilisateurs".
[Table("utilisateurs")]
public class Utilisateurs
{
    // Indique à Entity Framework la clé primaire.
    [Key]
    public int id_utilisateur {get; set;}
    public string email {get; set;} = string.Empty;
    public string identifiant {get; set;} = string.Empty;
    public string password {get; set;} = string.Empty;
}