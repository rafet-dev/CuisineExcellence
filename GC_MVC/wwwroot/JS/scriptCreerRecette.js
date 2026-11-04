//*********************************************** */
// ******* Variables provenant du DOM *********** */
//*********************************************** */

// Récupère le champ de recherche des catégories dans le HTML.
let RechercheCategorieHTML = document.getElementById("rechercheCategorie");
// Récupère tous les éléments HTML représentant les catégories.
let CategorieResultatHTML = document.querySelectorAll(".categorie-resultat");
// conteneur HTML dans lequel nous allons afficher les catégories.
let CategoriesSelectionneesHTML = document.getElementById("categoriesSelectionnees");
// conteneur HTML dans lequel nous allons afficher les ingrédients sélectionnés.
const IngredientsSelectionnesHTML = document.getElementById("ingredientsSelectionnes");

const ListeIngredientsHTML = document.querySelector(".liste-ingredient");
const RechercheIngredientHTML = document.getElementById("rechercheIngredient");
const ResultatsIngredientsHTML = document.getElementById("resultatsIngredients");
const BoutonAjouterEtapeHTML = document.getElementById("ajouterEtape");
const EtapesRecetteHTML = document.getElementById("etapesRecette");
const BoutonAjouterImageHTML = document.getElementById("ajouterImage");
const PhotoRecetteHTML = document.getElementById("photoRecette");
const ApercuPhotoHTML = document.getElementById("apercuPhoto");

//*********************************************** */
// ******* Variables spécifiques au script ****** */
//*********************************************** */

// tableau contenant les identifiants des catégories sélectionnées.
const CategoriesSelectionnees = [];
const IngredientsSelectionnes = [];



//*********************************************** */
// ***************  Fonctions ******************* */
//*********************************************** */

// fonction pour mettre à jour les indices des champs HTML
function MettreAJourIndices()
{
    IngredientsSelectionnes.forEach(function(ingredient, index)
    {
        ingredient.champId.name = `IngredientsSelectionnes[${index}].IdIngredient`;
        ingredient.champQuantite.name = `IngredientsSelectionnes[${index}].Quantite`;

        console.log("Ingrédient : ", ingredient.nom, "Index : ", index);
        console.log("Quantité : ", ingredient.champQuantite.name);
    });
}

function MettreAJourNumerosEtapes()
{
    let BlocsEtapesHTML = EtapesRecetteHTML.querySelectorAll(":scope > div");

    BlocsEtapesHTML.forEach(function(BlocEtapeHTML, index)
    {
        let NouvelleEtapeHTML = BlocEtapeHTML.querySelector("textarea");
        
         // Numéro visible par l'utilisateur
        NouvelleEtapeHTML.placeholder="Etape " + (index + 1);

        // Nom du champ pour ASP.NET Core MVC
        NouvelleEtapeHTML.name = "Etapes[" + index + "]";
    });
}

