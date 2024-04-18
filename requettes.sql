--1- Afficher toutes les recettes disponibles (nom de la recette, catégorie et temps de préparation) triées de façon décroissante sur la durée de réalisation
    SELECT recette.nom, duree
    FROM recette
    INNER JOIN categorie ON categorie.id_categorie = recette.id_categorie
    ORDER BY duree DESC;



--2- En modifiant la requête précédente, faites apparaître le nombre d’ingrédients nécessaire par recette.
    SELECT recette.nom,  COUNT(contenir.id_ingredient) AS nombre_ingredients
    FROM recette
    INNER JOIN contenir ON recette.id_recette = contenir.id_recette
    GROUP BY recette.id_recette, recette.nom, recette.id_categorie, recette.duree
    ORDER BY recette.duree DESC;



--3- Afficher les recettes qui nécessitent au moins 30 min de préparation
    SELECT nom 
    FROM recette 
    WHERE duree >= 30 ;



--4- Afficher les recettes dont le nom contient le mot « Salade » (peu importe où est situé le mot en question)
    SELECT nom 
    FROM recette 
    WHERE nom LIKE '%salade%';



--5- Insérer une nouvelle recette : « Pâtes à la carbonara » dont la durée de réalisation est de 20 min avec 
--les instructions de votre choix. Pensez à alimenter votre base de données en conséquence afin de 
--pouvoir lister les détails de cette recettes (ingrédients)
    INSERT INTO recette (nom, duree, instructions, id_categorie)
    VALUES ('Pâtes à la carbonara', 20, 'instructions...', 2);

        -- ajout ingredient necessaire pour pates carbo
        INSERT INTO contenir (id_recette , id_ingredient , quantite)
        VALUES (12, 19, 600);
        INSERT INTO contenir (id_recette , id_ingredient , quantite)
        VALUES (12, 20, 200);


--6- Modifier le nom de la recette ayant comme identifiant id_recette = 11 (nom de la recette à votre convenance)
    UPDATE recette 
    SET nom = 'entrée salade'
    WHERE id_recette = 11 ;


--7- Supprimer la recette n°2 de la base de données
    DELETE FROM recette
    WHERE id_recette =2;


--8- Afficher le prix total de la recette n°7
    SELECT SUM(prix*quantite) AS prixRecette
    FROM ingredient
    INNER JOIN contenir ON ingredient.id_ingredient = contenir.id_ingredient
    WHERE id_recette = 7;



--9- Afficher le détail de la recette n°8 (liste des ingrédients, quantités et prix)
    SELECT nom, quantite,(prix*quantite)
    FROM ingredient
    INNER JOIN contenir ON ingredient.id_ingredient = contenir.id_ingredient
    WHERE id_recette =7;




--10- Ajouter un ingrédient en base de données : Poivre, unité : cuillère à café, prix : 2.5 €
    INSERT INTO ingredient (nom, uniteDeMesure, prix)
    VALUES ('poivre', 'cuillère à café', 2.50);


--11- Modifier le prix de l’ingrédient n°12 (prix à votre convenance)
    UPDATE ingredient 
    SET prix = 1.50
    WHERE id_ingredient= 12;

--12- Afficher le nombre de recettes par catégories : X entrées, Y plats, Z desserts

    SELECT nom_categorie, COUNT(id_recette)
    FROM recette
    INNER JOIN categorie ON recette.id_categorie = categorie.id_categorie
    GROUP BY categorie.id_categorie ;



--13- Afficher les recettes qui contiennent l’ingrédient « Poulet »
    SELECT recette.nom 
    FROM recette
    INNER JOIN contenir ON recette.id_recette = contenir.id_recette
    INNER JOIN ingredient ON contenir.id_ingredient = ingredient.id_ingredient
    WHERE ingredient.nom LIKE '%poulet%';


--14- Mettez à jour toutes les recettes en diminuant leur temps de préparation de 5 minutes 
    UPDATE recette
    SET duree = (duree - 5)
    WHERE recette.duree > 5;


--15- Afficher les recettes qui ne nécessitent pas d’ingrédients coûtant plus de 2€ par unité de mesure
    SELECT distinct recette.nom
    FROM recette 
    INNER JOIN contenir ON recette.id_recette = contenir.id_recette
    INNER JOIN ingredient ON contenir.id_ingredient = ingredient.id_ingredient
    WHERE ingredient.prix <= 2;



--16- Afficher la / les recette(s) les plus rapides à préparer
    SELECT nom
    FROM recette
    WHERE duree = (SELECT MIN(duree) FROM recette);


--17- Trouver les recettes qui ne nécessitent aucun ingrédient (par exemple la recette de la tasse d’eau chaude qui consiste à verser de l’eau chaude dans une tasse)
   SELECT recette.nom
    FROM recette
    INNER JOIN contenir ON recette.id_recette = contenir.id_recette
    INNER JOIN ingredient ON contenir.id_ingredient = ingredient.id_ingredient
    GROUP BY recette.id_recette, recette.nom
    HAVING COUNT(ingredient.id_ingredient) = 1;




--18- Trouver les ingrédients qui sont utilisés dans au moins 3 recettes
    SELECT ingredient.nom
    FROM ingredient
    INNER JOIN contenir ON ingredient.id_ingredient = contenir.id_ingredient
    GROUP BY ingredient.id_ingredient, ingredient.nom
    HAVING COUNT(DISTINCT contenir.id_recette) >= 3;


--19- Ajouter un nouvel ingrédient à une recette spécifique

INSERT INTO contenir (id_recette, id_ingredient, quantite)
VALUES (27, 11, 5);


--20- Bonus : Trouver la recette la plus coûteuse de la base de données (il peut y avoir des ex aequo, il est 
--donc exclu d’utiliser la clause LIMIT
    SELECT recette.nom, SUM(prix * quantite) AS prix_total
    FROM recette 
    INNER JOIN contenir ON recette.id_recette = contenir.id_recette
    INNER JOIN ingredient ON contenir.id_ingredient = ingredient.id_ingredient
    GROUP BY recette.id_recette, recette.nom
    ORDER BY prix_total DESC;

