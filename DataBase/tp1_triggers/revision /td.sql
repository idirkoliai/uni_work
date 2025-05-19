DROP TABLE IF EXISTS users CASCADE;
DROP TABLE IF EXISTS project CASCADE;
DROP TABLE IF EXISTS contributions CASCADE;
drop trigger if exists titlechange on project;
drop trigger if exists deleteproject on project;
drop trigger if exists autocontribute on contributions;
CREATE TABLE users
(
    uid serial primary key,
    name varchar(20),
    surname varchar (20),
    email varchar(100) UNIQUE
);

CREATE TABLE project 
(
    pid serial primary key,
    title varchar (100),
    author int references users(uid),
    status varchar(20),
    required numeric(4,2) NOT NULL,
    dateLimit date 
);

CREATE TABLE contributions 
(
    uid int references users(uid),
    pid int references project(pid),
    amount numeric(4,2),
    primary key (uid,pid)
);

create trigger titlechange 
before update 
on project
for each Row
when (old.title <> new.title)
execute procedure cancelTitleChange();

create trigger deleteproject
before DELETE 
on project
for each row
when (old.status = 'in progress')
execute procedure cancelprojectdelete();

create trigger autocontribute
before insert 
on contributions
for each row
when (new.amount is NULL)
execute procedure defaultamount();

