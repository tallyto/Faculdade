-- 1.	Crie a base sakila usando o script que vimos nas aulas passadas

mysql -u root -p < sakila.sql

-- 2.	Qual é o nome e a duração dos filmes cuja duração é maior que a média?

SELECT 
  filme.titulo as filme,
  filme.duracao_do_filme as duracao
FROM filme
WHERE filme.duracao_do_filme > (SELECT AVG(filme.duracao_do_filme) FROM filme);

-- 3.	Quantas lojas tem a videolocadora?

SELECT COUNT(loja_id) as lojas FROM loja;

-- 4.	Em que cidades ficam estas lojas?

SELECT 
  loja.loja_id as loja,
  endereco.endereco, 
  endereco.bairro, 
  cidade.cidade as cidade, 
  pais.pais as pais 
FROM endereco 
INNER JOIN cidade ON endereco.cidade_id = cidade.cidade_id 
INNER JOIN pais ON cidade.pais_id = pais.pais_id 
INNER JOIN loja ON endereco.endereco_id = loja.endereco_id;

-- 5.	Qual das lojas tem mais clientes?

SELECT 
  loja.loja_id as loja,
  COUNT(cliente.cliente_id) as clientes
FROM loja
INNER JOIN cliente ON loja.loja_id = cliente.loja_id
GROUP BY loja.loja_id
ORDER BY clientes DESC
LIMIT 1;

-- 6.	Quantos funcionários trabalham em cada loja?

SELECT 
  loja.loja_id as loja,
  COUNT(funcionario.funcionario_id) as funcionarios
FROM loja
INNER JOIN funcionario ON loja.loja_id = funcionario.loja_id
GROUP BY loja.loja_id
ORDER BY funcionarios DESC;

-- 7.	Quais são as categorias dos filmes cujo nome começa com a letra A?

SELECT 
  categoria.categoria_id as categoria,
  categoria.nome as nome_categoria,
  filme.titulo as filme
FROM categoria
INNER JOIN filme_categoria ON categoria.categoria_id = filme_categoria.categoria_id
INNER JOIN filme ON filme_categoria.filme_id = filme.filme_id
WHERE filme.titulo LIKE 'A%';

-- 8.	Quais atores trabalham no filme cujo título é ‘LAMBS CINCINATTI’?

SELECT 
  ator.ator_id as ator,
  ator.primeiro_nome as primeiro_nome,
  ator.ultimo_nome as ultimo_nome,
  filme.titulo as filme
FROM ator
INNER JOIN filme_ator ON ator.ator_id = filme_ator.ator_id
INNER JOIN filme ON filme_ator.filme_id = filme.filme_id
WHERE filme.titulo = 'LAMBS CINCINATTI';

-- 9.	Qual o nome dos atores que trabalham em filmes de classificação mais restrita? Recupere também o título, a descrição e a classificação dos filmes correspondentes. 

SELECT 
  ator.ator_id as ator,
  ator.primeiro_nome as nome,
  ator.ultimo_nome as sobrenome,
  filme.titulo as filme,
  filme.descricao as descricao,
  filme.classificacao as classificacao
FROM ator
INNER JOIN filme_ator ON ator.ator_id = filme_ator.ator_id
INNER JOIN filme ON filme_ator.filme_id = filme.filme_id
WHERE filme.classificacao = 'R';

-- 10.	Qual cliente gastou mais locações? Qual o cliente que fez mais locações?

-- Qual cliente gastou mais locações?
SELECT 
  cliente.cliente_id as cliente,
  cliente.primeiro_nome as nome,
  cliente.ultimo_nome as sobrenome,
  SUM(pagamento.valor) as valor_total
FROM cliente
INNER JOIN aluguel ON cliente.cliente_id = aluguel.cliente_id
INNER JOIN pagamento ON aluguel.aluguel_id = pagamento.aluguel_id
GROUP BY cliente.cliente_id
ORDER BY valor_total DESC
LIMIT 1;

-- Qual o cliente que fez mais locações?
SELECT 
  cliente.cliente_id as cliente,
  cliente.primeiro_nome as nome,
  cliente.ultimo_nome as sobrenome,
  COUNT(aluguel.aluguel_id) as locacoes
FROM cliente
INNER JOIN aluguel ON cliente.cliente_id = aluguel.cliente_id
GROUP BY cliente.cliente_id
ORDER BY locacoes DESC
LIMIT 1;