use oficina_mecanica;

-- Inserindo clientes
INSERT INTO Cliente (Nome, Telefone, Endereco, Email) VALUES
('João Silva', '(11) 9999-8888', 'Rua A, 123 - São Paulo', 'joao.silva@email.com'),
('Maria Oliveira', '(11) 7777-6666', 'Av. B, 456 - São Paulo', 'maria.oliveira@email.com'),
('Carlos Souza', '(11) 5555-4444', 'Rua C, 789 - São Paulo', 'carlos.souza@email.com'),
('Ana Santos', '(11) 3333-2222', 'Av. D, 101 - São Paulo', 'ana.santos@email.com'),
('Pedro Costa', '(11) 1111-0000', 'Rua E, 202 - São Paulo', 'pedro.costa@email.com');

-- Inserindo veículos (relacionados aos clientes)
INSERT INTO Veiculo (Placa, Modelo, Marca, Ano, IdCliente) VALUES
('ABC-1234', 'Gol', 'Volkswagen', 2018, 1),
('DEF-5678', 'Onix', 'Chevrolet', 2020, 2),
('GHI-9012', 'HB20', 'Hyundai', 2019, 3),
('JKL-3456', 'Corolla', 'Toyota', 2021, 4),
('MNO-7890', 'Civic', 'Honda', 2017, 5);

-- Inserindo equipes de mecânicos
INSERT INTO Equipe (NomeEquipe) VALUES
('Equipe Motor'),
('Equipe Elétrica'),
('Equipe Suspensão'),
('Equipe Freios'),
('Equipe Geral');

-- Inserindo mecânicos
INSERT INTO Mecanico (Nome, Especialidade) VALUES
('Roberto Alves', 'Motor'),
('Fernando Lima', 'Elétrica'),
('Marcos Santos', 'Suspensão'),
('Paulo Oliveira', 'Freios'),
('Lucas Costa', 'Geral'),
('Antonio Pereira', 'Motor'),
('Ricardo Mendes', 'Elétrica');

-- Associando mecânicos às equipes
INSERT INTO MecanicoEquipe (IdMecanico, IdEquipe) VALUES
(1, 1), -- Roberto na Equipe Motor
(6, 1), -- Antonio na Equipe Motor
(2, 2), -- Fernando na Equipe Elétrica
(7, 2), -- Ricardo na Equipe Elétrica
(3, 3), -- Marcos na Equipe Suspensão
(4, 4), -- Paulo na Equipe Freios
(5, 5); -- Lucas na Equipe Geral

-- Inserindo serviços
INSERT INTO Servico (Descricao, Valor, IdEquipe) VALUES
('Troca de óleo', 150.00, 1),
('Reparo no motor', 800.00, 1),
('Troca de bateria', 300.00, 2),
('Reparo na parte elétrica', 450.00, 2),
('Alinhamento e balanceamento', 200.00, 3),
('Troca de amortecedores', 600.00, 3),
('Troca de pastilhas de freio', 250.00, 4),
('Revisão geral', 350.00, 5),
('Diagnóstico eletrônico', 180.00, 2),
('Troca de correia dentada', 500.00, 1);

-- Inserindo ordens de serviço
INSERT INTO OrdemServico (DataRecebimento, DataEntregaPrevista, Status, IdVeiculo) VALUES
('2023-10-01', '2023-10-03', 'Concluído', 1),
('2023-10-02', '2023-10-05', 'Em andamento', 2),
('2023-10-03', '2023-10-06', 'Em andamento', 3),
('2023-10-04', '2023-10-07', 'Aguardando peças', 4),
('2023-10-05', '2023-10-08', 'Aguardando aprovação', 5);

-- Inserindo pagamentos
INSERT INTO Pagamento (ValorTotal, FormaPagamento, StatusPagamento) VALUES
(300.00, 'Cartão de crédito', 'Pago'),
(450.00, 'Pix', 'Pago'),
(800.00, 'Dinheiro', 'Pendente'),
(250.00, 'Cartão de débito', 'Pago'),
(350.00, 'Boleto', 'Pendente');

-- Inserindo itens da ordem de serviço (relacionando serviços, ordens e pagamentos)
INSERT INTO ItensOrdemServico (IdOrdemServico, IdServico, Quantidade, Subtotal, IdPagamento) VALUES
(1, 1, 1, 150.00, 1),   -- Troca de óleo
(1, 3, 1, 300.00, 1),   -- Troca de bateria
(2, 2, 1, 800.00, 3),   -- Reparo no motor
(3, 4, 1, 450.00, 2),   -- Reparo elétrico
(4, 7, 1, 250.00, 4),   -- Pastilhas de freio
(5, 8, 1, 350.00, 5);   -- Revisão geral


-- Consulta para ver ordens de serviço com detalhes do cliente e veículo
SELECT 
    os.IdOrdemServico,
    c.Nome AS Cliente,
    v.Modelo AS Veiculo,
    os.DataRecebimento,
    os.DataEntregaPrevista,
    os.Status
FROM OrdemServico os
JOIN Veiculo v ON os.IdVeiculo = v.IdVeiculo
JOIN Cliente c ON v.IdCliente = c.IdCliente;

-- Consulta para ver serviços realizados em cada ordem
SELECT 
    os.IdOrdemServico,
    s.Descricao AS Servico,
    ios.Quantidade,
    ios.Subtotal,
    p.ValorTotal,
    p.FormaPagamento,
    p.StatusPagamento
FROM ItensOrdemServico ios
JOIN OrdemServico os ON ios.IdOrdemServico = os.IdOrdemServico
JOIN Servico s ON ios.IdServico = s.IdServico
LEFT JOIN Pagamento p ON ios.IdPagamento = p.IdPagamento;

-- Consulta para ver a equipe e mecânicos responsáveis por cada tipo de serviço
SELECT 
    e.NomeEquipe,
    m.Nomo AS Mecanico,
    m.Especialidade,
    s.Descricao AS Servico
FROM Servico s
JOIN Equipe e ON s.IdEquipe = e.IdEquipe
JOIN MecanicoEquipe me ON e.IdEquipe = me.IdEquipe
JOIN Mecanico m ON me.IdMecanico = m.IdMecanico;