CREATE OR REPLACE FUNCTION  validate_answer()

RETURNS TRIGGER AS 
$$	
	DECLARE 	
		average_eval float ;
		count_evals int;
		idquest int;
	BEGIN 
		select avg(note) into average_eval from evaluation where idR = NEW.idR ;
		select count(note) into count_evals from evaluation where idR = NEW.idR ;
		select idQ into idquest from evaluation join reponse on (evaluation.idR = reponse.idR );
		IF average_eval >= 4 AND count_evals >=10 :
			UPDATE question SET resolue = TRUE WHERE idQ = idquest ;
		END IF;
	END;		
$$
LANGUAGE plpgsql;



CREATE TRIGGER trigger_validate_answer 
AFTER INSERT OR UPDATE ON EVALUATION 
FOR EACH ROW 
WHEN (NEW.note >= 4)
execute FUNCTION validate_answer();
