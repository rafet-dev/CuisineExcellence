// ============================================================
// 1. VARIABLES PROVENANT DU DOM
// ============================================================

// ---------- Catégories ----------

const RechercheCategorieHTML = document.getElementById("rechercheCategorie");
const CategoriesResultatsHTML = document.querySelectorAll(".categorie-resultat");
const CategoriesSelectionneesHTML = document.getElementById("categoriesSelectionnees");

// ---------- Ingrédients ----------

const IngredientsSelectionnesHTML = document.getElementById("ingredientsSelectionnes");
const ListeIngredientsHTML = document.querySelector(".liste-ingredient");
const RechercheIngredientHTML = document.getElementById("rechercheIngredient");
const ResultatsIngredientsHTML = document.getElementById("resultatsIngredients");
const CompteurIngredientsHTML = document.getElementById("compteurIngredients");

// ---------- Étapes de préparation ----------

const BoutonAjouterEtapeHTML = document.getElementById("ajouterEtape");
const EtapesRecetteHTML = document.getElementById("etapesRecette");

// ---------- Difficulté ----------

const CurseurDifficulteHTML = document.getElementById("Difficulte");
const ValeurDifficulteHTML = document.getElementById("valeurDifficulte");
const ToquesDifficulteHTML = document.getElementById("toquesDifficulte");
const NombreToquesHTML = document.getElementById("nombreToques");

// ---------- Photographie ----------

const BoutonAjouterImageHTML = document.getElementById("ajouterImage");
const PhotoRecetteHTML = document.getElementById("photoRecette");
const ApercuPhotoHTML = document.getElementById("apercuPhoto");

// Nouveaux éléments propres à la modification
const BoutonSupprimerPhotoHTML = document.getElementById("supprimerPhoto");
const SupprimerPhotoHTML = document.getElementById("SupprimerPhoto");
const TexteAjoutPhotoHTML = document.querySelector(".texte-ajout-photo");

// ---------- Fenêtre modale des catégories ----------

const ModalCategoriesHTML = document.getElementById("modalCategories");
const OuvrirModalCategoriesHTML = document.getElementById("ouvrirModalCategories");
const FermerModalCategoriesHTML = document.getElementById("fermerModalCategories");
const TerminerModalCategoriesHTML = document.getElementById("terminerModalCategories");

// ---------- Fenêtre modale des ingrédients ----------

const ModalIngredientsHTML = document.getElementById("modalIngredients");
const OuvrirModalIngredientsHTML = document.getElementById("ajouterIngrédient");
const FermerModalIngredientsHTML = document.getElementById("fermerModalIngredients");
const TerminerModalIngredientsHTML = document.getElementById("terminerModalIngredients");

// ============================================================
// 2. VARIABLES INTERNES AU SCRIPT
// ============================================================

// Liste des identifiants des catégories sélectionnées.
const CategoriesSelectionnees = [];

// Liste des ingrédients sélectionnés avec leurs informations.
const IngredientsSelectionnes = [];

// Données initiales de la recette transmises par Razor.
// Ces données seront définies dans ModifierRecette.cshtml.
const DonneesRecetteInitiales = window.DonneesRecetteInitiales ?? {
    categories: [],
    ingredients: [],
    etapes: [],
    photo: null
};

// ============================================================
// 3. FONCTIONS
// ============================================================

