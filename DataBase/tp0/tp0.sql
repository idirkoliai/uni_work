--  TP d'échauffement. Ce TP avait originellement servi de TP noté en filière INFO 1 à l'ESIPE.
--
--	Consigne originale
-----------------------
--  Utilisez le script soiree_exam.sql afin de créer la base de données qui sera utilisée pour les questions suivantes.
--  Prenez le temps de vous familiariser avec les différentes tables et leur contenu avant de commencer à répondre aux questions.
--  Pour chaque question, donnez la requête SQL permettant d'obtenir le résultat demandé. 
--  Ajoutez en commentaire le nombre de lignes renvoyées par cette requête. Si la requête renvoie une seule ligne, précisez également la ligne renvoyée.
--  Soignez la présentation (indentation, nom des variables, etc.) de vos requêtes. La lisibilité de votre travail sera prise en compte.
--  A la fin du TP, déposez votre fichier dans la zone de rendu prévue à cet effet sur elearning.
--  Pensez à enregistrer régulièrement votre travail afin de ne pas le perdre en cas de panne.
--
--
--1. La liste de toutes les personnes, avec tous leurs attributs.

SELECT * FROM personne ;


--2. La liste des villes où il y a une soirée, sans doublons.

SELECT DISTINCT  lieu from soiree ;



--3. La liste des modèles de déguisements que l'on peut acheter pour moins de 24 euros.

SELECT modele from deguisement NATURAL JOIN vendre WHERE prix <= 24 ;


--4. La personne la plus jeune inscrite dans la base de données.

SELECT * FROM personne ORDER BY age ASC LIMIT 1 ;

--5. La liste des magasins qui vendent le costume ang82.

 SELECT distinct * from vendre NATURAL JOIN deguisement WHERE modele = 'ang82';


--6. Les soirées (idS, lieu, date) où au moins une personne ne porte pas de déguisement.

select distinct idS,lieu,date,avatar from soiree natural join participe where avatar is NULL;


--7. Les personnes (surnom, nom, prenom) qui ont participé à la fois à une soirée à Marseille et à une soirée à Reims.

select surnom, nom, prenom from personne natural join   participe natural join  soiree where lieu = 'Marseille' intersect select surnom, nom, prenom from personne natural join participe natural join  soiree where lieu = 'Reims'  ;



--8. Les costumes (modele, avatar) que l'on ne trouve pas en taille XL.

select distinct modele,avatar from deguisement except  select modele,avatar from deguisement natural join vendre where taille = 'XL';



--9. Les personnes (surnom, prenom, nom) qui sont allées à une soirée (idS) déguisées en un personnage portant leur prénom.

select surnom,prenom,nom from personne natural join participe where avatar = prenom ;


--10. La liste des personnes (surnom) qui sont allées à une soirée à Paris en étant déguisées en Jon Snow.

select surnom,ids,avatar,lieu from (soiree natural join participe natural join personne) where lieu  = 'Paris' and avatar = 'Jon Snow';



--11. Le prix le plus bas d'un costume de vampire.

select min(prix) from deguisement natural join vendre where avatar = 'vampire' ;



--12. La liste des soirées (ids, lieu, date) qui ont eu au moins 100 participants, triée par nombre de participants décroissant.

select ids,lieu,date,count(*) from participe natural join soiree group by (ids,lieu,date) having count(*) >= 100 ;

--13. La liste des avatars disponibles dans le commerce avec pour chacun le nom du magasin le moins cher pour l'acheter (quel que soit le modèle ou la taille).

select distinct modele,avatar,nomMag,prix from (deguisement natural join vendre) as t1 where prix = ( select min(prix) from vendre natural join deguisement where t1.avatar = avatar );


--14. Le nombre de participants de chaque âge. La liste devra être ordonnée par âges croissants.

select age,count(*) as number_of_participants from  personne as t1 where exists ( select surnom from participe as t2 where t1.surnom = t2.surnom  )    group by age order by age ;

--15. La liste de toutes les soirées (ids, lieu, date) avec pour chacune la recette totale des entrées, triée par recette décroissante.

select ids,sum(entree) as recette from participe natural join soiree group by ids order by recette desc;

--16. La liste des soirées (ids, lieu, date), avec pour chacune le nombre total de participants, triée par nombre de participants décroissant.

select ids,lieu,date,count(*) as nbr from soiree natural join participe group by ids order by count(*) desc ;


--17. La liste des villes où sont uniquement organisées des soirées de faible affluence (au plus 30 participants).
select distinct lieu from soiree as t1 where 30 >= all(select nbmax from soiree where lieu = t1.lieu);

--18. La liste des participants (surnom), avec pour chacun la fréquentation moyenne des soirées auxquelles il participe.

SELECT surnom, AVG(nb_participants) AS frequence_moyenne
FROM (
    SELECT idS, COUNT(*) AS nb_participants
    FROM participe p
    GROUP BY idS
) AS soiree_frequentation natural 
JOIN participe GROUP BY surnom;



--19. La liste des organisateurs de soirées (surnom, nom, prenom), avec pour chacun la date et le lieu de la soirée qui lui a rapporté le plus d'argent.

WITH revenue_per_soiree AS (
    SELECT s.idS, s.organisateur, s.date, s.lieu, s.entree * COUNT(pa.surnom) AS revenu
    FROM soiree s 
    NATURAL JOIN participe pa
    GROUP BY s.idS, s.organisateur, s.date, s.lieu, s.entree
)
SELECT p.surnom, p.nom, p.prenom, s.date, s.lieu, s.revenu
FROM revenue_per_soiree s
NATURAL JOIN personne p
WHERE s.revenu = (
    SELECT MAX(r.revenu) 
    FROM revenue_per_soiree r
    WHERE r.organisateur = p.surnom
)
ORDER BY p.surnom;


--20. La liste des soirées (ids, lieu, date) où apparaissent tous les avatars qui sont disponibles dans au moins un magasin.



