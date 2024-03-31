/******************/
/* Criar tabelas */
/*************************************/

CREATE SCHEMA kart;

-- Eventos
CREATE TABLE kart.eventos AS
SELECT *
FROM read_csv('csv\eventos.csv');

-- Corridas
CREATE TABLE kart.corridas AS
SELECT *
FROM read_csv('csv\corridas.csv');

-- Pilotos
CREATE TABLE kart.pilotos AS
SELECT *
FROM read_csv('csv\pilotos.csv');

-- Resultados
CREATE TABLE kart.resultados AS
SELECT *
FROM read_csv('csv\resultados.csv');

-- Tempo de voltas
CREATE TABLE kart.tempo_voltas AS
SELECT *
FROM read_csv('csv\tempo_voltas.csv');


/*********************/
/* Validar inserção */
/*************************************/

SELECT * FROM kart.corridas  LIMIT 100;
SELECT * FROM kart.eventos LIMIT 100;
SELECT * FROM kart.pilotos LIMIT 100;
SELECT * FROM kart.resultados LIMIT 100;
SELECT * FROM kart.tempo_voltas LIMIT 100;

/************************/
/* Exemplo de análises */
/*************************************/

-- Quantidade de pilotos
SELECT COUNT(*) AS qtde_pilotos FROM kart.pilotos;

-- Quantidade de eventos por tipo
SELECT CASE tp_evento
		WHEN 0 THEN 'Aberto'
		WHEN 1 THEN 'Grupo fechado'
	   END AS tipo_evento
	  ,COUNT(*) AS qtde_eventos
FROM kart.eventos 
GROUP BY tp_evento;

-- Velocidade média por kart
SELECT num_kart 
	  ,AVG(velocidade_media) AS velocidade_media 
FROM kart.resultados
GROUP BY num_kart
ORDER BY 2 DESC;

-- Média de voltas por corrida e categoria
SELECT CASE res.categoria 
		WHEN 1 THEN 'Kart 13 HP'
		ELSE 'Outras categorias'
	   END AS categoria
	  ,AVG(tes.num_volta) media_voltas
FROM kart.corridas  cos
INNER JOIN kart.resultados res
	ON cos.sk_corrida = res.fk_corrida 
INNER JOIN kart.tempo_voltas tes
	ON res.sk_resultado = tes.fk_resultado
WHERE cos.tp_corrida = 4
GROUP BY res.categoria;