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
    
    if NOT  FOUND THEN 
      RAISE EXCEPTION 'the price for % heart is not available there it should be calculated manually',NEW.coeur ;
    end if ;

    
    
    SELECT prixCm INTO prix_2
    FROM prixBois
    WHERE bois = NEW.bois;
    IF NOT FOUND THEN 
      RAISE EXCEPTION 'the price for % wood is not available there it should be calculated manually',NEW.bois;
    END IF;
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