//********************************************** */
// **************** Events ********************* */
//********************************************** */

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
    if (Recherche === "")
    {
        return;
    }

    const IngredientsFiltres = IngredientsDisponibles.filter(function(ingredient)
    {
        return ingredient.nom.toLowerCase().includes(Recherche);
    });

    IngredientsFiltres.forEach(function(ingredient)
    {
        const NouvelIngredientHTML = document.createElement("div");
        NouvelIngredientHTML.textContent = ingredient.nom;

        NouvelIngredientHTML.addEventListener("click", function()
        {
            const IngredientExiste = IngredientsSelectionnes.some(function(ingredientSelectionne)
            {
                return ingredientSelectionne.id === ingredient.id;
            });

            if (!IngredientExiste)
            {
                ingredient.quantite = "";
                IngredientsSelectionnes.push(ingredient);
                const IndexIngredient = IngredientsSelectionnes.length - 1;

                // Création du conteneur de la carte
                const CarteIngredientHTML = document.createElement("div");
                CarteIngredientHTML.classList.add("un-ingredient");

                // Création de l'emplacement de l'image
                const ImageIngredientHTML = document.createElement("div");
                ImageIngredientHTML.classList.add("img");

                // Ajout de l'image à la carte
                CarteIngredientHTML.appendChild(ImageIngredientHTML);

                // Création du paragraphe contenant le nom de l'ingrédient
                const NomIngredientHTML = document.createElement("p");
                NomIngredientHTML.textContent = ingredient.nom;

                // Ajout du nom à la carte
                CarteIngredientHTML.appendChild(NomIngredientHTML);

                // Ajout de la carte dans la liste des ingrédients
                ListeIngredientsHTML.appendChild(CarteIngredientHTML);

                const ConteneurIngredientHTML = document.createElement("div");

                let NouvelIngredientSelectionneHTML = document.createElement("span");
                NouvelIngredientSelectionneHTML.textContent = ingredient.nom;
                ConteneurIngredientHTML.appendChild(NouvelIngredientSelectionneHTML);

                // Création du champ invisible pour l'identifiant
                const IdIngredientHTML = document.createElement("input");
                IdIngredientHTML.type = "hidden";
                IdIngredientHTML.value = ingredient.id;
                IdIngredientHTML.name = `IngredientsSelectionnes[${IndexIngredient}].IdIngredient`;

                ConteneurIngredientHTML.appendChild(IdIngredientHTML);

                // Création du champs de quantité 
                let QuantiteIngredientHTML = document.createElement("input");
                QuantiteIngredientHTML.type = "text";
                QuantiteIngredientHTML.placeholder = "Ex: 300 g, 2 sachets ...";
                QuantiteIngredientHTML.name = `IngredientsSelectionnes[${IndexIngredient}].Quantite`;

                ConteneurIngredientHTML.appendChild(QuantiteIngredientHTML);
                
                ingredient.champId = IdIngredientHTML;
                ingredient.champQuantite = QuantiteIngredientHTML;

                // évènement de saisie de la quantité 
                QuantiteIngredientHTML.addEventListener("input", function()
                {
                    const QuantiteSaisie = QuantiteIngredientHTML.value.trim();
                    ingredient.quantite = QuantiteSaisie;
                    
                    IngredientsSelectionnes.forEach(function(ingredient)
                    {
                        console.log("Ingrédient sélectionné : ", ingredient.nom, "Quantité : ", ingredient.quantite);
                    });
                });

                // Création du bouton de suppression 
                const BoutonSupprimerIngredientHTML = document.createElement("button");
                BoutonSupprimerIngredientHTML.type = "button";
                BoutonSupprimerIngredientHTML.textContent = "×";

                // Ajout du bouton dans le conteneur
                ConteneurIngredientHTML.appendChild(BoutonSupprimerIngredientHTML);

                // Événement de suppression
                BoutonSupprimerIngredientHTML.addEventListener("click", function()
                {
                    const IndexIngredient = IngredientsSelectionnes.findIndex(function(ingredientSelectionne)
                    {
                        return ingredientSelectionne.id === ingredient.id;
                    });

                    if (IndexIngredient >= 0)
                    {
                        IngredientsSelectionnes.splice(IndexIngredient, 1);
                        ConteneurIngredientHTML.remove();
                        CarteIngredientHTML.remove();

                        MettreAJourIndices();
                    }
                });

                // Ajout du conteneur complet au formulaire
                IngredientsSelectionnesHTML.appendChild(ConteneurIngredientHTML);
            }
            console.log("Tableau des ingrédients sélectionnés : ", IngredientsSelectionnes);
        });
        ResultatsIngredientsHTML.appendChild(NouvelIngredientHTML);
    });
});

BoutonAjouterEtapeHTML.addEventListener("click", function()
{
    let NumeroEtape = EtapesRecetteHTML.children.length + 1;
    let BlocEtapeHTML = document.createElement("div");
    let NouvelleEtapeHTML = document.createElement("textarea");

    NouvelleEtapeHTML.placeholder = "Étape " + NumeroEtape;

    let BoutonSupprimerEtapeHTML = document.createElement("button");

    BoutonSupprimerEtapeHTML.textContent = "Supprimer";
    BoutonSupprimerEtapeHTML.type = "button";

    BoutonSupprimerEtapeHTML.addEventListener("click", function()
    {
        BlocEtapeHTML.remove();
        MettreAJourNumerosEtapes();
    });

    // Ajouter la zone de texte dans le bloc
    BlocEtapeHTML.appendChild(NouvelleEtapeHTML);

    // Ajouter le bouton Supprimer dans le bloc
    BlocEtapeHTML.appendChild(BoutonSupprimerEtapeHTML);

    // Ajouter le bloc complet dans le conteneur principal
    EtapesRecetteHTML.appendChild(BlocEtapeHTML);
    MettreAJourNumerosEtapes();
});

// Ouvrir la fenêtre de sélection d'une image
BoutonAjouterImageHTML.addEventListener("click", function()
{
    PhotoRecetteHTML.click();
});

PhotoRecetteHTML.addEventListener("change", function()
{
    const FichierSelectionne = PhotoRecetteHTML.files[0];

    if (FichierSelectionne)
    {
        ApercuPhotoHTML.src = URL.createObjectURL(FichierSelectionne);

        // Rendre l'image visible
        ApercuPhotoHTML.hidden = false;
    }
});

