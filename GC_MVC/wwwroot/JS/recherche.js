const formulaireRecherche = document.getElementById("formulaireRecherche");
const champRecherche = document.getElementById("champRecherchePage");
const champCategorie = document.getElementById("categorie");
const resultatsRecherche = document.getElementById("resultatsRecherche");

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
            resultatsRecherche.innerHTML ="";

            // Vérifier si la recherche ne renvoie aucun résultat
            if (recettes.length === 0)
            {
                resultatsRecherche.textContent = "Aucune recette ne correspond à votre recherche.";
            }

            // création de la grille
            const grilleRecettes = document.createElement("div");
            grilleRecettes.className = "grille-recettes";
            resultatsRecherche.appendChild(grilleRecettes);

            // pour créer les cartes recettes répondant à la recherche
            recettes.forEach(function(recette)
            {
                console.log(recette.nom);
                const carteRecette = document.createElement("div");
                carteRecette.className = "resultat-recette";
                resultatsRecherche.appendChild(carteRecette);

                const imageRecette = document.createElement("img");
                const imageParDefaut = "/img/recettes/image-par-defaut.png";
                imageRecette.alt = recette.nom;
                imageRecette.onerror = function()
                {
                    imageRecette.onerror = null;
                    imageRecette.src = imageParDefaut;
                };
                imageRecette.src = recette.photo
                    ? "/img/recettes/" + recette.photo
                    : imageParDefaut;

                carteRecette.appendChild(imageRecette);
                const titreRecette = document.createElement("h2");
                titreRecette.textContent = recette.nom;

                const lienRecette = document.createElement("a");
                lienRecette.href = "/Recettes/Detail/" + recette.id_recette;
                lienRecette.appendChild(titreRecette);
                carteRecette.appendChild(lienRecette);

                grilleRecettes.appendChild(carteRecette);

            });
        });     
});