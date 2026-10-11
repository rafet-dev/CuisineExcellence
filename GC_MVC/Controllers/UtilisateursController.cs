using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace GC_MVC.Models
{
    [Table("utilisateurs")]
    public class Utilisateurs
    {
        [Key]
        public int id_utilisateur { get; set; }

        public string? email { get; set; }
        public string? identifiant { get; set; }
        public string? password { get; set; }
    }
}