// 3.1 Gestion des catégories
// Ajoute une catégorie au formulaire.
function AjouterCategorie(IdCategorie, NomCategorie)
{
    // Conversion de l'identifiant en chaîne de caractères.
    const Id = String(IdCategorie);

    // Vérifie que la catégorie n'est pas déjà sélectionnée.
    if (CategoriesSelectionnees.includes(Id))
    {
        return;
    }

    // Ajout de l'identifiant au tableau.
    CategoriesSelectionnees.push(Id);

    // Création de l'étiquette de la catégorie.
    const NouvelleCategorieHTML = document.createElement("span");
    NouvelleCategorieHTML.className = "categorie-selectionnee";
    NouvelleCategorieHTML.textContent = NomCategorie;

    // Création du champ caché pour ASP.NET Core MVC.
    const ChampCacheHTML = document.createElement("input");
    ChampCacheHTML.type = "hidden";
    ChampCacheHTML.name = "CategoriesSelectionnees";
    ChampCacheHTML.value = Id;

    // Création du bouton de suppression.
    const BoutonSupprimerHTML = document.createElement("button");
    BoutonSupprimerHTML.type = "button";
    BoutonSupprimerHTML.className = "supprimer-categorie";
    BoutonSupprimerHTML.textContent = "×";

    // Suppression de la catégorie au clic.
    BoutonSupprimerHTML.addEventListener("click", function()
    {
        SupprimerCategorie(Id, NouvelleCategorieHTML, ChampCacheHTML);
    });

    // Construction de l'étiquette.
    NouvelleCategorieHTML.appendChild(BoutonSupprimerHTML);

    // Ajout des éléments dans le formulaire.
    CategoriesSelectionneesHTML.appendChild(NouvelleCategorieHTML);
    CategoriesSelectionneesHTML.appendChild(ChampCacheHTML);

    // Actualisation de l'affichage.
    ActualiserAffichageCategories();
}

// Supprime une catégorie du formulaire.
function SupprimerCategorie(IdCategorie, EtiquetteHTML, ChampCacheHTML)
{
    const IndexCategorie = CategoriesSelectionnees.indexOf(IdCategorie);

    // Retire l'identifiant du tableau.
    if (IndexCategorie >= 0)
    {
        CategoriesSelectionnees.splice(IndexCategorie, 1);
    }

    // Supprime les éléments HTML correspondants.
    EtiquetteHTML.remove();
    ChampCacheHTML.remove();

    // Actualise les catégories dans la fenêtre modale.
    ActualiserAffichageCategories();
}

// Actualise les indications visuelles des catégories.
function ActualiserAffichageCategories()
{
    CategoriesResultatsHTML.forEach(function(CategorieHTML)
    {
        const IdCategorie = CategorieHTML.dataset.id;

        const EstSelectionnee = CategoriesSelectionnees.includes(IdCategorie);

        // Applique ou retire la classe CSS de sélection.
        CategorieHTML.classList.toggle("est-selectionne", EstSelectionnee);

        // Recherche l'indication visuelle existante.
        let IndicationHTML = CategorieHTML.querySelector(".indication-ajout");

        if (EstSelectionnee && !IndicationHTML)
        {
            // Ajoute l'indication si la catégorie est sélectionnée.
            IndicationHTML = document.createElement("span");
            IndicationHTML.className = "indication-ajout";
            IndicationHTML.textContent = "✓ Ajoutée";

            CategorieHTML.appendChild(IndicationHTML);
        }
        else if (!EstSelectionnee && IndicationHTML)
        {
            // Retire l'indication si la catégorie n'est plus sélectionnée.
            IndicationHTML.remove();
        }
    });
}

