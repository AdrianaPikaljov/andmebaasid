create database pikaljovtriger;
use pikaljovtriger;

--loome tabelid
Create table linnad(
linnID int identity(1,1) PRIMARY KEY,
linnanimi varchar(15),
rahvaarv int);

--tabel logi näitab adminile kuidas tabel linnad kasustatakse, tabel logi täidab triger
Create table logi(
id int identity(1,1) PRIMARY KEY,
aeg DATETIME,
toiming  varchar(100),
andmed varchar(200),
kasutaja varchar(100)
)

--insert triger, mis jalgib tabeli linnad taitmine
create trigger linnalisamine
on linnad
for insert 
as 
insert into logi(aeg, kasutaja, toiming, andmed)
select 
getdate(),
system_user,
'linn on lisatud',
inserted.linnanimi
from inserted;
--trigeri tegevuse kontroll
insert into linnad (linnanimi, rahvaarv)
values('tallinn', 650000);
select * from linnad;
select * from logi;

--delete triger, jälgib linnade kustutamine tabelis linnad  
create trigger linnakustutamine
on linnad
for delete
as 
insert into logi(aeg, kasutaja, toiming, andmed)
select 
getdate(),
system_user,
'linn on kustutatud',
deleted.linnanimi
from deleted;

--trigeri tegevuse kontroll
delete from linnad where linnID=1;
select * from linnad;
select * from logi;


--update triger, jälgib linnade uuendamist tabelis linnad

create trigger linnauuendamine
on linnad
for update
as 
insert into logi(aeg, kasutaja, toiming, andmed)
select 
getdate(),
system_user,
'linn on uuendatud',
concat ('vanad andmed: ' ,deleted.linnanimi, ', ',deleted.rahvaarv,
'uued andmed: ',inserted.linnanimi, ', ',inserted.rahvaarv)
from deleted
inner join inserted
on deleted.linnID=inserted.linnID;

--trigeri tegevuse kontroll
update linnad set rahvaarv=650001
where linnID=2;
select * from linnad;
select * from logi;
