DROP TRIGGER IF EXISTS required_class ON suit;
CREATE OR REPLACE FUNCTION required_class()
RETURNS TRIGGER AS
$$
    DECLARE
        c requiert%ROWTYPE;
        student  eleve%ROWTYPE;
        class cours%ROWTYPE;
        required_class cours%ROWTYPE;
        check_exist suit%ROWTYPE;
    BEGIN
        SELECT * INTO student FROM eleve WHERE numEl = NEW.numEl;
        SELECT * INTO class FROM cours WHERE codeCours = NEW.codeCours;
        FOR c IN SELECT * FROM requiert WHERE codeCours = NEW.codeCours
        LOOP
            SELECT * INTO required_class FROM cours WHERE codeCours = c.codeCoursRequis;
            PERFORM * FROM suit WHERE numEl = NEW.numEl AND codeCours = c.codeCoursRequis;
            IF NOT FOUND THEN
                RAISE NOTICE 'the student % % has been automatically to the required class %  to take the class %', student.nom, student.prenom, required_class.intitule, class.intitule;
                INSERT INTO suit VALUES (NEW.numEl,c.codeCoursRequis,NULL);
            END IF;
        END LOOP;
        RETURN NEW;
    END;
$$
LANGUAGE plpgsql;
    



CREATE TRIGGER required_class
AFTER INSERT
ON suit
FOR EACH ROW
EXECUTE PROCEDURE required_class();