// 3.2 Gestion des ingrédients
// Ajoute un ingrédient au formulaire.
function AjouterIngredient(IdIngredient, NomIngredient, QuantiteInitiale = "")
{
    const Id = Number(IdIngredient);

    // Vérifie que l'ingrédient n'est pas déjà sélectionné.
    const IngredientExiste = IngredientsSelectionnes.some(function(ingredient)
    {
        return ingredient.id === Id;
    });

    if (IngredientExiste)
    {
        return;
    }

    // Création de la carte.
    const CarteIngredientHTML = document.createElement("div");
    CarteIngredientHTML.className = "un-ingredient";

    // Emplacement de l'image de l'ingrédient.
    const ImageIngredientHTML = document.createElement("div");
    ImageIngredientHTML.className = "img";

    // Nom de l'ingrédient.
    const NomIngredientHTML = document.createElement("p");
    NomIngredientHTML.textContent = NomIngredient;

    // Conteneur de la quantité et du bouton de suppression.
    const InfosIngredientHTML = document.createElement("div");
    InfosIngredientHTML.className = "infos-ingredient";

    // Champ caché contenant l'identifiant de l'ingrédient.
    const IdIngredientHTML = document.createElement("input");
    IdIngredientHTML.type = "hidden";
    IdIngredientHTML.value = Id;

    // Champ permettant de modifier la quantité.
    const QuantiteIngredientHTML = document.createElement("input");
    QuantiteIngredientHTML.type = "text";
    QuantiteIngredientHTML.placeholder = "Ex : 200 g";
    QuantiteIngredientHTML.value = QuantiteInitiale ?? "";

    // Bouton permettant de supprimer l'ingrédient.
    const BoutonSupprimerHTML = document.createElement("button");
    BoutonSupprimerHTML.type = "button";
    BoutonSupprimerHTML.className = "supprimer-ingredient";
    BoutonSupprimerHTML.textContent = "×";

    // Objet représentant l'ingrédient sélectionné.
    const NouvelIngredient = {
        id: Id,
        nom: NomIngredient,
        quantite: QuantiteIngredientHTML.value,
        champId: IdIngredientHTML,
        champQuantite: QuantiteIngredientHTML
    };

    // Ajout de l'ingrédient au tableau.
    IngredientsSelectionnes.push(NouvelIngredient);

    // Mise à jour de la quantité lorsque l'utilisateur la modifie.
    QuantiteIngredientHTML.addEventListener("input", function()
    {
        NouvelIngredient.quantite = QuantiteIngredientHTML.value.trim();
    });

    // Suppression de l'ingrédient.
    BoutonSupprimerHTML.addEventListener("click", function()
    {
        SupprimerIngredient(Id, CarteIngredientHTML);
    });

    // Construction du conteneur quantité + suppression.
    InfosIngredientHTML.appendChild(QuantiteIngredientHTML);
    InfosIngredientHTML.appendChild(BoutonSupprimerHTML);

    // Construction de la carte.
    CarteIngredientHTML.appendChild(ImageIngredientHTML);
    CarteIngredientHTML.appendChild(NomIngredientHTML);
    CarteIngredientHTML.appendChild(IdIngredientHTML);
    CarteIngredientHTML.appendChild(InfosIngredientHTML);

    // Affichage de la carte.
    IngredientsSelectionnesHTML.appendChild(CarteIngredientHTML);

    // Mise à jour des indices et de l'affichage.
    MettreAJourIndicesIngredients();
    ActualiserAffichageIngredients();
}


// Supprime un ingrédient du formulaire.
function SupprimerIngredient(IdIngredient, CarteIngredientHTML)
{
    const IndexIngredient = IngredientsSelectionnes.findIndex(function(ingredient)
    {
        return ingredient.id === IdIngredient;
    });

    if (IndexIngredient < 0)
    {
        return;
    }

    // Retire l'ingrédient du tableau.
    IngredientsSelectionnes.splice(IndexIngredient, 1);

    // Supprime sa carte HTML.
    CarteIngredientHTML.remove();

    // Réorganise les indices et actualise l'affichage.
    MettreAJourIndicesIngredients();
    ActualiserAffichageIngredients();
}

// Met à jour les indices des champs pour ASP.NET Core MVC.
function MettreAJourIndicesIngredients()
{
    IngredientsSelectionnes.forEach(function(ingredient, index)
    {
        ingredient.champId.name =
            `IngredientsSelectionnes[${index}].IdIngredient`;

        ingredient.champQuantite.name =
            `IngredientsSelectionnes[${index}].Quantite`;
    });
}

// Actualise les indications visuelles et le compteur.
function ActualiserAffichageIngredients()
{
    // Actualisation des résultats de recherche.
    document.querySelectorAll(".ingredient-resultat").forEach(function(element)
    {
        const IdIngredient = Number(element.dataset.id);

        const EstSelectionne = IngredientsSelectionnes.some(function(ingredient)
        {
            return ingredient.id === IdIngredient;
        });

        element.classList.toggle("est-selectionne", EstSelectionne);

        let IndicationHTML = element.querySelector(".indication-ajout");

        if (EstSelectionne && !IndicationHTML)
        {
            IndicationHTML = document.createElement("span");
            IndicationHTML.className = "indication-ajout";
            IndicationHTML.textContent = "✓ Ajouté";

            element.appendChild(IndicationHTML);
        }
        else if (!EstSelectionne && IndicationHTML)
        {
            IndicationHTML.remove();
        }
    });

    // Actualisation du compteur d'ingrédients.
    if (CompteurIngredientsHTML)
    {
        const Nombre = IngredientsSelectionnes.length;

        CompteurIngredientsHTML.textContent =
            `${Nombre} ingrédient${Nombre > 1 ? "s" : ""} sélectionné${Nombre > 1 ? "s" : ""}`;
    }
}

