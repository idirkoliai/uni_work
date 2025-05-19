DROP VIEW IF EXISTS valide CASCADE;

CREATE VIEW valide(numEl, prenom, nom) AS (
  SELECT numEl, prenom, nom
  FROM eleve NATURAL JOIN suit
  WHERE note >= 10
  GROUP BY numEl
  HAVING count(*) >= 4
);

DELETE from cours where intitule = 'Points de jury';

CREATE OR REPLACE FUNCTION pointsJury()
RETURNS TRIGGER AS
$$
  declare 
    student eleve%rowtype;
    count int;
  BEGIN

    
    PERFORM * FROM eleve WHERE numEl = NEW.numEl and prenom = NEW.prenom and nom = New.nom;    
    IF NOT FOUND THEN
      RAISE NOTICE 'L''élève n''existe pas.'; RETURN NULL;
    END IF;

    perform numEl from suit where numEl = NEW.numEl and note > 10 group by numEl HAVING count(*) > 2;
    if not FOUND then 
      raise EXCEPTION 'trop de retard la chiente %',New.numEl;
    end if;

    perform * from cours where intitule = 'Points de jury' ;

    if not found then 
      insert into cours values ('jury','Points de jury',NULL,NULL,NULL);
      Raise NOTICE 'inserted jury';
    end if ;

    PERFORM * FROM valide WHERE numEl = NEW.numEl;    
    IF FOUND THEN
      RAISE NOTICE 'L''élève valide déjà son année.'; RETURN NULL;
    END IF;
    
    INSERT INTO suit VALUES (NEW.numEl, 'jury', 10);
    RETURN NEW;
  END ;
$$
LANGUAGE plpgsql;

CREATE TRIGGER valideEleve
INSTEAD OF INSERT
ON valide
FOR EACH ROW
EXECUTE PROCEDURE pointsJury();
