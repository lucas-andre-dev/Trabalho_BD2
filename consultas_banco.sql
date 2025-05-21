use palhaco_db;

/*palhaco por circo*/
SELECT 
	p.nome nome_palhaco, c.nome nome_circo
FROM
	palhaco p
JOIN
	circo c
USING
	(id_circo)
order by c.nome,p.nome;
    

SELECT 
	c.nome,count(p.id_circo)
FROM
	circo c
JOIN
	palhaco p
USING(id_circo)
GROUP BY c.nome;


SELECT count(*) FROM circo;

SELECT count(*) FROM palhaco;



SELECT 
	nome nome_palhaco
FROM
	palhaco
where id_circo is  null;



select* from circo;



SELECT * FROM palhaco WHERE data_nascimento BETWEEN '2000-01-01' AND '2010-12-31';