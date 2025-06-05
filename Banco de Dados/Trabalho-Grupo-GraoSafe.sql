-- CRIANDO O BANCO DE DADOS
CREATE DATABASE GraoSafe;
USE GraoSafe;
DROP DATABASE GraoSafe;

-- CRIAÇÃO DA TABELA CLIENTE (USUÁRIO)
CREATE TABLE usuario (
    idUsuario INT PRIMARY KEY AUTO_INCREMENT, -- AUTO_INCREMENT para o idUsuario
    nome VARCHAR(50) NOT NULL, -- Nome do usuário
    email VARCHAR(100) NOT NULL UNIQUE, -- E-mail único
    CONSTRAINT checkEmail CHECK (email LIKE '%@%'), -- Validação simples para e-mail
    senha VARCHAR(100) NOT NULL, -- Senha
    telefone VARCHAR(14) UNIQUE NOT NULL -- Telefone único
);

-- CRIAÇÃO DA TABELA EMPRESA (corrigindo o tipo da coluna codigo_ativacao)
CREATE TABLE empresa (
    idEmpresa INT PRIMARY KEY AUTO_INCREMENT, -- AUTO_INCREMENT para idEmpresa
    nome VARCHAR(45) NOT NULL, -- Nome da empresa
    codigo_ativacao VARCHAR(20) NOT NULL, -- Altere para VARCHAR(20) para suportar códigos alfanuméricos
    dtCadastro DATETIME DEFAULT CURRENT_TIMESTAMP, -- Data de cadastro com valor default
    cnpj CHAR(14) NOT NULL, -- CNPJ da empresa
    cep CHAR(8) NOT NULL, -- CEP da empresa
    estado VARCHAR(45), -- Estado
    uf CHAR(2), -- UF (Unidade Federativa)
    cidade VARCHAR(45), -- Cidade
    fkFilial INT NOT NULL, -- Filial
    fkUsuario INT NOT NULL, -- ID do usuário associado
    CONSTRAINT fkFilial FOREIGN KEY (fkFilial) REFERENCES empresa(idEmpresa), -- Chave estrangeira para a filial
    CONSTRAINT fkUsuario FOREIGN KEY (fkUsuario) REFERENCES usuario(idUsuario) -- Chave estrangeira para o usuário
);


-- CRIAÇÃO DA TABELA SILO
CREATE TABLE silo (
    idSilo INT PRIMARY KEY AUTO_INCREMENT, -- AUTO_INCREMENT para idSilo
    tipo VARCHAR(50) NOT NULL, -- Tipo de silo
    CONSTRAINT chkTipo CHECK (tipo IN ('Silo metálico', 'Silo de alvenaria', 'Silo de concreto', 'Silos bolsa', 'Armazém graneleiro')), -- Validação do tipo de silo
    fkEmpSilo INT NOT NULL, -- ID da empresa associada ao silo
    CONSTRAINT fkEmpSilo FOREIGN KEY (fkEmpSilo) REFERENCES empresa(idEmpresa), -- Chave estrangeira para a empresa
    capacidadeTonelada INT NOT NULL -- Capacidade do silo em toneladas
);

-- CRIAÇÃO DA TABELA SENSOR LM35
CREATE TABLE sensor (
    idSensor INT PRIMARY KEY AUTO_INCREMENT, -- AUTO_INCREMENT para idSensor
    tipo VARCHAR(45), -- Tipo do sensor (ex: LM35)
    dtInstalacao DATETIME, -- Data de instalação do sensor
    dtManutencao DATETIME, -- Data de manutenção do sensor
    statusSensor VARCHAR(50), -- Status do sensor
    CONSTRAINT chkStatus CHECK (statusSensor IN ('Ativo', 'Inativo', 'Manutenção')), -- Validação do status
    CONSTRAINT chkTipoSensor CHECK (tipo IN ('LM35')), -- Validação do tipo de sensor (só LM35 por enquanto)
    fkSilo INT NOT NULL, -- ID do silo ao qual o sensor está associado
    CONSTRAINT fkSiloSensor FOREIGN KEY (fkSilo) REFERENCES silo(idSilo) -- Chave estrangeira para o silo
);

