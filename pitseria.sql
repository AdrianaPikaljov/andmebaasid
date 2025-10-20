create database pitseria2
use pitseria2

CREATE TABLE pizzamenu (
    pizzaID INT PRIMARY KEY IDENTITY(1,1),
    nimi VARCHAR(30),
    hind DECIMAL(10, 2)
);

CREATE TABLE tellimuse_staatus (
    staatus_ID INT PRIMARY KEY,
    nimetus VARCHAR(20) UNIQUE
);

CREATE TABLE tellimused (
    tellimus_ID INT PRIMARY KEY IDENTITY(1,1),
    tellimus_aeg DATETIME,
    staatusID INT,
    FOREIGN KEY (staatusID) REFERENCES tellimuse_staatus(staatus_ID)
);


CREATE TABLE klientid (
    klienti_ID INT PRIMARY KEY IDENTITY(1,1),
    nimi VARCHAR(30),
    telefon VARCHAR(30)
);

CREATE TABLE tootajad (
    tootaja_ID INT PRIMARY KEY IDENTITY(1,1),
    tootajanimi VARCHAR(30),
    roll VARCHAR(30)
);

CREATE TABLE kohaletoimetamine (
    kohaletoimetamine_ID INT PRIMARY KEY IDENTITY(1,1),
    address VARCHAR(35),
    kohaletoimetamise_tyyp VARCHAR(20),
    tootajad_tootaja_ID INT,
    klientid_klienti_ID INT,
    FOREIGN KEY (tootajad_tootaja_ID) REFERENCES tootajad(tootaja_ID),
    FOREIGN KEY (klientid_klienti_ID) REFERENCES klientid(klienti_ID)
);

CREATE TABLE tellimusse_rida (
    tellimuserida_ID INT PRIMARY KEY IDENTITY(1,1),
    kogus INT,
    pizzamenu_pizzaID INT,
    tellimusused_tellimus_ID INT,
    FOREIGN KEY (pizzamenu_pizzaID) REFERENCES pizzamenu(pizzaID),
    FOREIGN KEY (tellimusused_tellimus_ID) REFERENCES tellimusused(tellimus_ID)
);

CREATE TABLE makse (
    makse_ID INT PRIMARY KEY IDENTITY(1,1),
    makseviis VARCHAR(30),
    makse_aeg DATETIME,
    summa DECIMAL(10, 2),
    tellimusused_tellimus_ID INT,
    FOREIGN KEY (tellimusused_tellimus_ID) REFERENCES tellimusused(tellimus_ID)
);


CREATE TABLE logi (
    logiID INT PRIMARY KEY IDENTITY(1,1),
    aeg DATETIME,
    toiming varchar(50),
    andmed varchar(400),
    kasutaja  varchar(100)
);



create trigger tellimuselisamine
on tellimused
for insert
as
begin
    insert into logi (aeg, kasutaja, toiming, andmed)
    select
        getdate(),
        system_user,
        'tellimus lisatud',
        concat('staatus: ', tellimuse_staatus.nimetus, ', aeg: ', inserted.tellimus_aeg, ', tellimus id: ', inserted.tellimus_ID)
    from inserted
    inner join tellimuse_staatus on inserted.staatusID = tellimuse_staatus.staatus_ID;
end;




create trigger tellimusemuudatus
on tellimused
for update
as
begin
    insert into logi (aeg, kasutaja, toiming, andmed)
    select
        getdate(),
        system_user,
        'tellimus on uuendatud',
		concat('vanad andmed: aeg: ', deleted.tellimus_aeg, ' ||| staatus: ', tellimuse_staatus.nimetus,' ||| tellimus id: ', inserted.tellimus_ID,' |||')
    from deleted
    inner join inserted on deleted.tellimus_ID = inserted.tellimus_ID
    inner join tellimuse_staatus on inserted.staatusID = tellimuse_staatus.staatus_ID;
end;


create trigger tellimusekustutus
on tellimused
for delete
as
begin
    insert into logi (aeg, kasutaja, toiming, andmed)
    select
        getdate(),
        system_user,
        'tellimus on kustutatud',
        concat('kustutatud tellimus: ', deleted.tellimus_ID, ' | staatus: ', tellimuse_staatus.nimetus, ' | tellimuse aeg: ', deleted.tellimus_aeg)
    from deleted
    inner join tellimuse_staatus on deleted.staatusID = tellimuse_staatus.staatus_ID;
end;


select * from logi



INSERT INTO tellimuse_staatus (staatus_ID, nimetus) VALUES
(1, 'Ootel'),
(2, 'Kinnitatud'),
(3, 'Täidetud'),
(4, 'Tühistatud');


INSERT INTO tellimused (tellimus_aeg, staatusID) VALUES
('2025-10-20 14:30:00', 1),
('2025-10-19 10:15:00', 2),
('2025-10-18 08:00:00', 3);


use pitseria2

DELETE FROM tellimuse_staatus
WHERE staatus_ID = 4;
