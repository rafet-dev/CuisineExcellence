-- création des tables --
create table recettes 
(
	id_recette int4 not null primary key,
	nom varchar(100) not null,
	temps_preparation interval not null,
	temps_cuisson interval not null,
	difficulte int2 not null,
	photo varchar(100),
	createur int4
);

create table etapes
(
	numero_etape int4 not null,
	id_recette int4 not null, 
	texte varchar(200) not null
);

create table avis
(
	id_recette int4 not null,
	id_utilisateur int4 not null,
	note int2 not null,
	commentaire varchar(500)
);

create table ingredients_recettes
(
	id_ingredient int4 not null,
	id_recette int4 not null,
	quantite varchar(40)
);

create table ingredients
(
	id_ingredient int4 not null primary key,
	nom varchar(50) not null unique
);

create table utilisateurs
(
	id_utilisateur int4 not null primary key,
	identifiant varchar(20) not null unique,
	email varchar(50) not null unique,
	password varchar(30) not null
);

create table categories
(
	id_categorie int4 not null primary key,
	nom varchar(50) not null unique
);

create table categories_recettes
(
	id_categorie int4 not null,
	id_recette int4 not null
);

-- déclaration des clés composées --
alter table avis 
add primary key(id_recette, id_utilisateur);

alter table ingredients_recettes
add primary key(id_recette, id_ingredient);

alter table categories_recettes
add primary key(id_recette, id_categorie);

alter table etapes
add primary key(id_recette, numero_etape);


-- déclaration des clés étrangères --
alter table avis
add constraint avis_idr_fk foreign key (id_recette) references recettes(id_recette);

alter table avis
add constraint avis_idu_fk foreign key (id_utilisateur) references utilisateurs(id_utilisateur);

alter table etapes
add constraint etapes_idr_fk foreign key (id_recette) references recettes(id_recette);

alter table ingredients_recettes 
add constraint ir_idi_fk foreign key (id_ingredient) references ingredients(id_ingredient);

alter table ingredients_recettes 
add constraint ir_idr_fk foreign key (id_recette) references recettes(id_recette);

alter table categories_recettes 
add constraint cr_idc_fk foreign key (id_categorie) references categories(id_categorie);

alter table categories_recettes 
add constraint cr_idr_fk foreign key (id_recette) references recettes(id_recette);

alter table recettes 
add constraint recette_createur_fk foreign key(createur) references utilisateurs(id_utilisateur);

-- insertion de données --

INSERT INTO ingredients (id_ingredient, nom) VALUES
(1, 'Farine'),
(2, 'Sucre'),
(3, 'Sel'),
(4, 'Beurre'),
(5, 'Œuf'),
(6, 'Lait'),
(7, 'Levure'),
(8, 'Vanille'),
(9, 'Chocolat'),
(10, 'Amande'),
(11, 'Huile d’olive'),
(12, 'Poivre noir'),
(13, 'Cumin'),
(14, 'Paprika'),
(15, 'Cannelle'),
(16, 'Miel'),
(17, 'Moutarde'),
(18, 'Vinaigre balsamique'),
(19, 'Tomate'),
(20, 'Oignon'),
(21, 'Ail'),
(22, 'Carotte'),
(23, 'Courgette'),
(24, 'Aubergine'),
(25, 'Poivron rouge'),
(26, 'Pomme de terre'),
(27, 'Riz'),
(28, 'Pâtes'),
(29, 'Lentilles'),
(30, 'Pois chiches'),
(31, 'Poulet'),
(32, 'Bœuf'),
(33, 'Saumon'),
(34, 'Thon'),
(35, 'Crevettes'),
(36, 'Crème fraîche'),
(37, 'Yaourt nature'),
(38, 'Parmesan'),
(39, 'Mozzarella'),
(40, 'Feta'),
(41, 'Citron'),
(42, 'Citron vert'),
(43, 'Orange'),
(44, 'Pomme'),
(45, 'Poire'),
(46, 'Fraise'),
(47, 'Framboise'),
(48, 'Myrtille'),
(49, 'Banane'),
(50, 'Avocat'),
(51, 'Champignon de Paris'),
(52, 'Épinard'),
(53, 'Brocoli'),
(54, 'Chou-fleur'),
(55, 'Haricot vert'),
(56, 'Maïs'),
(57, 'Patate douce'),
(58, 'Gingembre'),
(59, 'Persil'),
(60, 'Basilic'),
(61, 'Thym'),
(62, 'Romarin'),
(63, 'Coriandre'),
(64, 'Ciboulette'),
(65, 'Laurier'),
(66, 'Piment'),
(67, 'Noix de muscade'),
(68, 'Origan'),
(69, 'Aneth'),
(70, 'Sauce soja'),
(71, 'Farine de maïs'),
(72, 'Fécule de maïs'),
(73, 'Levure chimique'),
(74, 'Bicarbonate de soude'),
(75, 'Sucre roux'),
(76, 'Sucre glace'),
(77, 'Sirop d’érable'),
(79, 'Pâte brisée'),
(80, 'Noisette'),
(81, 'Noix'),
(82, 'Pistache'),
(83, 'Noix de coco râpée'),
(84, 'Graines de sésame'),
(85, 'Graines de chia'),
(86, 'Flocons d’avoine'),
(87, 'Quinoa'),
(88, 'Boulgour'),
(89, 'Semoule'),
(90, 'Haricots rouges'),
(91, 'Haricots blancs'),
(92, 'Petits pois'),
(93, 'Chou rouge'),
(94, 'Poireau'),
(95, 'Céleri'),
(96, 'Radis'),
(97, 'Concombre'),
(98, 'Courge butternut'),
(99, 'Lait de coco'),
(100, 'Bouillon de légumes'),
(101, 'Lentilles corail'),
(102, 'Pois cassés'),
(103, 'Haricots noirs'),
(104, 'Tofu'),
(105, 'Lait de soja'),
(106, 'Lait d’amande'),
(107, 'Œuf de caille'),
(108, 'Lardons'),
(109, 'Jambon'),
(110, 'Saucisse'),
(111, 'Agneau'),
(112, 'Dinde'),
(113, 'Cabillaud'),
(114, 'Morue'),
(115, 'Moules'),
(116, 'Calamar'),
(117, 'Noix de Saint-Jacques'),
(118, 'Ricotta'),
(119, 'Mascarpone'),
(120, 'Gorgonzola'),
(121, 'Comté'),
(122, 'Chèvre frais'),
(123, 'Crème liquide'),
(124, 'Lait concentré'),
(125, 'Chocolat blanc'),
(126, 'Cacao en poudre'),
(127, 'Pâte de tomate'),
(128, 'Câpres'),
(129, 'Olives noires'),
(130, 'Cornichons'),
(131, 'Pâte de curry'),
(132, 'Sauce tomate'),
(133, 'Sauce Worcestershire'),
(134, 'Sauce nuoc-mâm'),
(135, 'Pesto'),
(136, 'Tahini'),
(137, 'Miso'),
(138, 'Lait de riz'),
(139, 'Lait d’avoine'),
(140, 'Crème de soja'),
(141, 'Artichaut'),
(142, 'Asperge'),
(143, 'Fenouil'),
(144, 'Chou de Bruxelles'),
(145, 'Endive'),
(146, 'Betterave'),
(147, 'Navet'),
(148, 'Potimarron'),
(149, 'Céleri-rave'),
(150, 'Panais'),
(151, 'Échalote'),
(152, 'Oignon rouge'),
(153, 'Ail en poudre'),
(154, 'Piment de Cayenne'),
(155, 'Curcuma'),
(156, 'Cardamome'),
(157, 'Clou de girofle'),
(158, 'Graines de moutarde'),
(159, 'Graines de fenouil'),
(160, 'Noix de cajou'),
(161, 'Pois gourmands'),
(162, 'Pak-choï'),
(163, 'Chou kale'),
(164, 'Roquette'),
(165, 'Mâche'),
(166, 'Laitue'),
(167, 'Cresson'),
(168, 'Germes de soja'),
(169, 'Pousses d’épinard'),
(170, 'Tomates séchées'),
(171, 'Artichauts marinés'),
(172, 'Poivron jaune'),
(173, 'Poivron vert'),
(174, 'Piment jalapeño'),
(175, 'Prune'),
(176, 'Abricot'),
(177, 'Pêche'),
(178, 'Mangue'),
(179, 'Ananas'),
(180, 'Kiwi'),
(181, 'Raisin'),
(182, 'Datte'),
(183, 'Figues sèches'),
(184, 'Canneberges séchées'),
(185, 'Graines de courge'),
(186, 'Graines de tournesol'),
(187, 'Pignons de pin'),
(188, 'Farine de sarrasin'),
(189, 'Farine complète'),
(190, 'Polenta'),
(191, 'Farine de riz'),
(192, 'Farine de pois chiches'),
(193, 'Farine d’épeautre'),
(194, 'Tapioca'),
(195, 'Vermicelles de riz'),
(196, 'Nouilles udon'),
(197, 'Nouilles soba'),
(198, 'Pâte miso'),
(199, 'Feuilles de riz'),
(200, 'Feuilles de brick'),
(201, 'Châtaigne'),
(202, 'Pâte d’amande'),
(203, 'Praliné'),
(204, 'Mélasse'),
(205, 'Sucre vanillé'),
(206, 'Eau de fleur d’oranger'),
(207, 'Extrait d’amande amère'),
(208, 'Zeste de citron'),
(209, 'Zeste d’orange'),
(210, 'Anchois'),
(211, 'Sardine'),
(212, 'Truite'),
(213, 'Merlu'),
(214, 'Poulpe'),
(215, 'Pancetta'),
(216, 'Chorizo'),
(217, 'Bacon'),
(218, 'Tempeh'),
(219, 'Seitan'),
(220, 'Algues nori'),
(221, 'Lait ribot'),
(222, 'Petit-suisse'),
(223, 'Fromage blanc'),
(224, 'Burrata'),
(225, 'Boursin'),
(226, 'Roquefort'),
(227, 'Bleu d’Auvergne'),
(228, 'Mimolette'),
(229, 'Reblochon'),
(230, 'Raclette'),
(231, 'Jambon cru'),
(232, 'Jambon de Parme'),
(233, 'Saucisse fumée'),
(234, 'Boudin noir'),
(235, 'Foie gras'),
(236, 'Crevettes séchées'),
(237, 'Pâte feuilletée'),
(238, 'Pâte à filo'),
(239, 'Champignons shiitakés'),
(240, 'Pleurotes'),
(241, 'Enoki'),
(242, 'Morilles'),
(243, 'Haricots mungo'),
(244, 'Edamame'),
(245, 'Chou chinois'),
(246, 'Pousses de bambou'),
(247, 'Châtaignes d’eau'),
(248, 'Poivre de Sichuan'),
(249, 'Piment d’Espelette'),
(250, 'Safran'),
(251, 'Piment chipotle'),
(252, 'Harissa'),
(253, 'Garam masala'),
(254, 'Curry en poudre'),
(255, 'Mélange cinq-épices'),
(256, 'Zaatar'),
(257, 'Sumac'),
(258, 'Fenugrec'),
(259, 'Graines de coriandre'),
(260, 'Graines de pavot'),
(261, 'Graines de lin'),
(262, 'Graines de nigelle'),
(263, 'Noix de pécan'),
(264, 'Noix du Brésil'),
(265, 'Macadamia'),
(266, 'Beurre de cacahuète'),
(267, 'Purée de noisette'),
(268, 'Purée de sésame'),
(269, 'Sirop d’agave'),
(270, 'Marmelade d’orange'),
(271, 'Confiture de framboise'),
(272, 'Compote de pomme'),
(273, 'Poires au sirop'),
(274, 'Raisins secs'),
(275, 'Pruneaux'),
(276, 'Miso rouge'),
(277, 'Vinaigre de cidre'),
(278, 'Vinaigre de riz'),
(279, 'Huile de sésame'),
(280, 'Huile de noix');

insert INTO ingredients(id_ingredient, nom) VALUES
(78, 'Porc'),
(281, 'Wasabi'),
(282, 'Pâte à pizza'),
(283, 'Pastèque'),
(284, 'Magret de canard'),
(285, 'Pâte à raviolis'),
(286, 'Canard'),
(287, 'Veau'),
(288, 'Filet mignon de porc'),
(289, 'Escalope de veau'),
(290, 'Viande hachée'),
(291, 'Dorade'),
(292, 'Bar'),
(293, 'Maquereau'),
(294, 'Coquilles Saint-Jacques'),
(295, 'Fromage frais'),
(296, 'Crème de coco'),
(297, 'Emmental'),
(298, 'Gruyère'),
(299, 'Courgette jaune'),
(300, 'Tomate cerise'),
(301, 'Pois mange-tout'),
(302, 'Champignon de Paris brun'),
(303, 'Gingembre moulu'),
(304, 'Piment doux'),
(305, 'Epice de cajun'),
(306, 'Sauce Teriyaki'),
(307, 'Mayonnaise'),
(308, 'Ketchup'),
(309, 'Gélatine'),
(310, 'Agar-Agar'),
(311, 'Noix de coco'),
(312, 'Poudre d''amande'),
(313, 'Pépites de chocolat'),
(314, 'Chocolat noir'),
(315, 'Pâte à choux');

