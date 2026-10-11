using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

 // Associe ce modèle à la table PostgreSQL "utilisateurs".
[Table("utilisateurs")]
public class Utilisateurs
{
    // Indique à Entity Framework la clé primaire.
    [Key]
    public int id_utilisateur {get; set;}
    public string email {get; set;}
    public string identifiant {get; set;}
    public string password {get; set;}
}