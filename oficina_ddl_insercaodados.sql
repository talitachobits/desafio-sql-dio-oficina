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

-- Inserção de dados na tabela de Clientes
insert into clients (PName, MInit, LName, Address, PhoneNumber)
values
    ('João', 'A.', 'Silva', 'Rua das Flores, 123', '11223344556'),
    ('Maria', 'B.', 'Santos', 'Avenida Principal, 456', '99887766554'),
    ('Carlos', 'C.', 'Ferreira', 'Rua da Esquina, 789', '88776655443'),
    ('Ana', 'D.', 'Oliveira', 'Travessa das Palmeiras, 101', '99887766550');

-- Inserção de dados na tabela de Veículos
insert into vehicle (IdClient, Color, Brand, Model, YearModel, Plate)
values
    (1, 'Vermelho', 'Toyota', 'Corolla', '2020', 'ABC1234'),
	(1, 'Preto', 'Volkswagen', 'Gol', '2018', 'DEF5678'),
    (1, 'Azul', 'Honda', 'Civic', '2019', 'XYZ5678'),
    (2, 'Azul', 'Ford', 'Focus', '2019', 'GHI9012'),
    (2, 'Prata', 'Ford', 'Focus', '2021', 'DEF4321'),
    (3, 'Preto', 'Chevrolet', 'Cruze', '2018', 'GHI9876'),
    (3, 'Branco', 'Chevrolet', 'Onix', '2022', 'MNO6789'),
    (4, 'Prata', 'Nissan', 'Sentra', '2017', 'MNO7890'),
    (4, 'Verde', 'Hyundai', 'HB20', '2021', 'STU4567'),
    (4, 'Cinza', 'Hyundai', 'Elantra', '2020', 'PQR5432'),
    (4, 'Verde', 'Kia', 'Optima', '2019', 'STU2109');

-- Inserção de dados na tabela do Time de mecânicos
insert into mechanicTeam (TeamName)
values
    ('Equipe Azul'),
    ('Equipe Vermelha'),
    ('Equipe Lotus'),
    ('Equipe Osiris');
    
-- Inserção de dados na tabela de Mecânicos
insert into mechanic (IdMechanicTeam, PName, MInit, LName, Address, Specialty)
values
    (1, 'Miguel', 'A.', 'Silva', 'Rua das Flores, 123', 'Motor'),
    (1, 'Sophia', 'B.', 'Santos', 'Avenida Principal, 456', 'Suspensão'),
    (2, 'Arthur', 'C.', 'Ferreira', 'Rua da Esquina, 789', 'Freios'),
    (2, 'Isabella', 'D.', 'Oliveira', 'Travessa das Palmeiras, 101', 'Transmissão'),
    (2, 'Thiago', 'E.', 'Souza', 'Rua da Paz, 222', 'Motor'),
    (3, 'Lorenzo', 'F.', 'Martins', 'Rua das Estrelas, 55', 'Suspensão'),
    (3, 'Laura', 'G.', 'Almeida', 'Avenida do Sol, 789', 'Freios'),
    (3, 'Gabriel', 'H.', 'Ribeiro', 'Praça da Lua, 456', 'Transmissão'),
    (3, 'Valentina', 'I.', 'Mendes', 'Rua das Nuvens, 23', 'Motor'),
    (4, 'Rafael', 'J.', 'Fernandes', 'Rua das Montanhas, 67', 'Freios'),
    (4, 'Manuela', 'K.', 'Carvalho', 'Avenida das Águas, 34', 'Motor');

-- Inserção de dados na tabela de Serviços
insert into service (ServiceDescription, Price)
values
    ('Troca de óleo', 50.00),
    ('Alinhamento e balanceamento', 80.00),
    ('Revisão de freios', 120.00),
    ('Substituição de correia dentada', 180.00),
    ('Troca de amortecedores', 200.00),
    ('Reparo na suspensão', 150.00),
    ('Diagnóstico de motor', 60.00),
    ('Reparo de sistema elétrico', 100.00),
    ('Substituição de bateria', 70.00);
    
-- Inserção de dados na tabela de Peças
insert into part (PartDescription, Price)
values
    ('Filtro de óleo', 10.00),
    ('Pastilhas de freio', 40.00),
    ('Correia dentada', 30.00),
    ('Amortecedor dianteiro', 60.00),
    ('Lâmpada do farol', 5.00),
    ('Bateria automotiva', 70.00),
    ('Sensor de oxigênio', 25.00),
    ('Vela de ignição', 8.00),
    ('Termostato', 15.00);
    
    -- Inserção de dados na tabela de Ordens de Serviço
