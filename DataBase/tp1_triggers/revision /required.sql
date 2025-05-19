drop trigger if exists required_courses on suit;
create or replace function auto_regeter()
returns trigger as 
$$
    declare
        row requiert%rowtype;
    BEGIN
    for row in SELECT * from requiert where codecours = New.codeCours loop
        insert into suit values(New.numEl,row.codeCoursRequis,NULL);
        raise notice 'inserting %', row.codeCoursRequis;
    end loop;
    return new;
    END;
$$
LANGUAGE plpgsql;

create  trigger required_courses 
after insert
on suit 
for EACH row
EXECUTE PROCEDURE auto_regeter();
    