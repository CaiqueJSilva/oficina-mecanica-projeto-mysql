CREATE DATABASE IF NOT EXISTS oficina_mecanica;
USE oficina_mecanica;

-- Tabela Cliente
CREATE TABLE Cliente (
    IdCliente INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(45) NOT NULL,
    Telefone VARCHAR(45),
    Endereco VARCHAR(45),
    Email VARCHAR(45)
);

-- Tabela Veiculo
CREATE TABLE Veiculo (
    IdVeiculo INT AUTO_INCREMENT PRIMARY KEY,
    Placa VARCHAR(45) NOT NULL,
    Modelo VARCHAR(45) NOT NULL,
    Marca VARCHAR(45) NOT NULL,
    Ano INT,
    IdCliente INT,
    FOREIGN KEY (IdCliente) REFERENCES Cliente(IdCliente)
);

-- Tabela OrdemServico
CREATE TABLE OrdemServico (
    IdOrdemServico INT AUTO_INCREMENT PRIMARY KEY,
    DataRecebimento DATE NOT NULL,
    DataEntregaPrevista DATE,
    Status VARCHAR(45),
    IdVeiculo INT,
    FOREIGN KEY (IdVeiculo) REFERENCES Veiculo(IdVeiculo)
);

-- Tabela Mecanico
CREATE TABLE Mecanico (
    IdMecanico INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(45) NOT NULL,
    Especialidade VARCHAR(45)
);

-- Tabela Equipe
CREATE TABLE Equipe (
    IdEquipe INT AUTO_INCREMENT PRIMARY KEY,
    NomeEquipe VARCHAR(45) NOT NULL
);

-- Tabela de relacionamento entre Mecanico e Equipe
CREATE TABLE MecanicoEquipe (
    IdMecanico INT,
    IdEquipe INT,
    PRIMARY KEY (IdMecanico, IdEquipe),
    FOREIGN KEY (IdMecanico) REFERENCES Mecanico(IdMecanico),
    FOREIGN KEY (IdEquipe) REFERENCES Equipe(IdEquipe)
);

-- Tabela Servico
CREATE TABLE Servico (
    IdServico INT AUTO_INCREMENT PRIMARY KEY,
    Descricao VARCHAR(45) NOT NULL,
    Valor DECIMAL(10,2) NOT NULL,
    IdEquipe INT,
    FOREIGN KEY (IdEquipe) REFERENCES Equipe(IdEquipe)
);

-- Tabela Pagamento
CREATE TABLE Pagamento (
    IdPagamento INT AUTO_INCREMENT PRIMARY KEY,
    ValorTotal DECIMAL(10,2) NOT NULL,
    FormaPagamento VARCHAR(45) NOT NULL,
    StatusPagamento VARCHAR(45) NOT NULL
);

-- Tabela ItensOrdemServico (tabela de relacionamento entre OrdemServico, Servico e Pagamento)
CREATE TABLE ItensOrdemServico (
    IdOrdemServico INT,
    IdServico INT,
    Quantidade INT NOT NULL DEFAULT 1,
    Subtotal DECIMAL(10,2) NOT NULL,
    IdPagamento INT,
    PRIMARY KEY (IdOrdemServico, IdServico),
    FOREIGN KEY (IdOrdemServico) REFERENCES OrdemServico(IdOrdemServico),
    FOREIGN KEY (IdServico) REFERENCES Servico(IdServico),
    FOREIGN KEY (IdPagamento) REFERENCES Pagamento(IdPagamento)
);