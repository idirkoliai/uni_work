DROP TABLE IF EXISTS test CASCADE;
DROP TRIGGER IF EXISTS before_insert_test ON test;
-- Assurez-vous que la table existe
CREATE TABLE IF NOT EXISTS test (
    id SERIAL PRIMARY KEY,
    a INT,
    b INT
);

-- Création de la fonction du trigger
CREATE OR REPLACE FUNCTION check_insert_trigger()
RETURNS TRIGGER AS $$
BEGIN
		 -- 3. Annuler l'insertion avec une exception lorsque a = b
    IF NEW.a = NEW.b THEN
        RAISE EXCEPTION 'Insertion impossible : a (%) est égal à b (%).', NEW.a,
    NEW.b;
    END IF;
    -- 1. RAISE NOTICE lorsque a est pair
    IF NEW.a % 2 = 0 THEN
        RAISE NOTICE 'La valeur de a (%) est paire.', NEW.a;
    END IF;

    -- 2. Annuler l'insertion lorsque b est pair
    IF NEW.b % 2 = 0 THEN
        RAISE NOTICE 'Insertion annulée : b (%) est pair.', NEW.b;
        RETURN NULL;  -- Annule l'insertion
    END IF;

    

    RETURN NEW; -- Permet l'insertion si aucune condition précédente ne l'annule
END;
$$ LANGUAGE plpgsql;

-- Création du trigger
CREATE TRIGGER before_insert_test
BEFORE INSERT ON test
FOR EACH ROW
EXECUTE FUNCTION check_insert_trigger();
