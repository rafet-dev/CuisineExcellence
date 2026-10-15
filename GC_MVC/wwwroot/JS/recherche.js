const formulaireRecherche = document.getElementById("formulaireRecherche");
const champRecherche = document.getElementById("champRecherchePage");
const champCategorie = document.getElementById("categorie");

formulaireRecherche.addEventListener("submit", event =>
{
    event.preventDefault();
    const terme = champRecherche.value;
    const categorie = champCategorie.value;

    const parametres = new URLSearchParams();
    parametres.append("terme", terme);
    parametres.append("categorie", categorie);

    const url = "/Recherche/Resultats?" + parametres.toString();
    console.log(url);
    fetch(url)
        .then(function(response)
        {
            return response.json();
        })
        .then(function(recettes)
        {
            console.log(recettes);
        });     
});