create database storep_trigger
use storep_trigger

create table CustomerAndSuppliers
(
cust_id char(6) primary key check(cust_id like '[CS][0-9][0-9][0-9][0-9][0-9]'),
cust_fname char(15) not null,
cust_lname varchar(15),
cust_address text,
cust_telno char(12) check (cust_telno like '[0-9][0-9][0-9]-[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
cust_city char(12) default 'Rajshahi',
cust_amnt money check(cust_amnt>=0),
cust_proc money check(cust_proc>=0)
)

insert into CustomerAndSuppliers values('C00001','Bipul','Islam','18/126 Shapla','017-00000001','Kurigram',100,100)
insert into CustomerAndSuppliers values('C00002','Jihad','Islam','18/129 Babita','017-00000002','Magura',100,100)
insert into CustomerAndSuppliers values('S00001','Risad','Islam','18/128 Shanta','017-00000003','Muktagacha',100,100)


create table Item
(
item_id char(6) primary key check(item_id like '[P][0-9][0-9][0-9][0-9][0-9]'),
item_name char(12),
item_category char(10),
item_price float check(item_price>=0),
item_qoh int check(item_qoh>=0),
itme_last_sold date default getdate()
)


insert into Item values('P00001','fan','Electrical',100,4,getdate())
insert into Item values('P00002','Pencil','Book',5,3,getdate())
insert into Item values('P00003','Hammer','Mechanical',150,2,getdate())
insert into Item values('P00004','Windows','Sofrware',10000,1,getdate())




Create table Transactions
(
tran_id char(10) primary key check(tran_id like '[T][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
item_id char(6) foreign key references Item(item_id),
cust_id char(6) foreign key references CustomerAndSuppliers(cust_id),
tran_type char(1) check (tran_type like '[OS]'),
tran_quantity int check(tran_quantity>=0),
tran_date datetime default getdate()
)




insert into Transactions values('T000000000','P00001','C00001','O',1,getdate())

select * from Transactions
select * from CustomerAndSuppliers
select * from Item


create trigger Itrigger on Transactions for insert
as
begin
declare @itemid char(6)
declare @trantype char(1)
declare @tranquantity int
select @itemid=item_id,@trantype=tran_type,@tranquantity=tran_quantity from inserted
if(@trantype='S')
update Item set item_qoh=item_qoh-@tranquantity where item_id=@itemid
else
update Item set item_qoh=item_qoh+@tranquantity where item_id=@itemid
end

select * from Item
insert into Transactions values('T000000015','P00004','C00001','O',4,GETDATE())
select * from Item

DROP TRIGGER Itrigger

alter trigger Itrigger on Transactions for insert
as
begin
declare @custid char(6)
declare @itemid char(6)
declare @trantype char(1)
declare @itemprice int
declare @totprice int
select @itemid=item_id,@custid=cust_id,@trantype=tran_type,@totprice=tran_quantity from inserted
select @itemprice=item_price from item where item_id=@itemid
print(@custid)
if(@trantype='S')
update customerandsuppliers set cust_amnt=cust_amnt+@itemprice * @totprice where cust_id=@custid
else
update customerandsuppliers set cust_proc=cust_proc+@itemprice  where cust_id=@custid
end


select * from CustomerAndSuppliers
select * from Item
insert into Transactions values('T000000020','P00001','S00001','S',3,getdate())
select * from CustomerAndSuppliers
select * from Item
select * from transactions




select * from CustomerAndSuppliers
select * from Item
select * from transactions
