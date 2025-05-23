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
nomeEmpresa VARCHAR(45) NOT NULL,
Codigo_Ativacao INT NOT NULL,
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
INSERT INTO Empresa (nomeEmpresa, cnpj_cpf, dtCadastro, email, senha, telefone, fkFilial) VALUES
('Empresa ABC', 12345678000195,'2015-05-14 15:30:00','empresaabc@gmail.com', 'senha123', 5511987654321,1),
('Tech Solutions', 98765432000100,'2019-11-25 13:00:00','techsolutions@hotmail.com', 'senha456', 5511976543210,1),
('Logistica LTDA', 19283746500010,'2023-03-17 18:30:00','logistica.ltda@outlook.com', 'senha789', 5511965432109,1); 

-- INSERINDO DADOS DA TABELA SILO.
INSERT INTO silo (nome, tipo, fkClienteSilo, capacidadeTonelada) VALUES
('Silo A', 'Silo de concreto',1, 124),
('Silo Central', 'Silo de concreto',2, 378),
('Silo Norte', 'Silo metálico',3, 92);

-- INSERINDO DADOS DA TABELA SENSORLM35.
INSERT INTO sensorLM35 (dtInstalacao, dtManutencao, statusSensor,fkSilo)VALUES
('2025-03-05 14:30:00','2023-03-11 11:00:00','Ativo',1),
('2024-01-10 09:00:00', '2025-02-25 16:45:00', 'Inativo',2),
('2024-03-10 13:00:00', '2025-02-28 11:00:00', 'Inativo',3);

select * from dadoSensor;

-- EXIBINDO OS DADOS DA EMPRESA.
SELECT c.nomeEmpresa AS 'Nome da Empresa',
c.cnpj_cpf AS 'CPF ou CNPJ',
c.email AS 'Email',
c.senha AS 'Senha',
c.telefone AS 'Telefone',
c.dtCadastro AS 'Data de cadastro'
FROM cliente AS c;

-- SELECT COM DADOS DO SENSOR E DA TEMPERATURA.
SELECT c.nomeEmpresa AS 'Nome da empresa',
s.nome AS 'Nome do silo', s.tipo AS 'Tipo de silo', l.dtInstalacao AS 'Data de instalação do sensor',
l.dtManutencao AS 'Data de Manutenção', l. statusSensor AS 'Status do sensor' FROM
cliente AS c JOIN endereco AS e ON c.idCliente = e.fkCliente
JOIN silo AS s ON e.idEndereco = s.fkClienteSilo
JOIN sensorLM35 AS l ON s.idSilo = l.fkSilo;

-- EXIBINDO OS DADOS DAS EMPRESAS E OS DADOS DE SEUS SILOS.
SELECT c.nomeEmpresa AS 'Nome da Empresa',
c.email AS 'Email',
c.senha AS 'Senha',
c.cnpj_cpf AS 'CNPJ',
c.telefone AS 'Contato',
e.CEP,
e.rua AS 'Rua',
e.bairro AS 'Bairro',
e.cidade as 'Cidade',
e.UF,
s.nome AS 'Nome do Silo',
s.tipo AS 'Tipo de Silo',
s.capacidadeTonelada AS 'Capacidade do Silo em toneladas',
lm.statusSensor AS 'Status do sensor',
lm.dtInstalacao AS 'Data de instalação do sensor',
lm.dtManutencao AS 'Data de manutenção do sensor',
c.dtCadastro AS 'Quando se cadastrou'
FROM cliente AS c JOIN endereco AS e ON e.fkCliente = c.idCliente
JOIN silo AS s ON s.fkClienteSilo = c.idCliente
JOIN sensorLM35 AS lm ON lm.fkSilo = s.idSilo;

-- EXIBINDO DADOS DAS EMPRESAS QUE TROCARAM DE SENHA.
SELECT c.idCliente,
c.nomeEmpresa,
c.email,
r.novaSenha,
r.dtTroca
FROM recSenha r
JOIN cliente c 
ON r.fkCliRec = c.idCliente;

-- ATUALIZANDO E DELETANDO DADOS DA EMPRESA TECH SOLUTIONS.
UPDATE endereco SET rua = 'Rua Delta R' WHERE idEndereco = 2;
UPDATE endereco SET bairro = 'Dos techs' WHERE idEndereco = 2;
UPDATE endereco SET cidade = 'Rio Grande do Norte' WHERE idEndereco = 2;
UPDATE endereco SET CEP = '04849220' WHERE idEndereco = 2;
UPDATE endereco SET UF = 'RN' WHERE idEndereco = 2;

-- DELETANDO OS DADOS DA EMPRESA ABC DEVIDO AO CORTE DE CONTRATO.
DELETE FROM cliente WHERE idCliente = 1;
DELETE FROM endereco WHERE idEndereco = 1;
DELETE FROM silo WHERE idSilo = 1;
DELETE FROM sensorLM35 WHERE idSensor = 1;  