using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace GC_MVC.Models
{
    [Table("categories")]
    public class Categories
    {
        [Key]
        public int id_categorie {get; set;}
        public string nom {get; set;}
    }
}
