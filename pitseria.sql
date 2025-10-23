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


--insert
tellimuselisamine
insert into logi (aeg, kasutaja, toiming, andmed)
    select
        now(),
        user(),
        'tellimus lisatud',
        concat('staatus: ', s.nimetus, ', aeg: ', new.tellimus_aeg, ', tellimus id: ', new.tellimus_ID)
FROM tellimuse_staatus s
WHERE s.staatus_ID = NEW.staatusID



--update
tellimusemuudatus
insert into logi (aeg, kasutaja, toiming, andmed)
    select
        now(),
        user(),
        'tellimus on uuendatud',
		concat('vanad andmed: aeg: ', old.tellimus_aeg, ' ||| staatus: ', s.nimetus,' ||| tellimus id: ', new.tellimus_ID,' |||')
FROM tellimuse_staatus s 
WHERE s.staatus_ID = NEW.staatusID

--kustutamine
tellimusekustutus
insert into logi (aeg, kasutaja, toiming, andmed)
    select
        now(),
        user(),
        'tellimus on kustutatud',
        concat('kustutatud tellimus: ', old.tellimus_ID, ' | staatus: ', s.nimetus, ' | tellimuse aeg: ', old.tellimus_aeg)
FROM tellimuse_staatus s
WHERE s.staatus_ID = OLD.staatusID


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


DELETE FROM tellimused
WHERE tellimus_ID = 4;

update tellimused
set tellimus_aeg ='2022-11-22 22:22:00'
WHERE tellimus_ID = 1;

