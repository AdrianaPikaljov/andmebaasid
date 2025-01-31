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



  

create database epoodPikaljov
use epoodPikaljov;

create table category (
idCategory int primary key identity (1, 1), 
CategoryName varchar(25) unique
)
select * from category
insert into category (CategoryName)
values ('jook'), ('sook')

--table struktuuri muutmine --> uue veergu lisamine 
alter table category add test int;
--table struktuuri muutmine --> uue veergu kustutamine
select * from category
alter table category drop column test;
select * from category

create table Product (
idProduct int primary key identity (1, 1),
ProductName varchar(25) unique,
idCategory int,
Price int
foreign key (idCategory) references category(idCategory));
select * from Product
insert into Product(ProductName, idCategory,  Price)
values ('coca-cola', 1, 2), ('milka', 2, 6)

Drop table Product;
create table Product (
idProduct int primary key identity (1, 1),
ProductName varchar(25) unique,
idCategory int,
Price decimal (5,2),
foreign key (idCategory) references category(idCategory));
Drop table Product;
Drop table Product;
create table Product (
idProduct int primary key identity (1, 1),
ProductName varchar(25) unique,
idCategory int,
Price decimal (5,2),
foreign key (idCategory) references category(idCategory));
select * from Product
insert into Product(ProductName, idCategory,  Price)
values ('apple', 1, 2), ('milka', 2, 6)

create table Sale (
idSale int primary key identity (1, 1),
idProduct int,
idCustomer int,
Count_ int,
DateOfSale date,
foreign key (idProduct) references Product(idProduct));

select * from Sale
--kustutab koik kirjed 
delete from Sale;

create table Customer (
idCustomer int primary key identity (1, 1), 
name varchar(25),
contact text) 

alter table Sale add foreign key (idCustomer) references Customer(idCustomer)

select * from Customer
insert into Customer(name, contact)
values ('adri', '555555555'), ('adri2', '66666666'), ('adri3', '77777777'),('adri6', '88888888'), ('adri', '999999999')
insert into Sale(idCustomer,Count_,DateOfSale)
values (3, 5, '2025-07-07'),(4, 3, '2023-06-06'), (2, 4, '2000-02-06'),(5, 2, '2022-08-06'), (2, 2, '2025-07-07')

select * from Customer;
select * from Sale;
select * from Product;
select * from category;