// 3.3 Gestion des étapes de préparation
// Ajoute une étape au formulaire avec un texte facultatif.
function AjouterEtape(TexteInitial = "")
{
    // Création du conteneur de l'étape.
    const BlocEtapeHTML = document.createElement("div");
    BlocEtapeHTML.className = "etape";

    // Création du numéro de l'étape.
    const NumeroHTML = document.createElement("p");
    NumeroHTML.className = "numero-etape";

    // Création du conteneur du texte.
    const InfoEtapeHTML = document.createElement("div");
    InfoEtapeHTML.className = "info-etape";

    // Création du champ de saisie.
    const TexteHTML = document.createElement("textarea");
    TexteHTML.value = TexteInitial ?? "";
    TexteHTML.required = true;

    // Création du bouton de suppression.
    const BoutonSupprimerHTML = document.createElement("button");
    BoutonSupprimerHTML.type = "button";
    BoutonSupprimerHTML.className = "supprimer-etape";
    BoutonSupprimerHTML.textContent = "Supprimer";

    // Événement de suppression de cette étape.
    BoutonSupprimerHTML.addEventListener("click", function()
    {
        SupprimerEtape(BlocEtapeHTML);
    });

    // Construction de l'étape.
    InfoEtapeHTML.appendChild(TexteHTML);

    BlocEtapeHTML.appendChild(NumeroHTML);
    BlocEtapeHTML.appendChild(InfoEtapeHTML);
    BlocEtapeHTML.appendChild(BoutonSupprimerHTML);

    // Ajout de l'étape dans le formulaire.
    EtapesRecetteHTML.appendChild(BlocEtapeHTML);

    // Actualisation des numéros et des indices.
    MettreAJourNumerosEtapes();
}

// Supprime une étape du formulaire.
function SupprimerEtape(BlocEtapeHTML)
{
    // Supprime l'étape sélectionnée.
    BlocEtapeHTML.remove();

    // Conserve au moins une étape dans le formulaire.
    if (EtapesRecetteHTML.children.length === 0)
    {
        AjouterEtape();
    }

    // Réorganise les numéros après la suppression.
    MettreAJourNumerosEtapes();
}

// Met à jour la numérotation et les noms des champs.
function MettreAJourNumerosEtapes()
{
    const BlocsEtapesHTML = EtapesRecetteHTML.querySelectorAll(".etape");

    BlocsEtapesHTML.forEach(function(BlocEtapeHTML, index)
    {
        const NumeroHTML = BlocEtapeHTML.querySelector(".numero-etape");
        const TexteHTML = BlocEtapeHTML.querySelector("textarea");

        // Numéro visible pour l'utilisateur.
        NumeroHTML.textContent = index + 1;

        // Nom attendu par le Model Binder ASP.NET Core MVC.
        TexteHTML.name = `Etapes[${index}]`;

        // Texte indicatif du champ.
        TexteHTML.placeholder = `Décrivez l'étape ${index + 1}...`;
    });
}

// 3.4 Gestion de la difficulté
// Met à jour l'affichage de la difficulté et des toques.
function MettreAJourDifficulte()
{
    // Récupération de la difficulté actuelle.
    const Difficulte = Number(CurseurDifficulteHTML.value);

    // Conversion de la difficulté sur 10 en nombre de toques sur 5.
    const NombreToques = Difficulte / 2;

    // Affichage de la difficulté sur 10.
    ValeurDifficulteHTML.textContent = `${Difficulte} / 10`;

    // Affichage du nombre de toques.
    NombreToquesHTML.textContent =
        `${NombreToques.toLocaleString("fr-FR")} ${NombreToques <= 1 ? "toque" : "toques"}`;

    // Récupération des cinq toques.
    const ToquesHTML = ToquesDifficulteHTML.querySelectorAll(".toque");

    // Mise à jour du remplissage de chaque toque.
    ToquesHTML.forEach(function(ToqueHTML, index)
    {
        const ValeurToque = NombreToques - index;

        // Suppression des anciennes classes.
        ToqueHTML.classList.remove(
            "toque-active",
            "toque-inactive",
            "toque-demi"
        );

        if (ValeurToque >= 1)
        {
            // Toque entièrement remplie.
            ToqueHTML.classList.add("toque-active");
        }
        else if (ValeurToque >= 0.5)
        {
            // Toque remplie à moitié.
            ToqueHTML.classList.add("toque-demi");
        }
        else
        {
            // Toque vide.
            ToqueHTML.classList.add("toque-inactive");
        }
    });
}

