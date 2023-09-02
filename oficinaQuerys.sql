use oficina;

-- Qual a quantidade de clientes?
select count(*) as ClientsCount
	from clients;

-- Quantos veículos cada cliente tem?
select concat(PName, ' ', MInit, ' ', LName) as ClientName, count(IdVehicle) as VehicleCount
	from clients c
    inner join vehicle v
		on c.IdClient = v.IdClient
	group by c.IdClient
    order by VehicleCount desc;
    
-- Quantas Ordens de Serviço foram pedidas por cada cliente?
select concat(PName, ' ', MInit, ' ', LName) as ClientName, count(IdOrder) as OrderServiceCount
	from clients c
    inner join vehicle v
		on c.IdClient = v.IdClient
	inner join orders o
		on v.IdVehicle = o.IdVehicle
	group by c.IdClient;

-- Veículos

-- Qual a quantidade de veículos registrados?
select count(*) as VehiclesTotal
	from vehicle;
    
-- Qual a cor de veículo mais usada?
select Color, count(IdVehicle) as ColorCount
	from vehicle
    group by Color
    order by ColorCount desc;

-- Quantas Ordens de Serviço foram registradas para cada veículo?
select Model, Brand, YearModel, Plate, Color, count(IdOrder) as OrderCount
	from vehicle v
    inner join orders o
		on v.IdVehicle = o.IdVehicle
	group by v.IdVehicle
    order by OrderCount desc;

-- Mecânicos

-- Quantos mecânicos trabalham na oficina?
select count(*) as MechanicCount 
	from mechanic;
    
-- Quantos mecânicos estão dispostos em cada time?
select TeamName, count(m.IdMechanic) as MechanicCount
	from mechanic m
    inner join mechanicTeam t
		on t.IdMechanicTeam = m.IdMechanicTeam
	group by t.IdMechanicTeam
    order by MechanicCount desc;
    
-- Quantos mecânicos temos por especilidade?
select Specialty, count(IdMechanic) as MechanicCount
	from Mechanic
    group by Specialty
    order by MechanicCount desc;
    
-- Serviços

-- Quantos serviços são oferecidos?
select count(*) as ServiceCount 
	from service;

-- Quais os serviços mais solicitados?
select ServiceDescription, sum(os.Quantity) as Quantity
	from service s
    inner join orderService os
		on s.IdService = os.IdService
	group by s.IdService
    order by Quantity desc;
    
-- Qual a receita obtida com cada serviço?
select ServiceDescription, Price, sum(os.Quantity) as Quantity, (Price * sum(os.Quantity)) as Amount
	from service s
    inner join orderService os
		on s.IdService = os.IdService
	group by s.IdService
    order by Amount desc;
    
-- Peças

-- Quais as peças mais usadas?
select PartDescription, sum(op.Quantity) as Quantity
	from part p
    inner join orderPart op
		on p.IdPart = op.IdPart
	group by p.IdPart
    order by Quantity desc;
    
-- Qual a receita obitida com cada peça?
select PartDescription, Price, sum(op.Quantity) as Quantity, (Price * sum(op.Quantity)) as Amount
	from part p
    inner join orderPart op
		on p.IdPart = op.IdPart
	group by p.IdPart
    order by Amount desc;
    
-- Ordem de Serviços

-- Qual a quantidade de Ordens de serviço por Status?
select ServiceOrderStatus, count(IdOrder) as OrderCount 
	from orders
    group by ServiceOrderStatus
    order by ServiceOrderStatus;
    
-- Quantas Ordens de Serviço 'Em Progresso' estão atribuídas a cada time?
select TeamName, count(IdOrder) as OrderCount
	from orders o
    inner join mechanicTeam t
		on t.IdMechanicTeam = o.IdMechanicTeam
	where ServiceOrderStatus = 'Em Progresso'
	group by t.IdMechanicTeam
    order by OrderCount desc;
    
-- Quanta receita cada Ordem de Serviço 'Concluída' gerou com peças?
select ServiceOrderStatus, sum(p.Amount) as AmountByPart
	from orders o
    inner join 
		(select IdOrder, (Price * sum(op.Quantity)) as Amount
				from part p
				inner join orderPart op
					on p.IdPart = op.IdPart
				group by p.IdPart, op.IdOrder) as p
		on o.IdOrder = p.IdOrder
	where ServiceOrderStatus = 'Concluído'
	group by ServiceOrderStatus;

-- Quanta receita cada Ordem de Serviço 'Concluída' gerou com serviços?
select ServiceOrderStatus, sum(s.Amount) as AmountByPart
	from orders o
    inner join 
		(select IdOrder, (Price * sum(os.Quantity)) as Amount
			from service s
			inner join orderService os
				on s.IdService = os.IdService
			group by s.IdService, os.IdOrder) as s
		on o.IdOrder = s.IdOrder
	where ServiceOrderStatus = 'Concluído'
	group by ServiceOrderStatus;
