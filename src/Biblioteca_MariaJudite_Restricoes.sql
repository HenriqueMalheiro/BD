-- CRIAS AS RESTRICOES
create user 'funcionario'@'localhost' identified by 'password';
grant select,insert,update,delete on EventsWorkbench.* to 'funcionario'@'localhost';
grant execute on procedure getlivrosgenero to 'funcionario'@'localhost';
grant execute on procedure getlivrosautor to 'funcionario'@'localhost';
grant execute on procedure getLivrosDaSeccao to 'funcionario'@'localhost';
grant execute on procedure addSalaEstudoGrupo to 'funcionario'@'localhost';
grant execute on procedure addSalaEstudoIndividual to 'funcionario'@'localhost';
grant execute on procedure addLivro to 'funcionario'@'localhost';
grant execute on procedure addLeitor to 'funcionario'@'localhost';
grant execute on procedure addFuncionario to 'funcionario'@'localhost';
grant select on  getLivrosEmprestados to 'funcionario'@'localhost';
grant select on  getLivrosDisponiveis to 'funcionario'@'localhost';
grant select on  getLivrosAtrasados to 'funcionario'@'localhost';
grant select on  getSalasEstudoUsadasDesdeSempre to 'funcionario'@'localhost';
grant select on  getGeneroMaisPresenteNaBiblio to 'funcionario'@'localhost';
grant select on  getHorarioMaisFrequente to 'funcionario'@'localhost';
grant select on  getQuantidadeLivros to 'funcionario'@'localhost';
grant select on  getSalasEstudoLivres to 'funcionario'@'localhost';
grant select on  getMaisRequisitado to 'funcionario'@'localhost';
grant select on  getLivrosDiferentes to 'funcionario'@'localhost';
grant select on  getAutoresDiferentes to 'funcionario'@'localhost';
grant select on  getLeitoresExistentes to 'funcionario'@'localhost';
grant select on  getLeitoresNasSalas to 'funcionario'@'localhost';
grant select on  countLivrosDisponiveis to 'funcionario'@'localhost';
grant select on  countLivrosEmprestados to 'funcionario'@'localhost';
grant select on  countSalasEstudoOcupadas to 'funcionario'@'localhost';
grant select on  countSalasEstudoLivres to 'funcionario'@'localhost';

create user 'leitor'@'localhost' identified by 'password';
grant select,insert,update,delete on EventsWorkbench.* to 'leitor'@'localhost';
grant select on  getGeneroMaisPresenteNaBiblio to 'funcionario'@'localhost';
grant select on  getSalasEstudoLivres to 'funcionario'@'localhost';
grant select on  getMaisRequisitado to 'funcionario'@'localhost';
grant select on  getLivrosDiferentes to 'funcionario'@'localhost';
grant select on  getAutoresDiferentes to 'funcionario'@'localhost';

-- mysql -u funcionario -p 
-- use nome_base
-- select * from nome;
-- call nome();

