create database retseptiRaamatPikaljov;
use retseptiRaamatPikaljov;
create table kasutaja(
kasutaja_id int primary key identity(1,1),
eesnimi varchar(50),
perenimi varchar(50) not null,
email varchar(150));

insert into kasutaja(eesnimi, perenimi, email)
values ('Adriana', 'Pikaljov', 'pikaljov@gmail.com');

select * from kasutaja;

create table kategooria(
kategooria_id int primary key identity(1,1),
kategooria_nimi varchar(50));

insert into kategooria(kategooria_nimi)
values ('xleb'), ('kinder'), ('moloko'), ('raamat'), 
('sõnastik'), ('kogus');

delete from kategooria;

create table toiduaine(
toiduaine_id int primary key identity(1,1),
toiduaine_nimi varchar(100));
insert into kategooria(kategooria_nimi)
values ('magus'), ('hapu'), ('terav'), ('meat'), 
('drink');
create table yhik(
yhik_id int primary key identity(1,1),
yhik_nimi varchar(100));
insert into yhik(yhik_nimi)
values ('ml'), ('g'), ('kl'), ('tl'), 
('sl');

create table retsept(
retsept_id int primary key identity(1,1),
retsept_nimi varchar(100),
kirjeldus varchar(200),
juhend varchar(500),
sisestatud_kp date,
kasutaja_id int,
kategooria_id int,
FOREIGN KEY (kasutaja_id) REFERENCES kasutaja(kasutaja_id),
FOREIGN KEY (kategooria_id) REFERENCES kategooria(kategooria_id),
);
INSERT INTO retsept (retsept_nimi, kirjeldus, juhend, sisestatud_kp, kasutaja_id, kategooria_id)
VALUES 
    ('Magus retsept', 'Magus dessert', 'Küpseta 30 minutit.', '2025-02-14', 1, 1),
    ('Hapu retsept', 'Kiseldatud salat', 'Sega koostisosad.', '2025-02-14', 2, 2),
    ('Terav retsept', 'Vürtsikas liha', 'Küpseta vürtsidega.', '2025-02-14', 3, 3),
    ('Meat retsept', 'Mugav liharoog', 'Sega köögiviljad ja liha.', '2025-02-14', 4, 4),
    ('Drink retsept', 'Maitsev jook', 'Sega viljad ja vesi.', '2025-02-14', 5, 5);

drop table retsept;
select * from retsept;
create table koostis(
koostis_id int primary key identity(1,1),
kogus int,
yhik_id int,
toiduaine_id int,
retsept_id int,
FOREIGN KEY (yhik_id) REFERENCES yhik(yhik_id),
FOREIGN KEY (toiduaine_id) REFERENCES toiduaine(toiduaine_id),
FOREIGN KEY (retsept_id) REFERENCES retsept(retsept_id),
);
INSERT INTO koostis (kogus, retsept_id)
VALUES
(3, 1),
(2, 2),
(1, 4),
(4, 1);

drop table koostis;

create table tehtud(
tehtud_id int primary key identity(1,1),
tehtud_kp date,
retsept_id int,
FOREIGN KEY (tehtud_id) REFERENCES retsept(retsept_id)
);
drop table tehtud;
INSERT INTO tehtud(tehtud_kp, retsept_id)
VALUES 
('2025-06-23', 1),
('2025-05-13', 2),('2025-02-28', 3),
('2025-01-14', 4),('2025-04-02', 5)
;

select * from tehtud;
select * from retsept;
select * from kategooria;
select * from toiduaine;
select * from yhik;
-----------------------------------
-----------------------------------
-----------------------------------
CREATE PROCEDURE AddRetsept
    @retsept_nimi VARCHAR(100),
    @kirjeldus VARCHAR(200),
    @juhend VARCHAR(500),
    @sisestatud_kp DATE,
    @kasutaja_id INT,
    @kategooria_id INT
AS
BEGIN
    INSERT INTO retsept (retsept_nimi, kirjeldus, juhend, sisestatud_kp, kasutaja_id, kategooria_id)
    VALUES (@retsept_nimi, @kirjeldus, @juhend, @sisestatud_kp, @kasutaja_id, @kategooria_id);
END;
EXEC AddRetsept
    @retsept_nimi = 'tort napaleon',
    @kirjeldus = 'teha kooki',
    @juhend = 'adri',
    @sisestatud_kp = '2025-02-14',
    @kasutaja_id = 1, 
    @kategooria_id = 2  
drop from retsept
select * from retsep 
-----------------------------------
CREATE PROCEDURE UpdateRetsept
    @retsept_id INT,
    @retsept_nimi VARCHAR(100),
    @kirjeldus VARCHAR(200),
    @juhend VARCHAR(500),
    @sisestatud_kp DATE,
    @kasutaja_id INT,
    @kategooria_id INT
