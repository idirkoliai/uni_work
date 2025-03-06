DROP TRIGGER IF EXISTS trigger_incompatible ON  baguette;

CREATE OR REPLACE FUNCTION check_compatibility()
RETURNS TRIGGER AS 
$$
  BEGIN
  
    PERFORM 1 FROM incompatible WHERE bois = NEW.bois AND coeur = NEW.coeur;
    IF FOUND THEN 
	RAISE EXCEPTION 'Incompatible combination detected: bois = %, coeur = %',NEW.bois, NEW.coeur;

      return NULL;
    end if;
    return NEW;
  END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER trigger_incompatible 
before INSERT or UPDATE
ON baguette
for each ROW
EXECUTE PROCEDURE check_compatibility();


