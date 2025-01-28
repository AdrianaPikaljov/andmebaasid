--AB loomine
create database PikaljovBaas;

use PikaljovBaas;
CREATE TABLE opilane(
opilaneId int primary key identity (1,1),
eesnimi varchar(25) not null,
perekonnanimi varchar(25) not null,
synniaeg date,
stip bit,
aadress text,
keskmine_hinne decimal(2,1)
)
select * from opilane;
--andmete lisamine tabelisse
insert into opilane(eesnimi, perekonnanimi, synniaeg, stip, keskmine_hinne)
VALUES(
'Adriana',
'Pikaljov',
'2007-07-26',
1,
4.5),
('Adri',
'lol',
'2005-06-13',
1,
2.2)

--tabeli kustutamine: 
drop tabel opilane;
--rida kustutamine, kus on opilaneId=2
delete from opilane where opilaneId=1;
select * from opilane;

--andmete uuendamine
update opilane SET aadress='Tartu'
where opilaneId=3

CREATE TABLE language
(
ID int NOT NULL PRIMARY KEY,
Code char(3) NOT NULL,
Language varchar(50) NOT NULL,
IsOfficial bit,
Percentage smallint
);
select * from language

insert into language(ID, Code, Language)
values (2, 'ger','saksa'), (3, 'rus','vene'), (4, 'eng','inglise')

create table keelevalik(
keelevalikID int primary key identity(2,1),
valikunimetus varchar(10) not null,
opilaneId int, 
foreign key (opilaneId) references opilane(opilaneId),
language int,
foreign key (language) references language(ID)
)
select * from keelevalik;
select * from language;
select * from opilane;

insert into keelevalik(valikunimetus, opilaneId, language)
VALUES ('valik C', 3, 2)

select *
from opilane, language, keelevalik
where opilane.opilaneId=keelevalik.opilaneId
and language.ID=keelevalik.language



CREATE TABLE oppiminee(
opilaneId int primary key identity (1,1),
aine text not null,
opetaja varchar(25) not null,
aasta char(4),
hinne int,
foreign key (opilaneId) references opilane(opilaneId));

insert into oppiminee(aine, opetaja, aasta, hinne)
VALUES ('andmebaasid', 'merkulova', 2025, 5)
select * from oppimine
