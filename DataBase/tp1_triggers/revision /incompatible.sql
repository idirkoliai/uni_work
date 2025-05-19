CREATE table incompatible
(
    bois varchar(15) not null , coeur varchar(15) not null,
    primary key (bois,coeur)
);


drop trigger if EXISTS incompatibility on baguette;


create or replace FUNCTION check_compatibility()
RETURNS trigger as 
$$
    DECLARE

    BEGIN

    perform * from incompatible where bois = NEW.bois and coeur = NEW.coeur ; 
    if not found then 
    RETURN NEW;
    end if ;
    RAISE EXCEPTION 'wood % and heart % are incompatible',NEW.bois,NEW.coeur;
    END ;
$$
LANGUAGE plpgsql;


create trigger incompatibility 
before INSERT
on baguette
for EACH row 
execute PROCEDURE check_compatibility() ;
 


-- Inserting some incompatible combinations
INSERT INTO incompatible (bois, coeur) VALUES ('Cèdre', 'Dragon');
-- This should raise an exception
INSERT INTO baguette (bois, coeur, longueur,prix)
VALUES ('Cèdre', 'dragon', 35.0,50.2);
