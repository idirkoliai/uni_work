DROP TABLE IF EXISTS projet CASCADE;
DROP TABLE IF EXISTS soutient CASCADE;

CREATE TABLE projet(
	pid serial primary key,
	titre varchar(50),
	statut varchar(15),
	requis int
);

CREATE TABLE soutient(
	uid int,
	pid int references projet(pid),
	montant int,
	primary key(uid, pid)
);

INSERT INTO projet VALUES
	(1,'Hoverboard','attente',50000),
	(2,'Full body VR','attente',10000),
	(3,'Perpetual motion','attente',500);

INSERT INTO soutient VALUES
	(2,2,6000);