------------------------------------------------------------------------------------------
INSERT INTO categories (id_categorie, nom) VALUES
(1, 'Entrées'),
(2, 'Plats'),
(3, 'Desserts'),
(4, 'Apéritifs'),
(5, 'Salades'),
(6, 'Soupes'),
(7, 'Pâtes et riz'),
(8, 'Viandes'),
(9, 'Poissons et fruits de mer'),
(10, 'Végétarien'),
(11, 'Vegan'),
(12, 'Cuisine du monde'),
(13, 'Cuisine française'),
(14, 'Cuisine italienne'),
(15, 'Cuisine asiatique'),
(16, 'Petit-déjeuner'),
(17, 'Brunch'),
(18, 'Goûter'),
(19, 'Sauces et accompagnements'),
(20, 'Boissons'),
(21, 'Pain et boulangerie'),
(22, 'Pâtisserie'),
(23, 'Recettes rapides'),
(24, 'Recettes de saison'),
(25, 'Recettes festives'),
(26, 'Amuse-bouches'),
(27, 'Tartes salées'),
(28, 'Quiches'),
(29, 'Tartines'),
(30, 'Sandwichs'),
(31, 'Burgers'),
(32, 'Gratins'),
(33, 'Risottos'),
(34, 'Woks'),
(35, 'Currys'),
(36, 'Rôtis'),
(37, 'Grillades'),
(38, 'Brochettes'),
(39, 'Fruits de mer'),
(40, 'Œufs'),
(41, 'Fromages'),
(42, 'Légumineuses'),
(43, 'Légumes'),
(44, 'Fruits'),
(45, 'Céréales'),
(46, 'Chocolat'),
(47, 'Glaces et sorbets'),
(48, 'Biscuits et cookies'),
(49, 'Mousses et crèmes'),
(50, 'Tartes sucrées'),
(51, 'Confitures'),
(52, 'Gâteaux'),
(53, 'Smoothies'),
(54, 'Cocktails sans alcool'),
(55, 'Boissons chaudes'),
(56, 'Conserves maison'),
(57, 'Fermentation'),
(58, 'Cuisine anti-gaspillage'),
(59, 'Recettes économiques'),
(60, 'Recettes sans gluten'),
(61, 'Cuisine méditerranéenne'),
(62, 'Cuisine mexicaine'),
(63, 'Cuisine indienne'),
(64, 'Cuisine orientale'),
(65, 'Cuisine créole'),
(66, 'Cuisine nordique'),
(67, 'Cuisine américaine'),
(68, 'Cuisine espagnole'),
(69, 'Cuisine grecque'),
(70, 'Cuisine marocaine'),
(71, 'Cuisine japonaise'),
(72, 'Cuisine thaïlandaise'),
(73, 'Cuisine libanaise'),
(74, 'Cuisine africaine'),
(75, 'Cuisson au four'),
(76, 'Cuisson à la vapeur'),
(77, 'Cuisson à la poêle'),
(78, 'Cuisson au barbecue'),
(79, 'Cuisson en cocotte'),
(80, 'Cuisine sous vide'),
(81, 'Recettes sans lactose'),
(82, 'Recettes sans œufs'),
(83, 'Recettes végétales'),
(84, 'Recettes protéinées'),
(85, 'Recettes légères'),
(86, 'Recettes gourmandes'),
(87, 'Recettes familiales'),
(88, 'Recettes pour enfants'),
(89, 'Recettes à préparer à l’avance'),
(90, 'Batch cooking');
-----------------------------------------------------------------------------------------------------------------
INSERT INTO utilisateurs (id_utilisateur, identifiant, email, password) VALUES
(1, 'ChefGourmand', 'chef.gourmand@example.com', 'Cuisine2026!'),
(2, 'MarieCuisine', 'marie.cuisine@example.com', 'Recette2026!'),
(3, 'PaulGourmet', 'paul.gourmet@example.com', 'Gourmet2026!'),
(4, 'SophieCook', 'sophie.cook@example.com', 'CuisineSophie!'),
(5, 'LucasCuisine', 'lucas.cuisine@example.com', 'Lucas2026!'),
(6, 'EmmaGourmande', 'emma.gourmande@example.com', 'EmmaCuisine!'),
(7, 'JulieRecettes', 'julie.recettes@example.com', 'Julie2026!'),
(8, 'ThomasChef', 'thomas.chef@example.com', 'ThomasCook!'),
(9, 'ClaireGourmet', 'claire.gourmet@example.com', 'Claire2026!'),
(10, 'AntoineCuisine', 'antoine.cuisine@example.com', 'AntoineCook!'),
(11, 'LauraGourmande', 'laura.gourmande@example.com', 'Laura2026!'),
(12, 'NicolasChef', 'nicolas.chef@example.com', 'NicolasCook!'),
(13, 'CamilleCuisine', 'camille.cuisine@example.com', 'Camille2026!'),
(14, 'AlexGourmet', 'alex.gourmet@example.com', 'AlexCuisine!'),
(15, 'JulieChef', 'julie.chef@example.com', 'JulieChef2026!'),
(16, 'MaxGourmand', 'max.gourmand@example.com', 'MaxCuisine2026!'),
(17, 'AliceRecettes', 'alice.recettes@example.com', 'AliceCook2026!'),
(18, 'HugoCuisine', 'hugo.cuisine@example.com', 'HugoGourmet!'),
(19, 'ChloeGourmet', 'chloe.gourmet@example.com', 'ChloeCuisine!'),
(20, 'LouisCuisine', 'louis.cuisine@example.com', 'LouisChef2026!');
-----------------------------------------------------------------------------------------------------------------
INSERT INTO recettes
(id_recette, createur, difficulte, nom, photo, temps_cuisson, temps_preparation)
VALUES

(1, 1, 2,
'Saucisse de Morteau à l''aubergine',
'aubergine-saucisse-de-morteau.jpeg',
INTERVAL '30 minutes',
INTERVAL '20 minutes'),

(2, 2, 3,
'Saumon à la plancha, crème au wasabi',
'saumon-315x420.jpeg',
INTERVAL '15 minutes',
INTERVAL '20 minutes'),

(3, 3, 2,
'Pizza à la pastèque',
'pizza-pasteque-315x420.jpg',
INTERVAL '10 minutes',
INTERVAL '15 minutes'),

(4, 4, 2,
'Risotto crémeux aux champignons',
'risotto-champignons.jpg',
INTERVAL '25 minutes',
INTERVAL '15 minutes'),

(5, 5, 1,
'Tarte fine aux tomates et au basilic',
'tarte-tomates-basilic.jpg',
INTERVAL '25 minutes',
INTERVAL '15 minutes'),

(6, 6, 3,
'Poulet rôti au citron et au romarin',
'poulet-citron-romarin.jpg',
INTERVAL '1 hour',
INTERVAL '20 minutes'),

(7, 7, 2,
'Velouté de courge et châtaignes',
'veloute-courge-chataignes.jpg',
INTERVAL '30 minutes',
INTERVAL '15 minutes'),

(8, 8, 1,
'Pâtes crémeuses aux épinards',
'pates-cremeuses-epinards.jpg',
INTERVAL '15 minutes',
INTERVAL '10 minutes'),

(9, 9, 3,
'Magret de canard aux fruits rouges',
'magret-fruits-rouges.jpg',
INTERVAL '20 minutes',
INTERVAL '25 minutes'),

(10, 10, 1,
'Salade fraîcheur avocat, mangue et crevettes',
'salade-avocat-mangue-crevettes.jpg',
INTERVAL '5 minutes',
INTERVAL '20 minutes'),

(11, 11, 2,
'Curry de pois chiches au lait de coco',
'curry-pois-chiches.jpg',
INTERVAL '30 minutes',
INTERVAL '15 minutes'),

(12, 12, 2,
'Cabillaud rôti aux tomates et olives',
'cabillaud-tomates-olives.jpg',
INTERVAL '25 minutes',
INTERVAL '15 minutes'),

(13, 13, 2,
'Quiche aux poireaux et au chèvre',
'quiche-poireaux-chevre.jpg',
INTERVAL '35 minutes',
INTERVAL '20 minutes'),

(14, 14, 1,
'Bowl quinoa, avocat et légumes croquants',
'bowl-quinoa-avocat.jpg',
INTERVAL '10 minutes',
INTERVAL '20 minutes'),

(15, 15, 3,
'Bœuf sauté aux légumes façon wok',
'boeuf-legumes-wok.jpg',
INTERVAL '15 minutes',
INTERVAL '20 minutes'),

(16, 16, 2,
'Tarte aux pommes et à la cannelle',
'tarte-pommes-cannelle.jpg',
INTERVAL '35 minutes',
INTERVAL '20 minutes'),

(17, 17, 2,
'Mousse au chocolat',
'mousse-chocolat.jpg',
INTERVAL '0 minutes',
INTERVAL '20 minutes'),

(18, 18, 1,
'Pancakes à la banane et au sirop d''érable',
'pancakes-banane.jpg',
INTERVAL '10 minutes',
INTERVAL '15 minutes'),

(19, 19, 2,
'Salade méditerranéenne à la feta',
'salade-mediterraneenne-feta.jpg',
INTERVAL '0 minutes',
INTERVAL '20 minutes'),

(20, 20, 3,
'Saumon au gingembre et à la sauce soja',
'saumon-gingembre-soja.jpg',
INTERVAL '20 minutes',
INTERVAL '15 minutes'),

(21, 1, 1,
'Bruschettas tomates, mozzarella et basilic',
'bruschettas-tomates-mozzarella.jpg',
INTERVAL '10 minutes',
INTERVAL '15 minutes'),

(22, 2, 2,
'Œufs cocotte aux épinards et à la crème',
'oeufs-cocotte-epinards.jpg',
INTERVAL '15 minutes',
INTERVAL '10 minutes'),

(23, 3, 1,
'Salade de lentilles, feta et légumes grillés',
'salade-lentilles-feta.jpg',
INTERVAL '20 minutes',
INTERVAL '15 minutes'),

(24, 4, 2,
'Gratin de pommes de terre au comté',
'gratin-pommes-de-terre-comte.jpg',
INTERVAL '45 minutes',
INTERVAL '20 minutes'),

(25, 5, 3,
'Lasagnes végétariennes aux légumes',
'lasagnes-vegetariennes.jpg',
INTERVAL '45 minutes',
INTERVAL '30 minutes'),

(26, 6, 2,
'Curry de poulet au lait de coco',
'curry-poulet-coco.jpg',
INTERVAL '30 minutes',
INTERVAL '20 minutes'),

(27, 7, 2,
'Crevettes sautées à l''ail et au citron vert',
'crevettes-ail-citron-vert.jpg',
INTERVAL '10 minutes',
INTERVAL '15 minutes'),

(28, 8, 3,
'Risotto aux asperges et parmesan',
'risotto-asperges-parmesan.jpg',
INTERVAL '30 minutes',
INTERVAL '15 minutes'),

(29, 9, 2,
'Tacos de bœuf aux poivrons et guacamole',
'tacos-boeuf-poivrons.jpg',
INTERVAL '15 minutes',
INTERVAL '25 minutes'),

(30, 10, 3,
'Pad thaï aux crevettes',
'pad-thai-crevettes.jpg',
INTERVAL '15 minutes',
INTERVAL '25 minutes'),

(31, 11, 2,
'Dahl de lentilles corail au curry',
'dahl-lentilles-corail.jpg',
INTERVAL '30 minutes',
INTERVAL '15 minutes'),

(32, 12, 3,
'Tajine d''agneau aux pruneaux et amandes',
'tajine-agneau-pruneaux.jpg',
INTERVAL '1 hour 30 minutes',
INTERVAL '25 minutes'),

(33, 13, 3,
'Moussaka aux aubergines et au bœuf',
'moussaka-aubergines-boeuf.jpg',
INTERVAL '1 hour',
INTERVAL '40 minutes'),

(34, 14, 2,
'Galettes de pois chiches aux herbes',
'galettes-pois-chiches.jpg',
INTERVAL '15 minutes',
INTERVAL '20 minutes'),

(35, 15, 2,
'Gnocchis poêlés aux champignons et parmesan',
'gnocchis-champignons-parmesan.jpg',
INTERVAL '15 minutes',
INTERVAL '15 minutes'),

(36, 16, 2,
'Focaccia aux tomates et au romarin',
'focaccia-tomates-romarin.jpg',
INTERVAL '25 minutes',
INTERVAL '20 minutes'),

(37, 17, 1,
'Crumble aux pommes et aux noix',
'crumble-pommes-noix.jpg',
INTERVAL '30 minutes',
INTERVAL '15 minutes'),

(38, 18, 3,
'Cheesecake aux fruits rouges',
'cheesecake-fruits-rouges.jpg',
INTERVAL '45 minutes',
INTERVAL '30 minutes'),

(39, 19, 2,
'Panna cotta à la vanille et aux framboises',
'panna-cotta-framboises.jpg',
INTERVAL '5 minutes',
INTERVAL '20 minutes'),

(40, 20, 1,
'Smoothie mangue, banane et lait d''amande',
'smoothie-mangue-banane.jpg',
INTERVAL '0 minutes',
INTERVAL '10 minutes'), 

(41, 1, 1,
'Velouté de brocoli au parmesan',
'veloute-brocoli-parmesan.jpg',
INTERVAL '25 minutes',
INTERVAL '15 minutes'),

(42, 2, 2,
'Tartare de saumon à l''avocat et au citron vert',
'tartare-saumon-avocat.jpg',
INTERVAL '0 minutes',
INTERVAL '20 minutes'),

(43, 3, 3,
'Poulet tikka masala',
'poulet-tikka-masala.jpg',
INTERVAL '35 minutes',
INTERVAL '25 minutes'),

(44, 4, 2,
'Poivrons farcis au quinoa et à la feta',
'poivrons-farcis-quinoa-feta.jpg',
INTERVAL '35 minutes',
INTERVAL '20 minutes'),

(45, 5, 3,
'Brandade de morue traditionnelle',
'brandade-morue.jpg',
INTERVAL '40 minutes',
INTERVAL '30 minutes'),

(46, 6, 2,
'Courgettes farcies aux lentilles et légumes',
'courgettes-farcies-lentilles.jpg',
INTERVAL '35 minutes',
INTERVAL '25 minutes'),

(47, 7, 3,
'Raviolis aux épinards et à la ricotta',
'raviolis-epinards-ricotta.jpg',
INTERVAL '10 minutes',
INTERVAL '45 minutes'),

(48, 8, 2,
'Moules au curry et lait de coco',
'moules-curry-coco.jpg',
INTERVAL '15 minutes',
INTERVAL '20 minutes'),

(49, 9, 1,
'Brochettes de poulet au paprika et citron',
'brochettes-poulet-paprika.jpg',
INTERVAL '15 minutes',
INTERVAL '20 minutes'),

(50, 10, 2,
'Polenta crémeuse aux champignons',
'polenta-champignons.jpg',
INTERVAL '25 minutes',
INTERVAL '15 minutes'),

(51, 11, 1,
'Salade de quinoa, concombre et pois chiches',
'salade-quinoa-concombre.jpg',
INTERVAL '15 minutes',
INTERVAL '20 minutes'),

(52, 12, 3,
'Bœuf mijoté aux carottes et au thym',
'boeuf-mijote-carottes.jpg',
INTERVAL '2 hours',
INTERVAL '25 minutes'),

(53, 13, 2,
'Chou-fleur rôti au curry et au tahini',
'chou-fleur-curry-tahini.jpg',
INTERVAL '35 minutes',
INTERVAL '15 minutes'),

(54, 14, 1,
'Aubergines grillées à la feta et aux tomates séchées',
'aubergines-grillees-feta.jpg',
INTERVAL '20 minutes',
INTERVAL '15 minutes'),

(55, 15, 2,
'Calamars à la provençale',
'calamars-provencale.jpg',
INTERVAL '25 minutes',
INTERVAL '20 minutes'),

(56, 16, 2,
'Galette de sarrasin au jambon et au comté',
'galette-sarrasin-jambon-comte.jpg',
INTERVAL '10 minutes',
INTERVAL '20 minutes'),

(57, 17, 3,
'Brioche à la fleur d''oranger',
'brioche-fleur-oranger.jpg',
INTERVAL '30 minutes',
INTERVAL '2 hours'),

(58, 18, 2,
'Financiers aux amandes et framboises',
'financiers-amandes-framboises.jpg',
INTERVAL '15 minutes',
INTERVAL '20 minutes'),

(59, 19, 2,
'Crème brûlée à la vanille',
'creme-brulee-vanille.jpg',
INTERVAL '45 minutes',
INTERVAL '20 minutes'),

