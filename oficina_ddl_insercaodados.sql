create database oficina;
use oficina;

-- Tabela de Clientes
create table clients (
	IdClient int auto_increment primary key,
    PName varchar(15) not null,
    MInit varchar(3) not null,
    LName varchar(20) not null,
    Address varchar(255),
    PhoneNumber char(11)
);

-- Tabela de Veículos
create table vehicle (
	IdVehicle int auto_increment primary key,
    IdClient int not null,
    Color varchar(10),
    Brand varchar(15),
    Model varchar(25),
    YearModel char(4),
    Plate char(7),
    constraint fk_vehicle_client
	foreign key (IdClient) references clients(IdClient)
);

-- Tabela do Time de mecânicos
create table mechanicTeam (
	IdMechanicTeam int auto_increment primary key,
    TeamName varchar(25) not null,
    constraint unique_mechanicTeam_TeamName
		unique(TeamName)
);

-- Tabela de Mecânicos
create table mechanic (
	IdMechanic int auto_increment primary key,
    IdMechanicTeam int,
	PName varchar(15) not null,
    MInit varchar(3) not null,
    LName varchar(20) not null,
	Address varchar(255) not null,
    Specialty varchar(20),
    constraint fk_mechanic_mechanicTeam
	foreign key (IdMechanicTeam) references mechanicTeam(IdMechanicTeam)
);

-- Tabela de serviços
create table service (
	IdService int auto_increment primary key,
    ServiceDescription varchar(255) not null,
    Price float not null
);

-- Tabela de peças
create table part (
	IdPart int auto_increment primary key,
    PartDescription varchar(255) not null,
    Price float not null
);

-- Tabela de Ordem de serviços
create table orders (
	IdOrder int auto_increment primary key,
    IdVehicle int,
    IdMechanicTeam int,
    IssueDate date not null,
    DeliveryDate date not null,
    ServiceOrderStatus enum('Agendado', 'Em Progresso', 'Concluído', 'Cancelado') default 'Agendado',
    Amount float,
    constraint fk_serviceOrder_vehicle
	foreign key (IdVehicle) references vehicle(IdVehicle),
    constraint fk_serviceOrder_mechanic
	foreign key (IdMechanicTeam) references mechanicTeam(IdMechanicTeam)
);


-- Tabela da relação entre Ordem de serviços e peças
create table orderPart (
	IdOrder int,
    IdPart int,
    Quantity int default 1,
    primary key (IdOrder, IdPart),
    constraint fk_orderPart_orders
	foreign key (IdOrder) references orders(IdOrder),
	constraint fk_orderPart_part
	foreign key (IdPart) references part(IdPart)
);


-- Tabela da relação entre Ordem de serviços e serviços
create table orderService (
	IdOrder int,
    IdService int,
    Quantity int default 1,
    primary key (IdOrder, IdService),
    constraint fk_orderService_orders
	foreign key (IdOrder) references orders(IdOrder),
	constraint fk_orderService_service
	foreign key (IdService) references service(IdService)
);
