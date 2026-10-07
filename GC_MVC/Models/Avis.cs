public class Avis
{
    public int id_recette {get; set;}
    public int id_utilisateur {get; set;}
    public string commentaire {get; set;} required
    public int note {get; set;}
}