(60, 20, 1,
'Compote de pommes, cannelle et sirop d''érable',
'compote-pommes-cannelle.jpg',
INTERVAL '25 minutes',
INTERVAL '10 minutes');
-------------------------------------------------------------------------------------------------
INSERT INTO categories_recettes (id_categorie, id_recette)
VALUES
-- 1. Saucisse de Morteau à l'aubergine
(2, 1),   -- Plats
(8, 1),   -- Viandes
(13, 1),  -- Cuisine française
-- 2. Saumon à la plancha, crème au wasabi
(2, 2),   -- Plats
(9, 2),   -- Poissons et fruits de mer
(15, 2),  -- Cuisine asiatique
(77, 2),  -- Cuisson à la poêle
-- 3. Pizza à la pastèque
(3, 3),   -- Desserts
(44, 3),  -- Fruits
(86, 3),  -- Recettes gourmandes
-- 4. Risotto crémeux aux champignons
(2, 4),   -- Plats
(10, 4),  -- Végétarien
(14, 4),  -- Cuisine italienne
(33, 4),  -- Risottos
(43, 4),  -- Légumes
-- 5. Tarte fine aux tomates et au basilic
(1, 5),   -- Entrées
(10, 5),  -- Végétarien
(13, 5),  -- Cuisine française
(27, 5),  -- Tartes salées
(43, 5),  -- Légumes
-- 6. Poulet rôti au citron et au romarin
(2, 6),   -- Plats
(8, 6),   -- Viandes
(13, 6),  -- Cuisine française
(36, 6),  -- Rôtis
(75, 6),  -- Cuisson au four
-- 7. Velouté de courge et châtaignes
(1, 7),   -- Entrées
(6, 7),   -- Soupes
(10, 7),  -- Végétarien
(24, 7),  -- Recettes de saison
(43, 7),  -- Légumes
-- 8. Pâtes crémeuses aux épinards
(2, 8),   -- Plats
(7, 8),   -- Pâtes et riz
(10, 8),  -- Végétarien
(14, 8),  -- Cuisine italienne
(43, 8),  -- Légumes
-- 9. Magret de canard aux fruits rouges
(2, 9),   -- Plats
(8, 9),   -- Viandes
(13, 9),  -- Cuisine française
(44, 9),  -- Fruits
(86, 9),  -- Recettes gourmandes
-- 10. Salade fraîcheur avocat, mangue et crevettes
(5, 10),  -- Salades
(9, 10),  -- Poissons et fruits de mer
(39, 10), -- Fruits de mer
(44, 10), -- Fruits
(85, 10), -- Recettes légères
-- 11. Curry de pois chiches au lait de coco
(2, 11),   -- Plats
(11, 11),  -- Vegan
(35, 11),  -- Currys
(42, 11),  -- Légumineuses
(63, 11),  -- Cuisine indienne
-- 12. Cabillaud rôti aux tomates et olives
(2, 12),   -- Plats
(9, 12),   -- Poissons et fruits de mer
(13, 12),  -- Cuisine française
(61, 12),  -- Cuisine méditerranéenne
(75, 12),  -- Cuisson au four
-- 13. Quiche aux poireaux et au chèvre
(1, 13),   -- Entrées
(10, 13),  -- Végétarien
(13, 13),  -- Cuisine française
(28, 13),  -- Quiches
(43, 13),  -- Légumes
-- 14. Bowl quinoa, avocat et légumes croquants
(2, 14),   -- Plats
(10, 14),  -- Végétarien
(11, 14),  -- Vegan
(43, 14),  -- Légumes
(45, 14),  -- Céréales
(85, 14),  -- Recettes légères
-- 15. Bœuf sauté aux légumes façon wok
(2, 15),   -- Plats
(8, 15),   -- Viandes
(15, 15),  -- Cuisine asiatique
(34, 15),  -- Woks
(77, 15),  -- Cuisson à la poêle
-- 16. Tarte aux pommes et à la cannelle
(3, 16),   -- Desserts
(44, 16),  -- Fruits
(50, 16),  -- Tartes sucrées
(86, 16),  -- Recettes gourmandes
-- 17. Mousse au chocolat
(3, 17),   -- Desserts
(46, 17),  -- Chocolat
(49, 17),  -- Mousses et crèmes
(86, 17),  -- Recettes gourmandes
-- 18. Pancakes à la banane et au sirop d'érable
(16, 18),  -- Petit-déjeuner
(18, 18),  -- Goûter
(44, 18),  -- Fruits
(86, 18),  -- Recettes gourmandes
-- 19. Salade méditerranéenne à la feta
(5, 19),   -- Salades
(10, 19),  -- Végétarien
(41, 19),  -- Fromages
(61, 19),  -- Cuisine méditerranéenne
-- 20. Saumon au gingembre et à la sauce soja
(2, 20),   -- Plats
(9, 20),   -- Poissons et fruits de mer
(15, 20),  -- Cuisine asiatique
(77, 20),  -- Cuisson à la poêle
-- 21. Bruschettas tomates, mozzarella et basilic
(1, 21),   -- Entrées
(10, 21),  -- Végétarien
(14, 21),  -- Cuisine italienne
(26, 21),  -- Amuse-bouches
(29, 21),  -- Tartines
-- 22. Œufs cocotte aux épinards et à la crème
(1, 22),   -- Entrées
(10, 22),  -- Végétarien
(13, 22),  -- Cuisine française
(40, 22),  -- Œufs
(43, 22),  -- Légumes
-- 23. Salade de lentilles, feta et légumes grillés
(5, 23),   -- Salades
(10, 23),  -- Végétarien
(42, 23),  -- Légumineuses
(43, 23),  -- Légumes
(61, 23),  -- Cuisine méditerranéenne
-- 24. Gratin de pommes de terre au comté
(2, 24),   -- Plats
(10, 24),  -- Végétarien
(13, 24),  -- Cuisine française
(32, 24),  -- Gratins
(41, 24),  -- Fromages
-- 25. Lasagnes végétariennes aux légumes
(2, 25),   -- Plats
(10, 25),  -- Végétarien
(14, 25),  -- Cuisine italienne
(43, 25),  -- Légumes
-- 26. Curry de poulet au lait de coco
(2, 26),   -- Plats
(8, 26),   -- Viandes
(15, 26),  -- Cuisine asiatique
(35, 26),  -- Currys
-- 27. Crevettes sautées à l'ail et au citron vert
(2, 27),   -- Plats
(9, 27),   -- Poissons et fruits de mer
(15, 27),  -- Cuisine asiatique
(39, 27),  -- Fruits de mer
(77, 27),  -- Cuisson à la poêle
-- 28. Risotto aux asperges et parmesan
(2, 28),   -- Plats
(10, 28),  -- Végétarien
(14, 28),  -- Cuisine italienne
(33, 28),  -- Risottos
(43, 28),  -- Légumes
-- 29. Tacos de bœuf aux poivrons et guacamole
(2, 29),   -- Plats
(8, 29),   -- Viandes
(43, 29),  -- Légumes
(62, 29),  -- Cuisine mexicaine
-- 30. Pad thaï aux crevettes
(2, 30),   -- Plats
(9, 30),   -- Poissons et fruits de mer
(15, 30),  -- Cuisine asiatique
(39, 30),  -- Fruits de mer
(72, 30),  -- Cuisine thaïlandaise
-- 31. Dahl de lentilles corail au curry
(2, 31),   -- Plats
(11, 31),  -- Vegan
(35, 31),  -- Currys
(42, 31),  -- Légumineuses
(63, 31),  -- Cuisine indienne
-- 32. Tajine d'agneau aux pruneaux et amandes
(2, 32),   -- Plats
(8, 32),   -- Viandes
(44, 32),  -- Fruits
(64, 32),  -- Cuisine orientale
(70, 32),  -- Cuisine marocaine
-- 33. Moussaka aux aubergines et au bœuf
(2, 33),   -- Plats
(8, 33),   -- Viandes
(43, 33),  -- Légumes
(69, 33),  -- Cuisine grecque
-- 34. Galettes de pois chiches aux herbes
(1, 34),   -- Entrées
(10, 34),  -- Végétarien
(11, 34),  -- Vegan
(42, 34),  -- Légumineuses
(43, 34),  -- Légumes
-- 35. Gnocchis poêlés aux champignons et parmesan
(2, 35),   -- Plats
(10, 35),  -- Végétarien
(14, 35),  -- Cuisine italienne
(41, 35),  -- Fromages
(77, 35),  -- Cuisson à la poêle
-- 36. Focaccia aux tomates et au romarin
(1, 36),   -- Entrées
(10, 36),  -- Végétarien
(14, 36),  -- Cuisine italienne
(21, 36),  -- Pain et boulangerie
(43, 36),  -- Légumes
-- 37. Crumble aux pommes et aux noix
(3, 37),   -- Desserts
(18, 37),  -- Goûter
(44, 37),  -- Fruits
(86, 37),  -- Recettes gourmandes
-- 38. Cheesecake aux fruits rouges
(3, 38),   -- Desserts
(22, 38),  -- Pâtisserie
(44, 38),  -- Fruits
(86, 38),  -- Recettes gourmandes
-- 39. Panna cotta à la vanille et aux framboises
(3, 39),   -- Desserts
(14, 39),  -- Cuisine italienne
(44, 39),  -- Fruits
(49, 39),  -- Mousses et crèmes
-- 40. Smoothie mangue, banane et lait d'amande
(16, 40),  -- Petit-déjeuner
(20, 40),  -- Boissons
(11, 40),  -- Vegan
(44, 40),  -- Fruits
(53, 40),  -- Smoothies
-- 41. Velouté de brocoli au parmesan
(1, 41),   -- Entrées
(6, 41),   -- Soupes
(10, 41),  -- Végétarien
(41, 41),  -- Fromages
(43, 41),  -- Légumes
-- 42. Tartare de saumon à l'avocat et au citron vert
(1, 42),   -- Entrées
(9, 42),   -- Poissons et fruits de mer
(44, 42),  -- Fruits
(61, 42),  -- Cuisine méditerranéenne
-- 43. Poulet tikka masala
(2, 43),   -- Plats
(8, 43),   -- Viandes
(35, 43),  -- Currys
(63, 43),  -- Cuisine indienne
-- 44. Poivrons farcis au quinoa et à la feta
(2, 44),   -- Plats
(10, 44),  -- Végétarien
(43, 44),  -- Légumes
(45, 44),  -- Céréales
-- 45. Brandade de morue traditionnelle
(2, 45),   -- Plats
(9, 45),   -- Poissons et fruits de mer
(13, 45),  -- Cuisine française
(75, 45),  -- Cuisson au four
-- 46. Courgettes farcies aux lentilles et légumes
(2, 46),   -- Plats
(10, 46),  -- Végétarien
(11, 46),  -- Vegan
(42, 46),  -- Légumineuses
(43, 46),  -- Légumes
-- 47. Raviolis aux épinards et à la ricotta
(2, 47),   -- Plats
(10, 47),  -- Végétarien
(14, 47),  -- Cuisine italienne
(43, 47),  -- Légumes
-- 48. Moules au curry et lait de coco
(2, 48),   -- Plats
(9, 48),   -- Poissons et fruits de mer
(15, 48),  -- Cuisine asiatique
(35, 48),  -- Currys
(39, 48),  -- Fruits de mer
-- 49. Brochettes de poulet au paprika et citron
(2, 49),   -- Plats
(8, 49),   -- Viandes
(13, 49),  -- Cuisine française
(38, 49),  -- Brochettes
-- 50. Polenta crémeuse aux champignons
(2, 50),   -- Plats
(10, 50),  -- Végétarien
(14, 50),  -- Cuisine italienne
(43, 50),  -- Légumes
(45, 50),  -- Céréales
-- 51. Salade de quinoa, concombre et pois chiches
(5, 51),   -- Salades
(10, 51),  -- Végétarien
(11, 51),  -- Vegan
(42, 51),  -- Légumineuses
(45, 51),  -- Céréales
(85, 51),  -- Recettes légères
-- 52. Bœuf mijoté aux carottes et au thym
(2, 52),   -- Plats
(8, 52),   -- Viandes
(13, 52),  -- Cuisine française
(43, 52),  -- Légumes
(79, 52),  -- Cuisson en cocotte
-- 53. Chou-fleur rôti au curry et au tahini
(2, 53),   -- Plats
(10, 53),  -- Végétarien
(11, 53),  -- Vegan
(35, 53),  -- Currys
(43, 53),  -- Légumes
(75, 53),  -- Cuisson au four
-- 54. Aubergines grillées à la feta et aux tomates séchées
(1, 54),   -- Entrées
(10, 54),  -- Végétarien
(41, 54),  -- Fromages
(43, 54),  -- Légumes
(61, 54),  -- Cuisine méditerranéenne
-- 55. Calamars à la provençale
(2, 55),   -- Plats
(9, 55),   -- Poissons et fruits de mer
(13, 55),  -- Cuisine française
(39, 55),  -- Fruits de mer
(61, 55),  -- Cuisine méditerranéenne
-- 56. Galette de sarrasin au jambon et au comté
(2, 56),   -- Plats
(8, 56),   -- Viandes
(13, 56),  -- Cuisine française
(41, 56),  -- Fromages
-- 57. Brioche à la fleur d'oranger
(3, 57),   -- Desserts
(18, 57),  -- Goûter
(21, 57),  -- Pain et boulangerie
(22, 57),  -- Pâtisserie
-- 58. Financiers aux amandes et framboises
(3, 58),   -- Desserts
(18, 58),  -- Goûter
(22, 58),  -- Pâtisserie
(44, 58),  -- Fruits
-- 59. Crème brûlée à la vanille
(3, 59),   -- Desserts
(13, 59),  -- Cuisine française
(22, 59),  -- Pâtisserie
(49, 59),  -- Mousses et crèmes
-- 60. Compote de pommes, cannelle et sirop d'érable
(3, 60),   -- Desserts
(18, 60),  -- Goûter
(24, 60),  -- Recettes de saison
(44, 60);  -- Fruits
-----------------------------------------------------------------------------------------------
INSERT INTO ingredients_recettes
(id_ingredient, id_recette, quantite)
VALUES
-- RECETTE 1 : Saucisse de Morteau à l'aubergine
(110, 1, '1'),
(24, 1, '2'),
(20, 1, '1'),
(21, 1, '1 gousse'),
(11, 1, '2 c. à soupe'),
(12, 1, '1 pincée'),
-- RECETTE 2 : Saumon à la plancha, crème au wasabi
(33, 2, '2 pavés'),
(281, 2, '1 c. à café'),
(36, 2, '20 cl'),
(41, 2, '1/2'),
(11, 2, '1 c. à soupe'),
(12, 2, '1 pincée'),
-- RECETTE 3 : Pizza à la pastèque
(282, 3, '1'),
(283, 3, '300 g'),
(39, 3, '125 g'),
(60, 3, 'quelques feuilles'),
(2, 3, '1 c. à café'),
-- RECETTE 4 : Risotto crémeux aux champignons
(27, 4, '300 g'),
(51, 4, '250 g'),
(20, 4, '1'),
(21, 4, '1 gousse'),
(38, 4, '60 g'),
(36, 4, '10 cl'),
(100, 4, '75 cl'),
(11, 4, '2 c. à soupe'),
-- RECETTE 5 : Tarte fine aux tomates et au basilic
(79, 5, '1 pâte'),
(19, 5, '4'),
(60, 5, 'quelques feuilles'),
(39, 5, '100 g'),
(11, 5, '1 c. à soupe'),
(12, 5, '1 pincée'),
-- RECETTE 6 : Poulet rôti au citron et au romarin
(31, 6, '1 poulet'),
(41, 6, '2'),
(62, 6, '2 branches'),
(21, 6, '3 gousses'),
(11, 6, '2 c. à soupe'),
(12, 6, '1 pincée'),
-- RECETTE 7 : Velouté de courge et châtaignes
(98, 7, '800 g'),
(201, 7, '150 g'),
(20, 7, '1'),
(100, 7, '75 cl'),
(36, 7, '10 cl'),
(11, 7, '1 c. à soupe'),
-- RECETTE 8 : Pâtes crémeuses aux épinards
(28, 8, '300 g'),
(52, 8, '250 g'),
(36, 8, '20 cl'),
(38, 8, '50 g'),
(21, 8, '1 gousse'),
(11, 8, '1 c. à soupe'),
-- RECETTE 9 : Magret de canard aux fruits rouges
(284, 9, '2'),
(47, 9, '150 g'),
(48, 9, '100 g'),
(16, 9, '1 c. à soupe'),
(18, 9, '1 c. à soupe'),
(12, 9, '1 pincée'),
-- RECETTE 10 : Salade avocat, mangue et crevettes
(50, 10, '2'),
(178, 10, '1'),
(35, 10, '200 g'),
(97, 10, '1/2'),
(42, 10, '1'),
(63, 10, 'quelques feuilles'),
(11, 10, '2 c. à soupe'),
-- RECETTE 11 : Curry de pois chiches au lait de coco
(30, 11, '400 g'),
(99, 11, '40 cl'),
(20, 11, '1'),
(21, 11, '2 gousses'),
(131, 11, '2 c. à soupe'),
(155, 11, '1 c. à café'),
(63, 11, 'quelques feuilles'),
-- RECETTE 12 : Cabillaud rôti aux tomates et olives
(113, 12, '2 filets'),
(19, 12, '3'),
(129, 12, '80 g'),
(21, 12, '2 gousses'),
(68, 12, '1 c. à café'),
(11, 12, '2 c. à soupe'),
-- RECETTE 13 : Quiche aux poireaux et au chèvre=
(79, 13, '1 pâte'),
(94, 13, '3'),
(122, 13, '150 g'),
(5, 13, '3'),
(36, 13, '20 cl'),
(6, 13, '10 cl'),
-- RECETTE 14 : Bowl quinoa, avocat et légumes croquants
(87, 14, '200 g'),
(50, 14, '1'),
(97, 14, '1/2'),
(25, 14, '1'),
(55, 14, '100 g'),
(84, 14, '1 c. à soupe'),
(42, 14, '1/2'),
-- RECETTE 15 : Bœuf sauté aux légumes façon wok
(32, 15, '400 g'),
(23, 15, '1'),
(25, 15, '1'),
(22, 15, '2'),
(70, 15, '3 c. à soupe'),
(58, 15, '1 morceau'),
(84, 15, '1 c. à soupe'),
(279, 15, '1 c. à soupe'),
-- RECETTE 16 : Tarte aux pommes et à la cannelle
(79, 16, '1 pâte'),
(44, 16, '4'),
(15, 16, '1 c. à café'),
(2, 16, '50 g'),
(4, 16, '40 g'),
-- RECETTE 17 : Mousse au chocolat
(314, 17, '200 g'),
(5, 17, '4'),
(2, 17, '30 g'),
-- RECETTE 18 : Pancakes à la banane et au sirop d'érable
(1, 18, '200 g'),
(6, 18, '20 cl'),
(5, 18, '2'),
(49, 18, '2'),
(73, 18, '1 c. à café'),
(77, 18, '3 c. à soupe'),
-- RECETTE 19 : Salade méditerranéenne à la feta
(40, 19, '150 g'),
(19, 19, '3'),
(97, 19, '1'),
(129, 19, '80 g'),
(20, 19, '1/2'),
(11, 19, '3 c. à soupe'),
(18, 19, '1 c. à soupe'),
-- RECETTE 20 : Saumon au gingembre et sauce soja
(33, 20, '2 pavés'),
(58, 20, '20 g'),
(70, 20, '3 c. à soupe'),
(42, 20, '1/2'),
(279, 20, '1 c. à café'),
-- RECETTE 21 : Bruschettas tomates, mozzarella et basilic
(19, 21, '3'),
(39, 21, '125 g'),
(60, 21, 'quelques feuilles'),
(1, 21, '4 tranches'),
(11, 21, '2 c. à soupe'),
(18, 21, '1 c. à café'),
-- RECETTE 22 : Œufs cocotte aux épinards et à la crème
(5, 22, '4'),
(52, 22, '200 g'),
(36, 22, '15 cl'),
(64, 22, '1 c. à soupe'),
(12, 22, '1 pincée'),
-- RECETTE 23 : Salade de lentilles, feta et légumes grillés
(29, 23, '250 g'),
(40, 23, '100 g'),
(23, 23, '1'),
(25, 23, '1'),
(20, 23, '1/2'),
(11, 23, '2 c. à soupe'),
-- RECETTE 24 : Gratin de pommes de terre au comté
(26, 24, '1 kg'),
(121, 24, '150 g'),
(36, 24, '30 cl'),
(21, 24, '1 gousse'),
(67, 24, '1 pincée'),
-- RECETTE 25 : Lasagnes végétariennes aux légumes
(28, 25, '250 g'),
(23, 25, '2'),
(24, 25, '1'),
(19, 25, '400 g'),
(39, 25, '125 g'),
(38, 25, '50 g'),
(20, 25, '1'),
-- RECETTE 26 : Curry de poulet au lait de coco
(31, 26, '500 g'),
(99, 26, '40 cl'),
(20, 26, '1'),
(21, 26, '2 gousses'),
(131, 26, '2 c. à soupe'),
(155, 26, '1 c. à café'),
(63, 26, 'quelques feuilles'),
-- RECETTE 27 : Crevettes sautées à l'ail et au citron vert
(35, 27, '300 g'),
(21, 27, '3 gousses'),
(42, 27, '2'),
(11, 27, '2 c. à soupe'),
(63, 27, 'quelques feuilles'),
(66, 27, '1 pincée'),
-- RECETTE 28 : Risotto aux asperges et parmesan
(27, 28, '300 g'),
(142, 28, '300 g'),
(38, 28, '70 g'),
(20, 28, '1'),
(100, 28, '75 cl'),
(11, 28, '2 c. à soupe'),
-- RECETTE 29 : Tacos de bœuf aux poivrons et guacamole
(32, 29, '400 g'),
(25, 29, '1'),
(50, 29, '2'),
(42, 29, '1'),
(20, 29, '1/2'),
(63, 29, 'quelques feuilles'),
(14, 29, '1 c. à café'),
-- RECETTE 30 : Pad thaï aux crevettes
(35, 30, '250 g'),
(195, 30, '250 g'),
(70, 30, '2 c. à soupe'),
(134, 30, '1 c. à soupe'),
(84, 30, '1 c. à soupe'),
(168, 30, '100 g'),
(63, 30, 'quelques feuilles'),
-- RECETTE 31 : Dahl de lentilles corail au curry
(101, 31, '250 g'),
(99, 31, '20 cl'),
(20, 31, '1'),
(21, 31, '2 gousses'),
(254, 31, '2 c. à café'),
(155, 31, '1 c. à café'),
(13, 31, '1 c. à café'),
-- RECETTE 32 : Tajine d'agneau aux pruneaux et amandes
(111, 32, '600 g'),
(275, 32, '150 g'),
(10, 32, '100 g'),
(20, 32, '2'),
(13, 32, '1 c. à café'),
(15, 32, '1/2 c. à café'),
(16, 32, '1 c. à soupe'),
-- RECETTE 33 : Moussaka aux aubergines et au bœuf
(24, 33, '3'),
(32, 33, '400 g'),
(19, 33, '400 g'),
(20, 33, '1'),
(36, 33, '20 cl'),
(38, 33, '50 g'),
(11, 33, '2 c. à soupe'),
-- RECETTE 34 : Galettes de pois chiches aux herbes
(192, 34, '250 g'),
(5, 34, '1'),
(63, 34, '1 c. à soupe'),
(59, 34, '1 c. à soupe'),
(21, 34, '1 gousse'),
(13, 34, '1 c. à café'),
(11, 34, '2 c. à soupe'),
-- RECETTE 35 : Gnocchis poêlés aux champignons et parmesan
(28, 35, '500 g'),
(51, 35, '250 g'),
(38, 35, '60 g'),
(21, 35, '1 gousse'),
(11, 35, '2 c. à soupe'),
-- RECETTE 36 : Focaccia aux tomates et au romarin
(1, 36, '500 g'),
(7, 36, '1 sachet'),
(19, 36, '200 g'),
(62, 36, '2 branches'),
(11, 36, '4 c. à soupe'),
(3, 36, '1 c. à café'),
-- RECETTE 37 : Crumble aux pommes et aux noix
(44, 37, '5'),
(1, 37, '100 g'),
(4, 37, '80 g'),
(2, 37, '80 g'),
(81, 37, '80 g'),
(15, 37, '1 c. à café'),
-- RECETTE 38 : Cheesecake aux fruits rouges
(295, 38, '500 g'),
(2, 38, '100 g'),
(5, 38, '3'),
(4, 38, '80 g'),
(47, 38, '100 g'),
(48, 38, '100 g'),
-- RECETTE 39 : Panna cotta à la vanille et aux framboises
(123, 39, '40 cl'),
(2, 39, '60 g'),
(8, 39, '1 gousse'),
(309, 39, '2 feuilles'),
(47, 39, '150 g'),
-- RECETTE 40 : Smoothie mangue, banane et lait d'amande
(178, 40, '1'),
(49, 40, '1'),
(106, 40, '30 cl'),
(16, 40, '1 c. à café'),
-- RECETTE 41 : Velouté de brocoli au parmesan
(53, 41, '500 g'),
(38, 41, '50 g'),
(20, 41, '1'),
(100, 41, '60 cl'),
(36, 41, '10 cl'),
(11, 41, '1 c. à soupe'),
-- RECETTE 42 : Tartare de saumon à l'avocat et citron vert
(33, 42, '300 g'),
(50, 42, '1'),
(42, 42, '2'),
(63, 42, '1 c. à soupe'),
(11, 42, '1 c. à soupe'),
(12, 42, '1 pincée'),
-- RECETTE 43 : Poulet tikka masala
(31, 43, '500 g'),
(37, 43, '150 g'),
(19, 43, '300 g'),
(253, 43, '2 c. à café'),
(155, 43, '1 c. à café'),
(20, 43, '1'),
(21, 43, '2 gousses'),
-- RECETTE 44 : Poivrons farcis au quinoa et à la feta
(172, 44, '4'),
(87, 44, '200 g'),
(40, 44, '150 g'),
(20, 44, '1'),
(19, 44, '2'),
(63, 44, '1 c. à soupe'),
-- RECETTE 45 : Brandade de morue traditionnelle
(114, 45, '500 g'),
(26, 45, '700 g'),
(36, 45, '20 cl'),
(21, 45, '2 gousses'),
(11, 45, '3 c. à soupe'),
(12, 45, '1 pincée'),
-- RECETTE 46 : Courgettes farcies aux lentilles et légumes
(23, 46, '4'),
(29, 46, '200 g'),
(22, 46, '2'),
(20, 46, '1'),
(19, 46, '2'),
(11, 46, '2 c. à soupe'),
-- RECETTE 47 : Raviolis aux épinards et à la ricotta
(285, 47, '250 g'),
(52, 47, '250 g'),
(118, 47, '250 g'),
(5, 47, '1'),
(38, 47, '40 g'),
(11, 47, '1 c. à soupe'),
-- RECETTE 48 : Moules au curry et lait de coco
(115, 48, '1 kg'),
(99, 48, '25 cl'),
(131, 48, '1 c. à soupe'),
(20, 48, '1'),
(21, 48, '2 gousses'),
(63, 48, 'quelques feuilles'),
-- RECETTE 49 : Brochettes de poulet au paprika et citron
(31, 49, '500 g'),
(14, 49, '1 c. à soupe'),
(41, 49, '1'),
(20, 49, '1'),
(11, 49, '2 c. à soupe'),
(12, 49, '1 pincée'),
-- RECETTE 50 : Polenta crémeuse aux champignons
(190, 50, '200 g'),
(51, 50, '250 g'),
(38, 50, '50 g'),
(36, 50, '15 cl'),
(100, 50, '60 cl'),
(11, 50, '1 c. à soupe'),
-- RECETTE 51 : Salade de quinoa, concombre et pois chiches
(87, 51, '200 g'),
(97, 51, '1'),
(30, 51, '200 g'),
(19, 51, '2'),
(42, 51, '1'),
(63, 51, '1 c. à soupe'),
(11, 51, '2 c. à soupe'),
-- RECETTE 52 : Bœuf mijoté aux carottes et au thym
(32, 52, '700 g'),
(22, 52, '4'),
(20, 52, '2'),
(61, 52, '2 branches'),
(65, 52, '1 feuille'),
(100, 52, '50 cl'),
(11, 52, '2 c. à soupe'),
-- RECETTE 53 : Chou-fleur rôti au curry et au tahini
(54, 53, '1'),
(136, 53, '3 c. à soupe'),
(254, 53, '1 c. à café'),
(11, 53, '2 c. à soupe'),
(42, 53, '1/2'),
(63, 53, 'quelques feuilles'),
-- RECETTE 54 : Aubergines grillées à la feta et tomates séchées
(24, 54, '2'),
(40, 54, '100 g'),
(170, 54, '80 g'),
(11, 54, '2 c. à soupe'),
(60, 54, 'quelques feuilles'),
(12, 54, '1 pincée'),
-- RECETTE 55 : Calamars à la provençale
(116, 55, '500 g'),
(19, 55, '400 g'),
(20, 55, '1'),
(21, 55, '2 gousses'),
(68, 55, '1 c. à café'),
(11, 55, '2 c. à soupe'),
-- RECETTE 56 : Galette de sarrasin au jambon et au comté
(188, 56, '150 g'),
(109, 56, '2 tranches'),
(121, 56, '100 g'),
(5, 56, '2'),
(6, 56, '30 cl'),
-- RECETTE 57 : Brioche à la fleur d'oranger
(1, 57, '500 g'),
(5, 57, '3'),
(6, 57, '15 cl'),
(4, 57, '100 g'),
(2, 57, '80 g'),
(7, 57, '1 sachet'),
(206, 57, '2 c. à soupe'),
-- RECETTE 58 : Financiers aux amandes et framboises
(10, 58, '100 g'),
(1, 58, '50 g'),
(76, 58, '100 g'),
(4, 58, '100 g'),
(5, 58, '3'),
(47, 58, '100 g'),
-- RECETTE 59 : Crème brûlée à la vanille
(123, 59, '50 cl'),
(5, 59, '5'),
(2, 59, '80 g'),
(8, 59, '1 gousse'),
-- RECETTE 60 : Compote de pommes, cannelle et sirop d'érable
(44, 60, '1 kg'),
(15, 60, '1 c. à café'),
(77, 60, '2 c. à soupe'),
(41, 60, '1/2 citron');
-------------------------------------------------------------------------------------------------------
INSERT INTO etapes (numero_etape, id_recette, texte)
VALUES
-- 1. Saucisse de Morteau à l'aubergine
(1, 1, 'Lavez les aubergines puis coupez-les en petits dés. Émincez l''oignon et hachez l''ail.'),
(2, 1, 'Faites chauffer l''huile d''olive dans une grande poêle puis faites revenir l''oignon et l''ail.'),
(3, 1, 'Ajoutez les aubergines et faites-les cuire une dizaine de minutes en mélangeant régulièrement.'),
(4, 1, 'Coupez les saucisses de Morteau en rondelles puis ajoutez-les dans la poêle.'),
(5, 1, 'Laissez cuire encore quelques minutes afin que les saucisses soient bien chaudes et légèrement dorées.'),
(6, 1, 'Poivrez, mélangez une dernière fois puis servez immédiatement.'),
-- 2. Saumon à la plancha, crème au wasabi
(1, 2, 'Épongez les pavés de saumon avec du papier absorbant puis assaisonnez-les légèrement.'),
(2, 2, 'Mélangez la crème fraîche avec le wasabi et le jus d''un demi-citron vert.'),
(3, 2, 'Ajoutez une cuillère d''huile d''olive à la sauce puis mélangez jusqu''à obtenir une préparation homogène.'),
(4, 2, 'Faites chauffer fortement la plancha puis déposez les pavés de saumon.'),
(5, 2, 'Faites cuire le saumon quelques minutes de chaque côté en conservant une chair légèrement fondante.'),
(6, 2, 'Servez les pavés avec la crème au wasabi et un peu de citron vert.'),
-- 3. Pizza à la pastèque
(1, 3, 'Préchauffez le four à la température adaptée à la cuisson de la pâte à pizza.'),
(2, 3, 'Étalez la pâte à pizza sur une plaque recouverte de papier cuisson.'),
(3, 3, 'Faites cuire la pâte jusqu''à ce qu''elle soit légèrement dorée puis laissez-la tiédir.'),
(4, 3, 'Coupez la pastèque en petits morceaux et égouttez-les afin de retirer l''excédent de jus.'),
(5, 3, 'Répartissez la mozzarella sur la pâte refroidie puis ajoutez les morceaux de pastèque.'),
(6, 3, 'Ajoutez quelques feuilles de basilic et une légère touche de sucre avant de servir.'),
-- 4. Risotto crémeux aux champignons
(1, 4, 'Nettoyez les champignons puis émincez-les. Émincez également l''oignon.'),
(2, 4, 'Faites revenir l''oignon dans l''huile d''olive jusqu''à ce qu''il devienne translucide.'),
(3, 4, 'Ajoutez les champignons et faites-les cuire quelques minutes.'),
(4, 4, 'Ajoutez le riz et mélangez pendant deux minutes afin de le nacrer.'),
(5, 4, 'Versez progressivement le bouillon chaud en mélangeant régulièrement jusqu''à absorption.'),
(6, 4, 'Poursuivez la cuisson jusqu''à ce que le riz soit crémeux et tendre.'),
(7, 4, 'Ajoutez la crème et le parmesan, mélangez puis servez immédiatement.'),
-- 5. Tarte fine aux tomates et au basilic
(1, 5, 'Préchauffez le four puis déroulez la pâte brisée sur une plaque de cuisson.'),
(2, 5, 'Piquez légèrement la pâte avec une fourchette pour éviter qu''elle ne gonfle.'),
(3, 5, 'Coupez les tomates en fines rondelles puis répartissez-les sur la pâte.'),
(4, 5, 'Ajoutez la mozzarella, quelques feuilles de basilic et un filet d''huile d''olive.'),
(5, 5, 'Assaisonnez légèrement puis enfournez jusqu''à ce que la pâte soit bien dorée.'),
(6, 5, 'Laissez tiédir quelques minutes puis ajoutez quelques feuilles de basilic frais.'),
-- 6. Poulet rôti au citron et au romarin
(1, 6, 'Préchauffez le four et placez le poulet dans un plat allant au four.'),
(2, 6, 'Pressez les citrons puis versez leur jus sur le poulet.'),
(3, 6, 'Ajoutez les gousses d''ail, le romarin et l''huile d''olive.'),
(4, 6, 'Assaisonnez puis massez légèrement le poulet afin de répartir les aromates.'),
(5, 6, 'Enfournez le poulet et arrosez-le régulièrement avec son jus de cuisson.'),
(6, 6, 'Poursuivez la cuisson jusqu''à ce que la chair soit bien cuite.'),
(7, 6, 'Laissez reposer le poulet quelques minutes avant de le découper et de le servir.'),
-- 7. Velouté de courge et châtaignes
(1, 7, 'Épluchez la courge, retirez les graines puis coupez-la en morceaux.'),
(2, 7, 'Émincez l''oignon et faites-le revenir dans une casserole avec l''huile d''olive.'),
(3, 7, 'Ajoutez la courge et les châtaignes puis mélangez quelques minutes.'),
(4, 7, 'Versez le bouillon de légumes et portez le mélange à ébullition.'),
(5, 7, 'Laissez cuire environ trente minutes jusqu''à ce que la courge soit parfaitement tendre.'),
(6, 7, 'Mixez finement la préparation jusqu''à obtenir un velouté homogène.'),
(7, 7, 'Ajoutez la crème, mélangez puis rectifiez l''assaisonnement avant de servir.'),
-- 8. Pâtes crémeuses aux épinards
(1, 8, 'Faites bouillir une grande casserole d''eau salée.'),
(2, 8, 'Faites cuire les pâtes selon le temps indiqué sur leur emballage.'),
(3, 8, 'Pendant ce temps, hachez l''ail et faites-le revenir dans l''huile d''olive.'),
(4, 8, 'Ajoutez les épinards et laissez-les réduire quelques minutes.'),
(5, 8, 'Versez la crème fraîche puis mélangez avec les épinards.'),
(6, 8, 'Égouttez les pâtes en conservant un peu d''eau de cuisson.'),
(7, 8, 'Ajoutez les pâtes à la sauce et mélangez avec le parmesan avant de servir.'),
-- 9. Magret de canard aux fruits rouges
(1, 9, 'Incisez la peau des magrets en réalisant des croisillons sans atteindre la chair.'),
(2, 9, 'Déposez les magrets côté peau dans une poêle froide puis faites chauffer progressivement.'),
(3, 9, 'Laissez cuire côté peau jusqu''à ce que la graisse soit bien fondue et la peau dorée.'),
(4, 9, 'Retirez l''excédent de graisse puis retournez les magrets.'),
(5, 9, 'Poursuivez la cuisson quelques minutes selon le niveau de cuisson souhaité.'),
(6, 9, 'Retirez les magrets et laissez-les reposer quelques minutes sous une feuille d''aluminium.'),
(7, 9, 'Ajoutez les fruits rouges, le miel et le vinaigre balsamique dans la poêle.'),
(8, 9, 'Faites réduire la sauce quelques minutes puis tranchez les magrets et servez avec la sauce.'),
-- 10. Salade fraîcheur avocat, mangue et crevettes
(1, 10, 'Décortiquez les crevettes puis retirez le boyau si nécessaire.'),
(2, 10, 'Épluchez l''avocat et la mangue puis coupez-les en morceaux réguliers.'),
(3, 10, 'Lavez le concombre et coupez-le en fines rondelles.'),
(4, 10, 'Pressez le citron vert puis mélangez son jus avec l''huile d''olive.'),
(5, 10, 'Réunissez les crevettes, les fruits et le concombre dans un saladier.'),
(6, 10, 'Ajoutez la coriandre et la sauce au citron vert puis mélangez délicatement.'),
(7, 10, 'Réservez quelques minutes au frais avant de servir.'),
-- 11. Curry de pois chiches au lait de coco
(1, 11, 'Émincez l''oignon et hachez finement les gousses d''ail.'),
(2, 11, 'Faites revenir l''oignon et l''ail dans une casserole avec un peu d''huile.'),
(3, 11, 'Ajoutez la pâte de curry et le curcuma puis faites revenir les épices quelques instants.'),
(4, 11, 'Ajoutez les pois chiches égouttés et mélangez pour bien les enrober.'),
(5, 11, 'Versez le lait de coco puis portez doucement à ébullition.'),
(6, 11, 'Laissez mijoter environ trente minutes à feu doux.'),
(7, 11, 'Ajoutez la coriandre fraîche, mélangez et servez bien chaud.'),
-- 12. Cabillaud rôti aux tomates et olives
(1, 12, 'Préchauffez le four puis déposez les filets de cabillaud dans un plat.'),
(2, 12, 'Coupez les tomates en morceaux et répartissez-les autour du poisson.'),
(3, 12, 'Ajoutez les olives et les gousses d''ail finement hachées.'),
(4, 12, 'Parsemez d''origan puis arrosez le tout avec l''huile d''olive.'),
(5, 12, 'Enfournez pendant environ vingt-cinq minutes.'),
(6, 12, 'Vérifiez que le poisson est bien cuit puis servez avec les tomates et les olives.'),
-- 13. Quiche aux poireaux et au chèvre
(1, 13, 'Préchauffez le four puis foncez un moule avec la pâte brisée.'),
(2, 13, 'Piquez le fond de la pâte avec une fourchette.'),
(3, 13, 'Nettoyez les poireaux et émincez-les finement.'),
(4, 13, 'Faites revenir les poireaux à la poêle jusqu''à ce qu''ils soient fondants.'),
(5, 13, 'Battez les œufs avec la crème fraîche et le lait.'),
(6, 13, 'Répartissez les poireaux et le chèvre sur le fond de tarte.'),
(7, 13, 'Versez l''appareil aux œufs puis enfournez environ trente-cinq minutes.'),
-- 14. Bowl quinoa, avocat et légumes croquants
(1, 14, 'Rincez le quinoa puis faites-le cuire dans une casserole d''eau.'),
(2, 14, 'Égouttez le quinoa et laissez-le refroidir quelques minutes.'),
(3, 14, 'Coupez l''avocat, le concombre et le poivron en morceaux.'),
(4, 14, 'Faites cuire les haricots verts puis refroidissez-les rapidement.'),
(5, 14, 'Répartissez le quinoa au fond des bols.'),
(6, 14, 'Disposez harmonieusement les légumes et l''avocat sur le quinoa.'),
(7, 14, 'Ajoutez les graines de sésame et arrosez de jus de citron avant de servir.'),
-- 15. Bœuf sauté aux légumes façon wok
(1, 15, 'Découpez le bœuf en fines lamelles.'),
(2, 15, 'Lavez puis émincez la courgette, le poivron et les carottes.'),
(3, 15, 'Épluchez et râpez finement le gingembre.'),
(4, 15, 'Faites chauffer fortement l''huile de sésame dans un wok.'),
(5, 15, 'Saisissez le bœuf à feu vif pendant quelques minutes puis réservez-le.'),
(6, 15, 'Faites sauter les légumes dans le même wok en les gardant légèrement croquants.'),
(7, 15, 'Remettez le bœuf dans le wok puis ajoutez la sauce soja et le gingembre.'),
(8, 15, 'Mélangez rapidement, ajoutez les graines de sésame puis servez immédiatement.'),
-- 16. Tarte aux pommes et à la cannelle
(1, 16, 'Préchauffez le four puis étalez la pâte brisée dans un moule.'),
(2, 16, 'Piquez le fond de tarte avec une fourchette.'),
(3, 16, 'Épluchez les pommes, retirez les pépins et coupez-les en fines lamelles.'),
(4, 16, 'Disposez les lamelles de pommes en cercle sur la pâte.'),
(5, 16, 'Saupoudrez les pommes de sucre et de cannelle.'),
(6, 16, 'Répartissez quelques petits morceaux de beurre sur les pommes.'),
(7, 16, 'Enfournez environ trente-cinq minutes puis laissez tiédir avant de servir.'),
-- 17. Mousse au chocolat
(1, 17, 'Cassez le chocolat noir en morceaux et faites-le fondre doucement au bain-marie.'),
(2, 17, 'Séparez les blancs des jaunes d''œufs dans deux récipients différents.'),
(3, 17, 'Retirez le chocolat du feu et laissez-le tiédir quelques minutes.'),
(4, 17, 'Ajoutez les jaunes d''œufs et le sucre au chocolat puis mélangez.'),
(5, 17, 'Montez les blancs en neige ferme à l''aide d''un fouet électrique.'),
(6, 17, 'Incorporez délicatement les blancs en neige au mélange au chocolat.'),
(7, 17, 'Répartissez la mousse dans des verrines et placez-les au réfrigérateur plusieurs heures.'),
-- 18. Pancakes à la banane et au sirop d'érable
(1, 18, 'Épluchez les bananes puis écrasez-les à la fourchette dans un saladier.'),
(2, 18, 'Ajoutez les œufs et mélangez avec les bananes.'),
(3, 18, 'Versez progressivement le lait tout en mélangeant.'),
(4, 18, 'Ajoutez la farine et la levure chimique puis mélangez jusqu''à obtenir une pâte homogène.'),
(5, 18, 'Faites chauffer une poêle légèrement huilée à feu moyen.'),
(6, 18, 'Versez une petite louche de pâte et faites cuire jusqu''à l''apparition de bulles.'),
(7, 18, 'Retournez le pancake et poursuivez la cuisson quelques instants.'),
(8, 18, 'Répétez l''opération puis servez les pancakes avec le sirop d''érable.'),
-- 19. Salade méditerranéenne à la feta
(1, 19, 'Lavez les tomates et le concombre puis coupez-les en morceaux.'),
(2, 19, 'Émincez finement l''oignon.'),
(3, 19, 'Coupez la feta en dés et ajoutez les olives.'),
(4, 19, 'Mélangez l''huile d''olive avec le vinaigre balsamique.'),
(5, 19, 'Réunissez tous les ingrédients dans un saladier.'),
(6, 19, 'Versez la vinaigrette puis mélangez délicatement avant de servir.'),
-- 20. Saumon au gingembre et à la sauce soja
(1, 20, 'Déposez les pavés de saumon dans un plat creux.'),
(2, 20, 'Râpez le gingembre frais puis mélangez-le avec la sauce soja.'),
(3, 20, 'Ajoutez le jus de citron vert et l''huile de sésame.'),
(4, 20, 'Versez la marinade sur le saumon et laissez reposer quelques minutes.'),
(5, 20, 'Faites chauffer une poêle puis déposez les pavés côté peau.'),
(6, 20, 'Faites cuire le saumon jusqu''à ce qu''il soit doré et encore légèrement fondant à cœur.'),
(7, 20, 'Arrosez avec la marinade restante puis servez immédiatement.'),
-- 21. Bruschettas tomates, mozzarella et basilic
(1, 21, 'Lavez les tomates puis coupez-les en petits dés.'),
(2, 21, 'Coupez la mozzarella en petits morceaux.'),
(3, 21, 'Faites griller les tranches de pain jusqu''à ce qu''elles soient légèrement croustillantes.'),
(4, 21, 'Frottez délicatement les tranches grillées avec une gousse d''ail.'),
(5, 21, 'Répartissez les tomates et la mozzarella sur les tranches de pain.'),
(6, 21, 'Ajoutez le basilic, l''huile d''olive et une touche de vinaigre balsamique.'),
(7, 21, 'Servez immédiatement afin de conserver le contraste entre pain croustillant et garniture fraîche.'),
-- 22. Œufs cocotte aux épinards et à la crème
(1, 22, 'Préchauffez le four et faites revenir les épinards dans une poêle.'),
(2, 22, 'Laissez cuire les épinards jusqu''à ce qu''ils aient rendu leur eau.'),
(3, 22, 'Beurrez légèrement les ramequins puis répartissez les épinards au fond.'),
(4, 22, 'Ajoutez une cuillère de crème dans chaque ramequin.'),
(5, 22, 'Cassez délicatement un œuf dans chaque ramequin.'),
(6, 22, 'Ajoutez la ciboulette et assaisonnez légèrement.'),
(7, 22, 'Faites cuire au four jusqu''à ce que les blancs soient pris et les jaunes encore coulants.'),
-- 23. Salade de lentilles, feta et légumes grillés
(1, 23, 'Rincez les lentilles puis faites-les cuire dans une casserole d''eau.'),
(2, 23, 'Égouttez les lentilles et laissez-les refroidir.'),
(3, 23, 'Coupez la courgette et le poivron en morceaux réguliers.'),
(4, 23, 'Faites griller les légumes dans une poêle avec un peu d''huile d''olive.'),
(5, 23, 'Émincez l''oignon et coupez la feta en dés.'),
(6, 23, 'Mélangez les lentilles avec les légumes grillés, l''oignon et la feta.'),
(7, 23, 'Ajoutez l''huile d''olive puis mélangez délicatement avant de servir.'),
-- 24. Gratin de pommes de terre au comté
(1, 24, 'Préchauffez le four et épluchez les pommes de terre.'),
(2, 24, 'Coupez les pommes de terre en rondelles très fines.'),
(3, 24, 'Frottez le plat de cuisson avec une gousse d''ail.'),
(4, 24, 'Disposez les pommes de terre en couches régulières dans le plat.'),
(5, 24, 'Versez la crème sur les pommes de terre.'),
(6, 24, 'Ajoutez le comté râpé et une pincée de noix de muscade.'),
(7, 24, 'Enfournez environ quarante-cinq minutes jusqu''à ce que les pommes de terre soient fondantes.'),
(8, 24, 'Laissez reposer quelques minutes avant de servir.'),
-- 25. Lasagnes végétariennes aux légumes
(1, 25, 'Préchauffez le four puis émincez l''oignon.'),
(2, 25, 'Coupez les courgettes et les aubergines en petits morceaux.'),
(3, 25, 'Faites revenir l''oignon dans une grande poêle avec un peu d''huile.'),
(4, 25, 'Ajoutez les courgettes, les aubergines et les tomates puis laissez mijoter.'),
(5, 25, 'Faites précuire les feuilles de lasagnes si nécessaire selon leur type.'),
(6, 25, 'Déposez une couche de légumes au fond d''un plat à gratin.'),
(7, 25, 'Ajoutez une couche de pâtes puis recommencez en alternant les préparations.'),
(8, 25, 'Terminez par la mozzarella et le parmesan puis enfournez environ quarante-cinq minutes.'),
-- 26. Curry de poulet au lait de coco
(1, 26, 'Coupez les blancs de poulet en morceaux de taille régulière.'),
(2, 26, 'Émincez l''oignon et hachez les gousses d''ail.'),
(3, 26, 'Faites revenir l''oignon et l''ail dans une grande poêle.'),
(4, 26, 'Ajoutez la pâte de curry et le curcuma puis mélangez.'),
(5, 26, 'Ajoutez le poulet et faites-le dorer sur toutes ses faces.'),
(6, 26, 'Versez le lait de coco et mélangez bien.'),
(7, 26, 'Laissez mijoter environ trente minutes à feu doux.'),
(8, 26, 'Ajoutez la coriandre fraîche puis servez bien chaud.'),
-- 27. Crevettes sautées à l'ail et au citron vert
(1, 27, 'Décortiquez les crevettes et retirez le boyau si nécessaire.'),
(2, 27, 'Hachez finement les gousses d''ail.'),
(3, 27, 'Pressez les citrons verts et réservez le jus.'),
(4, 27, 'Faites chauffer l''huile d''olive dans une poêle bien chaude.'),
(5, 27, 'Ajoutez l''ail puis les crevettes et faites-les sauter rapidement.'),
(6, 27, 'Ajoutez le jus de citron vert et une pincée de piment.'),
(7, 27, 'Parsemez de coriandre fraîche puis servez immédiatement.'),
-- 28. Risotto aux asperges et parmesan
(1, 28, 'Lavez les asperges et retirez la partie dure des tiges.'),
(2, 28, 'Coupez les asperges en petits morceaux en conservant quelques pointes entières.'),
(3, 28, 'Émincez l''oignon puis faites-le revenir dans l''huile d''olive.'),
(4, 28, 'Ajoutez le riz et mélangez jusqu''à ce qu''il devienne légèrement translucide.'),
(5, 28, 'Ajoutez progressivement le bouillon chaud tout en mélangeant régulièrement.'),
(6, 28, 'Ajoutez les morceaux d''asperges en cours de cuisson.'),
(7, 28, 'Terminez la cuisson avec les pointes d''asperges.'),
(8, 28, 'Ajoutez le parmesan, mélangez et servez le risotto immédiatement.'),
-- 29. Tacos de bœuf aux poivrons et guacamole
(1, 29, 'Émincez le bœuf, le poivron et l''oignon en fines lamelles.'),
(2, 29, 'Faites chauffer une poêle avec un filet d''huile.'),
(3, 29, 'Faites revenir le bœuf à feu vif jusqu''à ce qu''il soit bien doré.'),
(4, 29, 'Ajoutez le poivron et l''oignon puis poursuivez la cuisson.'),
(5, 29, 'Écrasez les avocats avec le jus de citron vert.'),
(6, 29, 'Ajoutez la coriandre au guacamole et mélangez.'),
(7, 29, 'Réchauffez les tortillas puis garnissez-les de bœuf et de légumes.'),
(8, 29, 'Ajoutez le guacamole et servez immédiatement.'),
-- 30. Pad thaï aux crevettes
(1, 30, 'Faites tremper ou cuire les nouilles de riz selon les indications du paquet.'),
(2, 30, 'Égouttez les nouilles et réservez-les.'),
(3, 30, 'Décortiquez les crevettes puis faites-les revenir dans un wok chaud.'),
(4, 30, 'Ajoutez les nouilles de riz et mélangez rapidement avec les crevettes.'),
(5, 30, 'Versez la sauce soja et la sauce nuoc-mâm puis mélangez.'),
(6, 30, 'Ajoutez les pousses de soja et poursuivez la cuisson quelques minutes.'),
(7, 30, 'Parsemez de graines de sésame et de coriandre fraîche.'),
(8, 30, 'Servez immédiatement pendant que les nouilles sont encore chaudes.'),
-- 31. Dahl de lentilles corail au curry
(1, 31, 'Rincez les lentilles corail à l''eau froide jusqu''à ce que l''eau soit claire.'),
(2, 31, 'Émincez l''oignon et hachez l''ail.'),
(3, 31, 'Faites revenir l''oignon et l''ail dans une casserole avec un peu d''huile.'),
(4, 31, 'Ajoutez le curry, le curcuma et le cumin puis faites revenir les épices.'),
(5, 31, 'Ajoutez les lentilles et mélangez afin de bien les enrober.'),
(6, 31, 'Versez le lait de coco puis laissez mijoter environ trente minutes.'),
(7, 31, 'Mélangez régulièrement jusqu''à obtenir une préparation crémeuse.'),
(8, 31, 'Servez chaud avec une touche de coriandre fraîche.'),
-- 32. Tajine d'agneau aux pruneaux et amandes
(1, 32, 'Coupez l''agneau en morceaux réguliers et émincez les oignons.'),
(2, 32, 'Faites chauffer une cocotte avec un peu d''huile puis faites dorer l''agneau.'),
(3, 32, 'Ajoutez les oignons et poursuivez la cuisson quelques minutes.'),
(4, 32, 'Ajoutez le cumin, la cannelle et le miel puis mélangez.'),
(5, 32, 'Ajoutez les pruneaux et versez un peu d''eau dans la cocotte.'),
(6, 32, 'Couvrez puis laissez mijoter environ une heure trente à feu doux.'),
(7, 32, 'Surveillez la cuisson et ajoutez un peu d''eau si nécessaire.'),
(8, 32, 'Ajoutez les amandes en fin de cuisson et mélangez délicatement.'),
(9, 32, 'Servez le tajine bien chaud avec son jus de cuisson.'),
-- 33. Moussaka aux aubergines et au bœuf
(1, 33, 'Coupez les aubergines en tranches régulières.'),
(2, 33, 'Faites revenir les aubergines dans une poêle avec un peu d''huile.'),
(3, 33, 'Émincez l''oignon puis faites-le revenir dans une seconde poêle.'),
(4, 33, 'Ajoutez le bœuf haché et faites-le cuire jusqu''à ce qu''il soit bien doré.'),
(5, 33, 'Ajoutez les tomates et laissez mijoter la préparation quelques minutes.'),
(6, 33, 'Disposez une couche d''aubergines dans un plat à gratin.'),
(7, 33, 'Ajoutez une couche de préparation au bœuf puis recommencez les couches.'),
(8, 33, 'Terminez avec la crème et le parmesan.'),
(9, 33, 'Enfournez environ une heure puis laissez reposer quelques minutes avant de servir.'),
-- 34. Galettes de pois chiches aux herbes
(1, 34, 'Versez la farine de pois chiches dans un saladier.'),
(2, 34, 'Ajoutez l''œuf et mélangez progressivement.'),
(3, 34, 'Ajoutez le persil, la coriandre, l''ail et le cumin.'),
(4, 34, 'Versez un peu d''eau si nécessaire afin d''obtenir une pâte épaisse.'),
(5, 34, 'Laissez reposer la préparation quelques minutes.'),
(6, 34, 'Formez des galettes de taille régulière avec vos mains.'),
(7, 34, 'Faites chauffer l''huile d''olive dans une poêle.'),
(8, 34, 'Faites dorer les galettes quelques minutes de chaque côté puis servez.'),
-- 35. Gnocchis poêlés aux champignons et parmesan
(1, 35, 'Nettoyez soigneusement les champignons puis émincez-les.'),
(2, 35, 'Hachez la gousse d''ail.'),
(3, 35, 'Faites chauffer l''huile d''olive dans une grande poêle.'),
(4, 35, 'Faites revenir l''ail puis ajoutez les champignons.'),
(5, 35, 'Laissez cuire les champignons jusqu''à ce qu''ils soient légèrement dorés.'),
(6, 35, 'Ajoutez les gnocchis et faites-les dorer en les retournant régulièrement.'),
(7, 35, 'Ajoutez le parmesan et mélangez délicatement.'),
(8, 35, 'Servez immédiatement avec un peu de parmesan supplémentaire.'),
-- 36. Focaccia aux tomates et au romarin
(1, 36, 'Mélangez la farine, la levure et le sel dans un grand saladier.'),
(2, 36, 'Ajoutez progressivement l''eau et mélangez jusqu''à former une pâte.'),
(3, 36, 'Pétrissez la pâte pendant plusieurs minutes jusqu''à ce qu''elle devienne souple.'),
(4, 36, 'Couvrez la pâte puis laissez-la lever jusqu''à ce qu''elle double de volume.'),
(5, 36, 'Déposez la pâte sur une plaque généreusement huilée.'),
(6, 36, 'Étalez-la avec les doigts et formez quelques creux à sa surface.'),
(7, 36, 'Ajoutez les tomates, le romarin, l''huile d''olive et le sel.'),
(8, 36, 'Laissez reposer quelques minutes puis enfournez jusqu''à obtenir une focaccia dorée.'),
-- 37. Crumble aux pommes et aux noix
(1, 37, 'Préchauffez le four à la température adaptée.'),
(2, 37, 'Épluchez les pommes et coupez-les en morceaux réguliers.'),
(3, 37, 'Disposez les morceaux de pommes dans un plat allant au four.'),
(4, 37, 'Mélangez la farine, le sucre et le beurre du bout des doigts.'),
(5, 37, 'Ajoutez les noix concassées puis travaillez la préparation jusqu''à obtenir une texture sableuse.'),
(6, 37, 'Répartissez la pâte à crumble sur les pommes.'),
(7, 37, 'Saupoudrez légèrement de cannelle puis enfournez environ trente minutes.'),
(8, 37, 'Laissez tiédir quelques minutes avant de servir.'),
-- 38. Cheesecake aux fruits rouges
(1, 38, 'Préchauffez le four puis préparez un moule à charnière.'),
(2, 38, 'Écrasez les biscuits puis mélangez-les avec le beurre fondu.'),
(3, 38, 'Répartissez le mélange dans le fond du moule et tassez bien.'),
(4, 38, 'Placez la base au frais pendant la préparation de la garniture.'),
(5, 38, 'Mélangez le fromage frais avec le sucre jusqu''à obtenir une préparation lisse.'),
(6, 38, 'Ajoutez les œufs un à un puis mélangez délicatement.'),
(7, 38, 'Versez la préparation sur la base biscuitée.'),
(8, 38, 'Ajoutez les fruits rouges puis enfournez environ quarante-cinq minutes.'),
(9, 38, 'Laissez refroidir complètement puis placez le cheesecake au réfrigérateur avant de servir.'),
-- 39. Panna cotta à la vanille et aux framboises
(1, 39, 'Placez les feuilles de gélatine dans un bol d''eau froide afin de les ramollir.'),
(2, 39, 'Versez la crème liquide dans une casserole.'),
(3, 39, 'Ajoutez le sucre et la gousse de vanille fendue.'),
(4, 39, 'Faites chauffer doucement la crème sans la porter à ébullition.'),
(5, 39, 'Retirez la casserole du feu et retirez la gousse de vanille.'),
(6, 39, 'Essorez la gélatine puis incorporez-la à la crème chaude.'),
(7, 39, 'Versez la préparation dans des verrines.'),
(8, 39, 'Laissez refroidir puis placez les verrines au réfrigérateur plusieurs heures.'),
(9, 39, 'Ajoutez les framboises juste avant de servir.'),
-- 40. Smoothie mangue, banane et lait d'amande
(1, 40, 'Épluchez la mangue et retirez son noyau.'),
(2, 40, 'Épluchez la banane puis coupez les fruits en morceaux.'),
(3, 40, 'Placez les fruits dans le bol d''un blender.'),
(4, 40, 'Ajoutez le lait d''amande et le miel.'),
(5, 40, 'Mixez à pleine puissance jusqu''à obtenir une texture lisse et crémeuse.'),
(6, 40, 'Ajoutez un peu de lait si le smoothie est trop épais.'),
(7, 40, 'Versez dans des verres et servez immédiatement.'),
-- 41. Velouté de brocoli au parmesan
(1, 41, 'Détaillez le brocoli en petites fleurettes puis émincez l''oignon.'),
(2, 41, 'Faites revenir l''oignon dans l''huile d''olive sans le colorer.'),
(3, 41, 'Ajoutez le brocoli puis versez le bouillon de légumes.'),
(4, 41, 'Laissez cuire environ vingt-cinq minutes jusqu''à ce que le brocoli soit tendre.'),
(5, 41, 'Mixez la préparation jusqu''à obtenir une texture parfaitement lisse.'),
(6, 41, 'Ajoutez la crème et le parmesan puis mélangez.'),
(7, 41, 'Rectifiez l''assaisonnement puis servez le velouté bien chaud.'),
-- 42. Tartare de saumon à l'avocat et au citron vert
(1, 42, 'Vérifiez que le saumon est adapté à une consommation crue puis coupez-le en petits dés.'),
(2, 42, 'Épluchez l''avocat et coupez-le en dés de taille similaire.'),
(3, 42, 'Pressez les citrons verts et réservez le jus.'),
(4, 42, 'Ciselez finement la coriandre.'),
(5, 42, 'Mélangez délicatement le saumon et l''avocat.'),
(6, 42, 'Ajoutez le citron vert, la coriandre et l''huile d''olive.'),
(7, 42, 'Assaisonnez puis réservez quelques minutes au réfrigérateur avant de servir.'),
-- 43. Poulet tikka masala
(1, 43, 'Coupez le poulet en morceaux réguliers.'),
(2, 43, 'Mélangez le poulet avec le yaourt et le garam masala.'),
(3, 43, 'Ajoutez le curcuma puis laissez mariner le poulet au frais.'),
(4, 43, 'Émincez l''oignon et hachez l''ail.'),
(5, 43, 'Faites revenir l''oignon et l''ail dans une grande poêle.'),
(6, 43, 'Ajoutez le poulet mariné et faites-le dorer sur toutes ses faces.'),
(7, 43, 'Ajoutez les tomates puis mélangez.'),
(8, 43, 'Laissez mijoter environ trente-cinq minutes jusqu''à ce que le poulet soit tendre.'),
(9, 43, 'Vérifiez l''assaisonnement puis servez bien chaud.'),
-- 44. Poivrons farcis au quinoa et à la feta
(1, 44, 'Préchauffez le four puis coupez les poivrons en deux dans le sens de la longueur.'),
(2, 44, 'Retirez les graines et les parties blanches des poivrons.'),
(3, 44, 'Faites cuire le quinoa puis égouttez-le.'),
(4, 44, 'Émincez l''oignon et coupez les tomates en petits dés.'),
(5, 44, 'Mélangez le quinoa avec l''oignon, les tomates et la feta.'),
(6, 44, 'Ajoutez la coriandre et mélangez la farce.'),
(7, 44, 'Garnissez généreusement les demi-poivrons avec la préparation.'),
(8, 44, 'Déposez les poivrons dans un plat puis enfournez environ trente-cinq minutes.'),
-- 45. Brandade de morue traditionnelle
(1, 45, 'Faites dessaler la morue au préalable si nécessaire en renouvelant régulièrement l''eau.'),
(2, 45, 'Faites cuire la morue dans une casserole d''eau puis égouttez-la.'),
(3, 45, 'Retirez les éventuelles arêtes et émiettez soigneusement la morue.'),
(4, 45, 'Épluchez les pommes de terre et coupez-les en morceaux.'),
(5, 45, 'Faites cuire les pommes de terre dans une casserole d''eau salée.'),
(6, 45, 'Écrasez les pommes de terre pour obtenir une purée.'),
(7, 45, 'Ajoutez la morue, l''ail, la crème et l''huile d''olive.'),
(8, 45, 'Mélangez jusqu''à obtenir une préparation homogène.'),
(9, 45, 'Versez dans un plat puis faites gratiner au four jusqu''à obtenir une surface dorée.'),
-- 46. Courgettes farcies aux lentilles et légumes
(1, 46, 'Préchauffez le four puis lavez les courgettes.'),
(2, 46, 'Coupez les courgettes en deux et évidez délicatement leur centre.'),
(3, 46, 'Faites cuire les lentilles puis égouttez-les.'),
(4, 46, 'Épluchez les carottes et coupez-les en petits dés.'),
(5, 46, 'Émincez l''oignon et faites-le revenir dans l''huile d''olive.'),
(6, 46, 'Ajoutez les carottes, les tomates et la chair des courgettes.'),
(7, 46, 'Ajoutez les lentilles puis mélangez la farce.'),
(8, 46, 'Garnissez les courgettes avec la préparation.'),
(9, 46, 'Enfournez environ trente-cinq minutes jusqu''à ce que les courgettes soient tendres.'),
-- 47. Raviolis aux épinards et à la ricotta
(1, 47, 'Faites revenir les épinards dans une poêle avec un filet d''huile d''olive.'),
(2, 47, 'Laissez-les refroidir puis pressez-les pour retirer l''excédent d''eau.'),
(3, 47, 'Hachez finement les épinards et mélangez-les avec la ricotta.'),
(4, 47, 'Ajoutez l''œuf et le parmesan puis mélangez jusqu''à obtenir une farce homogène.'),
(5, 47, 'Déposez de petites portions de farce sur les feuilles de pâte à raviolis.'),
(6, 47, 'Humidifiez légèrement les bords puis recouvrez avec une seconde feuille de pâte.'),
(7, 47, 'Pressez les bords pour bien fermer les raviolis puis découpez-les.'),
(8, 47, 'Portez une grande casserole d''eau salée à ébullition.'),
(9, 47, 'Plongez les raviolis dans l''eau et faites-les cuire quelques minutes.'),
(10, 47, 'Égouttez délicatement les raviolis puis servez-les immédiatement.'),
-- 48. Moules au curry et lait de coco
(1, 48, 'Nettoyez soigneusement les moules et retirez les coquilles cassées.'),
(2, 48, 'Émincez l''oignon et hachez l''ail.'),
(3, 48, 'Faites revenir l''oignon et l''ail dans une grande casserole.'),
(4, 48, 'Ajoutez la pâte de curry et mélangez pendant quelques secondes.'),
(5, 48, 'Versez le lait de coco et portez doucement à ébullition.'),
(6, 48, 'Ajoutez les moules puis couvrez immédiatement la casserole.'),
(7, 48, 'Faites cuire jusqu''à ce que les moules soient toutes ouvertes.'),
(8, 48, 'Ajoutez la coriandre puis servez immédiatement avec la sauce.'),
-- 49. Brochettes de poulet au paprika et citron
(1, 49, 'Coupez les blancs de poulet en morceaux de taille régulière.'),
(2, 49, 'Pressez le citron et mélangez son jus avec l''huile d''olive.'),
(3, 49, 'Ajoutez le paprika et mélangez la marinade.'),
(4, 49, 'Déposez le poulet dans la marinade et mélangez soigneusement.'),
(5, 49, 'Laissez mariner le poulet quelques minutes au frais.'),
(6, 49, 'Répartissez les morceaux de poulet sur les brochettes.'),
(7, 49, 'Faites cuire les brochettes au barbecue ou à la poêle en les retournant régulièrement.'),
(8, 49, 'Vérifiez que le poulet est bien cuit puis servez immédiatement.'),
-- 50. Polenta crémeuse aux champignons
(1, 50, 'Nettoyez les champignons puis émincez-les.'),
(2, 50, 'Faites revenir les champignons dans l''huile d''olive jusqu''à ce qu''ils soient dorés.'),
(3, 50, 'Pendant ce temps, portez le bouillon à ébullition.'),
(4, 50, 'Versez progressivement la polenta dans le bouillon en mélangeant constamment.'),
(5, 50, 'Poursuivez la cuisson jusqu''à ce que la polenta soit épaisse et crémeuse.'),
(6, 50, 'Ajoutez la crème et le parmesan puis mélangez.'),
(7, 50, 'Répartissez la polenta dans les assiettes et ajoutez les champignons.'),
(8, 50, 'Servez immédiatement.'),
-- 51. Salade de quinoa, concombre et pois chiches
(1, 51, 'Rincez le quinoa puis faites-le cuire dans une casserole d''eau.'),
(2, 51, 'Égouttez le quinoa puis laissez-le refroidir.'),
(3, 51, 'Lavez le concombre et les tomates puis coupez-les en petits morceaux.'),
(4, 51, 'Égouttez les pois chiches.'),
(5, 51, 'Réunissez le quinoa, les légumes et les pois chiches dans un saladier.'),
(6, 51, 'Ajoutez le jus de citron, la coriandre et l''huile d''olive.'),
(7, 51, 'Mélangez délicatement puis placez au frais avant de servir.'),
-- 52. Bœuf mijoté aux carottes et au thym
(1, 52, 'Coupez le bœuf en morceaux de taille régulière.'),
(2, 52, 'Épluchez les carottes et coupez-les en rondelles.'),
(3, 52, 'Émincez les oignons puis faites-les revenir dans une cocotte.'),
(4, 52, 'Ajoutez les morceaux de bœuf et faites-les dorer sur toutes leurs faces.'),
(5, 52, 'Ajoutez les carottes, le thym et la feuille de laurier.'),
(6, 52, 'Versez le bouillon puis portez le mélange à frémissement.'),
(7, 52, 'Couvrez et laissez mijoter environ deux heures à feu doux.'),
(8, 52, 'Vérifiez la tendreté de la viande et rectifiez l''assaisonnement.'),
(9, 52, 'Retirez le laurier puis servez le bœuf avec les carottes et la sauce.'),
-- 53. Chou-fleur rôti au curry et au tahini
(1, 53, 'Préchauffez le four puis détaillez le chou-fleur en petits bouquets.'),
(2, 53, 'Rincez les bouquets puis séchez-les soigneusement.'),
(3, 53, 'Mélangez le chou-fleur avec l''huile d''olive et le curry.'),
(4, 53, 'Disposez les bouquets sur une plaque de cuisson sans les superposer.'),
(5, 53, 'Enfournez environ trente-cinq minutes en retournant les bouquets à mi-cuisson.'),
(6, 53, 'Mélangez le tahini avec le jus de citron et un peu d''eau.'),
(7, 53, 'Versez la sauce au tahini sur le chou-fleur rôti.'),
(8, 53, 'Ajoutez quelques feuilles de coriandre puis servez.'),
-- 54. Aubergines grillées à la feta et aux tomates séchées
(1, 54, 'Lavez les aubergines puis coupez-les en tranches dans le sens de la longueur.'),
(2, 54, 'Badigeonnez les tranches avec l''huile d''olive.'),
(3, 54, 'Faites griller les aubergines à la poêle ou au four jusqu''à ce qu''elles soient tendres.'),
(4, 54, 'Coupez les tomates séchées en petits morceaux.'),
(5, 54, 'Émiettez la feta sur les aubergines encore chaudes.'),
(6, 54, 'Ajoutez les tomates séchées et quelques feuilles de basilic.'),
(7, 54, 'Poivrez légèrement puis servez chaud ou tiède.'),
-- 55. Calamars à la provençale
(1, 55, 'Nettoyez les calamars puis coupez-les en anneaux réguliers.'),
(2, 55, 'Émincez l''oignon et hachez les gousses d''ail.'),
(3, 55, 'Faites revenir l''oignon et l''ail dans l''huile d''olive.'),
(4, 55, 'Ajoutez les calamars et faites-les saisir rapidement à feu vif.'),
(5, 55, 'Ajoutez les tomates et l''origan puis mélangez.'),
(6, 55, 'Laissez mijoter à feu doux jusqu''à ce que les calamars soient tendres.'),
(7, 55, 'Rectifiez l''assaisonnement puis servez immédiatement.'),
-- 56. Galette de sarrasin au jambon et au comté
(1, 56, 'Mélangez la farine de sarrasin avec le lait et les œufs.'),
(2, 56, 'Fouettez jusqu''à obtenir une pâte homogène puis laissez-la reposer quelques minutes.'),
(3, 56, 'Faites chauffer une poêle ou une crêpière légèrement huilée.'),
(4, 56, 'Versez une louche de pâte et étalez-la finement.'),
(5, 56, 'Faites cuire la galette sur la première face puis retournez-la.'),
(6, 56, 'Déposez le jambon au centre et ajoutez le comté râpé.'),
(7, 56, 'Rabattez les bords de la galette vers le centre.'),
(8, 56, 'Poursuivez la cuisson jusqu''à ce que le fromage soit complètement fondu.'),
-- 57. Brioche à la fleur d'oranger
(1, 57, 'Versez la farine dans un saladier puis ajoutez la levure et le sucre.'),
(2, 57, 'Ajoutez les œufs et le lait puis commencez à pétrir la pâte.'),
(3, 57, 'Ajoutez progressivement le beurre en morceaux tout en continuant de pétrir.'),
(4, 57, 'Versez la fleur d''oranger et pétrissez jusqu''à obtenir une pâte souple.'),
(5, 57, 'Couvrez la pâte et laissez-la lever environ une heure dans un endroit tiède.'),
(6, 57, 'Dégazez la pâte puis façonnez la brioche selon la forme souhaitée.'),
(7, 57, 'Placez la brioche dans son moule puis laissez-la lever une seconde fois.'),
(8, 57, 'Préchauffez le four pendant la seconde pousse.'),
(9, 57, 'Enfournez la brioche et faites-la cuire jusqu''à ce qu''elle soit bien dorée.'),
(10, 57, 'Laissez refroidir la brioche sur une grille avant de la découper.'),
-- 58. Financiers aux amandes et framboises
(1, 58, 'Préchauffez le four et faites fondre doucement le beurre.'),
(2, 58, 'Mélangez la poudre d''amande avec la farine et le sucre glace.'),
(3, 58, 'Ajoutez les blancs d''œufs et mélangez jusqu''à obtenir une pâte homogène.'),
(4, 58, 'Incorporez le beurre fondu puis mélangez délicatement.'),
(5, 58, 'Beurrez légèrement les moules à financiers si nécessaire.'),
(6, 58, 'Répartissez la pâte dans les moules sans les remplir complètement.'),
(7, 58, 'Déposez quelques framboises dans chaque financier.'),
(8, 58, 'Enfournez environ quinze minutes jusqu''à ce que les bords soient dorés.'),
(9, 58, 'Laissez refroidir quelques minutes avant de démouler les financiers.'),
-- 59. Crème brûlée à la vanille
(1, 59, 'Préchauffez le four puis fendez la gousse de vanille dans le sens de la longueur.'),
(2, 59, 'Versez la crème dans une casserole et ajoutez la gousse de vanille.'),
(3, 59, 'Faites chauffer la crème doucement sans la porter à ébullition.'),
(4, 59, 'Séparez les jaunes d''œufs puis fouettez-les avec le sucre.'),
(5, 59, 'Retirez la vanille puis versez progressivement la crème chaude sur les jaunes.'),
(6, 59, 'Mélangez délicatement afin de ne pas incorporer trop d''air.'),
(7, 59, 'Répartissez la préparation dans des ramequins.'),
(8, 59, 'Faites cuire au four jusqu''à ce que les crèmes soient prises mais encore légèrement tremblotantes.'),
(9, 59, 'Laissez refroidir puis placez les ramequins au réfrigérateur plusieurs heures.'),
(10, 59, 'Saupoudrez de sucre puis caramélisez la surface juste avant de servir.'),
-- 60. Compote de pommes, cannelle et sirop d'érable
(1, 60, 'Épluchez les pommes et retirez les pépins.'),
(2, 60, 'Coupez les pommes en petits morceaux de taille régulière.'),
(3, 60, 'Placez les morceaux de pommes dans une casserole avec la cannelle.'),
(4, 60, 'Ajoutez un petit fond d''eau puis faites chauffer à feu doux.'),
(5, 60, 'Couvrez et laissez cuire environ vingt-cinq minutes en mélangeant régulièrement.'),
(6, 60, 'Vérifiez que les pommes sont suffisamment fondantes puis retirez du feu.'),
(7, 60, 'Écrasez les pommes à la fourchette ou mixez-les selon la texture souhaitée.'),
(8, 60, 'Ajoutez le sirop d''érable, mélangez puis laissez tiédir avant de servir.');
------------------------------------------------------------------------------------------------------------------------
INSERT INTO avis
(id_recette, id_utilisateur, note, commentaire)
VALUES
-- Recette 1
(1, 2, 5, 'Une association très réussie entre la saucisse de Morteau et l''aubergine. Très savoureux.'),
(1, 7, 4, 'Très bon plat, avec beaucoup de goût. La saucisse apporte une belle saveur fumée.'),
(1, 14, 4, 'Recette simple à réaliser et très réconfortante.'),
-- Recette 2
(2, 1, 5, 'Le saumon est excellent avec la crème au wasabi. Une recette originale.'),
(2, 8, 4, 'Très bonne recette, le wasabi apporte juste ce qu''il faut de piquant.'),
(2, 16, 5, 'Délicieux et assez rapide à préparer.'),
-- Recette 3
(3, 3, 4, 'Une recette étonnante et très originale.'),
(3, 9, 3, 'Concept amusant, même si l''association est assez surprenante.'),
(3, 18, 4, 'Très frais et agréable en été.'),
-- Recette 4
(4, 4, 5, 'Un risotto bien crémeux et très parfumé.'),
(4, 11, 5, 'Excellent avec les champignons, je referai cette recette.'),
(4, 19, 4, 'Très bon résultat, même si la préparation demande un peu de temps.'),
-- Recette 5
(5, 5, 5, 'Une tarte très simple et pleine de fraîcheur.'),
(5, 10, 4, 'Le basilic apporte vraiment une excellente touche finale.'),
(5, 17, 5, 'Très bonne recette pour un repas léger.'),
-- Recette 6
(6, 2, 5, 'Le poulet est tendre et très parfumé.'),
(6, 12, 4, 'Très bonne recette familiale.'),
(6, 20, 5, 'Le citron et le romarin fonctionnent parfaitement ensemble.'),
-- Recette 7
(7, 6, 5, 'Un velouté très doux et réconfortant.'),
(7, 13, 4, 'Très bon, surtout en automne.'),
(7, 15, 5, 'La châtaigne apporte une excellente texture.'),
-- Recette 8
(8, 1, 4, 'Des pâtes simples mais très gourmandes.'),
(8, 7, 5, 'Les épinards se marient très bien avec la crème.'),
(8, 16, 4, 'Rapide à préparer et délicieux.'),
-- Recette 9
(9, 3, 5, 'Le magret est parfaitement accompagné par les fruits rouges.'),
(9, 8, 5, 'Une très belle association sucrée-salée.'),
(9, 19, 4, 'Très bon plat, élégant et savoureux.'),
-- Recette 10
(10, 4, 5, 'Une salade fraîche et pleine de couleurs.'),
(10, 9, 4, 'Très agréable en été.'),
(10, 14, 5, 'L''avocat et la mangue se marient très bien avec les crevettes.'),
-- Recette 11
(11, 2, 5, 'Un curry végétarien très parfumé.'),
(11, 10, 4, 'Simple à préparer et très gourmand.'),
(11, 18, 5, 'Le lait de coco apporte beaucoup d''onctuosité.'),
-- Recette 12
(12, 5, 4, 'Un plat de poisson simple et efficace.'),
(12, 11, 5, 'Les tomates et les olives donnent beaucoup de goût au cabillaud.'),
(12, 20, 4, 'Très bonne recette méditerranéenne.'),
-- Recette 13
(13, 1, 5, 'La quiche est fondante et très parfumée.'),
(13, 6, 4, 'Très bonne association entre le poireau et le chèvre.'),
(13, 17, 5, 'Une recette facile et idéale pour un repas en famille.'),
-- Recette 14
(14, 3, 5, 'Un bowl très frais et équilibré.'),
(14, 12, 4, 'Très bon mélange de textures.'),
(14, 16, 5, 'Une recette saine et colorée.'),
-- Recette 15
(15, 4, 5, 'Le bœuf est tendre et les légumes restent croquants.'),
(15, 9, 4, 'Très bon wok, rapide à préparer.'),
(15, 19, 5, 'Une recette pleine de saveurs.'),
-- Recette 16
(16, 2, 5, 'Une excellente tarte aux pommes.'),
(16, 8, 4, 'La cannelle apporte une très bonne touche parfumée.'),
(16, 15, 5, 'Simple, traditionnelle et délicieuse.'),
-- Recette 17
(17, 5, 5, 'Une mousse au chocolat très gourmande.'),
(17, 13, 5, 'La texture est parfaite.'),
(17, 20, 4, 'Une recette classique toujours efficace.'),
-- Recette 18
(18, 1, 5, 'Des pancakes moelleux et très parfumés.'),
(18, 7, 4, 'La banane apporte beaucoup de douceur.'),
(18, 14, 5, 'Parfait pour un petit-déjeuner gourmand.'),
-- Recette 19
(19, 3, 4, 'Une salade fraîche et très agréable.'),
(19, 10, 5, 'La feta apporte une excellente touche salée.'),
(19, 18, 5, 'Très bonne recette méditerranéenne.'),
-- Recette 20
(20, 6, 5, 'Le saumon est très parfumé avec le gingembre.'),
(20, 11, 4, 'Très bonne recette asiatique.'),
(20, 16, 5, 'La sauce soja relève parfaitement le poisson.'),
-- Recette 21
(21, 2, 5, 'Des bruschettas simples et très savoureuses.'),
(21, 9, 4, 'Très bonnes pour un apéritif improvisé.'),
(21, 17, 5, 'Tomate, mozzarella et basilic : une valeur sûre.'),
-- Recette 22
(22, 4, 4, 'Les œufs sont bien crémeux.'),
(22, 12, 5, 'Très bonne idée pour un repas rapide.'),
(22, 19, 4, 'Simple et délicieux.'),
-- Recette 23
(23, 1, 5, 'Une salade complète et très savoureuse.'),
(23, 8, 4, 'Les lentilles donnent beaucoup de consistance.'),
(23, 15, 5, 'Une recette saine et facile.'),
-- Recette 24
(24, 3, 5, 'Un gratin très fondant et gourmand.'),
(24, 10, 5, 'Le comté apporte énormément de goût.'),
(24, 20, 4, 'Parfait pour accompagner une viande.'),
-- Recette 25
(25, 5, 5, 'Des lasagnes végétariennes vraiment délicieuses.'),
(25, 11, 4, 'Très bon plat, même sans viande.'),
(25, 18, 5, 'Les légumes rendent les lasagnes très savoureuses.'),
-- Recette 26
(26, 2, 5, 'Un curry de poulet très parfumé.'),
(26, 7, 4, 'Le lait de coco apporte une belle douceur.'),
(26, 16, 5, 'Très facile à préparer et excellent.'),
-- Recette 27
(27, 4, 5, 'Les crevettes sont parfaitement parfumées.'),
(27, 13, 4, 'Le citron vert apporte beaucoup de fraîcheur.'),
(27, 19, 5, 'Une recette rapide et délicieuse.'),
-- Recette 28
(28, 1, 5, 'Un risotto crémeux et très réussi.'),
(28, 9, 5, 'Les asperges et le parmesan se marient parfaitement.'),
(28, 17, 4, 'Très bon plat, même si la cuisson demande de l''attention.'),
-- Recette 29
(29, 3, 5, 'Des tacos très gourmands et bien relevés.'),
(29, 8, 4, 'Le guacamole accompagne parfaitement le bœuf.'),
(29, 14, 5, 'Une recette conviviale et pleine de saveurs.'),
-- Recette 30
(30, 6, 5, 'Un excellent pad thaï fait maison.'),
(30, 12, 4, 'Très bon résultat et beaucoup de saveurs.'),
(30, 20, 5, 'Les crevettes sont délicieuses avec les nouilles.'),
-- Recette 31
(31, 2, 5, 'Un dahl très parfumé et réconfortant.'),
(31, 10, 4, 'Très bonne recette végétarienne.'),
(31, 18, 5, 'Le curry donne beaucoup de caractère au plat.'),
-- Recette 32
(32, 5, 5, 'Un tajine très parfumé et fondant.'),
(32, 11, 5, 'Les pruneaux et les amandes donnent une excellente association.'),
(32, 16, 4, 'Très bon plat familial.'),
-- Recette 33
(33, 1, 5, 'Une moussaka généreuse et très savoureuse.'),
(33, 7, 4, 'Très bonne recette traditionnelle.'),
(33, 19, 5, 'Les aubergines sont parfaitement fondantes.'),
-- Recette 34
(34, 3, 4, 'Des galettes très faciles à préparer.'),
(34, 9, 5, 'Très bonnes avec une salade verte.'),
(34, 15, 4, 'Une bonne alternative végétarienne.'),
-- Recette 35
(35, 4, 5, 'Les gnocchis sont très gourmands avec les champignons.'),
(35, 12, 4, 'Une recette simple et efficace.'),
(35, 18, 5, 'Le parmesan apporte une excellente finition.'),
-- Recette 36
(36, 2, 5, 'Une focaccia très parfumée et moelleuse.'),
(36, 8, 4, 'Les tomates et le romarin fonctionnent très bien ensemble.'),
(36, 14, 5, 'Parfaite pour accompagner un repas italien.'),
-- Recette 37
(37, 5, 5, 'Un crumble très gourmand et facile à réaliser.'),
(37, 10, 4, 'Les noix ajoutent un bon croquant.'),
(37, 17, 5, 'Excellent encore tiède.'),
-- Recette 38
(38, 1, 5, 'Un cheesecake très crémeux et fruité.'),
(38, 6, 5, 'Les fruits rouges apportent beaucoup de fraîcheur.'),
(38, 20, 4, 'Très bon dessert, un peu long à préparer mais ça vaut le coup.'),
-- Recette 39
(39, 3, 5, 'Une panna cotta légère et très parfumée.'),
(39, 11, 4, 'La vanille est bien présente.'),
(39, 16, 5, 'Très joli dessert et facile à réaliser.'),
-- Recette 40
(40, 4, 5, 'Un smoothie frais et très fruité.'),
(40, 9, 4, 'Très bon mélange de fruits.'),
(40, 15, 5, 'Parfait pour un petit-déjeuner rapide.'),
-- Recette 41
(41, 2, 5, 'Un velouté de brocoli très doux.'),
(41, 7, 4, 'Le parmesan apporte beaucoup de goût.'),
(41, 19, 5, 'Une bonne manière de cuisiner le brocoli.'),
-- Recette 42
(42, 5, 5, 'Un tartare très frais et savoureux.'),
(42, 12, 4, 'L''avocat apporte une texture très agréable.'),
(42, 18, 5, 'Excellent avec le citron vert.'),
-- Recette 43
(43, 1, 5, 'Un poulet tikka masala très parfumé.'),
(43, 8, 5, 'Les épices sont parfaitement équilibrées.'),
(43, 14, 4, 'Très bon plat indien.'),
-- Recette 44
(44, 3, 4, 'Des poivrons très savoureux et colorés.'),
(44, 10, 5, 'Le quinoa et la feta fonctionnent très bien ensemble.'),
(44, 17, 5, 'Une recette végétarienne complète.'),
-- Recette 45
(45, 6, 5, 'Une brandade généreuse et très réconfortante.'),
(45, 11, 4, 'Très bonne recette traditionnelle.'),
(45, 20, 5, 'La morue est parfaitement préparée.'),
-- Recette 46
(46, 2, 5, 'Une recette végétarienne très gourmande.'),
(46, 9, 4, 'Les courgettes sont bien fondantes.'),
(46, 16, 5, 'Très bon plat complet.'),
-- Recette 47
(47, 4, 5, 'Des raviolis très fins et savoureux.'),
(47, 13, 5, 'Les épinards et la ricotta sont une excellente association.'),
(47, 19, 4, 'Une recette un peu longue mais très réussie.'),
-- Recette 48
(48, 1, 5, 'Les moules sont délicieuses avec le curry et le lait de coco.'),
(48, 7, 4, 'Très bonne recette originale.'),
(48, 15, 5, 'Un plat rapide et plein de saveurs.'),
-- Recette 49
(49, 3, 5, 'Des brochettes très parfumées et faciles à réaliser.'),
(49, 8, 4, 'Le paprika donne beaucoup de goût au poulet.'),
(49, 18, 5, 'Parfait pour un barbecue.'),
-- Recette 50
(50, 5, 5, 'Une polenta très crémeuse et savoureuse.'),
(50, 10, 4, 'Les champignons apportent une excellente texture.'),
(50, 17, 5, 'Un plat simple et réconfortant.'),
-- Recette 51
(51, 2, 4, 'Une salade fraîche et complète.'),
(51, 12, 5, 'Le quinoa et les pois chiches rendent la salade très consistante.'),
(51, 20, 5, 'Très bonne recette pour un déjeuner léger.'),
-- Recette 52
(52, 1, 5, 'Une viande très fondante et pleine de saveurs.'),
(52, 6, 5, 'La cuisson longue donne un excellent résultat.'),
(52, 14, 4, 'Un très bon plat familial.'),
-- Recette 53
(53, 4, 5, 'Le chou-fleur rôti est délicieux.'),
(53, 9, 4, 'Le tahini apporte une belle touche crémeuse.'),
(53, 16, 5, 'Une excellente recette végétarienne.'),
-- Recette 54
(54, 3, 5, 'Les aubergines grillées sont très savoureuses.'),
(54, 11, 4, 'Très bonne association avec la feta.'),
(54, 19, 5, 'Les tomates séchées apportent beaucoup de caractère.'),
-- Recette 55
(55, 2, 5, 'Des calamars très tendres et bien parfumés.'),
(55, 8, 4, 'Une excellente recette méditerranéenne.'),
(55, 15, 5, 'Simple et vraiment délicieux.'),
-- Recette 56
(56, 5, 5, 'Une galette bretonne très gourmande.'),
(56, 13, 4, 'Le jambon et le comté forment une très bonne association.'),
(56, 18, 5, 'Une recette simple et efficace.'),
-- Recette 57
(57, 1, 5, 'Une brioche très moelleuse et parfumée.'),
(57, 7, 5, 'La fleur d''oranger apporte un parfum délicat.'),
(57, 20, 4, 'Très bonne brioche, parfaite au petit-déjeuner.'),
-- Recette 58
(58, 4, 5, 'Des financiers très moelleux et parfumés.'),
(58, 10, 4, 'Les framboises apportent une belle acidité.'),
(58, 16, 5, 'Très bons avec un café.'),
-- Recette 59
(59, 6, 5, 'Une crème brûlée très réussie.'),
(59, 12, 5, 'La texture est parfaite et la vanille bien présente.'),
(59, 19, 4, 'Un grand classique toujours aussi bon.'),
-- Recette 60
(60, 5, 5, 'Une compote simple et très parfumée.'),
(60, 9, 4, 'Très bonne recette, parfaite pour utiliser des pommes bien mûres.'),
(60, 15, 5, 'Rapide, économique et délicieuse, surtout encore légèrement tiède.');
---------------------------------------------------------------------------------------------------------------------
