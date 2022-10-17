-- TESTANDO DATABASE
select * from projeto_enem.base;

USE  projeto_enem;

SELECT NU_NOTA_CN, NU_NOTA_CH, NU_NOTA_LC, NU_NOTA_MT, NU_NOTA_REDACAO, (NU_NOTA_CN+NU_NOTA_CH+NU_NOTA_LC+NU_NOTA_MT+NU_NOTA_REDACAO)/5 AS MAIOERSMEDIASBR
FROM projeto_enem.base ORDER BY MAIOERSMEDIASBR DESC LIMIT 10;

-- MEDIA DAS NOTAS GERAIS (RETIRANDO OS FALTANTES NOS DOIS DIAS) - GERAL FEITA NO BI
CREATE TABLE MEDIASGERAIS
SELECT avg (NU_NOTA_CN) AS MEDIACN,avg (NU_NOTA_CH) AS MEDIACH,
avg (NU_NOTA_LC) AS MEDIALC,avg (NU_NOTA_MT) AS MEDIAMT,avg (NU_NOTA_REDACAO) AS MEDIARED
FROM  projeto_enem.base WHERE TP_PRESENCA_CH =1 OR TP_PRESENCA_MT=1;

-- INSCRITOS POR ESTADO
CREATE TABLE INSCRITOSPORESTADO
SELECT SG_UF_PROVA AS UF, COUNT(*) INSCRITOSPORESTADO FROM projeto_enem.base GROUP BY SG_UF_PROVA
ORDER BY INSCRITOSPORESTADO DESC;

-- INSCRITOS POR FAIXA ETARIA    
CREATE TABLE INSCRITOSPORFAIXAETARIA
SELECT TP_FAIXA_ETARIA AS FXETARIA, COUNT(*) INSCRITOSPORFXET FROM projeto_enem.base GROUP BY TP_FAIXA_ETARIA
ORDER BY INSCRITOSPORFXET DESC;

-- INSCRITOS POR TIPOESCOLA
CREATE TABLE INSCRITOSPORTIPOESCOLA
SELECT  TP_ESCOLA AS TIPOESCOLA, COUNT(*) INSCRITOSPORTPESC FROM projeto_enem.base GROUP BY TP_ESCOLA
ORDER BY INSCRITOSPORTPESC DESC;

-- AUSENTES
CREATE TABLE PORCENTAGEMDEAUSENTES
SELECT (FALTANTES/2000000)*100 AS PORCENTAGEMFALTANTES FROM(
SELECT COUNT(*) AS FALTANTES FROM projeto_enem.base
WHERE TP_PRESENCA_CH = 0 AND TP_PRESENCA_MT= 0) AS SUB1;

 -- ALUNOS COM MAIOR MEDIA DE NOTAS BR
CREATE TABLE MAIOERSMEDIASBR
SELECT MAIOERSMEDIASBR
FROM (SELECT NU_NOTA_CN, NU_NOTA_CH, NU_NOTA_LC, NU_NOTA_MT, NU_NOTA_REDACAO, (NU_NOTA_CN+NU_NOTA_CH+NU_NOTA_LC+NU_NOTA_MT+NU_NOTA_REDACAO)/5 AS MAIOERSMEDIASBR
FROM projeto_enem.base ORDER BY MAIOERSMEDIASBR DESC LIMIT 10) AS SUB1;

-- ALUNOS COM MAIOR MEDIA DE NOTAS AL/RELAÇÃO MEDIA DE NOTAS E TP_ENSINO
CREATE TABLE MAIOERSMEDIASAL
SELECT MAIOERSMEDIASAL, TP_ESCOLA AS TIPOESCOLA
FROM (SELECT TP_ESCOLA,NU_NOTA_CN, NU_NOTA_CH, NU_NOTA_LC, NU_NOTA_MT, NU_NOTA_REDACAO, (NU_NOTA_CN+NU_NOTA_CH+NU_NOTA_LC+NU_NOTA_MT+NU_NOTA_REDACAO)/5 AS MAIOERSMEDIASAL
FROM projeto_enem.base WHERE SG_UF_ESC='AL'  ORDER BY MAIOERSMEDIASAL DESC LIMIT 50) AS SUB1;


-- Perfil dos alunos com as notas abaixo da média (SEXO, ETNIA, FAIXA ETARIA)
-- FOI NECESSÁRIA A CRIAÇÃO DA TABLE 
/*DROP TABLE MEDIAPORALUNO;
USE projeto_enem;
CREATE TABLE MEDIAPORALUNO 
SELECT TP_SEXO, TP_COR_RACA, TP_FAIXA_ETARIA, TP_ESCOLA, (NU_NOTA_CN+NU_NOTA_CH+NU_NOTA_LC+NU_NOTA_MT+NU_NOTA_REDACAO)/5 AS MEDIADOALUNO
FROM projeto_enem.base;
*/
-- VOLTANDO AO PERFIL 
CREATE TABLE PERFILABAIXODAMEDIA
SELECT TP_SEXO, TP_COR_RACA, TP_FAIXA_ETARIA, TP_ESCOLA, MEDIADOALUNO FROM projeto_enem.MEDIAPORALUNO WHERE MEDIADOALUNO < (
SELECT (MEDIACN+MEDIACH+MEDIALC+MEDIAMT+MEDIARED)/5 MEDIAGERAL FROM(
SELECT avg (NU_NOTA_CN) AS MEDIACN,avg (NU_NOTA_CH) AS MEDIACH,
avg (NU_NOTA_LC) AS MEDIALC,avg (NU_NOTA_MT) AS MEDIAMT,avg (NU_NOTA_REDACAO) AS MEDIARED
FROM  projeto_enem.base WHERE TP_PRESENCA_CH =1 OR TP_PRESENCA_MT=1) AS SUB1);

--  RANKING DOS MELHORES ALUNOS DE ALAGOAS POR DISCIPLINA
-- CN
CREATE TABLE MELHORALCN
SELECT NU_NOTA_CN
FROM projeto_enem.base WHERE SG_UF_ESC ='AL' ORDER BY NU_NOTA_CN DESC LIMIT 20;
-- CH
CREATE TABLE MELHORALCH
SELECT NU_NOTA_CH
FROM projeto_enem.base WHERE SG_UF_ESC ='AL' ORDER BY NU_NOTA_CH DESC LIMIT 20;
-- LC
CREATE TABLE MELHORALLC
SELECT NU_NOTA_LC
FROM projeto_enem.base WHERE SG_UF_ESC ='AL' ORDER BY NU_NOTA_LC DESC LIMIT 20;
-- MT
CREATE TABLE MELHORALMT
SELECT NU_NOTA_MT
FROM projeto_enem.base WHERE SG_UF_ESC ='AL' ORDER BY NU_NOTA_MT DESC LIMIT 20;
-- REDACAO
CREATE TABLE MELHORALRED
SELECT NU_NOTA_REDACAO
FROM projeto_enem.base WHERE SG_UF_ESC ='AL' ORDER BY NU_NOTA_REDACAO DESC LIMIT 20;

--  MEDIA POR ESCOLAS
CREATE TABLE mediaporescolas
SELECT (NU_NOTA_CN+NU_NOTA_CH+NU_NOTA_LC+NU_NOTA_MT+NU_NOTA_REDACAO)/5 MEDIAGERAL, CO_MUNICIPIO_ESC AS CODIGODAESCOLA, SG_UF_ESC
FROM projeto_enem.base GROUP BY CO_MUNICIPIO_ESC ORDER BY MEDIAGERAL DESC LIMIT 10;


		