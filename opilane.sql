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
