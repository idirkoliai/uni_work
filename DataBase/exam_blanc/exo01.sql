drop table if exists evaluation;
drop table if exists reponse;
drop table if exists question;
drop table if exists personne;


CREATE TABLE personne (
    pseudo VARCHAR(50) PRIMARY KEY,
    nom VARCHAR(100),
    prenom VARCHAR(100),
    email VARCHAR(100),
    mdp VARCHAR(100)
);

CREATE TABLE question (
    idQ SERIAL PRIMARY KEY,
    auteurQ VARCHAR(50),
    dateQ DATE,
    theme TEXT,
    description VARCHAR(5000),
    resolue BOOLEAN,
    FOREIGN KEY (auteurQ) REFERENCES personne(pseudo) on delete cascade
);

CREATE TABLE reponse (
    idR SERIAL PRIMARY KEY,
    auteurR VARCHAR(50),
    dateR DATE DEFAULT now(),
    idQ INTEGER,
    message TEXT,
    FOREIGN KEY (auteurR) REFERENCES personne(pseudo) on delete cascade,
    FOREIGN KEY (idQ) REFERENCES question(idQ) on delete cascade
);

CREATE TABLE evaluation (
    pseudo VARCHAR(50),
    idR INTEGER,
    note INTEGER,
    PRIMARY KEY (pseudo, idR),
    FOREIGN KEY (pseudo) REFERENCES personne(pseudo) ON DELETE CASCADE,
    FOREIGN KEY (idR) REFERENCES reponse(idR) ON DELETE CASCADE
);


--exo 01 trigger ou contrainte : 


-- 3

CREATE OR REPLACE FUNCTION delete_question()
RETURNS TRIGGER AS 
$$  
    DECLARE 
        c INT;
    BEGIN
        SELECT COUNT(*) INTO c FROM evaluation WHERE idR = NEW.idR AND note <= 1 ;
        IF c >= 10 THEN
            DELETE FROM reponse where idR = NEW.idR;
        END IF ;
        RETURN NEW;
    END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER reply_quality
AFTER insert or update on evaluation 
for each row
when (NEW.note <= 1)
execute procedure delete_question();

-- 4

CREATE OR REPLACE FUNCTION cancel_op()
RETURNS TRIGGER AS 
$$  
    
    BEGIN
        RETURN NULL; --or raise exception "cannot reopen a question"
    END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER CANCEL_REOPENING
BEFORE update on question 
for each row
when (NEW.resolue = FALSE  and OLD.resolue = TRUE)
execute procedure cancel_op();


-- 5 

CREATE OR REPLACE FUNCTION can_ask()
RETURNS TRIGGER AS 
$$  
    
    BEGIN
        PERFORM * FROM question where auteurQ = NEW.auteurQ ;
        IF FOUND THEN
            RETURN NULL;
        END IF ;
        RETURN NEW;
    END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER check_if_can_ask
BEFORE INSERT on question 
for each row
execute procedure can_ask();


--8

CREATE OR REPLACE FUNCTION notif()
RETURNS TRIGGER AS 
$$  
    
    BEGIN
        raise notice 'new questions were added on %',now();
        RETURN NEW;
    END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER notification
after INSERT on question 
FOR EACH STATEMENT
EXECUTE PROCEDURE notif();


--9 

CREATE OR REPLACE FUNCTION evaluate()
RETURNS TRIGGER AS 
$$  
    
    BEGIN
        PERFORM * FROM question WHERE resolue = FALSE AND idQ = new.idQ;
        IF FOUND THEN
            RETURN NEW;
        END IF;
        RETURN NULL;
    END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER can_evaluate
BEFORE INSERT on reponse 
for each row 
execute procedure evaluate();


--10 

CREATE OR REPLACE FUNCTION cancel_MOFID()
RETURNS TRIGGER AS 
$$  
    
    BEGIN
        RETURN NULL; --or raise exception "cannot MOFIDY ..."
    END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER CANCEL_REOPENING
BEFORE update on evaluation 
for each row
execute procedure cancel_MOFID();

--  7 

CREATE OR REPLACE FUNCTION edit_dq()
RETURNS TRIGGER AS 
$$  
    
    BEGIN
        NEW.description := NEW.description || E'Édité le ' || now();
        RETURN NEW;
    END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER edit
BEFORE update on question 
for each row
when(old.description is distinct from NEW.description)
execute procedure edit_dq();



CREATE OR REPLACE FUNCTION resolved()
RETURNS TRIGGER AS 
$$  
    declare 
        question_id int;
        auteur varchar(50);
        evals int;
        avg float;
    BEGIN
        select idQ,auteurR into question_id,auteur from  reponse where idR = NEW.idR;
        select count(*),avg(note) into evals,avg from evaluation where idR = NEW.idR;
        if evals >=10 and avg >= 4 then 
            update questions set resolue = TRUE where idQ = question ;
            raise notice '% a ete resolue par %',question_id,auteur;
        END if;
        RETURN NEW;
    END;
$$
LANGUAGE plpgsql;


CREATE TRIGGER res
after insert on evaluation 
for each row
execute procedure resolved();

