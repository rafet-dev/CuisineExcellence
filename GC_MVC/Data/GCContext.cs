using Microsoft.EntityFrameworkCore;
using GC_MVC.Models;

namespace GC_MVC.Data
{
    public class GCContext : DbContext
    {
        public GCContext(DbContextOptions<GCContext> options) : base(options)
        {
            
        }

         //Permet à Entity Framework d'accéder à la table "categories"
        public DbSet<Categories> Categories {get; set;}
        //Permet à Entity Framework d'accéder à la table "recettes"
        public DbSet<Recettes> Recettes {get; set;}
        // Permet à Entity Framework d'accéder à la table d'association entre les catégories et les recettes.
        public DbSet<Categories_recettes> Categories_recettes {get; set;}

        // Cette méthode permet de préciser à Entity Framework certaines règles concernant nos modèles et notre BDD.
        // ModelBuilder modelBuilder => objet qu'Entity Framework nous fournit pour configurer les entités.
        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            // On indique que la clé primaire de Categories_recettes est composée de DEUX colonnes.
            modelBuilder.Entity<Categories_recettes>().HasKey(cr => new
            {
                cr.id_categorie,
                cr.id_recette
            });
        }
    }
}