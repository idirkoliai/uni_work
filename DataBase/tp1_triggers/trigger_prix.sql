DROP TRIGGER IF EXISTS trigger_prix ON baguette;

CREATE OR REPLACE FUNCTION calcul_prix()
RETURNS TRIGGER AS
$$
  DECLARE
    prix_1 numeric;
    prix_2 numeric;

  BEGIN

    SELECT prixUnitaire INTO prix_1
    FROM prixCoeur
    WHERE coeur = NEW.coeur;
    IF NOT FOUND THEN 
        RAISE NOTICE 'the heart %s is not available therefore the price must be calculated manually',NEW.coeur; RETURN NULL;
    END IF;
    
    SELECT prixCm INTO prix_2
    FROM prixBois
    WHERE bois = NEW.bois;
    IF NOT FOUND THEN 
        RAISE NOTICE 'the wood %s is not available therefore the price must be calculated manually',NEW.wood; RETURN NULL;
    END IF;
    
    SELECT prixCm INTO prix_2
    FROM prixBois
    WHERE bois = NEW.bois;



    
    NEW.prix = prix_1 + NEW.longueur * prix_2;

  RETURN NEW;
  END ;
$$
LANGUAGE plpgsql;

CREATE TRIGGER trigger_prix
BEFORE INSERT
ON baguette
FOR EACH ROW
WHEN (NEW.prix IS NULL)
EXECUTE PROCEDURE calcul_prix();
