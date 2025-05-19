create table historiquePrix 
(
    log_id serial primary key,
    date date,
    numbag int references baguette(numbag),
    ancienPrix numeric(4,2),
    nouveauPrix numeric(4,2)
);


drop trigger if EXISTS pricelog on baguette;

create or replace FUNCTION updatelogs()
RETURNS trigger as
$$
    DECLARE
        cheapwood baguette%rowtype;
        cheapwood2 baguette%rowtype;
        cheapheart baguette%rowtype;
        cheapheart2 baguette%rowtype;
    BEGIN

    select * into cheapwood from baguette where bois = NEW.bois order by prix asc limit 1;
    select * into cheapheart from baguette where coeur = NEW.coeur order by prix asc limit 1;
    select * into cheapwood2 from baguette where bois = OLD.bois order by prix asc offset 1 limit 1;
    select * into cheapheart2 from baguette where coeur = OLD.coeur order by prix asc offset 1 limit 1;

    IF cheapwood.numbag IS NOT NULL THEN
        IF cheapwood.numbag = NEW.numbag THEN
            -- NEW est déjà le moins cher → vérifier s’il reste moins cher
            IF cheapwood2.numbag IS NOT NULL AND NEW.prix < cheapwood2.prix THEN
                RAISE NOTICE 'La baguette % (bois %) est toujours la moins chère à % euros', NEW.numbag, NEW.bois, NEW.prix;
            END IF;
        ELSE
            -- Vérifier si NEW devient moins cher que l’ancien premier
            IF NEW.prix < cheapwood.prix THEN
                RAISE NOTICE 'La baguette % (bois %) devient la moins chère à % euros', NEW.numbag, NEW.bois, NEW.prix;
            END IF;
        END IF;
    END IF;


    IF cheapheart.numbag IS NOT NULL THEN
        IF cheapheart.numbag = NEW.numbag THEN
            -- NEW est déjà le moins cher → vérifier s’il reste moins cher
            IF cheapheart2.numbag IS NOT NULL AND NEW.prix < cheapheart2.prix THEN
                RAISE NOTICE 'La baguette % (coeur %) est toujours la moins chère à % euros', NEW.numbag, NEW.coeur, NEW.prix;
            END IF;
        ELSE
            -- Vérifier si NEW devient moins cher que l’ancien premier
            IF NEW.prix < cheapheart.prix THEN
                RAISE NOTICE 'La baguette % (coeur %) devient la moins chère à % euros', NEW.numbag, NEW.coeur, NEW.prix;
            END IF;
        END IF;
    END IF;
    
    RETURN NEW;

    end ;
$$
LANGUAGE plpgsql;


create trigger pricelog
before update 
on baguette 
for each row
when (NEW.prix <> OLD.prix)
EXECUTE PROCEDURE updatelogs()