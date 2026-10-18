using System.Security.Cryptography;
using System.Text;

namespace GC_MVC.Services;

/// <summary>
/// Service de gestion des tokens de vérification d'email
/// </summary>
public class TokenService
{
    private readonly byte[] _key;
    private readonly byte[] _iv;

    public TokenService(IConfiguration configuration)
    {
        _key = Encoding.ASCII.GetBytes(
            configuration["TokenKey"] ?? throw new Exception("TokenKey manquant dans la configuration"));
        _iv = Encoding.ASCII.GetBytes(
            configuration["InitializationVector"] ?? throw new Exception("InitializationVector manquant dans la configuration"));
    }

    /// <summary>
    /// Génère un token unique pour la vérification d'email
    /// </summary>
    public string GenerateEmailVerificationToken()
    {
        byte[] time = BitConverter.GetBytes(DateTime.UtcNow.ToBinary());
        byte[] key = Guid.NewGuid().ToByteArray();
        return Convert.ToBase64String(time.Concat(key).ToArray());
    }

    /// <summary>
    /// Chiffre un token
    /// </summary>
    public string EncryptToken(string token)
    {
        using var aes = Aes.Create();
        aes.Key = _key;
        aes.IV = _iv;

        using var encryptor = aes.CreateEncryptor(aes.Key, aes.IV);
        using var memoryStream = new MemoryStream();

        using (var cryptoStream = new CryptoStream(memoryStream, encryptor, CryptoStreamMode.Write))
        using (var streamWriter = new StreamWriter(cryptoStream))
        {
            streamWriter.Write(token);
        }

        return Convert.ToBase64String(memoryStream.ToArray());
    }

    /// <summary>
    /// Déchiffre un token
    /// </summary>
    public string DecryptToken(string encryptedToken)
    {
        byte[] cipherText = Convert.FromBase64String(encryptedToken);

        using var aes = Aes.Create();
        aes.Key = _key;
        aes.IV = _iv;

        using var decryptor = aes.CreateDecryptor(aes.Key, aes.IV);
        using var memoryStream = new MemoryStream(cipherText);
        using var cryptoStream = new CryptoStream(memoryStream, decryptor, CryptoStreamMode.Read);
        using var streamReader = new StreamReader(cryptoStream);

        return streamReader.ReadToEnd();
    }
}