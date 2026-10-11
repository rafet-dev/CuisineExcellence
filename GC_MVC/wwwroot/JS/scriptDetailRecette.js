// données récupérés du DOM
const augmenterPersonne = document.querySelector("#augmenter-personnes");
const diminuerPersonne = document.querySelector("#diminuer-personnes");
const nombrePersonnes = document.querySelector("#nombre-personnes");
// pour conserver le nombre référence pour le calcul des quantités des recettes
const nombrePersonnesInitial =Number(nombrePersonnes.textContent);
// sélectionne tous les éléments HTML possédant l'attribut data-quantite-initiale. (une recette a plusieurs ingrédients)
const ingredients = document.querySelectorAll("[data-quantite-initiale]");
console.log(ingredients);
//----------------------------------------------------------------------------------------------------------------------------
// fonctions 

function calculerQuantite()
{
    ingredients.forEach(function(ingredient)
    {
        console.log("Ingrédient parcouru :", ingredient);
        const quantiteInitiale = parseFloat(ingredient.dataset.quantiteInitiale);
        // pour séparer la quantité de l'unité de mesure
        const morceaux = ingredient.dataset.quantiteInitiale.split(" ");
        const unite = morceaux[1]; 
        console.log("Quantité convertie :", quantiteInitiale);
        // lien entre le calcul JS & l'affichage HTML
       
        const nombrePersonnesChoisi = Number(nombrePersonnes.textContent);

        const nouvelleQuantite = (quantiteInitiale * nombrePersonnesChoisi) / nombrePersonnesInitial;
        
    
        if (unite !== undefined)
        {
            ingredient.textContent = nouvelleQuantite + " " + unite;
        }
        else
        {
            ingredient.textContent = nouvelleQuantite;
        }
    });
}

//------------------------------------------------------------------------------------------------------------------------------
// évènements
augmenterPersonne.addEventListener("click", function()
{
    // Lire et convertir la valeur
    let compteurPersonne = Number(nombrePersonnes.textContent);
    compteurPersonne = compteurPersonne + 1;
    // Modifier la valeur affichée
    nombrePersonnes.textContent = compteurPersonne;
    console.log("Nb de personnes :" + compteurPersonne);
    // fonction calcul des quantités
    calculerQuantite();
});

diminuerPersonne.addEventListener("click", function()
{
    let compteurPersonne = Number(nombrePersonnes.textContent);
    // on ne peut pas cuisiner pour moins d'une personne ...
    if(compteurPersonne > 1)
    {
        compteurPersonne = compteurPersonne - 1;
        nombrePersonnes.textContent = compteurPersonne;
        console.log("Nb de personnes :" + compteurPersonne);
        calculerQuantite();
    }
});