-- CRIAÇÃO DA TABELA DADOSENSOR (Leitura de Temperatura)
CREATE TABLE medida (
    idMedida INT PRIMARY KEY AUTO_INCREMENT, -- AUTO_INCREMENT para idMedida
    temperatura FLOAT NOT NULL, -- Temperatura medida pelo sensor
    dtHora DATETIME DEFAULT CURRENT_TIMESTAMP, -- Data e hora da medição
    fkSensor INT NOT NULL, -- ID do sensor que fez a medição
    CONSTRAINT fkSensor FOREIGN KEY (fkSensor) REFERENCES sensor(idSensor) -- Chave estrangeira para o sensor
);
-- CRIAÇÃO DA TABELA ALERTA
CREATE TABLE alerta(
    idAlerta INT primary key auto_increment,
    fkSensor INT,
    tempAlerta FLOAT,
    dtAlerta DATETIME DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fkSensorAlerta FOREIGN KEY (fkSensor) REFERENCES sensor(idSensor)
);
 
-- INSERÇÃO DE DADOS NA TABELA USUARIO (Cliente)
INSERT INTO usuario (nome, email, senha, telefone) VALUES
('João Silva', 'joao@empresa.com', 'senha123', '11999999999'),
('Maria Souza', 'maria@tech.com', 'senha456', '11988888888'),
('Carlos Pereira', 'carlos@logistica.com', 'senha789', '11977777777');

-- INSERÇÃO DE DADOS NA TABELA EMPRESA (agora com codigo_ativacao como VARCHAR)
INSERT INTO empresa (nome, codigo_ativacao, dtCadastro, fkFilial, fkUsuario, cnpj, cep, estado, uf, cidade) VALUES
('Empresa ABC', 'HIJ901', '2015-05-14 15:30:00', 1, 1, '12345678000195', '12345678', 'São Paulo', 'SP', 'São Paulo'),
('Tech Solutions', 'EFG678', '2019-11-25 13:00:00', 1, 2, '98765432000100', '87654321', 'Rio de Janeiro', 'RJ', 'Rio de Janeiro'),
('Logistica LTDA', 'ABC456', '2023-03-17 18:30:00', 1, 3, '19283746500010', '11223344', 'Belo Horizonte', 'MG', 'Minas Gerais');


-- INSERÇÃO DE DADOS NA TABELA SILO
INSERT INTO silo (tipo, fkEmpSilo, capacidadeTonelada) VALUES
('Silo de concreto', 1, 124),
('Silo de concreto', 2, 378),
('Silo metálico', 3, 92);

-- INSERÇÃO DE DADOS NA TABELA SENSOR LM35
INSERT INTO sensor (tipo, dtInstalacao, dtManutencao, statusSensor, fkSilo) VALUES
('LM35', '2025-03-05 14:30:00', '2023-03-11 11:00:00', 'Ativo', 1),
('LM35', '2024-01-10 09:00:00', '2025-02-25 16:45:00', 'Inativo', 2),
('LM35', '2024-03-10 13:00:00', '2025-02-28 11:00:00', 'Inativo', 3);

-- EXIBINDO OS DADOS DAS EMPRESAS E SEUS DADOS DE SILOS E SENSOR
SELECT 
    e.nome AS 'Nome da Empresa',
    u.email AS 'Email',
    u.senha AS 'Senha',
    e.cnpj AS 'CNPJ',
    u.telefone AS 'Contato',
    e.cep AS 'CEP',
    e.cidade AS 'Cidade',
    e.uf AS 'UF',
    e.estado AS 'Estado',
    s.tipo AS 'Tipo de Silo',
    s.capacidadeTonelada AS 'Capacidade do Silo em toneladas',
    lm.statusSensor AS 'Status do Sensor',
    lm.dtInstalacao AS 'Data de Instalação do Sensor',
    lm.dtManutencao AS 'Data de Manutenção do Sensor',
    e.dtCadastro AS 'Data de Cadastro da Empresa'
FROM 
    usuario AS u 
JOIN empresa AS e ON e.fkUsuario = u.idUsuario
JOIN silo AS s ON s.fkEmpSilo = e.idEmpresa
JOIN sensor AS lm ON lm.fkSilo = s.idSilo;