// Met à jour la couleur de progression du curseur.
function ActualiserCouleurDifficulte()
{
    const Minimum = Number(CurseurDifficulteHTML.min);
    const Maximum = Number(CurseurDifficulteHTML.max);
    const Valeur = Number(CurseurDifficulteHTML.value);

    // Calcul de la progression en pourcentage.
    const Progression =
        ((Valeur - Minimum) / (Maximum - Minimum)) * 100;

    // Transmission de la progression au CSS.
    CurseurDifficulteHTML.style.setProperty(
        "--progression",
        `${Progression}%`
    );
}

// 3.5 Gestion de la photographie
// Affiche une photographie dans le formulaire.
function AfficherPhoto(CheminPhoto)
{
    if (!CheminPhoto)
    {
        ApercuPhotoHTML.removeAttribute("src");
        ApercuPhotoHTML.hidden = true;

        TexteAjoutPhotoHTML.hidden = false;
        return;
    }

    // Affichage de la photographie.
    ApercuPhotoHTML.src = CheminPhoto;
    ApercuPhotoHTML.hidden = false;

    // Masque le message d'ajout de photographie.
    TexteAjoutPhotoHTML.hidden = true;
}

// Affiche l'aperçu d'une nouvelle photographie sélectionnée.
function RemplacerPhoto()
{
    const FichierSelectionne = PhotoRecetteHTML.files[0];

    if (!FichierSelectionne)
    {
        return;
    }

    // Création d'une URL temporaire pour l'aperçu.
    const URLPhoto = URL.createObjectURL(FichierSelectionne);

    // Affichage de la nouvelle photographie.
    AfficherPhoto(URLPhoto);

    // Une nouvelle photographie annule la demande de suppression.
    SupprimerPhotoHTML.checked = false;

    // Libération de l'URL temporaire après chargement.
    ApercuPhotoHTML.addEventListener("load", function LibererURL()
    {
        URL.revokeObjectURL(URLPhoto);
    }, { once: true });
}

// Supprime la photographie de l'interface.
function SupprimerPhotoRecette()
{
    // Retire le fichier éventuellement sélectionné.
    PhotoRecetteHTML.value = "";

    // Indique au serveur que la photographie doit être supprimée.
    SupprimerPhotoHTML.checked = true;

    // Retire l'aperçu.
    AfficherPhoto(null);
}

// 3.6 Fonctions communes de mise à jour
// Actualise les différents éléments du formulaire.
function ActualiserFormulaire()
{
    // Actualisation des catégories sélectionnées.
    ActualiserAffichageCategories();

    // Actualisation des ingrédients sélectionnés.
    MettreAJourIndicesIngredients();
    ActualiserAffichageIngredients();

    // Actualisation des étapes de préparation.
    MettreAJourNumerosEtapes();

    // Actualisation de la difficulté.
    MettreAJourDifficulte();
    ActualiserCouleurDifficulte();
}

// ============================================================
// 4. ÉVÉNEMENTS
// ============================================================

// 4.1 Événements des catégories
// Recherche d'une catégorie.

RechercheCategorieHTML.addEventListener("input", function()
{
    const Recherche = RechercheCategorieHTML.value
        .trim()
        .toLowerCase();

    CategoriesResultatsHTML.forEach(function(CategorieHTML)
    {
        const NomCategorie = CategorieHTML.dataset.nom.toLowerCase();

        CategorieHTML.style.display =
            NomCategorie.includes(Recherche) ? "" : "none";
    });
});


