USE palhaco_db;

/*POPULAR TABLE CIRCO*/


DELIMITER //

CREATE PROCEDURE popular_circo_batch(IN num_inserts INT, IN batch_size INT)
BEGIN
  DECLARE i INT DEFAULT 0;
  DECLARE id_atual INT DEFAULT 0;
  DECLARE nome_c VARCHAR(100);
  DECLARE cidade_c VARCHAR(100);
  DECLARE lotacao_c VARCHAR(100);
  DECLARE data_i DATE;

  DECLARE sql_batch LONGTEXT DEFAULT '';
  DECLARE batch_count INT DEFAULT 0;

  SELECT COUNT(*)  FROM circo INTO id_atual;

  WHILE i < num_inserts DO
    SET nome_c = CONCAT('circo ', id_atual + i);
    SET cidade_c = CONCAT('cidade ', id_atual + i);
    SET lotacao_c = CONCAT('tamanho: ', id_atual + i);
    SET data_i = DATE_SUB(CURDATE(), INTERVAL FLOOR(RAND() * 365 * 50) DAY);

    IF sql_batch = '' THEN
      SET sql_batch = CONCAT('INSERT INTO circo (nome, cidade, lotacao, data_inicio) VALUES ');
    ELSE
      SET sql_batch = CONCAT(sql_batch, ',');
    END IF;

    SET sql_batch = CONCAT(
      sql_batch, '("', nome_c, '", "', cidade_c, '", "', lotacao_c, '", ''',
      DATE_FORMAT(data_i, '%Y-%m-%d'), ''')'
    );

    SET batch_count = batch_count + 1;

    IF batch_count >= batch_size OR i = num_inserts - 1 THEN
      SET @sql_statement = sql_batch;
      PREPARE stmt FROM @sql_statement;
      EXECUTE stmt;
      DEALLOCATE PREPARE stmt;
      SET sql_batch = '';
      SET batch_count = 0;
    END IF;

    SET i = i + 1;
  END WHILE;
END //

DELIMITER ;


/*POPULAR TABLE PALHACO*/

DELIMITER //

CREATE PROCEDURE popular_palhacos_batch(IN batch_size INT)
BEGIN
  DECLARE i 			  INT DEFAULT 0;
  DECLARE nome_  		  VARCHAR(100);
  DECLARE nome_artistico_ VARCHAR(100);
  DECLARE data_nasc 	  DATE;
  DECLARE especialidade_  INT;
  DECLARE fk_circo 		  INT;
  DECLARE sql_batch 	  LONGTEXT DEFAULT '';
  DECLARE batch_count 	  INT;
  DECLARE quant_circo 	  INT;
  DECLARE quant_palhaco   INT;

  SELECT COUNT(*) FROM circo   INTO quant_circo;
  SELECT COUNT(*) FROM palhaco INTO quant_palhaco ;
  
  WHILE i < quant_circo DO
    SET nome_ = 		  CONCAT('Palhaço ', quant_palhaco + i);
    SET nome_artistico_ = CONCAT('Pirueta ', quant_palhaco +i);
    SET data_nasc = 	  DATE_SUB(CURDATE(), INTERVAL FLOOR(RAND() * 365 * 50) DAY);
    SET especialidade_ =  FLOOR(RAND() * 10) + 1;
    SET fk_circo = i + 1;

    IF sql_batch = '' THEN
      SET sql_batch = 'INSERT INTO palhaco (nome, nome_artistico, data_nascimento, especialidade, id_circo) VALUES ';
    ELSE
      SET sql_batch = CONCAT(sql_batch, ', ');
    END IF;

    SET sql_batch = CONCAT(sql_batch, '("', nome_, '", "', nome_artistico_, '", "', data_nasc, '", ', especialidade_, ', ', fk_circo, ')');

    SET batch_count = batch_count + 1;

    IF batch_count >= batch_size OR i = quant_circo - 1 THEN
      SET @sql_statement = sql_batch;
      PREPARE stmt FROM @sql_statement;
      EXECUTE stmt;
      DEALLOCATE PREPARE stmt;

      SET sql_batch = '';
      SET batch_count = 0;
    END IF;

    SET i = i + 1;
  END WHILE;
END //

DELIMITER ;