AS
BEGIN
    UPDATE retsept
    SET retsept_nimi = @retsept_nimi,
        kirjeldus = @kirjeldus,
        juhend = @juhend,
        sisestatud_kp = @sisestatud_kp,
        kasutaja_id = @kasutaja_id,
        kategooria_id = @kategooria_id
    WHERE retsept_id = @retsept_id;
END;
-----------------------------------
EXEC UpdateRetsept
    @retsept_id = 1,
    @retsept_nimi = 'Uuendatud Retsepti Nimi', 
    @kirjeldus = 'See on uuendatud retsepti kirjeldus.', 
    @juhend = 'Uuendatud samm-sammult juhend retsepti tegemiseks.', 
    @sisestatud_kp = '2025-02-14', 
    @kasutaja_id = 2, 
    @kategooria_id = 3;  
select * from retsep
-----------------------------------
CREATE PROCEDURE DeleteRetsept
    @retsept_id INT
AS
BEGIN
    DELETE FROM retsept WHERE retsept_id = @retsept_id;
END;
select * from retsep



-----------------------------------



CREATE PROCEDURE AddKoostis
    @kogus INT,
    @yhik_id INT,
    @toiduaine_id INT,
    @retsept_id INT
AS
BEGIN
    INSERT INTO koostis (kogus, yhik_id, toiduaine_id, retsept_id)
    VALUES (@kogus, @yhik_id, @toiduaine_id, @retsept_id);
END;
EXEC AddKoostis @kogus = 500, @yhik_id = 1, @toiduaine_id = 1, @retsept_id = 1;
select * from koostis
-----------------------------------
CREATE PROCEDURE UpdateKoostis
    @koostis_id INT,
    @kogus INT,
    @yhik_id INT,
    @toiduaine_id INT,
    @retsept_id INT
AS
BEGIN
    UPDATE koostis
    SET kogus = @kogus,
        yhik_id = @yhik_id,
        toiduaine_id = @toiduaine_id,
        retsept_id = @retsept_id
    WHERE koostis_id = @koostis_id;
END;
EXEC UpdateKoostis @koostis_id = 1, @kogus = 600, @yhik_id = 1, @toiduaine_id = 1, @retsept_id = 1;
select * from koostis
-----------------------------------
CREATE PROCEDURE DeleteKoostis
    @koostis_id INT
AS
BEGIN
    DELETE FROM koostis WHERE koostis_id = @koostis_id;
END;
EXEC DeleteKoostis @koostis_id = 1;



-----------------------------------



CREATE PROCEDURE AddTehtud
    @tehtud_kp DATE,
    @retsept_id INT
AS
BEGIN
    INSERT INTO tehtud (tehtud_kp, retsept_id)
    VALUES (@tehtud_kp, @retsept_id);
END;
EXEC AddTehtud @tehtud_kp = '2025-02-14', @retsept_id = 1;
select * from Tehtud
-----------------------------------
CREATE PROCEDURE UpdateTehtud
    @tehtud_id INT,
    @tehtud_kp DATE,
    @retsept_id INT
AS
BEGIN
    UPDATE tehtud
    SET tehtud_kp = @tehtud_kp,
        retsept_id = @retsept_id
    WHERE tehtud_id = @tehtud_id;
END;
EXEC UpdateTehtud @tehtud_id = 1, @tehtud_kp = '2025-02-15', @retsept_id = 2;

select * from Tehtud
-----------------------------------
CREATE PROCEDURE DeleteTehtud
    @tehtud_id INT
AS
BEGIN
    DELETE FROM tehtud WHERE tehtud_id = @tehtud_id;
END;
EXEC DeleteTehtud @tehtud_id = 1;
select * from Tehtud

------------------------------------------

--minu table


--Portsjoni kaalud (Вес порции)
create table kaalud(
kaalud_id int primary key identity(1,1),
kaal int,
kasutaja_id int,
retsept_id int,
FOREIGN KEY (kasutaja_id) REFERENCES kasutaja(kasutaja_id),
FOREIGN KEY (retsept_id) REFERENCES retsept(retsept_id),
);
drop table kaalud 
insert into kaalud(kaal)
values (300),(250), (220), (600), (467);



CREATE PROCEDURE InsertKaalud 
    @kaal INT,
    @kasutaja_id INT,
    @retsept_id INT
AS
BEGIN
    INSERT INTO kaalud (kaal, kasutaja_id, retsept_id)
    VALUES (@kaal, @kasutaja_id, @retsept_id);
END;
EXEC InsertKaalud @kaal = 300, @kasutaja_id = 1, @retsept_id = 5;




CREATE PROCEDURE UpdateKaalud
    @kaalud_id INT,
    @kaal INT
AS
BEGIN
    UPDATE kaalud
    SET kaal = @kaal
    WHERE kaalud_id = @kaalud_id;
END;
EXEC UpdateKaalud @kaalud_id = 1, @kaal = 350;




CREATE PROCEDURE DeleteKaalud
    @kaalud_id INT
AS
BEGIN
    DELETE FROM kaalud
    WHERE kaalud_id = @kaalud_id;
END;
EXEC DeleteKaalud @kaalud_id = 3;
