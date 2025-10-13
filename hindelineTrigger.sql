create database PuuAB
use PuuAB


CREATE TABLE puu (
    puuID INT PRIMARY KEY IDENTITY(1,1),
    puuNimi VARCHAR(50) NOT NULL,
    kirjeldus VARCHAR(200),
    pikkus DECIMAL(5,2)
);


CREATE TABLE logi (
    logiID INT PRIMARY KEY IDENTITY(1,1),
    aeg DATETIME,
    toiming varchar(50),
    andmed varchar(400),
    kasutaja  varchar(100)
);


CREATE TABLE puuLeht(
puuLehtID int PRIMARY KEY identity(1,1),
lehtNimi varchar(15),
puuID int,
Foreign key (puuID) REFERENCES puu(puuID)
)


create trigger puulisamine
on puu
for insert 
as 
insert into logi(aeg, kasutaja, toiming, andmed)
select 
getdate(),
system_user,
'puu nimi on lisatud',
inserted.puuNimi
from inserted;

insert into puu (puuNimi , kirjeldus, pikkus) values ('tamm', 'see on tamm', 12.7)

select * from puu
select * from logi

create trigger puukustutamine
on puu
for delete
as 
insert into logi(aeg, kasutaja, toiming, andmed)
select 
getdate(),
system_user,
'puu on kustutatud',
deleted.puuNimi
from deleted;



delete from puu where puuID=3;
select * from puu;
select * from logi;


create trigger puumuumine
on puu
for update
as 
insert into logi(aeg, kasutaja, toiming, andmed)
select 
getdate(),
system_user,
'puu on muudatud',
concat ('vanad andmed: ' ,deleted.puuNimi, ', ',deleted.pikkus,
'uued andmed: ',inserted.puuNimi, ', ',inserted.pikkus)
from deleted
inner join inserted
on deleted.puuID=inserted.puuID;


update puu set pikkus = 11.7
where puuID=2;
select * from puu;
select * from logi;


--lisamine leht
create trigger lehelisamine
on puuLeht
for insert 
as 
insert into logi(aeg, kasutaja, toiming, andmed)
select 
getdate(),
system_user,
'lehe nimi on lisatud',
inserted.lehtNimi
from inserted;

insert into puuLeht (lehtNimi , puuID) values ('kaseleht', 2)

select * from puuleht
select * from logi

--kustutamine leht
create trigger lehekustutamine
on puuLeht
for delete
as 
insert into logi(aeg, kasutaja, toiming, andmed)
select 
getdate(),
system_user,
'leht on kustutatud',
deleted.lehtNimi
from deleted;



delete from puuLeht where puuLehtID=2;
delete from puu where puuID=2;
select * from puuLeht;
select * from logi;


create trigger lehemuumine
on puuLeht
for update
as 
insert into logi(aeg, kasutaja, toiming, andmed)
select 
getdate(),
system_user,
'leht on muudatud',
concat ('vanad andmed: ' ,deleted.lehtNimi, deleted.puuID,
'uued andmed: ',inserted.lehtNimi, ', ',inserted.puuID)
from deleted
inner join inserted
on deleted.puuLehtID=inserted.puuLehtID;


update puuLeht set lehtNimi = 'Tamm'
where puuID=2;
select * from puuLeht;
select * from logi;




update puu set puuNimi='kuusk'
where puuID=4;
select * from puu;
select * from puuLeht;
select * from logi






create trigger puulehtlisamine
on puuleht
for insert
as
begin
    insert into logi (aeg, kasutaja, toiming, andmed)
    select
        getdate(),
        system_user,
        'lisatud puu leht',
        concat('leht lisatud puule: ', puu.puuNimi, ', lehe nimi: ', inserted.lehtNimi, ', puu id: ', inserted.puuID)
    from inserted
    inner join puu on inserted.puuID = puu.puuID;
end;

insert into puuleht (lehtNimi, puuID) 
values ('tamme leht', 9);



select * from puuleht;
select * from logi;



create trigger puulehtmuudatus
on puuleht
for update
as
begin
    insert into logi (aeg, kasutaja, toiming, andmed)
    select
        getdate(),
        system_user,
        'puu leht on uuendatud',
		concat('vanad andmed: leht nimi: ', deleted.lehtNimi, ' ||| puu: ', puu.puuNimi,' ||| uued andmed: leht nimi: ', inserted.lehtNimi,' ||| puu: ', puu.puuNimi)
    from deleted
    inner join inserted on deleted.puuLehtID = inserted.puuLehtID
    inner join puu on inserted.puuID = puu.puuID;
end;


update puuLeht set lehtNimi='kuusk'
where puuID=7;


select * from puuleht;
select * from logi;



create trigger puulehtkustutus
on puuleht
for delete
as
begin
    insert into logi (aeg, kasutaja, toiming, andmed)
    select
        getdate(),
        system_user,
        'puu leht on kustutatud',
        concat('kustutatud leht: ', deleted.lehtNimi, ' | puu: ', puu.puuNimi, ' | puu id: ', deleted.puuID)
    from deleted
    inner join puu on deleted.puuID = puu.puuID;
end;

delete from puuleht where puuLehtID = 4;


select * from puuleht;
select * from puu;
select * from logi;



insert into  puu(puuNimi, kirjeldus, pikkus) VALUES ('Kask', 'Valge koorega puu', 12.5);
insert into puuLeht(lehtNimi, puuID) VALUES ('Kase leht', 9);


UPDATE puu SET puuNimi = 'Tamm' WHERE puuID = 8;
DELETE FROM puu WHERE puuID = 8;
