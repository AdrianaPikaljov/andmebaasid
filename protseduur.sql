--SQL  salvestatud protseduur - funktsioon, mis kaivitab serveris mitu SQL tegevust jarjest.

kasutame SQL server

create database protseduurPikaljov;
use protseduurPikaljov;
create table linn(
linnId int primary key identity(1,1),
linnanimi varchar(30),
rahvaarv int);
select * from linn;
insert into linn (linnanimi, rahvaarv)
values  ('paide', 8888888), ('pärnu', 7777777), ('narva', 666666), ('tartu', 555555)

create procedure lisaLinn
@linnanimi varchar(30),
@rahvaarv int
as
begin

insert into linn (linnanimi, rahvaarv)
values  (@linnanimi, @rahvaarv);
select * from linn;

end;
-- protseduuri kutse 
--kerulisem  variant
exec lisaLinn @linnanimi='põlva', @rahvaarv=44444
--lihtsam variant 
exec lisaLinn 'maardu', 33333

--kirje kustutamine 
delete from linn where  linnId=3;

--protseduur mis kustutab linn id järgi
create procedure kustutalinn
@deleteId int 
as
begin
select * from linn;
delete from linn where  linnId=@deleteId;
select * from linn;
end;

--kutse 
exec kustutalinn 5;
--proceduri kustutamine 
drop procedure kustutalinn;

--protseduur, mis otsib linn esimene tahe jargi 
create procedure linnaotsing
@taht char(1)
as
begin 
select * from linn
where linnanimi like @taht + '%';
-- % - koik teised tahed 
end;
--kutse 
exec linnaotsing t;

--ulesanne 
CREATE TABLE opilane(
opilaneId int primary key identity (1,1),
eesnimi varchar(25) not null,
perekonnanimi varchar(25) not null,
synniaeg date,
stip bool,
aadress text,
keskmine_hinne decimal(2,1)
);
select * from opilane;
insert into opilane(eesnimi, perekonnanimi, synniaeg, stip, keskmine_hinne)
VALUES(
'Adriana',
'Pikaljov',
'2007-07-26',
1,
4.5),
('Adri',
'sss',
'2005-06-11',
1,
2.2),
('sdri',
'bbb',
'2004-06-24',
1,
3.3),
('ddri',
'lll',
'2009-04-23',
1,
5.2),
('bdri',
'ooo',
'2000-06-13',
1,
2.7)
--protseduur mis lisab opilasi
create procedure lisaopilaseandmed
@eesnimi varchar(25),
@perekonnanimi varchar(25),
@synniaeg date
as
begin

insert into opilane(eesnimi, perekonnanimi, synniaeg)
values  (@eesnimi, @perekonnanimi,@synniaeg);
select * from opilane

end;
-- protseduuri kutse 

exec lisaopilaseandmed 'nikita', 'üüü', '2002-08-09'
--protseduur mis kustutab opilasi id järgi
create procedure opilastekustutamine
@deleteId int 
as
begin
select * from opilane;
delete from opilane where opilaneId=@deleteId;
select * from opilane;
end;

exec opilastekustutamine 3;
--protseduur, mis otsib opilasi esimese tahe jargi 
create procedure opilastenimeotsing
@taht char(1)
as
begin 
select * from opilane
where eesnimi like @taht + '%';
-- % - koik teised tahed 
end;
--kutse 
exec opilastenimeotsing d;

create procedure stipvuuendus 
@opilaneId int, 
@koef decimal(2,1)
as
begin
select * from opilane;
update opilane set stip=stip*@koef
WHERE opilaneId=@opilaneId;
select * from opilane;
end;
--kutse
exec stipvuuendus 1, 1.2;



drop procedure stipvuuendus;
--protseduur mis uuendab keskhinned
create procedure khinneuuendus
@opilaneId int, 
@koef decimal(2,1)
as
begin
select * from khinneuuendus;
update opilane set keskmine_hinne=keskmine_hinne*@koef
WHERE opilaneId=@opilaneId;
select * from opilane;
end;
--kutse
exec khinneuuendus 1, 1.2;
--protseduuri kustutamine
drop procedure khinneuuendus;
--keskmise hinne uuendamine

--protseduur mis uuendab keskhinned
create procedure khinneuuendus
@opilaneId int, 
@koef decimal(2,1)
as
begin
select * from khinneuuendus;
update opilane set keskmine_hinne=keskmine_hinne*@koef
WHERE opilaneId=@opilaneId;
select * from opilane;
end;
--kutse
exec khinneuuendus 2, 1.2;

--tabeli uuendamine - rahvaarv kasvab 10% võrra
update opilane set keskmine_hinne=keskmine_hinne*1.1
select * from opilane;
update opilane set keskmine_hinne=keskmine_hinne*1.1
WHERE opilaneId=2;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
kasutame XAMPP/ localhost
create table linn(
linnId int primary key AUTO_INCREMENT,
linnanimi varchar(30),
rahvaarv int);
insert into linn (linnanimi, rahvaarv)
values  ('paide', 8888888), ('pärnu', 7777777);




