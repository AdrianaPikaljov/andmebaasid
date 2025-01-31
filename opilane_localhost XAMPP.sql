CREATE TABLE opilane(
opilaneId int primary key AUTO_INCREMENT,
eesnimi varchar(25) not null,
perekonnanimi varchar(25) not null,
synniaeg date,
stip bit,
aadress text,
keskmine_hinne decimal(2,1)
);
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

CREATE TABLE language
(
ID int NOT NULL PRIMARY KEY AUTO_INCREMENT,
Code char(3) NOT NULL,
Language varchar(50) NOT NULL,
IsOfficial bit,
Percentage smallint
);

insert into language(Code, Language)
values ('ger','saksa'), ('rus','vene'), ('eng','inglise'), ('est', 'eesti')
  
create table keelevalik(
keelevalikID int primary key AUTO_INCREMENT),
valikunimetus varchar(10) not null,
opilaneId int, 
foreign key (opilaneId) references opilane(opilaneId),
language int,
foreign key (language) references language(ID)
)
insert into keelevalik(valikunimetus, opilaneId, language)
VALUES ('valik A', 1, 1), ('valik B', 2, 3), ('valik C', 2, 4)



create table category (
idCategory int primary key AUTO_INCREMENT, 
CategoryName varchar(25) unique
)
insert into category (CategoryName)
values ('jook'), ('sook')
alter table category add test int;
alter table category drop column test;

create table Product (
idProduct int primary key AUTO_INCREMENT,
ProductName varchar(25) unique,
idCategory int,
foreign key (idCategory) references category(idCategory),
Price int not null);
insert into Product(ProductName, idCategory,  Price)
values ('coca-cola', 1, 2), ('milka', 2, 6);

create table Sale (
idSale int primary key AUTO_INCREMENT,
idProduct int,
idCustomer int,
Count_ int,
DateOfSale date,
foreign key (idProduct) references Product(idProduct));

create table Customer (
idCustomer int primary key AUTO_INCREMENT, 
name varchar(25),
contact text);

alter table Sale add foreign key (idCustomer) references Customer(idCustomer)

insert into Customer(name, contact)
values ('adri', '555555555'), ('adri2', '66666666'), ('adri3', '77777777'),('adri6', '88888888'), ('adri', '999999999')
insert into Sale(idCustomer,Count_,DateOfSale)
values (3, 5, '2025-07-07'),(4, 3, '2023-06-06'), (2, 4, '2000-02-06'),(5, 2, '2022-08-06'), (2, 2, '2025-07-07');
