using Microsoft.EntityFrameworkCore;
using GC_MVC.Models;

namespace GC_MVC.Data
{
    public class GCContext : DbContext
    {
        public GCContext(DbContextOptions<GCContext> options) : base(options)
        {
            
        }

        public DbSet<Categories> Categories {get; set;}

    }
}