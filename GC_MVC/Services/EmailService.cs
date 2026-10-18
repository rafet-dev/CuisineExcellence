using System.Net;
using System.Net.Mail;

namespace GC_MVC.Services;

public class EmailService
{
    private readonly string _smtpHost;
    private readonly int _smtpPort;
    private readonly string _smtpUsername;
    private readonly string _smtpPassword;
    private readonly bool _enableSsl;
    private readonly string _fromAddress;

    public EmailService(IConfiguration configuration)
    {
        _smtpHost = configuration["Smtp:Host"] ?? "127.0.0.1";
        _smtpPort = configuration.GetValue<int>("Smtp:Port", 1025);
        _smtpUsername = configuration["Smtp:Username"] ?? "app@testmail.com";
        _smtpPassword = configuration["Smtp:Password"] ?? "fromage";
        _enableSsl = configuration.GetValue<bool>("Smtp:EnableSsl", false);
        _fromAddress = configuration["Smtp:FromAddress"] ?? "app@testmail.com";
    }

    public void SendVerificationEmail(string toEmail, string verificationUrl)
    {
        using var mail = new MailMessage
        {
            From = new MailAddress(_fromAddress),
            Subject = "Verifiez votre adresse email",
            Body = $"Veuillez cliquer sur ce lien pour verifier votre email : <a href='{verificationUrl}'>Verifier mon email</a>",
            IsBodyHtml = true
        };

        mail.To.Add(toEmail);

        using var smtp = new SmtpClient(_smtpHost, _smtpPort)
        {
            Credentials = new NetworkCredential(_smtpUsername, _smtpPassword),
            EnableSsl = _enableSsl
        };

        smtp.Send(mail);
    }
}