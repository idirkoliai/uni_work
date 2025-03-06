DROP TRIGGER IF EXISTS HISTORY ON baguette;

CREATE OR REPLACE FUNCTION add_to_history()
RETURNS TRIGGER AS 
$$
DECLARE
    cheapestwood baguette%ROWTYPE;
    secondcheapestwood baguette%ROWTYPE;
    cheapestheart baguette%ROWTYPE;
    secondcheapestheart baguette%ROWTYPE;
BEGIN
    SELECT * INTO cheapestwood 
    FROM baguette 
    WHERE bois = OLD.bois 
    ORDER BY prix ASC 
    LIMIT 1;

    SELECT * INTO secondcheapestwood 
    FROM baguette 
    WHERE bois = OLD.bois 
    ORDER BY prix ASC 
    OFFSET 1 LIMIT 1;

    SELECT * INTO cheapestheart
    FROM baguette 
    WHERE coeur = OLD.coeur 
    ORDER BY prix ASC 
    LIMIT 1;

    SELECT * INTO secondcheapestheart
    FROM baguette 
    WHERE coeur = OLD.coeur 
    ORDER BY prix ASC 
    OFFSET 1 LIMIT 1;

    IF (NEW.prix < cheapestwood.prix OR 
        (OLD.prix = cheapestwood.prix AND secondcheapestwood.prix IS NOT NULL AND NEW.prix < secondcheapestwood.prix)) THEN
        
        RAISE NOTICE 'La baguette % (% cm, coeur de %, bois de %) à % € est la meilleure offre pour le bois %',
                     NEW.numbag, NEW.longueur, NEW.coeur, NEW.bois, NEW.prix, NEW.bois;

    ELSIF OLD.prix = cheapestwood.prix  AND secondcheapestwood.prix IS NOT NULL AND NEW.prix > cheapestwood.prix THEN
        
        RAISE NOTICE 'La baguette % (% cm, coeur de %, bois de %) à % € est la meilleure offre pour le bois %',
                     secondcheapestwood.numbag, secondcheapestwood.longueur, secondcheapestwood.coeur,
                     secondcheapestwood.bois, secondcheapestwood.prix, secondcheapestwood.bois;

    ELSIF NEW.prix = cheapestwood.prix THEN
        
        RAISE NOTICE 'La baguette % (% cm, coeur de %, bois de %) à % € fait partie des meilleures offres pour le bois %',
                     NEW.numbag, NEW.longueur, NEW.coeur, NEW.bois, NEW.prix, NEW.bois;
    END IF;

    IF (NEW.prix < cheapestheart.prix OR 
        (OLD.prix = cheapestheart.prix AND secondcheapestheart.prix IS NOT NULL AND NEW.prix < secondcheapestheart.prix)) THEN
        
        RAISE NOTICE 'La baguette % (% cm, coeur de %, bois de %) à % € est la meilleure offre pour le coeur %',
                     NEW.numbag, NEW.longueur, NEW.coeur, NEW.bois, NEW.prix, NEW.coeur;

    ELSIF OLD.prix = cheapestheart.prix AND secondcheapestheart.prix IS NOT NULL AND NEW.prix > cheapestheart.prix THEN
        
        RAISE NOTICE 'La baguette % (% cm, coeur de %, bois de %) à % € est la meilleure offre pour le coeur %',
                     secondcheapestheart.numbag, secondcheapestheart.longueur, secondcheapestheart.coeur,
                     secondcheapestheart.bois, secondcheapestheart.prix, secondcheapestheart.coeur;

    ELSIF NEW.prix = cheapestheart.prix THEN
        
        RAISE NOTICE 'La baguette % (% cm, coeur de %, bois de %) à % € fait partie des meilleures offres pour le coeur %',
                     NEW.numbag, NEW.longueur, NEW.coeur, NEW.bois, NEW.prix, NEW.coeur;
    END IF;

	insert into historiqueprix(date,numbag,ancienprix,nouveauprix) values (now(),OLD.numbag,OLD.prix,NEW.prix);

    RETURN NEW;
END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER HISTORY
BEFORE UPDATE 
ON baguette
FOR EACH ROW
WHEN (OLD.prix <> NEW.prix)
EXECUTE FUNCTION add_to_history();
