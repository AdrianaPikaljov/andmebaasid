CREATE TABLE tellimusse_rida (
    tellimuserida_ID INT PRIMARY KEY,
    kogus INT,
    pizzamenu_pizzaID INT,
    tellimusused_tellimus_ID INT,
    FOREIGN KEY (pizzamenu_pizzaID) REFERENCES pizzamenu(pizzaID),
    FOREIGN KEY (tellimusused_tellimus_ID) REFERENCES tellimusused(tellimus_ID)
);

CREATE TABLE pizzamenu (
    pizzaID INT PRIMARY KEY,
    nimi VARCHAR(30),
    hind VARCHAR(10)
);

CREATE TABLE tellimusused (
    tellimus_ID INT PRIMARY KEY,
    tellimus_aeg DATETIME
);

CREATE TABLE klientid (
    klienti_ID INT PRIMARY KEY,
    nimi VARCHAR(30),
    telefon VARCHAR(30)
);

CREATE TABLE kohaletoimetamine (
    kohaletoimetamine_ID INT PRIMARY KEY,
    address VARCHAR(35),
    kohaletoimetamise_tyyp VARCHAR(20),
    tootajad_tootaja_ID INT,
    klientid_klienti_ID INT,
    FOREIGN KEY (tootajad_tootaja_ID) REFERENCES tootajad(tootaja_ID),
    FOREIGN KEY (klientid_klienti_ID) REFERENCES klientid(klienti_ID)
);

CREATE TABLE tootajad (
    tootaja_ID INT PRIMARY KEY,
    tootajanimi VARCHAR(30),
    roll VARCHAR(30)
);

CREATE TABLE makse (
    makse_ID INT PRIMARY KEY,
    naksevis VARCHAR(30),
    makse_aeg INT,
    summa VARCHAR(10),
    tellimusused_tellimus_ID INT,
    FOREIGN KEY (tellimusused_tellimus_ID) REFERENCES tellimusused(tellimus_ID)
);
