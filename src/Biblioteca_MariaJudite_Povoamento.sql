-- Povoamento--
INSERT INTO Funcionário (nome,email,nº_telemóvel,rua,localidade,codigo_postal)
VALUES
	('Francisca de Andrade','xica72@gmail.com','932432543','Rua da Xica','Lousada','4522-55'),
    ('João Silva','joao.silva@gmail.com','912345678','Rua dos Lírios','Porto','4000-001'),
    ('Maria Santos','maria.santos@gmail.com','919876543','Avenida das Flores','Lisboa','1000-200'),
    ('Pedro Costa','pedro.costa@hotmail.com','925678943','Travessa das Oliveiras','Braga','4700-400'),
    ('Sofia Ferreira','sofia.ferreira@outlook.com','933215477','Praça Central','Coimbra','3000-100');


INSERT INTO Leitor (nome,email,nº_do_CC,rua,localidade,codigo_postal,Funcionário_id)
VALUES
	('José Silva','jose@gmail.com','75423311','Rua do Largo','Lousada','4322-011','1'),
	('Ana Santos','ana.santos@gmail.com','64567832','Avenida das Rosas','Porto','4000-123','2'),
	('Rui Costa','rui.costa@hotmail.com','84562378','Travessa das Flores','Lisboa','1000-345','3'),
	('Marta Pereira','marta.pereira@gmail.com','95678432','Rua dos Pinheiros','Braga','4700-567','4'),
	('Carlos Ferreira','carlos.ferreira@hotmail.com','73647892','Praça Central','Coimbra','3000-678','1'),
	('Sara Martins','sara.martins@gmail.com','84562312','Rua da Fonte','Guimarães','4800-789','2'),
	('André Rodrigues','andre.rodrigues@outlook.com','92567890','Avenida Principal','Faro','8000-890','3');
    

INSERT INTO Nº_Telemóvel(nº_telemóvel,Leitor_id)
VALUES 
	('912435617','5'),
    ('912431117','1'),
    ('944435617','3'),
    ('963377227','3'),
    ('919393937','6'),
    ('933892927','4');
    
    
INSERT INTO Sala_de_Estudo (número_da_sala,tipo,capacidade,estado)
VALUES
	('1','Individual','1','Livre'),
    ('7','Grupo','5','Ocupada'),
    ('4','Individual','1','Ocupada'),
    ('3','Grupo','3','Livre'),
    ('6','Grupo','8','Livre');
    
    
INSERT INTO Reserva_Sala_Estudo(tipo,dia,hora_de_entrada,hora_de_saída,Leitor_id,Funcionário_id,Sala_de_Estudo_número_da_sala)
VALUES 
	('Individual','2020-05-10','10:05','12:05','1','2','4'),
    ('Grupo','2022-05-10','10:10','12:10','2','3','3'),
    ('Individual','2021-04-05','13:35','15:35','4','5','1'),
    ('Grupo','2022-03-02','10:05','12:25','3','1','6'),
    ('Grupo','2023-01-02','12:05','14:45','5','3','7');
  

INSERT INTO Reserva_Livro (dia,Funcionário_id,Leitor_id)
VALUES 
	('2020-10-10','4','6'),
    ('2020-08-15','1','3'),
    ('2020-05-15','2','1'),
    ('2020-07-19','3','4'),
    ('2020-02-24','5','2');
    

INSERT INTO Livro(género,autor,título,sala,corredor,secção)
VALUES 
	('ficção cientifica','Francisca de Sousa','Perdido no Espaço','1','2','4'),
    ('comedia','Francisca de Andrade','Perdido no Shopping','2','5','5'),
    ('comedia','Francisco de Sousa','Caso perdido','4','1','5'),
    ('ficção cientifica','Jose Almeida','Sou humano?','3','3','3'),
    ('romance','Jose Amaro','Perdido em ti','5','4','1'),
    ('terror','Joao Afonso','Perdido na UM','2','1','2'),
    ('cientifico','Josefina Alberta','Perdido na Mitocondria','3','6','3');
  

INSERT INTO ReservaLivro_Livro(Reserva_Livro_id,Livro_id)
VALUES 
	('1','2'),
    ('2','1'),
    ('3','7'),
    ('4','3'),
    ('5','6');