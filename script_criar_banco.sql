CREATE SCHEMA palhaco_db;
USE palhaco_db;
/*TABELA CIRCO*/
CREATE TABLE IF NOT EXISTS circo(
id_circo INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(100),
cidade VARCHAR(100),
lotacao VARCHAR(100),
data_inicio DATE
);
/*TABELA PALHAÇO*/
CREATE TABLE IF NOT EXISTS palhaco(
id_palhaco 	    INT PRIMARY KEY AUTO_INCREMENT,
nome 		   	VARCHAR(100) NOT NULL,
nome_artistico 	VARCHAR(100) NOT NULL,
data_nascimento DATE NOT NULL,
especialidade 	INT NOT NULL,
id_circo 		INT,
CONSTRAINT fk_palhaco_circo FOREIGN KEY (id_circo) REFERENCES circo(id_circo)
);

DROP TABLE palhaco;
DROP TABLE circo;