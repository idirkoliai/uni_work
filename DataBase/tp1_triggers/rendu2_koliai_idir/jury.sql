DROP VIEW IF EXISTS valide CASCADE;

CREATE VIEW valide(numEl, prenom, nom) AS (
  SELECT numEl, prenom, nom
  FROM eleve NATURAL JOIN suit
  WHERE note >= 10
  GROUP BY numEl
  HAVING count(*) >= 4
);

CREATE OR REPLACE FUNCTION pointsJury()
RETURNS TRIGGER AS
$$
  DECLARE
    eleveRecord eleve%ROWTYPE;
    countValide integer;
  BEGIN

    

    SELECT * INTO eleveRecord FROM eleve WHERE numEl = NEW.numEl;
    IF NOT FOUND THEN
      RAISE NOTICE 'L''élève n''existe pas.'; RETURN NULL;
    END IF;

    /*check name and surname is the same*/

    IF NEW.nom is NULL OR NEW.prenom is NULL OR eleveRecord.prenom != NEW.prenom OR eleveRecord.nom != NEW.nom THEN
      RAISE NOTICE 'Le prénom et/ou le nom de l''élève ne correspondent pas.'; RETURN NULL;
    END IF;

    PERFORM * FROM valide WHERE numEl = NEW.numEl;    
    IF FOUND THEN
      RAISE NOTICE 'L''élève valide déjà son année.'; RETURN NULL;
    END IF;

    /*count how many notes are >= 10*/

    SELECT count(*) INTO countValide FROM suit WHERE numEl = NEW.numEl AND note >= 10;

    IF countValide < 3 THEN
      RAISE NOTICE 'L''élève n''a pas assez de notes >= 10 pour forcer le passage'; RETURN NULL;
    END IF;

    PERFORM * FROM cours WHERE intitule = 'Points de jury';
    IF NOT FOUND THEN
      INSERT INTO cours VALUES('jury','Points de jury',NULL,NULL,NULL);
      RAISE NOTICE 'Le cours Points de jury a été créé.';
    END IF;
    INSERT INTO suit VALUES (NEW.numEl, 'jury', 10);
    RAISE NOTICE 'L''élève a validé son année. grâce aux points de jury.';
    RETURN NEW;
  END ;
$$
LANGUAGE plpgsql;

CREATE TRIGGER valideEleve
INSTEAD OF INSERT
ON valide
FOR EACH ROW
EXECUTE PROCEDURE pointsJury();
