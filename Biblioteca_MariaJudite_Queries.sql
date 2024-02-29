-- QUERIES
-- Quantos livros estao disponieis
create view countLivrosDisponiveis as 
	SELECT count(título)
				FROM Livro
				WHERE id NOT IN (
					SELECT Livro_id
						FROM ReservaLivro_Livro);
                        
-- Quantos livros emprestados
CREATE view countLivrosEmprestados as
        SELECT count(título)
        FROM ReservaLivro_Livro
        JOIN Livro ON (ReservaLivro_Livro.Livro_id = Livro.id);

-- Quais livros estão emprestados
CREATE view getLivrosEmprestados as
        SELECT título
        FROM ReservaLivro_Livro
        JOIN Livro ON (ReservaLivro_Livro.Livro_id = Livro.id);

-- Quais livros estao disponiveis
CREATE view getLivrosDisponiveis as 
		SELECT título
			FROM Livro
			WHERE id NOT IN (
				SELECT Livro_id
					FROM ReservaLivro_Livro);


CREATE view getLivrosAtrasados as
		SELECT Reserva_Livro.id, Livro.título, Reserva_Livro.dia
			FROM Reserva_Livro
			JOIN ReservaLivro_Livro ON (Reserva_Livro.id = ReservaLivro_Livro.Reserva_Livro_id)
			JOIN Livro ON (ReservaLivro_Livro.Livro_id = Livro.id)
			WHERE DATEDIFF(CURDATE(), Reserva_Livro.dia) > 30; -- Considerando 30 dias como um mês
    
-- Que leitores estão a usar as salas de estudo desde sempre
CREATE view getSalasEstudoUsadasDesdeSempre as 
		SELECT distinct Leitor.nome
			FROM Reserva_Sala_Estudo JOIN Leitor ON (Reserva_Sala_Estudo.Leitor_id = Leitor.id);


-- Onde se encontra determinado livro
DELIMITER $$
CREATE FUNCTION	getlivrolocal (input VARCHAR(25))
  RETURNS VARCHAR(100)
  DETERMINISTIC
  BEGIN
    DECLARE output VARCHAR(100);
	
    SELECT CONCAT('Sala: ', sala, ' Corredor: ', corredor,' Secção: ', secção)
    INTO output
    FROM Livro
    WHERE título = input;

    RETURN output;
  END $$
DELIMITER ;

-- gêneros mais presente na biblioteca
CREATE view getGeneroMaisPresenteNaBiblio as
		SELECT género
			FROM Livro
			GROUP BY género
			ORDER BY count(*) DESC
			LIMIT 1;

-- horário onde a biblioteca é mais frequentada pelos leitores.
CREATE view getHorarioMaisFrequente as 
		SELECT HOUR(hora_de_entrada)
			FROM Reserva_Sala_Estudo
			GROUP BY HOUR(hora_de_entrada)
			ORDER BY count(*) DESC
			LIMIT 1;

-- Quantidade de livros da biblioteca
CREATE view getQuantidadeLivros as 
		SELECT count(*)
			FROM Livro;

-- Listagem dos livros de um determinado genero.
DELIMITER $$
CREATE PROCEDURE getlivrosgenero (IN input VARCHAR(25)) -- permite executar uma ou mais instrucoes varias vezes
BEGIN
  SELECT título
  FROM Livro
  WHERE género = input;
END $$
DELIMITER ;

-- CALL getlivrosgenero('comedia');

-- Listagem dos livros de um autor à escolha.
DELIMITER $$
CREATE PROCEDURE getlivrosautor (IN input VARCHAR(25)) -- permite executar uma ou mais instrucoes varias vezes
BEGIN
  SELECT título
  FROM Livro
  WHERE autor = input;
END $$
DELIMITER ;

-- CALL getlivrosautor('Francisco de Sousa');
-- DROP PROCEDURE getlivrosautor;

-- Listagem das salas de estudo disponíveis.
CREATE view getSalasEstudoLivres as
		SELECT número_da_sala, tipo
		  FROM Sala_de_Estudo
		  WHERE estado = 'Livre';

-- Quantas salas de estudo livres
CREATE view countSalasEstudoLivres as
		SELECT count(número_da_sala)
		  FROM Sala_de_Estudo
		  WHERE estado = 'Livre';

-- Quantas salas de estudo ocupadas
CREATE view countSalasEstudoOcupadas as
		SELECT count(número_da_sala)
		  FROM Sala_de_Estudo
		  WHERE estado = 'Ocupada';	


-- gêneros mais requisitados pelos leitores.
CREATE view getMaisRequisitado as 
    SELECT Livro.género
    FROM livro
    JOIN ReservaLivro_Livro ON ReservaLivro_Livro.Livro_id = Livro.id
    GROUP BY Livro.género
    ORDER BY COUNT(*) DESC
    LIMIT 1;

