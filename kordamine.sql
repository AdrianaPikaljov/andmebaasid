
create database triger2tablid
use triger2tablid
 
 
--tabel toode ja toodekategooria on seotud oma vahel
create table toodekategooria(
toodekategooriaId int not null primary key identity (1,1),
toodekategooria varchar(100) unique,
kirjeldus text);
 
create table toode(
toodeId int not null primary key identity (1,1),
toodenimetus varchar(100) unique,
hind decimal(5,2),
toodekategooriaId int,
foreign key (toodekategooriaId) references toodekategooria(toodekategooriaId)
);
 
 
 
insert into toodekategooria (toodekategooria, kirjeldus)
values
('Kodutehnika', 'Kodumasinad ja muud kodutehnika seadmed'),
('Aiandus', 'Taimed, tööriistad ja tarvikud aiatöödeks'),
('Jalatsid', 'Kingad, saapad ja muud jalanõud kõikidele hooaegadele'),
('Lemmikloomad', 'Tooted ja tarvikud lemmikloomadele'),
('Raamatud', 'Erinevad raamatud, ajakirjad ja õpikud');

 
 
insert into toode (toodenimetus, hind, toodekategooriaId)
values
('Tolmuimeja', 229.90, 1),
('Kontoritool', 139.99, 2),
('Dressipluus', 34.95, 3),
('Pasta', 2.49, 4),
('Matt', 24.90, 5);
 
select * from toode;
select * from toodekategooria;

--Päringud
--1 
select t.toodenimetus, t.hind, k.toodekategooria
from toode t
inner join toodekategooria k on t.toodekategooriaId = k.toodekategooriaId;

--2
select tk.toodekategooria, max(t.hind) as maksimaalne_hind
from toode t 
inner join toodekategooria tk on t.toodekategooriaId = tk.toodekategooriaId
group by tk.toodekategooria;

--3
select tk.toodekategooria, count(t.hind) as toode_kogus
from toode t 
inner join toodekategooria tk on t.toodekategooriaId = tk.toodekategooriaId
group by tk.toodekategooria;

--4
select tk.toodekategooria, cast(avg(t.hind) as decimal(6,2)) as keskmine_hind
from toodekategooria tk
inner join toode t
on t.toodekategooriaId = tk.toodekategooriaId
group by tk.toodekategooria;

--5
select tk.toodekategooria, t.toodenimetus
from toodekategooria tk 
left join toode t on t.toodekategooriaId = tk.toodekategooriaId
where t.toodekategooriaId is null;

--6
select toodenimetus, hind 
from toode
where hind>(select avg(hind) from toode);



--Vaated
 
--1
create view tootedNimedjaHinnad as
select toodenimetus, hind
from toode;
 
select * from tootedNimedjaHinnad
 
--2
create view tootedjaKategooriad as
select t.toodenimetus, t.hind, k.toodekategooria
from toode t
join toodekategooria k on t.toodekategooriaId = k.toodekategooriaId
 
select * from tootedjaKategooriad
 
--3
--tabeli struktuuri muutmine 
alter table toode
add aktiivne BIT
 
 
Update toode set aktiivne = 1
 
Update toode set aktiivne = 0 
where toodeId=2;
 
 
create view Aktiivsed as
select *
from toode 
where aktiivne = 1
 
 
select * from Aktiivsed
 
 
select * from toode;
select * from toodekategooria;
 
--4
create view KategooriaStatistika as
select
   k.toodekategooria,
   count(t.toodeId) as 'toodete_arv',
   cast(min(t.hind) as decimal(5, 1)) as 'minimaalne_hind',
   cast(max(t.hind) as decimal(5, 1)) as 'maksimaalne_hind'
from toodekategooria k
inner join toode t on t.toodekategooriaId = k.toodekategooriaId
group by k.toodekategooria;
 
select * from KategooriaStatistika
 
 
--5
create view ToodeKaibemaksuga as
select
   toodenimetus,
   hind,
   cast((hind * 0.24) as decimal(5,2)) as 'kaibemaks',
   cast((hind * 1.24) as decimal(5,2)) as 'hind_kaibemaksuga'
from toode;
 
select * from ToodeKaibemaksuga
 
 
 
 
 
 
 
--Protseduurid 
--1
create procedure lisaToode
@toodeNimetus varchar(200),
@hind decimal(5,2),
@kategooriaId int,
@aktiivne bit
as
begin
insert into toode(toodenimetus, hind, toodekategooriaId, aktiivne)
values(@toodeNimetus, @hind, @kategooriaId, @aktiivne);
select * from toode
end
 
exec lisaToode 'Ratas', 68.99, 1, 0;
 
drop procedure lisaToode
 
select * from toode;
select * from toodekategooria;
 
--2
create procedure uuendaToodeHind
@toodeId int,
@uusHind decimal(5,2)
as
begin
update toode
set hind = @uusHind
where toodeId = @toodeId 
select * from toode
end;
 
exec uuendaToodeHind 3, 5.30
 
