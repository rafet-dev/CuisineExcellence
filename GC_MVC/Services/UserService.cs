using GC_MVC.Models;
using Npgsql;
using Dapper;
using System;
using System.Data.SqlClient;
using Microsoft.AspNetCore.Identity;
using GC_MVC.ViewModels;

namespace GC_MVC.Services;

/// <summary>
/// Service de gestion des utilisateurs en base de données
/// </summary>
public class UserService
{
    private readonly string _connectionString;
    private static readonly PasswordHasher<string> _passwordHasher = new();

    public UserService(IConfiguration configuration)
    {
        _connectionString = configuration.GetConnectionString("GC")
            ?? throw new Exception("La chaîne de connexion est manquante");
    }

    /// <summary>
    /// Vérifie si un email existe déjà en base
    /// </summary>
    public bool EmailExists(string email)
    {
        string query = "SELECT COUNT(*) FROM Utilisateurs WHERE email = @Email";
        using var connection = new NpgsqlConnection(_connectionString);
        var count = connection.ExecuteScalar<int>(query, new { Email = email });
        return count > 0;
    }

    /// <summary>
    /// Crée un nouvel utilisateur en base
    /// </summary>
    public bool CreateUser(InscriptionViewModel userData, out int userId)
    {
        string query = @"
            INSERT INTO utilisateurs (identifiant, email, password)
            VALUES (@Identifiant, @Email, @HashedPassword)
            RETURNING id_utilisateur";

        string hashedPassword = _passwordHasher.HashPassword( userData.Identifiant, userData.MotDePasse);

        using var connection = new NpgsqlConnection(_connectionString);
        userId = connection.ExecuteScalar<int>(query, new
        {
            Identifiant = userData.Identifiant,
            Email = userData.Email,
            HashedPassword = hashedPassword
            
        });

        return userId > 0;
    }

    /// <summary>
    /// Récupérer un utilisateur par son email
    /// </summary>
    public Utilisateurs? GetUserByIdentifiantOuEmail(string identifiantOuEmail)
    {
        string query = @"SELECT id_utilisateur, identifiant, email, password FROM Utilisateurs
                        WHERE identifiant=@identifiantOuEmail OR email=@identifiantOuEmail";

        using var connection = new NpgsqlConnection(_connectionString);
        
        var utilisateur = connection.QueryFirstOrDefault<Utilisateurs>(query, 
        new {IdentifiantOuEmail = identifiantOuEmail});

        return utilisateur;
    }

    /// <summary>
    /// Récupère un utilisateur à partir de son identifiant en base
    /// </summary>
    public Utilisateurs? GetUserById(int id)
    {
        string query = @"SELECT id_utilisateur, identifiant, email
                        FROM utilisateurs 
                        WHERE id_utilisateur = @Id";
        
        using var connection = new NpgsqlConnection(_connectionString);

        return connection.QueryFirstOrDefault<Utilisateurs>(query, new{Id = id});
    }
}