insert into orders (IdVehicle, IdMechanicTeam, IssueDate, DeliveryDate, ServiceOrderStatus, Amount)
values
    (1, 1, '2023-08-10', '2023-08-15', 'Em Progresso', 0.00),
    (1, 2, '2023-07-20', '2023-07-25', 'Concluído', 150.00),
    (1, 3, '2023-09-05', '2023-09-10', 'Agendado', 0.00),
    (2, 2, '2023-08-12', '2023-08-17', 'Em Progresso', 0.00),
    (2, 4, '2023-07-25', '2023-07-30', 'Concluído', 200.00),
    (2, 3, '2023-08-30', '2023-09-04', 'Agendado', 0.00),
    (3, 1, '2023-08-15', '2023-08-20', 'Em Progresso', 0.00),
    (3, 3, '2023-09-10', '2023-09-15', 'Concluído', 180.00),
    (4, 2, '2023-08-20', '2023-08-25', 'Em Progresso', 0.00),
    (4, 4, '2023-07-30', '2023-08-04', 'Concluído', 220.00),
    (4, 2, '2023-09-15', '2023-09-20', 'Agendado', 0.00),
    (5, 1, '2023-08-25', '2023-08-30', 'Agendado', 0.00),
    (6, 3, '2023-09-04', '2023-09-09', 'Agendado', 0.00),
    (6, 4, '2023-08-04', '2023-08-09', 'Em Progresso', 0.00),
    (6, 2, '2023-09-20', '2023-09-25', 'Concluído', 210.00),
    (7, 1, '2023-08-30', '2023-09-04', 'Concluído', 100.00),
    (7, 2, '2023-08-09', '2023-08-14', 'Agendado', 0.00),
    (8, 3, '2023-09-09', '2023-09-14', 'Em Progresso', 0.00),
    (8, 4, '2023-08-14', '2023-08-19', 'Concluído', 130.00),
    (8, 2, '2023-09-25', '2023-09-30', 'Agendado', 0.00),
    (9, 1, '2023-09-15', '2023-09-20', 'Agendado', 0.00),
    (9, 2, '2023-08-19', '2023-08-24', 'Em Progresso', 0.00),
    (10, 1, '2023-08-01', '2023-08-03', 'Concluído', 160.00),
    (10, 2, '2023-08-10', '2023-08-12', 'Concluído', 250.00),
    (11, 3, '2023-08-15', '2023-08-18', 'Concluído', 120.00);

-- Inserção de dados na tabela de relação entre Ordem de Serviços e Peças
insert into orderPart (IdOrder, IdPart, Quantity)
values
    (1, 1, 2),
    (1, 3, 1),
    (2, 2, 1),
    (3, 5, 4),
    (4, 4, 1),
    (4, 6, 2),
    (5, 8, 3),
    (6, 9, 1),
    (7, 1, 1),
    (7, 2, 2),
    (8, 3, 1),
    (8, 7, 1),
    (9, 4, 2),
    (9, 5, 1),
    (9, 6, 1),
    (10, 9, 1),
    (10, 1, 3),
    (11, 5, 2),
    (11, 6, 1),
    (12, 7, 1),
    (12, 8, 2),
    (12, 9, 1),
    (13, 2, 1),
    (13, 3, 1),
    (13, 4, 1),
    (13, 5, 2),
    (13, 6, 1),
    (13, 8, 1),
    (14, 7, 1),
    (14, 9, 1),
    (15, 1, 2),
    (16, 2, 1),
    (16, 3, 1),
    (16, 5, 1),
    (17, 6, 1),
    (17, 7, 1),
    (18, 8, 1),
    (18, 9, 1),
    (19, 1, 1),
    (19, 2, 1),
    (20, 3, 2),
    (20, 4, 1),
	(21, 5, 1),
    (21, 3, 1),
    (22, 4, 1),
    (23, 5, 2),
    (23, 2, 1),
    (23, 3, 1),
    (24, 4, 2),
    (24, 5, 3),
    (25, 6, 1),
    (25, 3, 1),
    (25, 4, 2);

-- Inserção de dados na tabela de relação entre Ordem de Serviços e Serviços
insert into orderService (IdOrder, IdService, Quantity)
values
    (1, 1, 1),
    (1, 2, 2),
    (2, 2, 1),
    (2, 3, 3),
    (3, 1, 2),
    (4, 4, 1),
    (4, 5, 2),
    (5, 6, 1),
    (6, 7, 1),
    (6, 8, 2),
    (7, 9, 1),
    (8, 3, 2),
    (9, 1, 1),
    (9, 2, 1),
    (9, 3, 1),
    (10, 4, 2),
    (10, 5, 3),
    (11, 6, 1),
    (11, 7, 1),
    (11, 8, 1),
    (12, 9, 2),
    (12, 8, 1),
    (13, 1, 2),
    (13, 2, 1),
    (13, 3, 2),
    (14, 4, 1),
    (14, 5, 1),
    (15, 6, 1),
    (15, 7, 2),
    (15, 8, 1),
    (16, 9, 2),
    (16, 5, 1),
    (17, 1, 1),
    (17, 2, 2),
    (18, 3, 1),
    (18, 4, 2),
    (18, 5, 1),
    (19, 6, 2),
    (19, 7, 1),
    (20, 8, 1),
    (21, 9, 1),
    (21, 3, 1),
    (22, 4, 1),
    (22, 5, 1),
    (23, 6, 1),
    (23, 7, 1),
    (23, 8, 1),
    (24, 9, 1),
    (24, 6, 1),
    (25, 3, 1),
    (25, 2, 1);
