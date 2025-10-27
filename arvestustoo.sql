create database kool
use kool
--1 - 2
create table opetaja (
    opetajaid int primary key identity (1,1),
    opetajanimi varchar(100) not null unique,
    aine varchar(100) not null
);


create table klass (
    klassid int primary key identity (1,1),
    klassnimi varchar(50) not null unique,
    opetajaid int,
    opilastearv int,
    foreign key (opetajaid) references opetaja(opetajaid)
);

create table opilane (
    opilaneid int primary key identity (1,1),
    opilasenimi varchar(100) not null unique,
    klassid int,
    foreign key (klassid) references klass(klassid)
);
drop table opetaja
--4
create table logi (
    id int identity(1,1) primary key,
    aeg datetime,
    toiming varchar(100),
    andmed varchar(200),
    kasutaja varchar(100)
);

select * from klass;
select * from logi;
select * from opetaja;
select * from opilane;

insert into opetaja (opetajanimi, aine)
values 
('nastja radasheva', 'füüsika'),
('marina oleinik', 'matemaatika'),
('peetri pitsa', 'keemia');

insert into klass (klassnimi, opetajaid, opilastearv)
values
('12b', 1, 18),
('11a', 2, 22),
('10c', 3, 20);

insert into opilane (opilasenimi, klassid)
values
('anna kruus', 1),
('markus leht', 1),
('kristi reim', 1),
('liis saar', 2),
('joonas vaher', 2),
('katrin kask', 2),
('peeter laas', 3),
('mari laan', 3),
('tõnis õis', 3);

grant select, insert on klass to opilanenimi;
grant select, insert on opetaja to opilanenimi;
grant select, insert on opilane to opilanenimi;
--5
create trigger klasskustutamine
on klass
for delete
as 
begin
    insert into logi (aeg, kasutaja, toiming, andmed)
    select 
        getdate(),
        system_user,
        'klass kustutatud',
        concat('klassnimi: ', d.klassnimi, 
               ', õpetajaid: ', d.opetajaid, 
               ', opilaste arv: ', d.opilastearv)
    from deleted d;
end;

--6
create trigger klasslisamine
on klass
for insert
as 
begin
    insert into logi (aeg, kasutaja, toiming, andmed)
    select 
        getdate(),
        system_user,
        'klass lisatud',
        concat('klassnimi: ', i.klassnimi, 
               ', õpetajaid: ', i.opetajaid, 
               ', opilaste arv: ', i.opilastearv)
    from inserted i;
end;


insert into opetaja (opetajanimi, aine) values ('irina merkulova', 'andmebaasid');


insert into klass (klassnimi, opetajaid, opilastearv)
values ('2c', 1, 20);


select * from logi;
select * from klass;


delete from klass where klassid = 4;
select * from logi;
--10
create procedure kuvaklassidjaopilased
    @opetajanimi nvarchar(100)
as
begin
    select 
        t.opetajanimi,
        t.aine,
        k.klassnimi,
        o.opilasenimi
    from opetaja t
    inner join klass k on t.opetajaid = k.opetajaid
    inner join opilane o on k.klassid = o.klassid
    where t.opetajanimi = @opetajanimi;
end;

exec kuvaklassidjaopilased @opetajanimi = 'marina oleinik';


--11
begin transaction;
save transaction ennenklassi;

insert into klass (klassnimi, opetajaid, opilastearv)
values ('13C', 2, 18);

select * from klass;
rollback transaction ennenklassi;
select * from klass;
commit transaction;


--13
create view klassiinfo as
select 
    k.klassid,
    k.klassnimi,
    t.opetajanimi,
    t.aine,
    k.opilastearv
from klass k
inner join opetaja t on k.opetajaid = t.opetajaid;

select * from klassiinfo;


create procedure lisaopilase
    @opilasenimi varchar(25),
    @Klassid int
as
begin

    insert into opilane (opilasenimi, klassid)
    values (@opilasenimi, @Klassid);

  
    select * from opilane;
end;
exec lisaopilase 'adri radasheva', 2 ;


--3
SELECT * FROM klass;

INSERT INTO Klass (KlassNimi, OpilasteArv, opetajaid)
VALUES ('6b', 33, 3);


UPDATE Klass SET KlassNimi = '12C' WHERE KlassID = 3;
DELETE FROM Klass WHERE KlassID = 1;
CREATE TABLE Test (id int);

