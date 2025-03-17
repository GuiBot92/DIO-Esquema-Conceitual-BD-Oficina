-- Criando DB Mecânica
create database mecanica;
use mecanica;

-- Criando Tabela dos mecânicos
CREATE TABLE mecanics (
    idMecanics INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    address VARCHAR(150),
    specialty VARCHAR(50) not null,
    cep char(8) not null unique,
    middle_name_initial varchar(3),
    last_name varchar(45) not null,
    cpf char(11) not null unique
);

-- Criando tabela dos clientes
CREATE TABLE clients (
    idClients INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(45) NOT NULL,
    middle_name_initial varchar(3),
    address VARCHAR(150),
    cep CHAR(8) NOT NULL UNIQUE,
    cpf CHAR(11) NOT NULL UNIQUE,
    contact_number VARCHAR(20) NOT NULL
);

-- Criando Tabela Equipes de Trabalho
CREATE TABLE working_team (
    idWorking_team INT AUTO_INCREMENT PRIMARY KEY,
    service ENUM('Manutenção', 'Reparo', 'Inspeção') NOT NULL,
    delivery_date DATE
);

-- Criando tabela do veículo
CREATE TABLE vehicle (
    idVehicle INT AUTO_INCREMENT PRIMARY KEY,
    plate VARCHAR(45) UNIQUE NOT NULL,
    model VARCHAR(50),
    idClients INT NOT NULL,
    FOREIGN KEY (idClients) REFERENCES clients(idClients) on delete cascade
);

CREATE TABLE service_order(
    idService_order INT AUTO_INCREMENT PRIMARY KEY,
    emission_date DATE NOT NULL,
    total_cost DECIMAL(10, 2) NOT NULL,
    service_status ENUM('Pendente', 'Em andamento', 'Concluído') NOT NULL,
    conclusion_date DATE,
    idClients INT NOT NULL,
	FOREIGN KEY (idClients) REFERENCES clients(idClients) on delete cascade
);

-- criando Tabela Custo de Mão de Obra
CREATE TABLE labor_cost (
    idLabor_cost INT AUTO_INCREMENT PRIMARY KEY,
    labor_description VARCHAR(100),
    total_cost DECIMAL(10, 2) NOT NULL
);

-- Criando tabela Mecanicos vs Time de trabalho
CREATE TABLE mecanics_in_team (
    idMecanics INT,
    idWorking_team INT,
    PRIMARY KEY (idMecanics, idWorking_team),
    FOREIGN KEY (idMecanics) REFERENCES mecanics(idMecanics) on delete cascade,
    FOREIGN KEY (idWorking_team) REFERENCES working_team(idWorking_team) on delete cascade
);

-- Criando Tabela Custo por Peça
CREATE TABLE parts_cost(
    idParts_cost INT AUTO_INCREMENT PRIMARY KEY,
    parts_description VARCHAR(100),
    total_cost DECIMAL(10, 2) NOT NULL
);

-- Criando tabela de Serviços Disponíveis
CREATE TABLE available_services(
    idAvailable_services INT AUTO_INCREMENT PRIMARY KEY,
    service_name VARCHAR(100) NOT NULL,
    service_description VARCHAR(255)
);

-- Tabela abaixo são as de relação

-- Criando tabela Time vs Ordem de Serviço
CREATE TABLE working_team_vs_os (
    idService_order INT,
    idWorking_team INT,
    PRIMARY KEY (idService_order, idWorking_team),
    FOREIGN KEY (idService_order) REFERENCES service_order(idService_order) on delete cascade,
    FOREIGN KEY (idWorking_team) REFERENCES working_team(idWorking_team) on delete cascade
);

-- Criando Tabela de ordem de serviço vs preço de mão de obra
CREATE TABLE labor_cost_vs_os (
    idService_order INT,
    idLabor_cost INT,
    PRIMARY KEY (idService_order, idLabor_cost),
    FOREIGN KEY (idService_order) REFERENCES service_order(idService_order) on delete cascade,
    FOREIGN KEY (idLabor_cost) REFERENCES labor_cost(idLabor_cost) on delete cascade
);

-- Criando Tabela peças por Ordem de Serviço
CREATE TABLE parts_vs_os (
    idService_order INT,
    idParts_cost INT,
    parts_quantity INT NOT NULL,
    PRIMARY KEY (idService_order, idParts_cost),
    FOREIGN KEY (idService_order) REFERENCES service_order(idService_order) on delete cascade,
    FOREIGN KEY (idParts_cost) REFERENCES parts_cost(idParts_cost) on delete cascade
);

