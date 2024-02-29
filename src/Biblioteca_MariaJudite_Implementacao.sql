-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Biblioteca_MariaJudite
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Biblioteca_MariaJudite
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS Biblioteca_MariaJudite;
USE Biblioteca_MariaJudite ;

-- -----------------------------------------------------
-- Table Funcionário
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Funcionário (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  nome VARCHAR(30) NOT NULL,
  email VARCHAR(35) NOT NULL,
  nº_telemóvel INT UNSIGNED NOT NULL,
  rua VARCHAR(45) NOT NULL,
  localidade VARCHAR(15) NOT NULL,
  codigo_postal VARCHAR(15) NOT NULL,
  PRIMARY KEY (id),
  UNIQUE INDEX id_UNIQUE (id ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table Leitor
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Leitor (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  nome VARCHAR(30) NOT NULL,
  email VARCHAR(30) NOT NULL,
  nº_do_CC INT UNSIGNED NOT NULL,
  rua VARCHAR(45) NOT NULL,
  localidade VARCHAR(15) NOT NULL,
  codigo_postal VARCHAR(15) NOT NULL,
  Funcionário_id INT UNSIGNED NOT NULL,
  PRIMARY KEY (id),
  UNIQUE INDEX id_UNIQUE (id ASC) VISIBLE,
  UNIQUE INDEX nº_do_CC_UNIQUE (nº_do_CC ASC) VISIBLE,
  INDEX fk_Leitor_Funcionário1_idx (Funcionário_id ASC) VISIBLE,
  CONSTRAINT fk_Leitor_Funcionário1
    FOREIGN KEY (Funcionário_id)
    REFERENCES Funcionário (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;    


-- -----------------------------------------------------
-- Table Nº Telemóvel
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Nº_Telemóvel (
  nº_telemóvel INT UNSIGNED NOT NULL,
  Leitor_id INT UNSIGNED NOT NULL,
  PRIMARY KEY (Leitor_id, nº_telemóvel),
  INDEX fk_Nº_Telemóvel_Leitor1_idx (Leitor_id ASC) VISIBLE,
  CONSTRAINT fk_Nº_Telemóvel_Leitor1
    FOREIGN KEY (Leitor_id)
    REFERENCES Leitor (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table Sala de Estudo
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Sala_de_Estudo (
  número_da_sala INT UNSIGNED NOT NULL,
  tipo ENUM('Individual', 'Grupo') NOT NULL,
  capacidade INT UNSIGNED NOT NULL,
  estado ENUM('Ocupada', 'Livre') NOT NULL,
  PRIMARY KEY (número_da_sala),
  UNIQUE INDEX número_da_sala_UNIQUE (número_da_sala ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table Reserva Sala_Estudo
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Reserva_Sala_Estudo (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  tipo ENUM('Individual', 'Grupo') NOT NULL,
  dia DATE NOT NULL,
  hora_de_entrada TIME NOT NULL,
  hora_de_saída TIME NOT NULL,
  Leitor_id INT UNSIGNED NOT NULL,
  Funcionário_id INT UNSIGNED NOT NULL,
  Sala_de_Estudo_número_da_sala INT UNSIGNED NOT NULL,
  PRIMARY KEY (id),
  UNIQUE INDEX id_UNIQUE (id ASC) VISIBLE,
  INDEX fk_Reserva_Sala_Estudo_Leitor1_idx (Leitor_id ASC) VISIBLE,
  INDEX fk_Reserva_Sala_Estudo_Funcionário1_idx (Funcionário_id ASC) VISIBLE,
  INDEX fk_Reserva_Sala_Estudo_Sala_de_Estudo1_idx (Sala_de_Estudo_número_da_sala ASC) VISIBLE,
  CONSTRAINT fk_Reserva_Sala_Estudo_Leitor1
    FOREIGN KEY (Leitor_id)
    REFERENCES Leitor (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_Reserva_Sala_Estudo_Funcionário1
    FOREIGN KEY (Funcionário_id)
    REFERENCES Funcionário (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_Reserva_Sala_Estudo_Sala_de_Estudo1
    FOREIGN KEY (Sala_de_Estudo_número_da_sala)
    REFERENCES Sala_de_Estudo (número_da_sala)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table Reserva Livro
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Reserva_Livro (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  dia DATE NOT NULL,
  Funcionário_id INT UNSIGNED NOT NULL,
  Leitor_id INT UNSIGNED NOT NULL,
  PRIMARY KEY (id),
  UNIQUE INDEX id_UNIQUE (id ASC) VISIBLE,
  INDEX fk_Reserva_Livro_Funcionário1_idx (Funcionário_id ASC) VISIBLE,
  INDEX fk_Reserva_Livro_Leitor1_idx (Leitor_id ASC) VISIBLE,
  CONSTRAINT fk_Reserva_Livro_Funcionário1
    FOREIGN KEY (Funcionário_id)
    REFERENCES Funcionário (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_Reserva_Livro_Leitor1
    FOREIGN KEY (Leitor_id)
    REFERENCES Leitor (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table Livro
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Livro (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  género VARCHAR(20) NOT NULL,
  autor VARCHAR(25) NOT NULL,
  título VARCHAR(25) NOT NULL,
  sala INT UNSIGNED NOT NULL,
  corredor INT UNSIGNED NOT NULL,
  secção VARCHAR(15) NOT NULL,
  PRIMARY KEY (id),
  UNIQUE INDEX id_UNIQUE (id ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table ReservaLivro_Livro
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS ReservaLivro_Livro (
  Reserva_Livro_id INT UNSIGNED NOT NULL,
  Livro_id INT UNSIGNED NOT NULL,
  INDEX fk_ReservaLivro_Livro_Reserva_Livro1_idx (Reserva_Livro_id ASC) VISIBLE,
  INDEX fk_ReservaLivro_Livro_Livro1_idx (Livro_id ASC) VISIBLE,
  CONSTRAINT fk_ReservaLivro_Livro_Reserva_Livro1
    FOREIGN KEY (Reserva_Livro_id)
    REFERENCES Reserva_Livro (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_ReservaLivro_Livro_Livro1
    FOREIGN KEY (Livro_id)
    REFERENCES Livro (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- drop database Biblioteca_MariaJudite;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;