using Microsoft.AspNetCore.Mvc;

namespace GC_MVC.Controllers;

public class ContactController : Controller
{
    public IActionResult Index()
    {
        return View();
    }
}