-- Tabela de Serviços disponíveis vs Ordem de Serviço
CREATE TABLE services_vs_os (
    idService_order INT,
    idAvailable_services INT,
    PRIMARY KEY (idService_order, idAvailable_services),
    FOREIGN KEY (idService_order) REFERENCES service_order(idService_order) on delete cascade,
    FOREIGN KEY (idAvailable_services) REFERENCES available_services(idAvailable_services) on delete cascade
);




------------------------------------------------------------------------------------------------------------



-- Inserindo dados na tabela dos mecânicos
INSERT INTO mecanics (first_name, address, specialty, cep, middle_name_initial, last_name, cpf)
VALUES
('Carlos', 'Rua das Flores, 100', 'Suspensão', '12345678', 'A.', 'Silva', '12345678901'),
('Ana', 'Avenida Central, 200', 'Freios', '87654321', 'B.', 'Souza', '98765432100'),
('João', 'Rua Verde, 300', 'Motor', '11223344', 'C.', 'Pereira', '45678912345'),
('Maria', 'Avenida Azul, 400', 'Elétrica', '33445566', 'D.', 'Costa', '78912345678'),
('Pedro', 'Rua Amarela, 500', 'Pintura', '66778899', 'E.', 'Santos', '34567891234');

-- Inserindo dados na tabela das equipes de trabalho
INSERT INTO working_team (service, delivery_date)
VALUES
('Manutenção', '2025-03-01'),
('Reparo', '2025-03-05'),
('Inspeção', '2025-03-10'),
('Manutenção', '2025-03-15'),
('Reparo', '2025-03-20');

-- Inserindo dados na tabela dos clientes
INSERT INTO clients (first_name, last_name, middle_name_initial, address, cep, cpf, contact_number)
VALUES
('Lucas', 'Oliveira', 'F.', 'Rua das Orquídeas, 10', '12345678', '12312312312', '11999998888'),
('Juliana', 'Almeida', 'G.', 'Avenida das Rosas, 20', '87654321', '45645645645', '21988887777'),
('Felipe', 'Silva', NULL, 'Rua das Margaridas, 30', '11223344', '78978978978', '31977776666'),
('Carla', 'Pereira', 'H.', 'Avenida dos Lírios, 40', '33445566', '32132132132', '41966665555'),
('Bruno', 'Costa', 'I.', 'Rua dos Cravos, 50', '66778899', '65465465465', '51955554444');

-- Inserindo dados na tabela de veículos
INSERT INTO vehicle (plate, model, idClients)
VALUES
('ABC1234', 'Ford Fiesta', 1),
('DEF5678', 'Chevrolet Onix', 2),
('GHI9012', 'Volkswagen Gol', 3),
('JKL3456', 'Toyota Corolla', 4),
('MNO7890', 'Fiat Uno', 5);

-- Inserindo dados na tabela de ordens de serviço
INSERT INTO service_order (emission_date, total_cost, service_status, conclusion_date, idClients)
VALUES
('2025-03-01', 150.00, 'Concluído', '2025-03-03', 1),
('2025-03-02', 300.00, 'Em andamento', NULL, 2),
('2025-03-03', 200.00, 'Pendente', NULL, 3),
('2025-03-04', 100.00, 'Concluído', '2025-03-05', 4),
('2025-03-05', 250.00, 'Em andamento', NULL, 5);

-- Inserindo dados na tabela de custos de mão de obra
INSERT INTO labor_cost (labor_description, total_cost)
VALUES
('Troca de óleo', 50.00),
('Reparo de freios', 100.00),
('Alinhamento', 80.00),
('Balanceamento', 70.00),
('Inspeção geral', 90.00);

-- Inserindo dados na tabela de custos por peça
INSERT INTO parts_cost (parts_description, total_cost)
VALUES
('Filtro de óleo', 20.00),
('Pastilhas de freio', 50.00),
('Amortecedor', 150.00),
('Pneu', 300.00),
('Bateria', 200.00);

-- Inserindo dados na tabela de serviços disponíveis
INSERT INTO available_services (service_name, service_description)
VALUES
('Troca de Óleo', 'Substituição do óleo do motor'),
('Reparo de Freios', 'Reparo e ajuste nos freios'),
('Alinhamento', 'Alinhamento das rodas'),
('Balanceamento', 'Balanceamento das rodas'),
('Inspeção Geral', 'Verificação completa do veículo');

-- Inserindo dados na tabela mecânicos em equipes
INSERT INTO mecanics_in_team (idMecanics, idWorking_team)
VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

-- Inserindo dados na tabela de equipes versus ordens de serviço
INSERT INTO working_team_vs_os (idService_order, idWorking_team)
VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