--07.02 keerilisemad protseduurid
create database protseduurPikaljov
create table linn(
linnId int primary key identity(1,1),
linnanimi varchar(30),
rahvaarv int);
select * from linn;
insert into linn (linnanimi, rahvaarv)
values  ('paide', 8888888), ('pärnu', 7777777), ('narva', 666666), ('tartu', 555555)

create procedure lisaLinn
@linnanimi varchar(30),
@rahvaarv int
as
begin

insert into linn (linnanimi, rahvaarv)
values  (@linnanimi, @rahvaarv);
select * from linn;

end;
-- protseduuri kutse 
exec lisaLinn 'maardu', 33333

--protseduur mis kustutab linn id järgi
create procedure kustutalinn
@deleteId int 
as
begin
select * from linn;
delete from linn where  linnId=@deleteId;
select * from linn;
end;

--kutse 
exec kustutalinn 5;

create procedure linnaotsing
@taht char(1)
as
begin 
select * from linn
where linnanimi like @taht + '%';
-- % - koik teised tahed 
end;
--kutse 
exec linnaotsing t;

-- uue veergu lisamine
alter table linn add test int;
select * from linn
--veergu kustutamine 
alter table linn drop column test;
create procedure veerulisakustuta
@valik varchar(20),
@veergunimi varchar(20),
@tyyp varchar(20)=null
as
begin
declare @sqltegevus as varchar(max)
set @sqltegevus=case
when @valik ='add' then CONCAT('alter table linn add  ', @veergunimi, ' ', @tyyp)
when @valik ='drop' then  CONCAT('alter table linn drop column  ',  @veergunimi)

end;
print @sqltegevus
begin 
exec (@sqltegevus);
end;
end;
--kutse
exec veerulisakustuta @valik='add', @veergunimi='test2', @tyyp='int'
select * from linn
exec veerulisakustuta @valik='drop', @veergunimi='test2'

create procedure veerulisakustutatabelis
@valik varchar(20),
@tabelinimi varchar(20),
@veergunimi varchar(20),
@tyyp varchar(20)=null

as
begin
declare @sqltegevus as varchar(max)
set @sqltegevus=case
when @valik ='add' then CONCAT('alter table ', @tabelinimi, ' add ', @veergunimi, ' ', @tyyp)
when @valik ='drop' then  CONCAT('alter table ', @tabelinimi, ' drop column ', @veergunimi)

end;
print @sqltegevus
begin 
exec (@sqltegevus);
end;
end;
exec veerulisakustutatabelis @valik='add', @tabelinimi= 'linn',  @veergunimi='test4', @tyyp='int'
select * from linn
exec veerulisakustutatabelis @valik='drop', @tabelinimi= 'linn', @veergunimi='test4'


--protseduur tingimustega 
create procedure rahvahinnang 
@piir int
as
begin
select linnanimi, rahvaarv, iif(rahvaarv<@piir, 'vaike linn', 'suur linn') as hinnang
from linn;


end;

drop procedure rahvahinnang;

exec rahvahinnang 666677;

--agregaat funktsioonid: SUM(), AVG(), MIN(), MAX(), COUNT() 

create procedure kokkurahvaarv

as 
begin
select sum(rahvaarv) as 'kokku rahvaarv', avg(rahvaarv) as 'keskmine rahvaarv', min(rahvaarv) as 'minimaalne rahvaarv', count (*) as 'linnade arv'
from linn;
end;

drop procedure kokkurahvaarv;
exec kokkurahvaarv;

create table sport(
idInimene int primary key identity(1,1), 
spordinimi varchar(25),
hind int,
treener varchar(25));
select * from sport;
insert into sport (spordinimi, hind, treener)
values ('jalgpall', 5, 'oleg'), ('võrkpall', 30, 'nikita'), ('korvpall', 15, 'aleksandr'), ('käsipall', 50, 'anastasia')

--sisestatud hinnast odavama osa otsimise kord
create procedure odavamsport

as
begin
select min(hind) as 'odavam sport'
from sport;
end;
exec odavamsport
drop procedure odavamsport;
drop table sport; 
--protseduur uute andmete lisamiseks tabelisse
create procedure andmetelisamine
@spordinimi varchar(25),
@treener varchar(25),
@hind int
as
begin

insert into sport(spordinimi, treener, hind)
values  (@spordinimi, @treener,@hind);
select * from sport

end;
exec andmetelisamine 'hokki', 'adri', 6
--kõigi inimeste kokkuarvamise kord

create procedure inimestearv

as 
begin
select count (*) as 'inimeste arv'
from sport;
end;

exec inimestearv;

---------------------------------------------------------------------
XAMPP
create table sport(
idInimene int primary key AUTO_INCREMENT, 
spordinimi varchar(25),
hind int,
treener varchar(25));
insert into sport (spordinimi, hind, treener)
values ('jalgpall', 5, 'oleg'), ('võrkpall', 30, 'nikita'), ('korvpall', 15, 'aleksandr'), ('käsipall', 50, 'anastasia');

