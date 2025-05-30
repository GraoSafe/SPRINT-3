-- CRIANDO O BANCO DE DADOS.
CREATE DATABASE GraoSafe;
USE GraoSafe;

-- CRIAÇÃO DA TABELA CLIENTE.
CREATE TABLE usuario(
idUsuario INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(50) NOT NULL,
email VARCHAR(100) NOT NULL UNIQUE, 
CONSTRAINT checkEmail check(email LIKE '%@%'),
senha VARCHAR(100) NOT NULL,
telefone VARCHAR(14) UNIQUE NOT NULL
);

-- CRIAÇÃO DA TABELA EMPRESA.
CREATE TABLE empresa(
idEmpresa INT PRIMARY KEY NOT NULL,
nome VARCHAR(45) NOT NULL,
codigo_ativacao INT NOT NULL,
dtCadastro DATETIME DEFAULT CURRENT_TIMESTAMP,
CNPJ CHAR(14) NOT NULL,
CEP CHAR(8) NOT NULL,
estado VARCHAR(45),
UF CHAR(2),
cidade VARCHAR(45),
fkFilial INT NOT NULL,
fkUsuario INT NOT NULL,
CONSTRAINT fkFilial FOREIGN KEY (fkFilial) REFERENCES empresa(idEmpresa),
CONSTRAINT fkUsuario FOREIGN KEY (fkUsuario) REFERENCES usuario(idUsuario)
);

-- CRIAÇÃO DA TABELA SILO.
CREATE TABLE silo(
idSilo INT PRIMARY KEY AUTO_INCREMENT,
tipo VARCHAR (50) NOT NULL,
CONSTRAINT chkTipo CHECK(tipo IN('Silo metálico', 'Silo de alvenaria', 'Silo de concreto', 'Silos bolsa', 'Armazém graneleiro')),
fkEmpSilo INT NOT NULL,
CONSTRAINT fkEmpSilo FOREIGN KEY (fkEmpSilo) REFERENCES empresa(idEmpresa),
capacidadeTonelada INT NOT NULL
);

-- CRIAÇÃO DA TABELA SENSORLM35.
CREATE TABLE sensor(
idSensor INT PRIMARY KEY AUTO_INCREMENT,
tipo VARCHAR(45),
dtInstalacao DATETIME,
dtManutencao DATETIME,
statusSensor VARCHAR (50),
CONSTRAINT chkStatus CHECK (statusSensor IN ('Ativo', 'Inativo', 'Manutenção')),
CONSTRAINT chkTipoSensor CHECK (tipo IN ('LM35')),
fkSilo INT NOT NULL,
CONSTRAINT fkSiloSensor FOREIGN KEY (fkSilo) REFERENCES silo(idSilo)
);

-- CRIAÇÃO DA TABELA DADOSENSOR.
CREATE TABLE medida(
idMedida INT PRIMARY KEY AUTO_INCREMENT,
temperatura FLOAT NOT NULL,
dtHora DATETIME DEFAULT CURRENT_TIMESTAMP,
fkSensor INT NOT NULL,
CONSTRAINT fkSensor FOREIGN KEY (fkSensor) REFERENCES sensor(idSensor)
);

-- INSERINDO DADOS DA TABELA CLIENTE.
INSERT INTO empresa (nome, codigo_ativacao, CPNJ, dtCadastro, fkFilial, fkUsuario) VALUES
('Empresa ABC','HIJ901', 12345678000195,'2015-05-14 15:30:00',1,1),
('Tech Solutions','EFG678', 98765432000100,'2019-11-25 13:00:00',1,2),
('Logistica LTDA','ABC456',19283746500010,'2023-03-17 18:30:00',1,3); 

-- INSERINDO DADOS DA TABELA SILO.
INSERT INTO silo (nome, tipo, fkEmpSilo, capacidadeTonelada) VALUES
('Silo A', 'Silo de concreto',1, 124),
('Silo Central', 'Silo de concreto',2, 378),
('Silo Norte', 'Silo metálico',3, 92);

-- INSERINDO DADOS DA TABELA SENSORLM35.
INSERT INTO sensor (dtInstalacao, dtManutencao, statusSensor,fkSilo) VALUES
('2025-03-05 14:30:00','2023-03-11 11:00:00','Ativo',1),
('2024-01-10 09:00:00', '2025-02-25 16:45:00', 'Inativo',2),
('2024-03-10 13:00:00', '2025-02-28 11:00:00', 'Inativo',3);

-- EXIBINDO OS DADOS DA EMPRESA CADASTRADA.
SELECT e.nome AS 'Nome da Empresa',
e.CNPJ,
u.email AS 'Email',
u.senha AS 'Senha',
u.telefone AS 'Telefone',
e.dtCadastro AS 'Data de cadastro'
FROM empresa AS e
LEFT JOIN usuario AS u
ON e.fkUsuario = u.idUsuario;

-- SELECT COM DADOS DO SENSOR E DA TEMPERATURA.
SELECT e.nome AS 'Nome da empresa',
s.nome AS 'Nome do silo', s.tipo AS 'Tipo de silo', l.dtInstalacao AS 'Data de instalação do sensor',
l.dtManutencao AS 'Data de Manutenção', l.statusSensor AS 'Status do sensor' FROM
empresa AS e JOIN silo AS s ON e.idEmpresa = s.fkEmpSilo
JOIN sensor AS l ON s.idSilo = l.fkSilo;

-- EXIBINDO OS DADOS DAS EMPRESAS E OS DADOS DE SEUS SILOS.
SELECT e.nome AS 'Nome da Empresa',
u.email AS 'Email',
u.senha AS 'Senha',
e.CNPJ,
u.telefone AS 'Contato',
e.CEP,
e.cidade as 'Cidade',
e.UF,
e.estado as 'Estado',
s.nome AS 'Nome do Silo',
s.tipo AS 'Tipo de Silo',
s.capacidadeTonelada AS 'Capacidade do Silo em toneladas',
lm.statusSensor AS 'Status do sensor',
lm.dtInstalacao AS 'Data de instalação do sensor',
lm.dtManutencao AS 'Data de manutenção do sensor',
e.dtCadastro AS 'Quando se cadastrou'
FROM usuario AS u JOIN empresa AS e ON e.fkUsuario = u.idUsuario
JOIN silo AS s ON s. fkEmpSilo = e.idEmpresa
JOIN sensor AS lm ON lm.fkSiloSensor = s.idSilo;

-- DELETANDO OS DADOS DA EMPRESA ABC DEVIDO AO CORTE DE CONTRATO.
DELETE FROM usuario WHERE idUsuario = 1;
DELETE FROM empresa WHERE idEmpresa = 1;
DELETE FROM silo WHERE idSilo = 1;
DELETE FROM sensor WHERE idSensor = 1;  

-- SELECT PARA MOSTRAR OS DADOS DO SENSOR
select * from medida;