-- que livros diferentes existem ordenados alfabeticamente
CREATE view getLivrosDiferentes as
	select distinct título from Livro
		order by título;

-- que autores diferentes existem ordenados alfabeticamente
CREATE view getAutoresDiferentes as 
	select distinct autor from Livro
		order by autor;
        
-- os livros de uma dada seccao
DELIMITER $$
create procedure getLivrosDaSeccao(in input varchar(15))
begin
  select título from Livro
	where secção = input;
end $$
DELIMITER ;

-- CALL getLivrosDaSeccao('5');
-- DROP PROCEDURE getLivrosDaSeccao;

-- quantos leitores existem
create view getLeitoresExistentes as
	select count(*) from Leitor;

-- quantos leitores existem nas salas de estudo neste momento
create view getLeitoresNasSalas as
		select count(*) from Reserva_Sala_Estudo where dia=curdate() and hora_de_entrada> curtime() and hora_de_saída< curtime();

-- -------------------------- CONTROLO -------------------------------------

DELIMITER $$
CREATE PROCEDURE addSalaEstudoGrupo(IN numero INT, IN hora_inicio TIME, IN hora_final TIME, IN id_funcionario INT, IN leitor INT)
BEGIN
    DECLARE sala INT UNSIGNED;
    DECLARE conta_funcionarios INT UNSIGNED;
    DECLARE conta_leitor INT UNSIGNED;
    
    -- Verificar se o leitor existe
    SELECT COUNT(*) INTO conta_leitor FROM Reserva_Sala_Estudo WHERE Leitor_id = leitor and dia=curdate();
    
    IF conta_leitor > 0 THEN
        SELECT 'O leitor ja reserrvou hoje' AS mensagem;
    ELSE
		IF numero <3 or numero >8 THEN
			SELECT 'Número de pessoas errado' AS mensagem;
		ELSE
			IF TIMESTAMPDIFF(HOUR, hora_inicio, hora_final) > 2 THEN
				SELECT 'Deve-se alugar menos tempo para a sala' AS mensagem;
			ELSE
				-- Obtém o número da sala livre
				SELECT número_da_sala INTO sala FROM Sala_de_Estudo WHERE estado = 'Livre' AND tipo = 'Grupo' LIMIT 1;
				
				IF sala IS NOT NULL THEN
					-- Sala está livre, atualiza o estado para ocupado
					UPDATE Sala_de_Estudo SET estado = 'Ocupada' WHERE número_da_sala = sala;
					INSERT INTO Reserva_Sala_Estudo (tipo, data_reserva, hora_inicio, hora_final, id_leitor, sala) VALUES ('Grupo', CURRENT_DATE(), hora_inicio, hora_final, leitor, sala);
					SELECT CONCAT('A sala ', sala, ' está agora ocupada.') AS mensagem;
				ELSE
					-- Todas as salas estão ocupadas
					SELECT 'Todas as salas de estudo em grupo estão ocupadas.' AS mensagem;
				END IF;
			END IF;
		END IF;
    END IF;
END $$
DELIMITER ;


-- alugar sala de estudo de individual
DELIMITER $$
CREATE PROCEDURE addSalaEstudoIndividual(IN numero INT, IN hora_inicio TIME, IN hora_final TIME, IN id_funcionario INT, IN leitor INT)
BEGIN
    DECLARE sala INT UNSIGNED;
    DECLARE conta_funcionarios INT UNSIGNED;
    DECLARE conta_leitor INT UNSIGNED;
    
    -- Verificar se o leitor existe
    SELECT COUNT(*) INTO conta_leitor FROM Reserva_Sala_Estudo WHERE Leitor_id = leitor and dia=curdate();
    
    IF conta_leitor > 0 THEN
        SELECT 'O leitor ja reserrvou hoje' AS mensagem;
    ELSE
		IF numero !=1 THEN
			SELECT 'Número de pessoas errado' AS mensagem;
		ELSE
			IF TIMESTAMPDIFF(HOUR, hora_inicio, hora_final) > 2 THEN
				SELECT 'Deve-se alugar menos tempo para a sala' AS mensagem;
			ELSE
				-- Obtém o número da sala livre
				SELECT número_da_sala INTO sala FROM Sala_de_Estudo WHERE estado = 'Livre' AND tipo = 'Individual' LIMIT 1;
				
				IF sala IS NOT NULL THEN
					-- Sala está livre, atualiza o estado para ocupado
					UPDATE Sala_de_Estudo SET estado = 'Ocupada' WHERE número_da_sala = sala;
					INSERT INTO Reserva_Sala_Estudo (tipo, data_reserva, hora_inicio, hora_final, id_leitor, sala) VALUES ('Individual', CURRENT_DATE(), hora_inicio, hora_final, leitor, sala);
					SELECT CONCAT('A sala ', sala, ' está agora ocupada.') AS mensagem;
				ELSE
					-- Todas as salas estão ocupadas
					SELECT 'Todas as salas de estudo individuais estão ocupadas.' AS mensagem;
				END IF;
			END IF;
		END IF;
    END IF;
