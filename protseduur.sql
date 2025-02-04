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