select * from toode;
select * from toodekategooria;
 
--3
create procedure toodeKustuta
@toodeId int
as
begin
delete from toode
where toodeId = @toodeId
select * from toode
end;
 
exec toodeKustuta 7
 
select * from toode;
select * from toodekategooria;
 
--4
create procedure leiatootedkategooriajargi
   @kategooria varchar(30)
as
begin
   select
       toodekategooria,
       toodenimetus,
       hind
   from toode t
   inner join toodekategooria tk on t.toodekategooriaid =tk.


toodekategooriaid
   where tk.toodekategooria = @kategooria
end;
 
exec leiatootedkategooriajargi 'Kodutehnika'
 
 
select * from toode;
select * from toodekategooria;
--5
create procedure Protsenti
@kategooriaId int
as
begin
select * from toode;
update toode
set hind = hind * 1.15
where toodekategooriaId = @kategooriaId
select * from toode;
end;
exec Protsenti 5
select * from toode;
select * from toodekategooria;
drop  procedure Protsenti
 
 
--6
create procedure KallimHind
as
begin
select top 1 *
from toode
order by hind desc
end
 
exec KallimHind

 
 
insert into toode (toodenimetus, toodekategooriaId, hind) values ('Honda', 11, 2);
insert into toode (toodenimetus, toodekategooriaId, hind) values ('Toyota', 6, 1);
insert into toode (toodenimetus, toodekategooriaId, hind) values ('Honda', 16, 1);
insert into toode (toodenimetus, toodekategooriaId, hind) values ('Chevrolet', 8, 2);
insert into toode (toodenimetus, toodekategooriaId, hind) values ('Mazda', 15, 5);
insert into toode (toodenimetus, toodekategooriaId, hind) values ('Lincoln', 4, 5);
insert into toode (toodenimetus, toodekategooriaId, hind) values ('Mitsubishi', 3, 4);
insert into toode (toodenimetus, toodekategooriaId, hind) values ('Aston Martin', 3, 6);
insert into toode (toodenimetus, toodekategooriaId, hind) values ('Nissan', 18, 3);
insert into toode (toodenimetus, toodekategooriaId, hind) values ('Nissan', 20, 5);
insert into toode (toodenimetus, toodekategooriaId, hind) values ('Lincoln', 19, 1);
insert into toode (toodenimetus, toodekategooriaId, hind) values ('Mazda', 16, 1);
insert into toode (toodenimetus, toodekategooriaId, hind) values ('Chevrolet', 11, 5);
insert into toode (toodenimetus, toodekategooriaId, hind) values ('Saab', 3, 2);
insert into toode (toodenimetus, toodekategooriaId, hind) values ('Audi', 18, 1);
insert into toode (toodenimetus, toodekategooriaId, hind) values ('Mercury', 4, 4);
insert into toode (toodenimetus, toodekategooriaId, hind) values ('Mercedes-Benz', 2, 5);
insert into toode (toodenimetus, toodekategooriaId, hind) values ('Nissan', 11, 4);
insert into toode (toodenimetus, toodekategooriaId, hind) values ('Subaru', 19, 1);
insert into toode (toodenimetus, toodekategooriaId, hind) values ('Isuzu', 18, 6);
insert into toode (toodenimetus, toodekategooriaId, hind) values ('Hummer', 1, 4);
insert into toode (toodenimetus, toodekategooriaId, hind) values ('Infiniti', 11, 3);
insert into toode (toodenimetus, toodekategooriaId, hind) values ('Mitsubishi', 10, 1);
insert into toode (toodenimetus, toodekategooriaId, hind) values ('Volvo', 11, 6);
insert into toode (toodenimetus, toodekategooriaId, hind) values ('Chevrolet', 14, 6);
insert into toode (toodenimetus, toodekategooriaId, hind) values ('Suzuki', 17, 5);
insert into toode (toodenimetus, toodekategooriaId, hind) values ('Hyundai', 10, 1);
insert into toode (toodenimetus, toodekategooriaId, hind) values ('Mitsubishi', 18, 6);
insert into toode (toodenimetus, toodekategooriaId, hind) values ('Mazda', 11, 3);
insert into toode (toodenimetus, toodekategooriaId, hind) values ('Cadillac', 3, 1);

 
--Lisa uus toode
 
begin transaction;
 
begin try
   insert into toode (toodenimetus, hind, toodekategooriaId)
   values ('pall', 7.50, 6);
end try
begin catch
   print 'Tekkis viga. Toode pole lisatud';
end catch;
 
select * from toode;
 
 
 
 
--Uuenda toote hinda
 
begin transaction;
 
begin try
   update toode
   set hind = hind + 7
   where toodenimetus = 'pall';
end try
begin catch
   print 'viga, hind pole uuendatud';
end catch;
 

select * from toode;
 
 
 

begin transaction;
 
begin try
   delete from toode
   where toodenimetus = 'Pasta';
end try
begin catch
   print 'viga, kustutamine ebaõnnestus';
end catch;
 

select * from toode;
 