// Sélection d'une catégorie.
CategoriesResultatsHTML.forEach(function(CategorieHTML)
{
    CategorieHTML.addEventListener("click", function()
    {
        const IdCategorie = CategorieHTML.dataset.id;
        const NomCategorie = CategorieHTML.dataset.nom;

        AjouterCategorie(IdCategorie, NomCategorie);
    });
});


// Ouverture de la fenêtre modale.
OuvrirModalCategoriesHTML.addEventListener("click", function()
{
    ModalCategoriesHTML.style.display = "flex";
    RechercheCategorieHTML.focus();
});


// Fermeture avec la croix.
FermerModalCategoriesHTML.addEventListener("click", function()
{
    ModalCategoriesHTML.style.display = "none";
});


// Fermeture avec le bouton Terminer.
TerminerModalCategoriesHTML.addEventListener("click", function()
{
    ModalCategoriesHTML.style.display = "none";
});


// Fermeture en cliquant à l'extérieur de la fenêtre.
ModalCategoriesHTML.addEventListener("click", function(event)
{
    if (event.target === ModalCategoriesHTML)
    {
        ModalCategoriesHTML.style.display = "none";
    }
});

// 4.2 Événements des ingrédients

// Recherche dynamique des ingrédients.
RechercheIngredientHTML.addEventListener("input", function()
{
    const Recherche = RechercheIngredientHTML.value
        .trim()
        .toLowerCase();

    // Réinitialisation des résultats.
    ResultatsIngredientsHTML.innerHTML = "";

    // Aucun résultat tant que la recherche est vide.
    if (Recherche === "")
    {
        return;
    }

    // Recherche dans les ingrédients disponibles.
    const IngredientsFiltres = IngredientsDisponibles.filter(function(ingredient)
    {
        return ingredient.nom.toLowerCase().includes(Recherche);
    });

    // Création des résultats.
    IngredientsFiltres.forEach(function(ingredient)
    {
        const IngredientHTML = document.createElement("div");
        IngredientHTML.className = "ingredient-resultat";

        // Identifiant utilisé pour vérifier la sélection.
        IngredientHTML.dataset.id = ingredient.id;

        // Nom affiché dans le résultat.
        const NomIngredientHTML = document.createElement("span");
        NomIngredientHTML.textContent = ingredient.nom;

        IngredientHTML.appendChild(NomIngredientHTML);

        // Ajout de l'ingrédient au clic.
        IngredientHTML.addEventListener("click", function()
        {
            AjouterIngredient(ingredient.id, ingredient.nom);
        });

        ResultatsIngredientsHTML.appendChild(IngredientHTML);
    });

    // Actualisation des indications de sélection.
    ActualiserAffichageIngredients();
});


// Ouverture de la fenêtre modale.
OuvrirModalIngredientsHTML.addEventListener("click", function()
{
    ModalIngredientsHTML.style.display = "flex";
    RechercheIngredientHTML.focus();
});


// Fermeture avec la croix.
FermerModalIngredientsHTML.addEventListener("click", function()
{
    ModalIngredientsHTML.style.display = "none";
});


// Fermeture avec le bouton Terminer.
TerminerModalIngredientsHTML.addEventListener("click", function()
{
    ModalIngredientsHTML.style.display = "none";
});


// Fermeture en cliquant à l'extérieur de la fenêtre.
ModalIngredientsHTML.addEventListener("click", function(event)
{
    if (event.target === ModalIngredientsHTML)
    {
        ModalIngredientsHTML.style.display = "none";
    }
});

// 4.3 Événements des étapes

// Ajout d'une nouvelle étape de préparation.
BoutonAjouterEtapeHTML.addEventListener("click", function()
{
    AjouterEtape();
});

// 4.4 Événements de la difficulté

// Mise à jour de la difficulté lorsque le curseur est déplacé.
CurseurDifficulteHTML.addEventListener("input", function()
{
    MettreAJourDifficulte();
    ActualiserCouleurDifficulte();
});

// 4.5 Événements de la photographie

// Ouverture de l'explorateur de fichiers.
BoutonAjouterImageHTML.addEventListener("click", function()
{
    PhotoRecetteHTML.click();
});


