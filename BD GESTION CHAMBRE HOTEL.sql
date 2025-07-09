create database GESTION_CHAMBRE_HOTEL

go
use GESTION_CHAMBRE_HOTEL
go
create table tCategorisation
(
	Id int primary key identity(1,1),
	Designation nvarchar(100)
)
go
create table tClient
(
	Id int primary key identity(1,1),
	Nom nvarchar(100),
	Adresse nvarchar(100),
	Contact nvarchar(100),
	RefCategorisation int foreign key references tCategorisation(id)
)
go
create table tClasse
(
	Id int primary key identity(1,1),
	Designation nvarchar(100),
	Prix decimal(20,2)
)
go
create table tChambre
(
	Id int primary key identity(1,1),
	Numero int,
	Contact nvarchar(20),
	RefClasse int foreign key references tClasse(id)
)
go
create table tReservation
(
	Id int primary key identity(1,1),
	RefClient int foreign key references tClient(id),
	RefChambre int foreign key references tChambre(id),
	DateEntree date,
	DateSortie date
)

go
create procedure SaveCategorisation
(
	@Id int,
	@Designation nvarchar(100)
)as
begin
if @Id in (select Id from tCategorisation)
begin
update tCategorisation set Designation = @Designation where Id = @Id 
end
else
begin
insert into tCategorisation values(@Designation)
end
end

go
create Procedure SaveClient
(
	@Id int,
	@Nom nvarchar(100),
	@Adresse nvarchar(100),
	@Contact nvarchar(100)
)as
begin
if @Id in (select id from tClient)
begin
update tClient set Nom = @Nom, Adresse = @Adresse, Contact = @Contact where Id = @Id
end
else
begin
insert into tClient(Nom, Adresse, Contact) values(@Nom, @Adresse, @Contact)
end
end

go
create procedure SaveClasse
(
	@Id int,
	@Designation nvarchar(100),
	@Prix decimal(20,2)
)as
begin
if @Id in (select id from tClasse)
begin
update tClasse set Designation = @Designation, Prix = @Prix where Id = @Id
end
else
begin
insert into tClasse(Designation, Prix) values(@Designation, @Prix)
end
end

go
create procedure SaveChambre
(
	@Id int,
	@Numero int,
	@Contact nvarchar(20),
	@RefClasse int
)as
begin
if @Id in (select id from tChambre)
begin
update tChambre set Numero = @Numero, Contact = @Contact, RefClasse = @RefClasse where Id = @Id
end
else
begin
insert into tChambre(Numero, Contact, RefClasse) values(@Numero, @Contact, @RefClasse)
end
end

go
create procedure SaveReservation
(
	@Id int,
	@RefClient int ,
	@RefChambre int ,
	@DateEntree date,
	@DateSortie date
)as
begin
if @Id in (select id from tReservation)
begin
update tReservation set RefClient = @RefClient, RefChambre = @RefChambre, DateEntree = @DateEntree, DateSortie = @DateSortie
where Id = @Id
end
else
begin
insert into tReservation(RefClient, RefChambre, DateEntree, DateSortie) values(@RefClient, @RefChambre, @DateEntree, @DateSortie)
end
end

EXEC SaveCategorisation 1,'HOMME'

select * from tCategorisation