// Récupère le champ de recherche des catégories dans le HTML.
let RechercheCategorieHTML = document.getElementById("rechercheCategorie");
// Récupère tous les éléments HTML représentant les catégories.
let CategorieResultatHTML = document.querySelectorAll(".categorie-resultat");
// conteneur HTML dans lequel nous allons afficher les catégories.
let CategoriesSelectionneesHTML = document.getElementById("categoriesSelectionnees");
// tableau contenant les identifiants des catégories sélectionnées.
const CategoriesSelectionnees = [];

const RechercheIngredientHTML = document.getElementById("rechercheIngredient");
const ResultatsIngredientsHTML = document.getElementById("resultatsIngredients");


// Masque les catégories dès le chargement du script.
CategorieResultatHTML.forEach(function(categorie)
{
    categorie.style.display = "none";
});

// Détecte chaque modification du champ de recherche.
RechercheCategorieHTML.addEventListener("input", function()
{
    // Récupère le texte saisi et le convertit en minuscules.
    let texteRecherche = RechercheCategorieHTML.value.trim().toLowerCase();
    // Affiche le résultat dans la console.
    console.log(texteRecherche);

    // Parcourt chaque catégorie présente dans notre page HTML.
    CategorieResultatHTML.forEach(function(categorie)
    {
         // Récupère le nom de la catégorie et le convertit en minuscules.
        let nomCategorie = categorie.textContent.trim().toLowerCase();
        // Affiche le nom de la catégorie dans la console.
        console.log(nomCategorie); 

        if(nomCategorie.includes(texteRecherche) && texteRecherche !== "")
        {
            console.log("catégorie trouvée !");
            categorie.style.display = "block";
        }
        else 
        {
            categorie.style.display = "none";
        }
    });
});

// Parcourt tous les résultats de catégories.
CategorieResultatHTML.forEach(function(categorie)
{
    // Détecte le clic sur une catégorie.
    categorie.addEventListener("click", function()
    {
        // Vérifie que la catégorie n'a pas déjà été sélectionnée.
        if (!CategoriesSelectionnees.includes(categorie.dataset.id))
        {
            // Ajoute l'identifiant de la catégorie au tableau.
            CategoriesSelectionnees.push(categorie.dataset.id);

            // Créer un champ <input> avec JavaScript.
            let ChampCache = document.createElement("input");
            // Définir son type hidden.
            ChampCache.type = "hidden";
            // Lui attribuer le nom CategoriesSelectionnees.
            ChampCache.name = "CategoriesSelectionnees";
            // Lui donner l'identifiant de la catégorie sélectionnée.
            ChampCache.value = categorie.dataset.id;
            // les 4 instructions sont identiques en html à : <input type="hidden" name="CategoriesSelectionnees" value="12">

            // Crée une étiquette HTML contenant le nom de la catégorie.
            let NouvelleCategorieHTML = document.createElement("span");
            // Ajoute la classe CSS permettant de styliser l'étiquette.
            NouvelleCategorieHTML.classList.add("categorie-selectionnee");
            NouvelleCategorieHTML.textContent = categorie.textContent.trim();

            // Crée le bouton permettant de supprimer cette catégorie.
            let BoutonSupprimerCategorieHTML = document.createElement("button");
            // Ajoute la classe CSS au bouton de suppression.
            BoutonSupprimerCategorieHTML.classList.add("supprimer-categorie");
            BoutonSupprimerCategorieHTML.textContent = "×";

            // Empêche le bouton de soumettre le formulaire.
            BoutonSupprimerCategorieHTML.type = "button";

            // Ajoute le bouton de suppression à l'étiquette.
            NouvelleCategorieHTML.appendChild(BoutonSupprimerCategorieHTML);

            // Affiche l'étiquette dans le conteneur des catégories sélectionnées.
            CategoriesSelectionneesHTML.appendChild(NouvelleCategorieHTML);

            // Ajoute le champ caché au conteneur.
            CategoriesSelectionneesHTML.appendChild(ChampCache);

            // Détecte un clic sur le bouton de suppression.
            BoutonSupprimerCategorieHTML.addEventListener("click", function()
            {
                // Recherche la position de l'identifiant dans le tableau.
                let IndexCategorie = CategoriesSelectionnees.indexOf(categorie.dataset.id);

                // Supprime l'identifiant uniquement s'il existe dans le tableau.
                if (IndexCategorie >= 0)
                {
                    CategoriesSelectionnees.splice(IndexCategorie, 1);
                }

                // Supprime l'étiquette, son bouton et l'élément caché de la page.
                NouvelleCategorieHTML.remove();
                ChampCache.remove();         
            });
        }
    });
});


RechercheIngredientHTML.addEventListener("input", function()
{   
    ResultatsIngredientsHTML.innerHTML="";

    const Recherche = RechercheIngredientHTML.value.trim().toLowerCase();
    const IngredientsFiltres = IngredientsDisponibles.filter(function(ingredient)
    {
        return ingredient.nom.toLowerCase().includes(Recherche);
    });

    IngredientsFiltres.forEach(function(ingredient)
    {
        console.log(ingredient.nom);
        const NouvelIngredientHTML = document.createElement("div");
        NouvelIngredientHTML.textContent = ingredient.nom;
        ResultatsIngredientsHTML.appendChild(NouvelIngredientHTML);
    });
});
    
    

