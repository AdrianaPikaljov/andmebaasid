create database kordamine
use kordamine
 
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


insert into toodekategooria(toodekategooria)
values ('meelelahutus'), ('joogid'), ('köögiviljad'), ('liha'), ('maiustused')

insert into toode (toodenimetus, hind)
values ('pall', 5.50), ('coca-cola', 2.30, 2), ('tomatid', 1.25, 3), ('lambaliha', 6.7, 4), ('kit-kat',2.40,5)

select * from toodekategooria
select * from toode
--1 Koosta päring, mis kuvab kõik tooted koos nende kategooriate nimedega.
select t.toodenimetus, t.hind, k.toodekategooria
from toode t
join toodekategooria k on t.toodekategooriaId = k.toodekategooriaID;
select * from toodekategooria

--2 Leia kõige kallim toode igast kategooriast.
select tk.toodekategooria, max(t.hind) as maksimaalne_hind
from toode t 
inner join toodekategooria tk on t.toodekategooriaId = tk.toodekategooriaId
group by tk.toodekategooria

--3 Kuvada kõik kategooriad ja nende toodete arv.

select tk.toodekategooria, count(t.hind) as toode_kogus
from toode t 
inner join toodekategooria tk on t.toodekategooriaId = tk.toodekategooriaId
group by tk.toodekategooria;

--4 Leia toodete keskmine hind kategooria kaupa.
select tk.toodekategooria, cast(avg (t.hind) as decimal(3,2)) as kesk_hind
from toodekategooria tk
inner join toode t
on t.toodekategooriaId=tk.toodekategooriaId
group by tk.toodekategooria

--5 Kuvada ainult need kategooriad, kus pole ühtegi toodet.
select tk.toodekategooria, t.toodenimetus
from toodekategooria tk
left join toode t on t.toodekategooriaId=tk.toodekategooriaId
where t.toodekategooriaId is null


--6 Leia kõik tooted, mille hind on suurem kui tabeli keskmine hind.
select toodenimetus, hind 
from toode
where hind > (select avg(hind) from toode);