END $$
DELIMITER ;


-- call addSalaEstudoGrupo('4','08:20','09:30',1,1);
-- drop procedure addSalaEstudoGrupo;

-- call addSalaEstudoIndividual('1','08:20','09:30',1,1);
-- drop procedure addSalaEstudoIndividual;


-- alugar livro
DELIMITER $$
CREATE PROCEDURE addLivroReserva(IN nome_livro VARCHAR(25), IN id_leitor INT, IN id_funcionario INT)
BEGIN
    DECLARE id_livro_procuramos INT UNSIGNED;
    DECLARE conta_reservas INT UNSIGNED;
    DECLARE conta_funcionarios INT UNSIGNED;
    
    -- Verificar se o funcionário existe
    SELECT COUNT(*) INTO conta_funcionarios FROM Funcionário WHERE id_funcionario = id;

	-- Verificar se o leitor tem menos de 5 livros reservados
	SELECT COUNT(*) INTO conta_reservas FROM Reserva_Livro WHERE Leitor_id = id_leitor;
	
	IF conta_reservas > 4 THEN
		SELECT 'Tem demasiados livros reservados' AS mensagem;
	ELSE
		-- Obter o livro com o nome dado
		SELECT id INTO id_livro_procuramos FROM Livro
		WHERE título = nome_livro AND id NOT IN (SELECT Livro_id FROM ReservaLivro_Livro);
		
		IF id_livro_procuramos IS NOT NULL THEN
			INSERT INTO ReservaLivro_Livro (Livro_id)
			VALUES (id_livro_procuramos);
			
			INSERT INTO Reserva_Livro (data_reserva, id_funcionario, id_leitor)
			VALUES (CURRENT_DATE(), id_funcionario, id_leitor);
			
			SELECT CONCAT('Reserva com o id ', id_livro_procuramos, ' feita com sucesso.') AS mensagem;
		ELSE
			-- Todas as cópias do livro estão ocupadas
			SELECT 'Não temos esse livro disponível.' AS mensagem;
		END IF;
	END IF;
END $$
DELIMITER ;

-- call addLivro('Perdido na UM',1,1);
-- drop procedure addLivro;

DELIMITER $$
CREATE PROCEDURE addLeitor(
    IN p_nome VARCHAR(30),
    IN p_email VARCHAR(30),
    IN p_n_do_CC INT,
    IN p_rua VARCHAR(45),
    IN p_localidade VARCHAR(15),
    IN p_codigo_postal VARCHAR(15),
    IN p_funcionário_id INT
)
BEGIN
    INSERT INTO Leitor (nome, email, nº_do_CC, rua, localidade, codigo_postal, funcionário_id)
    VALUES (p_nome, p_email, p_n_do_CC, p_rua, p_localidade, p_codigo_postal, p_funcionário_id);
END $$
DELIMITER ;

-- call inserirLeitor('Joao Figueiredo','fig@hotmail.com','256482923','Rua direita','Ermesinde','4343-234',1);
-- drop procedure inserirLeitor;

DELIMITER $$
CREATE PROCEDURE addLivro(
	IN género_p VARCHAR(20),
	IN autor_p VARCHAR(25),
	IN título_P VARCHAR(25),
	IN sala_p INT,
	IN corredor_p INT,
	IN secção_p VARCHAR(15)
)
BEGIN
    INSERT INTO Livro (género, autor, título, sala, corredor, secção)
    VALUES (género_p, autor_p, título_P, sala_p, corredor_p, secção_p);
END $$
DELIMITER ;

-- call addLivro ('comedia','autor','Achei o meu rumo','2','3','4');
-- drop procedure addLivro;

DELIMITER $$
CREATE PROCEDURE addFuncionario(
    IN nome_p VARCHAR(30),
    IN email_p VARCHAR(35),
    IN n_telemovel_p INT,
    IN rua_p VARCHAR(45),
    IN localidade_p VARCHAR(15),
    IN codigo_postal_p VARCHAR(15)
)
BEGIN
    INSERT INTO Funcionário (nome, email, nº_telemóvel, rua, localidade, codigo_postal)
    VALUES (nome_p, email_p, n_telemovel_p, rua_p, localidade_p, codigo_postal_p);
END $$
DELIMITER ;

-- call addFuncionario('Helder Pereira','hp@gmail.com','986251282','rua do sol','Braga','3421-234');
-- drop procedure addFuncionario;

-- drop database biblioteca_mariajudite;
