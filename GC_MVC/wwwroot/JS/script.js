const boutonMenu = document.getElementById("boutonMenu");
const menuNavigation = document.getElementById("menuNavigation");

if (boutonMenu && menuNavigation) {
    boutonMenu.addEventListener("click", function () {
        const menuOuvert = menuNavigation.classList.toggle("menu-ouvert");

        boutonMenu.setAttribute("aria-expanded", String(menuOuvert));
        boutonMenu.setAttribute(
            "aria-label",
            menuOuvert ? "Fermer le menu de navigation" : "Ouvrir le menu de navigation"
        );
    });
}

// nombre de toques selon la difficulté 
document.addEventListener("DOMContentLoaded", function()
{
    lucide.createIcons();
});