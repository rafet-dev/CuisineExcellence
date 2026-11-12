
using Microsoft.AspNetCore.Identity;
using System.Security.Cryptography;
using System.Text;

var utilisateurs = new (int Id, string Identifiant)[]
{
    (1, "ChefGourmand"),
    (2, "MarieCuisine"),
    (3, "PaulGourmet"),
    (4, "SophieCook"),
    (5, "LucasCuisine"),
    (6, "EmmaGourmande"),
    (7, "JulieRecettes"),
    (8, "ThomasChef"),
    (9, "ClaireGourmet"),
    (10, "AntoineCuisine"),
    (11, "LauraGourmande"),
    (12, "NicolasChef"),
    (13, "CamilleCuisine"),
    (14, "AlexGourmet"),
    (15, "JulieChef"),
    (16, "MaxGourmand"),
    (17, "AliceRecettes"),
    (18, "HugoCuisine"),
    (19, "ChloeGourmet"),
    (20, "LouisCuisine")
};

var dossier = Path.Combine(
    AppContext.BaseDirectory,
    "..", "..", "..", "SortiesPrivees"
);

dossier = Path.GetFullPath(dossier);
Directory.CreateDirectory(dossier);

var fichierSql = Path.Combine(dossier, "migration_passwords.sql");
var fichierComptes = Path.Combine(dossier, "comptes_test.csv");

if (File.Exists(fichierSql) || File.Exists(fichierComptes))
{
    Console.WriteLine("Des fichiers existent déjà. Aucune modification.");
    return;
}

var hasher = new PasswordHasher<string>();

var sql = new StringBuilder();
var csv = new StringBuilder();

sql.AppendLine("BEGIN;");
csv.AppendLine("id_utilisateur;identifiant;mot_de_passe");

foreach (var utilisateur in utilisateurs)
{
    string motDePasse = Convert.ToHexString(
        RandomNumberGenerator.GetBytes(16)
    );

    string hash = hasher.HashPassword(
        utilisateur.Identifiant,
        motDePasse
    );

    csv.AppendLine(
        $"{utilisateur.Id};{utilisateur.Identifiant};{motDePasse}"
    );

    sql.AppendLine(
        $"UPDATE public.utilisateurs SET password = '{hash}' " +
        $"WHERE id_utilisateur = {utilisateur.Id} " +
        $"AND identifiant = '{utilisateur.Identifiant}' " +
        "AND (password IS NULL OR password NOT LIKE 'AQAAAA%' " +
        "OR LENGTH(password) <> 84);"
    );
}

sql.AppendLine("COMMIT;");

File.WriteAllText(fichierSql, sql.ToString());
File.WriteAllText(fichierComptes, csv.ToString());

Console.WriteLine($"Comptes préparés : {utilisateurs.Length}");
Console.WriteLine("Fichiers créés dans SortiesPrivees.");
Console.WriteLine("Aucune modification effectuée en base.");