-- Inserindo dados na tabela de custos de mão de obra por ordem de serviço
INSERT INTO labor_cost_vs_os (idService_order, idLabor_cost)
VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

-- Inserindo dados na tabela de peças por ordens de serviço
INSERT INTO parts_vs_os (idService_order, idParts_cost, parts_quantity)
VALUES
(1, 1, 2),
(2, 2, 4),
(3, 3, 1),
(4, 4, 1),
(5, 5, 2);

-- Inserindo dados na tabela de serviços disponíveis por ordens de serviço
INSERT INTO services_vs_os (idService_order, idAvailable_services)
VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);



------------------------------------------------------------------------------------------------------
-- Querries

-- SELECT
-- Recupera todos os nomes e especialidades dos mecânicos
SELECT first_name, specialty
FROM mecanics;

-- Recupera as placas e modelos de todos os veículos
SELECT plate, model
FROM vehicle;

-- WHERE
-- Filtra clientes que têm o CEP '12345678'
SELECT first_name, last_name, contact_number
FROM clients
WHERE cep = '12345678';

-- Filtra ordens de serviço que estão com status 'Em andamento'
SELECT idService_order, total_cost, service_status
FROM service_order
WHERE service_status = 'Em andamento';

-- Atributos Derivados:
-- Calcula o custo total (peça + mão de obra) para cada ordem de serviço
SELECT so.idService_order,
       (lc.total_cost + pc.total_cost) AS total_order_cost
FROM service_order so
JOIN labor_cost_vs_os lco ON so.idService_order = lco.idService_order
JOIN labor_cost lc ON lco.idLabor_cost = lc.idLabor_cost
JOIN parts_vs_os pvo ON so.idService_order = pvo.idService_order
JOIN parts_cost pc ON pvo.idParts_cost = pc.idParts_cost;

-- Adiciona um campo derivado com o nome completo dos mecânicos
SELECT CONCAT(first_name, ' ', last_name) AS full_name, specialty
FROM mecanics;

-- ORDER BY
-- Lista os clientes ordenados pelo sobrenome em ordem alfabética
SELECT first_name, last_name, contact_number
FROM clients
ORDER BY last_name ASC;

-- Lista as ordens de serviço pelo custo total em ordem decrescente
SELECT idService_order, total_cost
FROM service_order
ORDER BY total_cost DESC;

-- HAVING
-- Mostra o total de veículos por cliente, apenas para clientes com mais de 1 veículo
SELECT idClients, COUNT(idVehicle) AS total_vehicles
FROM vehicle
GROUP BY idClients
HAVING COUNT(idVehicle) > 1;

-- Soma os custos totais de mão de obra e filtra ordens com custo maior que 150
SELECT lco.idService_order, SUM(lc.total_cost) AS labor_total
FROM labor_cost_vs_os lco
JOIN labor_cost lc ON lco.idLabor_cost = lc.idLabor_cost
GROUP BY lco.idService_order
HAVING SUM(lc.total_cost) > 150;

-- JOINS
-- Recupera os nomes dos clientes, placas de veículos e status das ordens de serviço
SELECT c.first_name AS client_name, v.plate AS vehicle_plate, so.service_status
FROM clients c
JOIN vehicle v ON c.idClients = v.idClients
JOIN service_order so ON c.idClients = so.idClients;

-- Lista os mecânicos e os serviços realizados por suas equipes
SELECT m.first_name AS mechanic_name, m.specialty, wt.service AS team_service
FROM mecanics m
JOIN mecanics_in_team mit ON m.idMecanics = mit.idMecanics
JOIN working_team wt ON mit.idWorking_team = wt.idWorking_team;

-- Extras
-- Qual o total de custos de peças e serviços disponíveis para uma ordem específica?
SELECT so.idService_order, 
       SUM(pc.total_cost) AS total_parts_cost, 
       SUM(av.service_description) AS total_services
FROM service_order so
JOIN parts_vs_os pvo ON so.idService_order = pvo.idService_order
JOIN parts_cost pc ON pvo.idParts_cost = pc.idParts_cost
JOIN services_vs_os svo ON so.idService_order = svo.idService_order
JOIN available_services av ON svo.idAvailable_services = av.idAvailable_services
WHERE so.idService_order = 2;

-- Qual mecânico realizou mais serviços em equipe?
SELECT m.first_name AS mechanic_name, 
       COUNT(mit.idWorking_team) AS total_teams
FROM mecanics m
JOIN mecanics_in_team mit ON m.idMecanics = mit.idMecanics
GROUP BY m.idMecanics
ORDER BY total_teams DESC
LIMIT 1;

