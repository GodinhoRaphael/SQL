create table if not exists produtos(
id integer primary key,
nome varchar(255) unique not null,
preco real not null,
estoque unsigned integer not null
);

create table if not exists pedidos(
id integer primary key,
id_cliente integer unique not null,
data_pedido date not null,
foreign key (id_cliente) references clientes(id)
);

create table if not exists detalhes_pedido(
id integer primary key,
id_produto integer not null,
quantidade integer not null,
foreign key (id_produto) references produtos(id),
foreign key (id) references pedidos(id)
);

create table if not exists clientes(
id integer primary key,
nome varchar(255) not null,
email varchar(255) unique not null,
endereço varchar(500) not null
);

-- Inserindo dados na tabela produtos
INSERT INTO produtos (nome, preco, estoque) VALUES
('Camiseta', 20.0, 100),
('Calça Jeans', 50.0, 50),
('Tênis', 80.0, 30);

-- Inserindo dados na tabela clientes
INSERT INTO clientes (nome, email, endereço) VALUES
('João Silva', 'joao@example.com', 'Rua A, 123'),
('Maria Oliveira', 'maria@example.com', 'Av. B, 456'),
('José Santos', 'jose@example.com', 'Praça C, 789');

-- Inserindo dados na tabela pedidos
INSERT INTO pedidos (id_cliente, data_pedido) VALUES
(1, '2024-05-01'),
(2, '2024-05-02'),
(3, '2024-05-03');

-- Inserindo dados na tabela detalhes_pedido
INSERT INTO detalhes_pedido (id_produto, quantidade, id) VALUES
(1, 2, 1),
(2, 1, 2),
(3, 3, 3);


SELECT c.nome AS cliente, p.nome AS produto, dp.quantidade
FROM detalhes_pedido dp
INNER JOIN produtos p ON dp.id_produto = p.id
INNER JOIN pedidos pe ON dp.id = pe.id
INNER JOIN clientes c ON pe.id_cliente = c.id;


SELECT c.nome AS cliente, SUM(p.preco * dp.quantidade) AS total_gasto
FROM clientes c
JOIN pedidos pe ON c.id = pe.id_cliente
JOIN detalhes_pedido dp ON pe.id = dp.id
JOIN produtos p ON dp.id_produto = p.id
GROUP BY c.nome;


SELECT *
FROM produtos
WHERE preco < 20.0; 

SELECT DISTINCT clientes.nome AS nome_cliente
FROM clientes
JOIN pedidos ON clientes.id = pedidos.id_cliente
WHERE pedidos.data_pedido BETWEEN date('2024-05-01') AND date('now');