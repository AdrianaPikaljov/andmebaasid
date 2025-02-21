create database autod 
use autod
create table autod (
	mark VARCHAR(50),
	regnub VARCHAR(50) primary key,
	aasta VARCHAR(50),
	regpiirk INT
);
insert into autod (mark, regnub, aasta, regpiirk) values ('Plymouth', '#04ae41', 1996, 1);
insert into autod (mark, regnub, aasta, regpiirk) values ('Volkswagen', '#d49157', 1986, 2);
insert into autod (mark, regnub, aasta, regpiirk) values ('Chevrolet', '#7b4197', 2007, 3);
insert into autod (mark, regnub, aasta, regpiirk) values ('Chevrolet', '#c36c5c', 2001, 4);
insert into autod (mark, regnub, aasta, regpiirk) values ('Subaru', '#0a1efb', 2011, 5);
insert into autod (mark, regnub, aasta, regpiirk) values ('Subaru', '#b89aea', 2007, 6);
insert into autod (mark, regnub, aasta, regpiirk) values ('Hyundai', '#5a815b', 2004, 7);
insert into autod (mark, regnub, aasta, regpiirk) values ('Mazda', '#d74dbe', 2000, 8);
insert into autod (mark, regnub, aasta, regpiirk) values ('Mitsubishi', '#684f3f', 2011, 9);
insert into autod (mark, regnub, aasta, regpiirk) values ('Aston Martin', '#0d4920', 2011, 10);
insert into autod (mark, regnub, aasta, regpiirk) values ('Mazda', '#ee4abb', 1989, 11);
insert into autod (mark, regnub, aasta, regpiirk) values ('Maserati', '#872fce', 2005, 12);
insert into autod (mark, regnub, aasta, regpiirk) values ('Toyota', '#b3e310', 2003, 13);
insert into autod (mark, regnub, aasta, regpiirk) values ('Volkswagen', '#43632d', 2000, 14);
insert into autod (mark, regnub, aasta, regpiirk) values ('Mercury', '#576853', 2005, 15);
insert into autod (mark, regnub, aasta, regpiirk) values ('Mazda', '#f523fc', 2000, 16);
insert into autod (mark, regnub, aasta, regpiirk) values ('Ford', '#a346b5', 2008, 17);
insert into autod (mark, regnub, aasta, regpiirk) values ('Lexus', '#0f0d82', 2007, 18);
insert into autod (mark, regnub, aasta, regpiirk) values ('BMW', '#a51800', 1994, 19);
insert into autod (mark, regnub, aasta, regpiirk) values ('Toyota', '#dc2d30', 2006, 20);
select * from autod

select aasta , mark 
from autod
order by aasta DESC;

select distinct mark
from autod

select mark, regnub, aasta
from autod
where aasta<1993

select mark, regnub, aasta
from autod
where aasta<1993
order by regnub

select min(aasta) as ' varasem väljalaskeaasta'
from autod 

update autod
set regnub = '333 KKK'
where regpiirk = 3
select mark, regnub, regpiirk
from autod
where regnub like '%KKK'

delete from autod
where regpiirk = 4
select * 
from autod
order by regpiirk

insert into autod (mark, regnub, aasta, regpiirk)
values ('Nissan','555 NNN', 2007,2)
select *
from autod
where regnub like '%NNN'

select mark 
from autod
where mark like '%K%'

select count(*) as 'autodearv'
from autod;

select *
from autod
where regnub like '3%'