// Affichage de l'aperçu après sélection d'une photographie.
PhotoRecetteHTML.addEventListener("change", function()
{
    RemplacerPhoto();
});


// Suppression de la photographie.
BoutonSupprimerPhotoHTML.addEventListener("click", function()
{
    SupprimerPhotoRecette();
});

// 4.6 Événements des fenêtres modales

// Fermeture des fenêtres modales avec la touche Échap.
document.addEventListener("keydown", function(event)
{
    if (event.key !== "Escape")
    {
        return;
    }

    // Fermeture de la fenêtre des catégories.
    if (ModalCategoriesHTML.style.display === "flex")
    {
        ModalCategoriesHTML.style.display = "none";
    }

    // Fermeture de la fenêtre des ingrédients.
    if (ModalIngredientsHTML.style.display === "flex")
    {
        ModalIngredientsHTML.style.display = "none";
    }
});

// ============================================================
// 5. INITIALISATION DES DONNÉES EXISTANTES
// ============================================================

// 5.1 Initialisation des catégories
// Charge les catégories déjà associées à la recette.
function InitialiserCategories()
{
    DonneesRecetteInitiales.categories.forEach(function(IdCategorie)
    {
        // Recherche de la catégorie dans les résultats disponibles.
        const CategorieHTML = Array.from(CategoriesResultatsHTML).find(
            function(element)
            {
                return Number(element.dataset.id) === Number(IdCategorie);
            }
        );

        // Si la catégorie existe, on l'ajoute au formulaire.
        if (CategorieHTML)
        {
            AjouterCategorie(
                CategorieHTML.dataset.id,
                CategorieHTML.dataset.nom
            );
        }
    });
}

// 5.2 Initialisation des ingrédients 
// Charge les ingrédients déjà associés à la recette.
function InitialiserIngredients()
{
    DonneesRecetteInitiales.ingredients.forEach(function(ingredient)
    {
        // Recherche de l'ingrédient dans la liste disponible.
        const IngredientDisponible = IngredientsDisponibles.find(
            function(element)
            {
                return Number(element.id) === Number(ingredient.id);
            }
        );

        // Si l'ingrédient existe, on l'ajoute avec sa quantité.
        if (IngredientDisponible)
        {
            AjouterIngredient(
                IngredientDisponible.id,
                IngredientDisponible.nom,
                ingredient.quantite
            );
        }
    });
}

// 5.3 Initialisation des étapes de préparation 
// Charge les étapes déjà enregistrées de la recette.
function InitialiserEtapes()
{
    const EtapesInitiales = DonneesRecetteInitiales.etapes;

    // Si la recette ne possède aucune étape, on en crée une vide.
    if (EtapesInitiales.length === 0)
    {
        AjouterEtape();
        return;
    }

    // Chargement des étapes existantes.
    EtapesInitiales.forEach(function(TexteEtape)
    {
        AjouterEtape(TexteEtape);
    });
}

// 5.4 Initialisation de la photographie
// Charge la photographie actuelle de la recette.
function InitialiserPhoto()
{
    // Récupération du chemin de la photographie enregistrée.
    const PhotoActuelle = DonneesRecetteInitiales.photo;

    // Aucune suppression demandée au chargement.
    SupprimerPhotoHTML.value = "false";

    // Affichage de la photographie existante.
    if (PhotoActuelle)
    {
        AfficherPhoto(PhotoActuelle);
    }
    else
    {
        // Affichage du message d'ajout si aucune photo n'existe.
        AfficherPhoto(null);
    }
}

// ============================================================
// 6. DÉMARRAGE DU SCRIPT
// ============================================================

// Appel des fonctions d'initialisation
// Initialise le formulaire avec les données de la recette.
function InitialiserFormulaire()
{
    // Chargement des catégories existantes.
    InitialiserCategories();

    // Chargement des ingrédients et de leurs quantités.
    InitialiserIngredients();

    // Chargement des étapes de préparation.
    InitialiserEtapes();

    // Chargement de la photographie actuelle.
    InitialiserPhoto();

    // Synchronisation de l'affichage.
    ActualiserFormulaire();
}

// Démarrage de l'initialisation.
InitialiserFormulaire();


