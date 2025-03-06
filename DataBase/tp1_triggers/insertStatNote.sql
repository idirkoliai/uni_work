DROP TRIGGER IF EXISTS updateStatNote ON StatNotes;

CREATE OR REPLACE FUNCTION updateSN() RETURNS TRIGGER AS 
$$
DECLARE 
    tmp suit%ROWTYPE;
BEGIN
    IF NEW.min IS NULL THEN
        NEW.min = OLD.min;
    END IF;

    IF NEW.max IS NULL THEN
        NEW.max = OLD.max;
    END IF;

    FOR tmp IN
        SELECT *
        FROM suit
        WHERE codeCours = NEW.codeCours
    LOOP
        UPDATE suit
        SET note = NEW.min + ((tmp.note - OLD.min) * (NEW.max - NEW.min)) / (OLD.max - OLD.min)
        WHERE codeCours = tmp.codeCours
        AND numel = tmp.numel;
    END LOOP;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER updateStatNote
INSTEAD OF UPDATE ON StatNotes
FOR EACH ROW EXECUTE PROCEDURE updateSN();
