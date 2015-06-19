SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

DROP SCHEMA IF EXISTS `InnovativeIdeas` ;
CREATE SCHEMA IF NOT EXISTS `InnovativeIdeas` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `InnovativeIdeas` ;

-- -----------------------------------------------------
-- Table `InnovativeIdeas`.`Paises`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `InnovativeIdeas`.`Paises` (
  `idPais` INT NOT NULL AUTO_INCREMENT ,
  `nombre` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`idPais`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `InnovativeIdeas`.`Provincias`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `InnovativeIdeas`.`Provincias` (
  `idProvincia` INT NOT NULL AUTO_INCREMENT ,
  `Nombre` VARCHAR(45) NOT NULL ,
  `idPais` INT NOT NULL ,
  PRIMARY KEY (`idProvincia`) ,
  CONSTRAINT `fk_Provincias_Paises1`
    FOREIGN KEY (`idPais` )
    REFERENCES `InnovativeIdeas`.`Paises` (`idPais` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Provincias_Paises1_idx` ON `InnovativeIdeas`.`Provincias` (`idPais` ASC) ;


-- -----------------------------------------------------
-- Table `InnovativeIdeas`.`Ciudades`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `InnovativeIdeas`.`Ciudades` (
  `idCiudades` INT NOT NULL AUTO_INCREMENT ,
  `nombre` VARCHAR(45) NOT NULL ,
  `idProvincia` INT NOT NULL ,
  PRIMARY KEY (`idCiudades`) ,
  CONSTRAINT `fk_Ciudades_Provincias1`
    FOREIGN KEY (`idProvincia` )
    REFERENCES `InnovativeIdeas`.`Provincias` (`idProvincia` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Ciudades_Provincias1_idx` ON `InnovativeIdeas`.`Ciudades` (`idProvincia` ASC) ;


-- -----------------------------------------------------
-- Table `InnovativeIdeas`.`Direcciones`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `InnovativeIdeas`.`Direcciones` (
  `idDirecciones` INT NOT NULL AUTO_INCREMENT ,
  `Detalle1` VARCHAR(45) NULL ,
  `Detalle2` VARCHAR(45) NULL ,
  `zipcode` VARCHAR(45) NULL ,
  `idCiudades` INT NOT NULL ,
  `latitud` VARCHAR(45) NOT NULL ,
  `longitud` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`idDirecciones`) ,
  CONSTRAINT `fk_Direcciones_Ciudades1`
    FOREIGN KEY (`idCiudades` )
    REFERENCES `InnovativeIdeas`.`Ciudades` (`idCiudades` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Direcciones_Ciudades1_idx` ON `InnovativeIdeas`.`Direcciones` (`idCiudades` ASC) ;


-- -----------------------------------------------------
-- Table `InnovativeIdeas`.`Perfiles`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `InnovativeIdeas`.`Perfiles` (
  `idPerfiles` INT NOT NULL AUTO_INCREMENT ,
  `fotografia` VARCHAR(800) NOT NULL ,
  `nombre` VARCHAR(45) NOT NULL ,
  `apellido1` VARCHAR(45) NOT NULL ,
  `apellido2` VARCHAR(45) NOT NULL ,
  `fechaNacimiento` DATETIME NOT NULL ,
  `idDirecciones` INT NOT NULL ,
  PRIMARY KEY (`idPerfiles`) ,
  CONSTRAINT `fk_Perfiles_Direcciones1`
    FOREIGN KEY (`idDirecciones` )
    REFERENCES `InnovativeIdeas`.`Direcciones` (`idDirecciones` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Perfiles_Direcciones1_idx` ON `InnovativeIdeas`.`Perfiles` (`idDirecciones` ASC) ;


-- -----------------------------------------------------
-- Table `InnovativeIdeas`.`TiposCuentas`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `InnovativeIdeas`.`TiposCuentas` (
  `idTiposCuentas` INT NOT NULL AUTO_INCREMENT ,
  `nombre` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`idTiposCuentas`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `InnovativeIdeas`.`Usuarios`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `InnovativeIdeas`.`Usuarios` (
  `idUsuarios` INT NOT NULL AUTO_INCREMENT ,
  `username` VARCHAR(200) NOT NULL ,
  `password` VARCHAR(200) NOT NULL ,
  `idPerfiles` INT NOT NULL ,
  `email` VARCHAR(200) NOT NULL ,
  `idTiposCuentas` INT NOT NULL ,
  PRIMARY KEY (`idUsuarios`) ,
  CONSTRAINT `fk_Usuarios_Perfiles1`
    FOREIGN KEY (`idPerfiles` )
    REFERENCES `InnovativeIdeas`.`Perfiles` (`idPerfiles` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Usuarios_TiposCuentas1`
    FOREIGN KEY (`idTiposCuentas` )
    REFERENCES `InnovativeIdeas`.`TiposCuentas` (`idTiposCuentas` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Usuarios_Perfiles1_idx` ON `InnovativeIdeas`.`Usuarios` (`idPerfiles` ASC) ;

CREATE INDEX `fk_Usuarios_TiposCuentas1_idx` ON `InnovativeIdeas`.`Usuarios` (`idTiposCuentas` ASC) ;


-- -----------------------------------------------------
-- Table `InnovativeIdeas`.`Perfil`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `InnovativeIdeas`.`Perfil` (
  `idPerfil` INT NOT NULL ,
  `Perfilcol` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`idPerfil`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `InnovativeIdeas`.`Perfiles`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `InnovativeIdeas`.`Perfiles` (
  `idPerfiles` INT NOT NULL AUTO_INCREMENT ,
  `fotografia` VARCHAR(600) NOT NULL ,
  `nombre` VARCHAR(45) NOT NULL ,
  `apellido1` VARCHAR(45) NOT NULL ,
  `apellido2` VARCHAR(45) NOT NULL ,
  `fechaNacimiento` DATETIME NOT NULL ,
  `idDirecciones` INT NOT NULL ,
  PRIMARY KEY (`idPerfiles`) ,
  CONSTRAINT `fk_Perfiles_Direcciones1`
    FOREIGN KEY (`idDirecciones` )
    REFERENCES `InnovativeIdeas`.`Direcciones` (`idDirecciones` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `InnovativeIdeas`.`TiposLogros`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `InnovativeIdeas`.`TiposLogros` (
  `idTiposLogros` INT NOT NULL AUTO_INCREMENT ,
  `Nombre` VARCHAR(20) NOT NULL ,
  PRIMARY KEY (`idTiposLogros`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `InnovativeIdeas`.`Instituciones`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `InnovativeIdeas`.`Instituciones` (
  `idInstituciones` INT NOT NULL AUTO_INCREMENT ,
  `nombre` VARCHAR(50) NOT NULL ,
  `idDirecciones` INT NOT NULL ,
  `idTiposLogros` INT NOT NULL ,
  PRIMARY KEY (`idInstituciones`) ,
  CONSTRAINT `fk_Instituciones_Direcciones1`
    FOREIGN KEY (`idDirecciones` )
    REFERENCES `InnovativeIdeas`.`Direcciones` (`idDirecciones` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Instituciones_TiposLogros1`
    FOREIGN KEY (`idTiposLogros` )
    REFERENCES `InnovativeIdeas`.`TiposLogros` (`idTiposLogros` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Instituciones_Direcciones1_idx` ON `InnovativeIdeas`.`Instituciones` (`idDirecciones` ASC) ;

CREATE INDEX `fk_Instituciones_TiposLogros1_idx` ON `InnovativeIdeas`.`Instituciones` (`idTiposLogros` ASC) ;


-- -----------------------------------------------------
-- Table `InnovativeIdeas`.`Logros`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `InnovativeIdeas`.`Logros` (
  `idLogros` INT NOT NULL AUTO_INCREMENT ,
  `fechaInicio` DATETIME NOT NULL ,
  `descripcion` VARCHAR(200) NOT NULL ,
  `idPerfiles` INT NOT NULL ,
  `fechaFinal` DATETIME NULL ,
  `idTiposLogros` INT NOT NULL ,
  `idInstituciones` INT NOT NULL ,
  PRIMARY KEY (`idLogros`) ,
  CONSTRAINT `fk_Estudios_Perfiles1`
    FOREIGN KEY (`idPerfiles` )
    REFERENCES `InnovativeIdeas`.`Perfiles` (`idPerfiles` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Logros_TiposLogros1`
    FOREIGN KEY (`idTiposLogros` )
    REFERENCES `InnovativeIdeas`.`TiposLogros` (`idTiposLogros` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Logros_Instituciones1`
    FOREIGN KEY (`idInstituciones` )
    REFERENCES `InnovativeIdeas`.`Instituciones` (`idInstituciones` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Estudios_Perfiles1_idx` ON `InnovativeIdeas`.`Logros` (`idPerfiles` ASC) ;

CREATE INDEX `fk_Logros_TiposLogros1_idx` ON `InnovativeIdeas`.`Logros` (`idTiposLogros` ASC) ;

CREATE INDEX `fk_Logros_Instituciones1_idx` ON `InnovativeIdeas`.`Logros` (`idInstituciones` ASC) ;


-- -----------------------------------------------------
-- Table `InnovativeIdeas`.`TipoPublicacion`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `InnovativeIdeas`.`TipoPublicacion` (
  `idTipoPublicacion` INT NOT NULL AUTO_INCREMENT ,
  `nombre` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`idTipoPublicacion`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `InnovativeIdeas`.`Proyectos`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `InnovativeIdeas`.`Proyectos` (
  `idProyectos` INT NOT NULL AUTO_INCREMENT ,
  `FechaInicio` DATETIME NOT NULL ,
  `FechaFinal` DATETIME NOT NULL ,
  `idDirecciones` INT NOT NULL ,
  PRIMARY KEY (`idProyectos`) ,
  CONSTRAINT `fk_Proyectos_Direcciones1`
    FOREIGN KEY (`idDirecciones` )
    REFERENCES `InnovativeIdeas`.`Direcciones` (`idDirecciones` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Proyectos_Direcciones1_idx` ON `InnovativeIdeas`.`Proyectos` (`idDirecciones` ASC) ;


-- -----------------------------------------------------
-- Table `InnovativeIdeas`.`EstadosPublicacion`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `InnovativeIdeas`.`EstadosPublicacion` (
  `idEstadosPublicacion` INT NOT NULL AUTO_INCREMENT ,
  `nombre` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`idEstadosPublicacion`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `InnovativeIdeas`.`CamposControl`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `InnovativeIdeas`.`CamposControl` (
  `idCamposControl` INT NOT NULL AUTO_INCREMENT ,
  `computador` VARCHAR(45) NOT NULL ,
  `ip` VARCHAR(50) NOT NULL ,
  `UsuarioSistema` VARCHAR(50) NOT NULL ,
  `checkSum` VARCHAR(200) NOT NULL ,
  PRIMARY KEY (`idCamposControl`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `InnovativeIdeas`.`Publicaciones`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `InnovativeIdeas`.`Publicaciones` (
  `idPublicaciones` INT NOT NULL AUTO_INCREMENT ,
  `descripcion` VARCHAR(400) NOT NULL ,
  `FechaCreacion` DATE NOT NULL ,
  `idTipoPublicacion` INT NOT NULL ,
  `idProyectos` INT NULL ,
  `Titulo` VARCHAR(100) NOT NULL ,
  `idUsuarios` INT NOT NULL ,
  `idEstadosPublicacion` INT NOT NULL ,
  `idCamposControl` INT NOT NULL ,
  `idPublicacionesfk` INT NOT NULL ,
  PRIMARY KEY (`idPublicaciones`) ,
  CONSTRAINT `fk_Publicaciones_TipoPublicacion1`
    FOREIGN KEY (`idTipoPublicacion` )
    REFERENCES `InnovativeIdeas`.`TipoPublicacion` (`idTipoPublicacion` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Publicaciones_Proyectos1`
    FOREIGN KEY (`idProyectos` )
    REFERENCES `InnovativeIdeas`.`Proyectos` (`idProyectos` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Publicaciones_Usuarios1`
    FOREIGN KEY (`idUsuarios` )
    REFERENCES `InnovativeIdeas`.`Usuarios` (`idUsuarios` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Publicaciones_EstadosPublicacion1`
    FOREIGN KEY (`idEstadosPublicacion` )
    REFERENCES `InnovativeIdeas`.`EstadosPublicacion` (`idEstadosPublicacion` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Publicaciones_CamposControl1`
    FOREIGN KEY (`idCamposControl` )
    REFERENCES `InnovativeIdeas`.`CamposControl` (`idCamposControl` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Publicaciones_Publicaciones1`
    FOREIGN KEY (`idPublicacionesfk` )
    REFERENCES `InnovativeIdeas`.`Publicaciones` (`idPublicaciones` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Publicaciones_TipoPublicacion1_idx` ON `InnovativeIdeas`.`Publicaciones` (`idTipoPublicacion` ASC) ;

CREATE INDEX `fk_Publicaciones_Proyectos1_idx` ON `InnovativeIdeas`.`Publicaciones` (`idProyectos` ASC) ;

CREATE INDEX `fk_Publicaciones_Usuarios1_idx` ON `InnovativeIdeas`.`Publicaciones` (`idUsuarios` ASC) ;

CREATE INDEX `fk_Publicaciones_EstadosPublicacion1_idx` ON `InnovativeIdeas`.`Publicaciones` (`idEstadosPublicacion` ASC) ;

CREATE INDEX `fk_Publicaciones_CamposControl1_idx` ON `InnovativeIdeas`.`Publicaciones` (`idCamposControl` ASC) ;

CREATE INDEX `fk_Publicaciones_Publicaciones1_idx` ON `InnovativeIdeas`.`Publicaciones` (`idPublicacionesfk` ASC) ;


-- -----------------------------------------------------
-- Table `InnovativeIdeas`.`TiposAdjuntos`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `InnovativeIdeas`.`TiposAdjuntos` (
  `idTiposAdjuntos` INT NOT NULL AUTO_INCREMENT ,
  `nombre` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`idTiposAdjuntos`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `InnovativeIdeas`.`Adjuntos`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `InnovativeIdeas`.`Adjuntos` (
  `idAdjuntos` INT NOT NULL AUTO_INCREMENT ,
  `Dato` VARCHAR(600) NOT NULL ,
  `idPublicaciones` INT NOT NULL ,
  `idTiposAdjuntos` INT NOT NULL ,
  PRIMARY KEY (`idAdjuntos`) ,
  CONSTRAINT `fk_Adjuntos_Publicaciones1`
    FOREIGN KEY (`idPublicaciones` )
    REFERENCES `InnovativeIdeas`.`Publicaciones` (`idPublicaciones` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Adjuntos_TiposAdjuntos1`
    FOREIGN KEY (`idTiposAdjuntos` )
    REFERENCES `InnovativeIdeas`.`TiposAdjuntos` (`idTiposAdjuntos` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Adjuntos_Publicaciones1_idx` ON `InnovativeIdeas`.`Adjuntos` (`idPublicaciones` ASC) ;

CREATE INDEX `fk_Adjuntos_TiposAdjuntos1_idx` ON `InnovativeIdeas`.`Adjuntos` (`idTiposAdjuntos` ASC) ;


-- -----------------------------------------------------
-- Table `InnovativeIdeas`.`Publicacion`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `InnovativeIdeas`.`Publicacion` (
  `idPublicacion` INT NOT NULL ,
  PRIMARY KEY (`idPublicacion`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `InnovativeIdeas`.`TiposCaracteristicas`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `InnovativeIdeas`.`TiposCaracteristicas` (
  `idTiposCaracteristicas` INT NOT NULL ,
  PRIMARY KEY (`idTiposCaracteristicas`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `InnovativeIdeas`.`Tags`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `InnovativeIdeas`.`Tags` (
  `idTags` INT NOT NULL AUTO_INCREMENT ,
  `Nombre` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`idTags`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `InnovativeIdeas`.`Calificaciones`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `InnovativeIdeas`.`Calificaciones` (
  `idCalificaciones` INT NOT NULL AUTO_INCREMENT ,
  `valor` INT NOT NULL ,
  `FechaCalificacion` DATETIME NOT NULL ,
  `idUsuarios` INT NOT NULL ,
  `idPublicaciones` INT NOT NULL ,
  PRIMARY KEY (`idCalificaciones`) ,
  CONSTRAINT `fk_Calificaciones_Usuarios1`
    FOREIGN KEY (`idUsuarios` )
    REFERENCES `InnovativeIdeas`.`Usuarios` (`idUsuarios` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Calificaciones_Publicaciones1`
    FOREIGN KEY (`idPublicaciones` )
    REFERENCES `InnovativeIdeas`.`Publicaciones` (`idPublicaciones` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Calificaciones_Usuarios1_idx` ON `InnovativeIdeas`.`Calificaciones` (`idUsuarios` ASC) ;

CREATE INDEX `fk_Calificaciones_Publicaciones1_idx` ON `InnovativeIdeas`.`Calificaciones` (`idPublicaciones` ASC) ;


-- -----------------------------------------------------
-- Table `InnovativeIdeas`.`TiposRelaciones`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `InnovativeIdeas`.`TiposRelaciones` (
  `idTiposRelaciones` INT NOT NULL AUTO_INCREMENT ,
  `nombre` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`idTiposRelaciones`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `InnovativeIdeas`.`TiposEvento`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `InnovativeIdeas`.`TiposEvento` (
  `idTiposEvento` INT NOT NULL AUTO_INCREMENT ,
  `nombre` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`idTiposEvento`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `InnovativeIdeas`.`Modulos`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `InnovativeIdeas`.`Modulos` (
  `idModulos` INT NOT NULL AUTO_INCREMENT ,
  `nombre` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`idModulos`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `InnovativeIdeas`.`Severidad`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `InnovativeIdeas`.`Severidad` (
  `idSeveridad` INT NOT NULL AUTO_INCREMENT ,
  `nombre` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`idSeveridad`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `InnovativeIdeas`.`Eventos`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `InnovativeIdeas`.`Eventos` (
  `idEventos` INT NOT NULL AUTO_INCREMENT  ,
  `fecha` DATETIME NOT NULL ,
  `descripcion` VARCHAR(100) NOT NULL ,
  `computadora` VARCHAR(45) NOT NULL ,
  `usuario` VARCHAR(45) NOT NULL ,
  `checksun` VARCHAR(20) NOT NULL ,
  `ip` VARCHAR(45) NOT NULL ,
  `referencia1` MEDIUMTEXT NULL ,
  `referencia2` MEDIUMTEXT NULL ,
  `idTiposEvento` INT NOT NULL ,
  `idModulos` INT NOT NULL ,
  `idSeveridad` INT NOT NULL ,
  PRIMARY KEY (`idEventos`) ,
  CONSTRAINT `fk_Eventos_TiposEvento1`
    FOREIGN KEY (`idTiposEvento` )
    REFERENCES `InnovativeIdeas`.`TiposEvento` (`idTiposEvento` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Eventos_Modulos1`
    FOREIGN KEY (`idModulos` )
    REFERENCES `InnovativeIdeas`.`Modulos` (`idModulos` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Eventos_Severidad1`
    FOREIGN KEY (`idSeveridad` )
    REFERENCES `InnovativeIdeas`.`Severidad` (`idSeveridad` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Eventos_TiposEvento1_idx` ON `InnovativeIdeas`.`Eventos` (`idTiposEvento` ASC) ;

CREATE INDEX `fk_Eventos_Modulos1_idx` ON `InnovativeIdeas`.`Eventos` (`idModulos` ASC) ;

CREATE INDEX `fk_Eventos_Severidad1_idx` ON `InnovativeIdeas`.`Eventos` (`idSeveridad` ASC) ;


-- -----------------------------------------------------
-- Table `InnovativeIdeas`.`Publicaciones_has_Tags`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `InnovativeIdeas`.`Publicaciones_has_Tags` (
  `idPublicaciones` INT NOT NULL ,
  `idTags` INT NOT NULL ,
  PRIMARY KEY (`idPublicaciones`, `idTags`) ,
  CONSTRAINT `fk_Publicaciones_has_Tags_Publicaciones1`
    FOREIGN KEY (`idPublicaciones` )
    REFERENCES `InnovativeIdeas`.`Publicaciones` (`idPublicaciones` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Publicaciones_has_Tags_Tags1`
    FOREIGN KEY (`idTags` )
    REFERENCES `InnovativeIdeas`.`Tags` (`idTags` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Publicaciones_has_Tags_Tags1_idx` ON `InnovativeIdeas`.`Publicaciones_has_Tags` (`idTags` ASC) ;

CREATE INDEX `fk_Publicaciones_has_Tags_Publicaciones1_idx` ON `InnovativeIdeas`.`Publicaciones_has_Tags` (`idPublicaciones` ASC) ;


-- -----------------------------------------------------
-- Table `InnovativeIdeas`.`Seguidores`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `InnovativeIdeas`.`Seguidores` (
  `idSeguidores` INT NOT NULL AUTO_INCREMENT ,
  `idPublicaciones` INT NOT NULL ,
  `idTiposRelaciones` INT NOT NULL ,
  `Visibilidad` TINYINT(1) NOT NULL ,
  PRIMARY KEY (`idSeguidores`) ,
  CONSTRAINT `fk_Seguidores_Publicaciones1`
    FOREIGN KEY (`idPublicaciones` )
    REFERENCES `InnovativeIdeas`.`Publicaciones` (`idPublicaciones` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Seguidores_TiposRelaciones1`
    FOREIGN KEY (`idTiposRelaciones` )
    REFERENCES `InnovativeIdeas`.`TiposRelaciones` (`idTiposRelaciones` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Seguidores_Publicaciones1_idx` ON `InnovativeIdeas`.`Seguidores` (`idPublicaciones` ASC) ;

CREATE INDEX `fk_Seguidores_TiposRelaciones1_idx` ON `InnovativeIdeas`.`Seguidores` (`idTiposRelaciones` ASC) ;


-- -----------------------------------------------------
-- Table `InnovativeIdeas`.`Usuarios_has_Seguidores`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `InnovativeIdeas`.`Usuarios_has_Seguidores` (
  `Usuarios_idUsuarios` INT NOT NULL ,
  `Seguidores_idSeguidores` INT NOT NULL ,
  PRIMARY KEY (`Usuarios_idUsuarios`, `Seguidores_idSeguidores`) ,
  CONSTRAINT `fk_Usuarios_has_Seguidores_Usuarios1`
    FOREIGN KEY (`Usuarios_idUsuarios` )
    REFERENCES `InnovativeIdeas`.`Usuarios` (`idUsuarios` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Usuarios_has_Seguidores_Seguidores1`
    FOREIGN KEY (`Seguidores_idSeguidores` )
    REFERENCES `InnovativeIdeas`.`Seguidores` (`idSeguidores` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Usuarios_has_Seguidores_Seguidores1_idx` ON `InnovativeIdeas`.`Usuarios_has_Seguidores` (`Seguidores_idSeguidores` ASC) ;

CREATE INDEX `fk_Usuarios_has_Seguidores_Usuarios1_idx` ON `InnovativeIdeas`.`Usuarios_has_Seguidores` (`Usuarios_idUsuarios` ASC) ;


USE `InnovativeIdeas` ;


#INSERT INTO Modulos(nombre) VALUES
#("primero","segundo","tercero");

#INSERT INTO TiposEvento(nombre) VALUES
#("creacion Publicacion","calificacion publicacion","actualizacion publicacion");

#INSERT INTO Severidad(nombre) VALUES
#("baja","media","alta"); 

/*#################################################################################*/
/*					SP PARA LLENADO DE TABLAS MISCELANEAS    		   			   */								
/*#################################################################################*/

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `llenadoTipoPublicacion`(cadena TEXT, separador VARCHAR(20))
BEGIN
 
    DECLARE itemArray TEXT;
    DECLARE i INT;
 
    SET i = 1; # se le puede dar cualquier valor menos 0.
 
    # INTRO BUCLE
    WHILE i > 0 DO
 
        SET i = INSTR(cadena,separador); # setear i a la posicion donde esta el caracter para separar
 
        SET itemArray = SUBSTRING(cadena,1,i-1); 
        # esta variable guardara el valor actual del supuesto array
        # se logra cortando desde la posicion 1 que para MySQL es la primera letra 
        
        IF i > 0 THEN
        
            SET cadena = SUBSTRING(cadena,i+CHAR_LENGTH(separador),CHAR_LENGTH(cadena));
                
        # Preparar la cadena total para la proxima vez que se entre al bucle para eso corto desde la posicion
        # donde esta el caracter separador hasta el tamaño total de la cadena
       
        ELSE

 
            SET itemArray = cadena;
 
        
        END IF;
        
		IF NOT EXISTS (SELECT * FROM tipopublicacion WHERE nombre = itemArray) THEN
			INSERT INTO tipopublicacion (nombre) VALUES (itemArray);
		END IF;

    END WHILE;

END $$

DELIMITER $$

CREATE DEFINER=`root`@`localhost` PROCEDURE `llenadoTiposRelaciones`(cadena TEXT, separador VARCHAR(20))
BEGIN
 
    DECLARE itemArray TEXT;
    DECLARE i INT;
 
    SET i = 1; # se le puede dar cualquier valor menos 0.
 
    # INTRO BUCLE
    WHILE i > 0 DO
 
        SET i = INSTR(cadena,separador); # setear i a la posicion donde esta el caracter para separar
 
        SET itemArray = SUBSTRING(cadena,1,i-1); 
        # esta variable guardara el valor actual del supuesto array
        # se logra cortando desde la posicion 1 que para MySQL es la primera letra 
        
        IF i > 0 THEN
        
            SET cadena = SUBSTRING(cadena,i+CHAR_LENGTH(separador),CHAR_LENGTH(cadena));
                
        # Preparar la cadena total para la proxima vez que se entre al bucle para eso corto desde la posicion
        # donde esta el caracter separador hasta el tamaño total de la cadena
       
        ELSE

            SET itemArray = cadena;
 
        
        END IF;
        
		IF NOT EXISTS (SELECT * FROM TiposRelaciones WHERE nombre = itemArray) THEN
			INSERT INTO TiposRelaciones (nombre) VALUES (itemArray);
		END IF;
	
    END WHILE;
 
END $$

DELIMITER $$

CREATE DEFINER=`root`@`localhost` PROCEDURE `llenadoPaises`(cadena TEXT, separador VARCHAR(20))
BEGIN
 
    DECLARE itemArray TEXT;
    DECLARE i INT;
 
    SET i = 1; # se le puede dar cualquier valor menos 0.
 
    # INTRO BUCLE
    WHILE i > 0 DO
 
        SET i = INSTR(cadena,separador); # setear i a la posicion donde esta el caracter para separar
 
        SET itemArray = SUBSTRING(cadena,1,i-1); 
        # esta variable guardara el valor actual del supuesto array
        # se logra cortando desde la posicion 1 que para MySQL es la primera letra 
        
        IF i > 0 THEN
        
            SET cadena = SUBSTRING(cadena,i+CHAR_LENGTH(separador),CHAR_LENGTH(cadena));
                
        # Preparar la cadena total para la proxima vez que se entre al bucle para eso corto desde la posicion
        # donde esta el caracter separador hasta el tamaño total de la cadena
       
        ELSE

            SET itemArray = cadena;
 
        
        END IF;
        
		IF NOT EXISTS (SELECT * FROM Paises WHERE nombre = itemArray) THEN
			INSERT INTO Paises (nombre) VALUES (itemArray);
		END IF;
 
    END WHILE;

 
END $$

DELIMITER $$

CREATE DEFINER=`root`@`localhost` PROCEDURE `llenadoTiposCuenta`(cadena TEXT, separador VARCHAR(20))
BEGIN
 
    DECLARE itemArray TEXT;
    DECLARE i INT;
 
    SET i = 1; # se le puede dar cualquier valor menos 0.
 
    # INTRO BUCLE
    WHILE i > 0 DO
 
        SET i = INSTR(cadena,separador); # setear i a la posicion donde esta el caracter para separar
 
        SET itemArray = SUBSTRING(cadena,1,i-1); 
        # esta variable guardara el valor actual del supuesto array
        # se logra cortando desde la posicion 1 que para MySQL es la primera letra 
        
        IF i > 0 THEN
        
            SET cadena = SUBSTRING(cadena,i+CHAR_LENGTH(separador),CHAR_LENGTH(cadena));
                
        # Preparar la cadena total para la proxima vez que se entre al bucle para eso corto desde la posicion
        # donde esta el caracter separador hasta el tamaño total de la cadena
       
        ELSE

            SET itemArray = cadena;
 
        
        END IF;
        
		IF NOT EXISTS (SELECT * FROM TiposCuentas WHERE nombre = itemArray) THEN
			INSERT INTO TiposCuentas (nombre) VALUES (itemArray);
		END IF;
        
 
    END WHILE;

 
END $$

DELIMITER $$

CREATE DEFINER=`root`@`localhost` PROCEDURE `llenadoTiposAdjuntos`(cadena TEXT, separador VARCHAR(20))
BEGIN
 
    DECLARE itemArray TEXT;
    DECLARE i INT;
 
    SET i = 1; # se le puede dar cualquier valor menos 0.
 
    # INTRO BUCLE
    WHILE i > 0 DO
 
        SET i = INSTR(cadena,separador); # setear i a la posicion donde esta el caracter para separar
 
        SET itemArray = SUBSTRING(cadena,1,i-1); 
        # esta variable guardara el valor actual del supuesto array
        # se logra cortando desde la posicion 1 que para MySQL es la primera letra 
        
        IF i > 0 THEN
        
            SET cadena = SUBSTRING(cadena,i+CHAR_LENGTH(separador),CHAR_LENGTH(cadena));
                
        # Preparar la cadena total para la proxima vez que se entre al bucle para eso corto desde la posicion
        # donde esta el caracter separador hasta el tamaño total de la cadena
       
        ELSE

            SET itemArray = cadena;
 
        
        END IF;
        
		IF NOT EXISTS (SELECT * FROM TiposAdjuntos WHERE nombre = itemArray) THEN
			INSERT INTO TiposAdjuntos (nombre) VALUES (itemArray);
		END IF;
 
    END WHILE;

 
END $$

DELIMITER $$

CREATE DEFINER=`root`@`localhost` PROCEDURE `llenadoTiposLogros`(cadena TEXT, separador VARCHAR(20))
BEGIN
 
    DECLARE itemArray TEXT;
    DECLARE i INT;
 
    SET i = 1; # se le puede dar cualquier valor menos 0.
 
    # INTRO BUCLE
    WHILE i > 0 DO
 
        SET i = INSTR(cadena,separador); # setear i a la posicion donde esta el caracter para separar
 
        SET itemArray = SUBSTRING(cadena,1,i-1); 
        # esta variable guardara el valor actual del supuesto array
        # se logra cortando desde la posicion 1 que para MySQL es la primera letra 
        
        IF i > 0 THEN
        
            SET cadena = SUBSTRING(cadena,i+CHAR_LENGTH(separador),CHAR_LENGTH(cadena));
                
        # Preparar la cadena total para la proxima vez que se entre al bucle para eso corto desde la posicion
        # donde esta el caracter separador hasta el tamaño total de la cadena
       
        ELSE
 
            SET itemArray = cadena;
 
        
        END IF;
        
		IF NOT EXISTS (SELECT * FROM TiposLogros WHERE nombre = itemArray) THEN
			INSERT INTO TiposLogros (nombre) VALUES (itemArray);
		END IF;
        
 
    END WHILE;

END $$

DELIMITER $$

CREATE DEFINER=`root`@`localhost` PROCEDURE `llenadoEstadosPublicacion`(cadena TEXT, separador VARCHAR(20))
BEGIN
 
    DECLARE itemArray TEXT;
    DECLARE i INT;
 
    SET i = 1; # se le puede dar cualquier valor menos 0.
 
    # INTRO BUCLE
    WHILE i > 0 DO
 
        SET i = INSTR(cadena,separador); # setear i a la posicion donde esta el caracter para separar
 
        SET itemArray = SUBSTRING(cadena,1,i-1); 
        # esta variable guardara el valor actual del supuesto array
        # se logra cortando desde la posicion 1 que para MySQL es la primera letra 
        
        IF i > 0 THEN
            SET cadena = SUBSTRING(cadena,i+CHAR_LENGTH(separador),CHAR_LENGTH(cadena));
                
        # Preparar la cadena total para la proxima vez que se entre al bucle para eso corto desde la posicion
        # donde esta el caracter separador hasta el tamaño total de la cadena
       
        ELSE
            SET itemArray = cadena;
 
        END IF;
        
		IF NOT EXISTS (SELECT * FROM EstadosPublicacion WHERE nombre = itemArray) THEN
			INSERT INTO EstadosPublicacion (nombre) VALUES (itemArray);
		END IF;
 
    END WHILE;

END $$

CREATE DEFINER=`root`@`localhost` PROCEDURE `llenadoTags`(cadena TEXT, separador VARCHAR(20))
BEGIN
 
    DECLARE itemArray TEXT;
    DECLARE i INT;
 
    SET i = 1; # se le puede dar cualquier valor menos 0.
 
    # INTRO BUCLE
    WHILE i > 0 DO
 
        SET i = INSTR(cadena,separador); # setear i a la posicion donde esta el caracter para separar
 
        SET itemArray = SUBSTRING(cadena,1,i-1); 
        # esta variable guardara el valor actual del supuesto array
        # se logra cortando desde la posicion 1 que para MySQL es la primera letra 
        
        IF i > 0 THEN
        
            SET cadena = SUBSTRING(cadena,i+CHAR_LENGTH(separador),CHAR_LENGTH(cadena)); # Preparar la cadena total para la proxima vez que se entre al bucle para eso corto desde la posicion
																							# donde esta el caracter separador hasta el tamaño total de la cadena
        ELSE
 
            SET itemArray = cadena;
 
        END IF;
        
		IF NOT EXISTS (SELECT * FROM Tags WHERE nombre = itemArray) THEN
			INSERT INTO Tags (nombre) VALUES (itemArray);
		END IF;
 
    END WHILE;

END $$


DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `llenarCamposControl`()
BEGIN
	INSERT INTO CamposControl VALUES
	(1,"PCHogar","199.22.45","Mario","10121011010"),
	(2,"Mi Pc","199.22.45","Luis","12234234"),
	(3,"PC Oficina 1","199.22.45","Natalia","12234234"),
	(4,"PC Jasson","199.22.45","Jessica","12234234"),
	(5,"PC Danilo","199.22.45","Danilo","12234234"),
	(6,"Compu 3","199.22.45","Karla","12234234"),
	(7,"MEGA PC","199.22.45","Hugo","12234234"),
	(8,"PC2","199.22.45","Juan","12234234"),
	(9,"COMPUTADORA CASA","199.22.45","Yamada","12234234"),
	(10,"MICompañia","199.22.45","Pepe","12234234");

END $$



/*#################################################################################*/
/*					SP LLENADO DE TABLAS CON VALORES RANDOM 		   			   */								
/*#################################################################################*/

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `llenarProvincia`()
BEGIN
 
	DECLARE variable int;

	DROP TEMPORARY TABLE IF EXISTS tabla_temp;
	CREATE TEMPORARY TABLE tabla_temp
	(
		id int(11) NOT NULL auto_increment,
		descripcion varchar(50),
		PRIMARY KEY (`id`),
		UNIQUE KEY `id` (`id`)
	) ;
	
	INSERT INTO tabla_temp VALUES 
	(1,"SanJose"),
	(2,"Cartago"),
	(3,"Heredia"),
	(4,"Alajuela"),
	(5,"Puntarenas"),
	(6,"Guanacaste"),
	(7,"Limon");

	SET variable = (SELECT COUNT(*) FROM Paises);
	INSERT INTO Provincias (idProvincia,nombre,idPais) SELECT tabla_temp.id,tabla_temp.descripcion,1 FROM tabla_temp;
	UPDATE Provincias SET idPais = (SELECT 1 + ROUND(RAND() * (variable - 1)));

	DROP TEMPORARY TABLE IF EXISTS tabla_temp;

END $$

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `llenarCiudades`()
BEGIN
 
	DECLARE variable int;

	DROP TEMPORARY TABLE IF EXISTS tabla_temp;
	CREATE TEMPORARY TABLE tabla_temp
	(
		id int(11) NOT NULL auto_increment,
		nombre varchar(50),
		PRIMARY KEY (`id`),
		UNIQUE KEY `id` (`id`)
	) ;
	
	INSERT INTO tabla_temp VALUES 
	(1,"escazu"),(2,"desamparados"),(3,"puriscal"),(4,"aserri"),(5,"mora"),
	(6,"paraiso"),(7,"turrialba"),(8,"alvarado"),(9,"oreamuno"),(10,"jimenez"),
	(11,"barva"),(12,"belen"),(13,"flores"),(14,"sarapiqui"),(15,"san Pablo"),
	(16,"grecia"),(17,"atenas"),(18,"naranjo"),(19,"upala"),(20,"naranjo"),
	(21,"esparza"),(22,"osa"),(23,"golfito"),(24,"parrita"),(25,"garabito"),
	(26,"liberia"),(27,"nicoya"),(28,"santa Cruz"),(29,"cañas"),(30,"abangares"),
	(31,"pococi"),(32,"matina"),(33,"guacimo"),(34,"siquirres"),(35,"talamanca");

	SET variable = (SELECT COUNT(*) FROM Provincias);
	INSERT INTO Ciudades (idCiudades,nombre,idProvincia) SELECT tabla_temp.id,tabla_temp.nombre,1 FROM tabla_temp;
	UPDATE Ciudades SET idProvincia = (SELECT 1 + ROUND(RAND() * (variable - 1)));
	
	DROP TEMPORARY TABLE IF EXISTS tabla_temp;

END $$

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `llenarDirecciones`()
BEGIN

	DECLARE variable,randomIdPErfil,contador,randomPerfil,i int;

	DROP TEMPORARY TABLE IF EXISTS referencia;
	DROP TEMPORARY TABLE IF EXISTS coordenadas;
	DROP TEMPORARY TABLE IF EXISTS tabla_temp;
	DROP TEMPORARY TABLE IF EXISTS randomUsuarios;

CREATE TEMPORARY TABLE randomUsuarios
	(
		idRandom int(11) NOT NULL auto_increment,
		valor int(11),
		PRIMARY KEY (`idRandom`),
		UNIQUE KEY `idRandom` (`idRandom`)
	) ;

	
	CREATE TEMPORARY TABLE referencia
	(
		idRef int(11) NOT NULL auto_increment,
		referencia1 varchar(400),
		referencia2 varchar(400),
		PRIMARY KEY (`idRef`),
		UNIQUE KEY `idRef` (`idRef`)
	) ;

	CREATE TEMPORARY TABLE coordenadas
	(
		idCor int(11) NOT NULL auto_increment,
		lat varchar(50),
		lon varchar(50),
		PRIMARY KEY (`idCor`),
		UNIQUE KEY `idCor` (`idCor`)
	) ;


	INSERT INTO referencia(referencia1,referencia2) VALUES 
	("350 metros este del banco popular","Casa numero 20"),				
	("150 metros oeste del tribunal","Porton color verde"),				
	("200 metros noreste de la catedral","Calle 52"),					
	("De Pizza Hut 75 metros al Oeste"," contiguo a Citi Bank"),			
	("De Casa Presidencial 200 metros al Oeste"," contiguo a bar chelo"),			
	("200 metros noreste de la catedral","Casa numero 20"),					
	("150 metros oeste del tribunal","contiguo a bar juanchos"),			
	("De Taco Bell 175 metros al Oeste"," contiguo Porton numero 20"),			
	("75 metros este del juzgado","contiguo a restaurante miramar"),			
	("Del palomar en San Pedro 300 al sur","diagonal al cine REX"),				
	("De la esquina del bar Zoom 50 metros al norte","primera casa amarilla con portones rojos"),
	("De la casona de Matilde 100 metros norte","Casa de techo verde"),			
	("150 metros oeste de soda Tere","Diagonal a las vias del tren"),			
	("100 metros oeste de las vias del tren","Frente a Club Arcadas"),			
	("De Taco Bell 175 metros al Oeste"," contiguo Porton numero 20"),			
	("350 metros este del banco popular","Casa numero 17"),
	("75 metros este del juzgado","contiguo a restaurante miramar"),		
	("De Casa Rosa 200 metros al Oeste"," contiguo a bar chelo"),			
	("Del palomar en San Pedro 300 al sur","diagonal a CCM Cinemas"),			
	("150 metros oeste de soda Angelica","Frente a Calle Ancha"),				
	("150 metros oeste de Bar Amplio","Frente a la casa de Ramon");

	INSERT INTO coordenadas (lat,lon) VALUES
	("45","180"),("175","50"),("210","150"),("180","210"),("170","210"),
	("210","150"),("170","210"),("180","210"),("90","310"),("190","210"),
	("115","270"),("215","170"),("170","210"),("225","135"),("180","210"),	
	("90","310"),("170","210"),("190","115"),("170","210"),("210","180");

	SET contador = 1;
	SET randomIdPErfil = (SELECT COUNT(*) FROM referencia) ;


	WHILE contador <= randomIdPErfil DO
	
	SET randomPerfil = (SELECT 1 + ROUND(RAND() * ((SELECT COUNT(*) FROM referencia) - 1)));
	
	IF (SELECT valor FROM randomUsuarios WHERE valor = randomPerfil) THEN
		SET contador = contador-1;
    ELSE
        INSERT INTO randomUsuarios (valor) VALUES (randomPerfil);
    END IF;

	SET contador=contador+1;


	END WHILE;


	INSERT INTO Direcciones(detalle1,detalle2,idCiudades,latitud,longitud) 
	SELECT referencia.referencia1,referencia.referencia2,1,coordenadas.lat,coordenadas.lon
	FROM referencia,coordenadas,randomUsuarios
	WHERE randomUsuarios.valor = referencia.idRef AND randomUsuarios.valor = coordenadas.idCor; 

	SET i = (SELECT COUNT(*) FROM Ciudades);
	UPDATE Direcciones SET idCiudades = (SELECT 1 + ROUND(RAND() * (i - 1)));


	DROP TEMPORARY TABLE IF EXISTS referencia;
	DROP TEMPORARY TABLE IF EXISTS coordenadas;
	DROP TEMPORARY TABLE IF EXISTS tabla_temp;
	DROP TEMPORARY TABLE IF EXISTS randomUsuarios;

END $$

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `llenarInstituciones`()
BEGIN
 
	DECLARE variable int;

	DROP TEMPORARY TABLE IF EXISTS tabla_temp;
	DROP TEMPORARY TABLE IF EXISTS tabla_aux;
	CREATE TEMPORARY TABLE tabla_temp
	(
		id int(11) NOT NULL auto_increment,
		nombre varchar(45),
		PRIMARY KEY (`id`),
		UNIQUE KEY `id` (`id`)
	) ;

	CREATE TEMPORARY TABLE tabla_aux
	(
		id int(11),
		nombre varchar(45),
		idDir int(11),
		PRIMARY KEY (`id`),
		UNIQUE KEY `id` (`id`)
	) ;
	
	INSERT INTO tabla_temp(nombre) VALUES 
	("Instituto Tecnologico de Costa Rica"),("Liceo de Calle Fallas"),
	("Innovative Ideas"),("Universidad de Costa Rica"),("McDonals"),
	("ICE"),("Zoologico Simon Bolivar"),("Harvard University"),("MIT"),
	("Museo Nacional"),("Parque de Diversiones"),("Teletica");
	

	SET variable = (SELECT COUNT(*) FROM Direcciones);
	
	INSERT INTO tabla_aux (id,nombre,idDir) 
	SELECT tabla_temp.id,tabla_temp.nombre,1
	FROM tabla_temp;
	UPDATE tabla_aux SET idDir = (SELECT 1 + ROUND(RAND() * (variable - 1)));

	SET variable = (SELECT COUNT(*) FROM TiposLogros);
	
	INSERT INTO Instituciones (idInstituciones,nombre,idDirecciones,idTiposLogros) 
	SELECT tabla_aux.id,tabla_aux.nombre,tabla_aux.idDir,1
	FROM tabla_aux;
	
	UPDATE Instituciones SET idTiposLogros = (SELECT 1 + ROUND(RAND() * (variable - 1)));
	
	DROP TEMPORARY TABLE IF EXISTS tabla_temp;
	DROP TEMPORARY TABLE IF EXISTS tabla_aux;

END $$

DELIMITER $$
DROP PROCEDURE IF EXISTS llenarLogros $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `llenarLogros`()
BEGIN

	DECLARE variable,randomIdPErfil,contador,randomPerfil,i int;

	DROP TEMPORARY TABLE IF EXISTS referencia;
	DROP TEMPORARY TABLE IF EXISTS coordenadas;
	DROP TEMPORARY TABLE IF EXISTS tabla_temp;
	DROP TEMPORARY TABLE IF EXISTS randomUsuarios;
	

	CREATE TEMPORARY TABLE randomUsuarios
	(
		idRandom int(11) NOT NULL auto_increment,
		valor int(11),
		PRIMARY KEY (`idRandom`),
		UNIQUE KEY `idRandom` (`idRandom`)
	) ;


	CREATE TEMPORARY TABLE referencia
	(
		idRef int(11) NOT NULL auto_increment,
		referencia1 varchar(400),
		referencia2 varchar(400),
		PRIMARY KEY (`idRef`),
		UNIQUE KEY `idRef` (`idRef`)
	) ;


	CREATE TEMPORARY TABLE coordenadas
	(
		idCor int(11) NOT NULL auto_increment,
		lat varchar(400),
		PRIMARY KEY (`idCor`),
		UNIQUE KEY `idCor` (`idCor`)
	) ;


	INSERT INTO referencia(referencia1,referencia2) VALUES 
	("2001-01-02" ,"2011-01-02"),("1994-01-02","1998-01-02"),					
	("1996-01-02","1997-01-02"),("1998-01-02","1998-11-09"),					
	("1999-01-02","2007-01-02"),("1998-01-02","1998-01-02"),					
	("1994-01-02","1999-01-02"),("1998-01-02","2008-01-01"),					
	("1991-01-02","2001-01-02"),("1998-01-02","1998-01-03"),			
	("1993-01-02","2004-01-02"),("1998-01-02","2011-09-05"),					
	("1995-01-02","1996-01-02"),("1998-01-02","1998-07-11"),					
	("1998-01-02","2008-01-02"),("1998-01-02","2008-10-12"),					
	("1997-01-02","2011-01-02"),("1998-01-02","1998-05-11"),					
	("1999-01-02","2001-01-02"),("1998-01-02","2008-06-07");	

	INSERT INTO coordenadas (lat) VALUES
	("Bachillerato en Ingenieria en Computacion"),("Educacion Media"),
	("Desarrollador Web"),("Licenciatura en Economia"),
	("Encargado Nacional de Mercadeo"),("Revision de Telecomunicaciones"),
	("Gerente General"),("Engineering Sciences: Bioengineering (Ph.D.)"),
	("Civil and Environmental Engineering (Ph.D.)"),("Curador"),
	("Director De Noticiero"),("Applied Mathematics (Ph.D.)"),
	("Licenciatura en Ingenieria Mecanica"),("Licenciatura en Produccion Industrial"),
	("Publicista"),	("Computational and Systems Biology (Ph.D.) "),
	("Engineering Sciences: Environmental Science and Engineering (S.M.)"),
	("Periodista"),("Ingeniero en Software"),("Ingeniero Industrial");

	SET contador = 1;
	SET randomIdPErfil = (SELECT COUNT(*) FROM coordenadas) ;

	WHILE contador <= randomIdPErfil DO
	
	SET randomPerfil = (SELECT 1 + ROUND(RAND() * ((SELECT COUNT(*) FROM referencia) - 1)));
	
	IF (SELECT valor FROM randomUsuarios WHERE valor = randomPerfil) THEN
		SET contador = contador-1;
    ELSE
        INSERT INTO randomUsuarios (valor) VALUES (randomPerfil);
    END IF;

	SET contador=contador+1;

	END WHILE;


	INSERT INTO Logros(fechaInicio,fechaFinal,descripcion,idPerfiles,idTiposLogros,idInstituciones) 
	SELECT referencia.referencia1,referencia.referencia2,coordenadas.lat,randomUsuarios.valor,1,1 
	FROM (referencia INNER JOIN randomUsuarios ON randomUsuarios.valor = referencia.IdRef)
					 INNER JOIN coordenadas  ON randomUsuarios.valor = coordenadas.IdCor; 


	UPDATE Logros SET idTiposLogros = (SELECT idTiposLogros FROM TiposLogros ORDER BY RAND() LIMIT 1);#(SELECT 1 + ROUND(RAND() * (i - 1)));

	UPDATE Logros SET idInstituciones = (SELECT idInstituciones FROM Instituciones ORDER BY RAND() LIMIT 1);#(SELECT 1 + ROUND(RAND() * (contador - 1)));
	
	
	DROP TEMPORARY TABLE IF EXISTS referencia;
	DROP TEMPORARY TABLE IF EXISTS coordenadas;
	DROP TEMPORARY TABLE IF EXISTS tabla_temp;
	DROP TEMPORARY TABLE IF EXISTS randomUsuarios;


END $$

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `llenarPerfiles`() 
BEGIN
 
	DECLARE variable,contador,cantidadUsuarios,randomUsu int;

	DROP TEMPORARY TABLE IF EXISTS randomUsuarios;
	DROP TEMPORARY TABLE IF EXISTS foto;
	DROP TEMPORARY TABLE IF EXISTS nombre;
	DROP TEMPORARY TABLE IF EXISTS apellido;
	DROP TEMPORARY TABLE IF EXISTS fecha;

	CREATE TEMPORARY TABLE randomUsuarios
	(
		idRandom int(11) NOT NULL auto_increment,
		random int(11),
		PRIMARY KEY (`idRandom`),
		UNIQUE KEY `idRandom` (`idRandom`)
	) ;


	CREATE TEMPORARY TABLE foto
	(
		idFoto int(11) NOT NULL auto_increment,
		foto varchar(700),
		PRIMARY KEY (`idFoto`),
		UNIQUE KEY `idFoto` (`idFoto`)
	) ;

	CREATE TEMPORARY TABLE nombre
	(
		idNombre int(11) NOT NULL auto_increment,
		nombre varchar(100),
		PRIMARY KEY (`idNombre`),
		UNIQUE KEY `idNombre` (`idNombre`)
	) ;

	CREATE TEMPORARY TABLE apellido
	(
		idApellido int(11) NOT NULL auto_increment,
		apellido1 varchar(100),
		apellido2 varchar(100),
		PRIMARY KEY (`idApellido`),
		UNIQUE KEY `idApellido` (`idApellido`)
	) ;

	CREATE TEMPORARY TABLE fecha
	(
		idFecha int(11) NOT NULL auto_increment,
		fecha datetime,
		PRIMARY KEY (`idFecha`),
		UNIQUE KEY `idFecha` (`idFecha`)
	) ;

	SET contador = 1;

    WHILE contador <= 20 DO

	SET randomUsu = (SELECT 1 + ROUND(RAND() * (20 - 1)));

	IF (SELECT random FROM randomUsuarios WHERE random = randomUsu) THEN
		SET contador = contador-1;
    ELSE
        INSERT INTO randomUsuarios (random) VALUES (randomUsu);
    END IF;

	SET contador=contador+1;

	END WHILE;


	INSERT INTO foto (foto) VALUES
	("http://t3.gstatic.com/images?q=tbn:ANd9GcTaQt6-bSja2-6n6qAOvfJMvqc9uQsOMQ4kMR58thbuRaeF04iT"),
	("http://t0.gstatic.com/images?q=tbn:ANd9GcRPdHTpBam5w77cTwK0K6QOElnFsB0k9WmIN_VnPXQXN47JPtT3"),
	("http://t1.gstatic.com/images?q=tbn:ANd9GcTGUNrQx-UTb2RaZ2EoW8U2xiMbOuiKorKeSLMkqZhzaH4Yi_tuzg"),
	("http://images02.olx.es/ui/4/95/46/65138946_1-canguro-chica-de-limpieza-cuidado-personas-mayores-centro.jpg"),
	("http://t3.gstatic.com/images?q=tbn:ANd9GcRNjJo99EZHN1aE0vvxAMNr5bZgitAunX91-kfqliYfYR1Abcy-fA"),
	("http://t3.gstatic.com/images?q=tbn:ANd9GcQAfiQDFdKfejFqCFG0J-2sOpuMABtUnzX3b2mQ3iCyyTyMAEYA"),
	("http://noticias.universia.edu.ve/ve/images/docentes/p/pe/per/personas-sacar-de-tu-circulo-de-amistades.jpg"),
	("http://i.cdn.turner.com/dr/nba/teamsites-nbateams/release/magic/sites/magic/files/imagecache/magic_standard/martins00_300_060811.jpg"),
	("http://t0.gstatic.com/images?q=tbn:ANd9GcRKrvhs4umlH_QVsKJ8tNCPK9xvyqAhRexX68TNTwm0f-tlFvnmGw"),
	("http://t0.gstatic.com/images?q=tbn:ANd9GcTobFvYZaxn5BNLvMc_iVLlASFv7lq1yazuxtJhZfBWyL7eEP1Rgg"),
	("http://t1.gstatic.com/images?q=tbn:ANd9GcQfgxLhPuIJNxobKlbPY4GYRUd1HR7VdfCaYzLvvWznn-9_mAaE"),
	("http://www.s21.com.gt/sites/default/files/imagecache/471x300/capturado%20por%20trata%20de%20personas%20en%20la%20zona%2012.jpg"),
	("http://t0.gstatic.com/images?q=tbn:ANd9GcQM266v7FHhtCoo1XOUkwfcqXnfW6Nk_3jJNhm06KriW5OzEKSX8Q"),
	("http://t2.gstatic.com/images?q=tbn:ANd9GcSGQvm4U5E3Q2p2TIOtGfmsnfxmHYndz2TrW4F1o-47SaPP7AUf2Q"),
	("http://t2.gstatic.com/images?q=tbn:ANd9GcSGQvm4U5E3Q2p2TIOtGfmsnfxmHYndz2TrW4F1o-47SaPP7AUf2Q"),
	("http://t1.gstatic.com/images?q=tbn:ANd9GcRqoa5XPkbANSAMZflxtKgUN06s3kdFsAX9QyzUKqIZa4CPdEmX"),
	("http://t1.gstatic.com/images?q=tbn:ANd9GcSQEkq1sLJ_evfX3QFza20gXMypIlZS1QXGtv_I9DDWhiPeptd8"),
	("http://t0.gstatic.com/images?q=tbn:ANd9GcTkEjBEme4qhQN2As8i7rmFGSMH1xrWcPb7Ss6qwQE3A4MvI52h"),
	("http://t3.gstatic.com/images?q=tbn:ANd9GcQml2NbYh_ayIVgvGH6ic6FXHSApmJpFLeVx7_T-HMbiF4GrWym"),
	("http://t0.gstatic.com/images?q=tbn:ANd9GcQwMLQ9I34bydFvQSmgxf_WuZCaotaWB_OsLJg_Slxqf5l5nPsTTQ");

	INSERT INTO nombre(nombre) VALUES
	("Juan"),("Pio"),("Juana"),("Teresa"),("Pedro"),("Ana"),("Esteban"),("Luis"),("Angela"),
    ("Digna"),("Hilda"),("Juan"),("Ramon"),("Luis"),("Luis"),("Ernesto"),("Daniela"),
	("Rafael"),("Marlen"),("Edison");

	INSERT INTO apellido(apellido1,apellido2) VALUES
	("Perez","Zuñiga"),("Porras","Tellez"),("Alvarado","Rios"),("Alvarez","Rios"),
	("Artavia","Perez"),("Salguero","Prendas"),("Jimenez","Perez"),("Nuñez","Perez"),
	("Artavia","Gonzales"),("Rubi","Cerdas"),("Perez","Cerdas"),("Perez","Rodriguez"),
	("Perez","Rodriguez"),("Gutierrez","White"),("Gutierrez","White"),("Maury","Acosta"),
	("Lopez","Acosta"),("Merkel","Rubi"),("Ulloa","Torres"),("Espinoza","Flores");

	INSERT INTO fecha(fecha) VALUES
	("1990-06-08"),("1884-06-08"),("1965-06-08"),("1985-09-10"),("1989-12-12"),
	("1970-11-10"),("1977-11-08"),("1986-01-08"),("1995-07-12"),("1977-02-02"),
	("1977-02-02"),("1982-11-06"),("1972-01-01"),("1985-08-06"),("1986-11-06"),
	("1972-12-10"),("1977-03-06"),("1950-11-11"),("1950-11-11"),("1950-11-11");


	SET variable = (SELECT COUNT(*) FROM Direcciones);
	
	INSERT INTO Perfiles (fotografia,nombre,apellido1,apellido2,fechaNacimiento,idDirecciones) 
	SELECT foto.foto,nombre.nombre,apellido.apellido1,apellido.apellido2,fecha.fecha,1
	FROM fecha INNER JOIN randomUsuarios ON randomUsuarios.random = fecha.idFecha
			   INNER JOIN apellido  ON apellido.idApellido = randomUsuarios.random
			   INNER JOIN nombre ON  nombre.idNombre = randomUsuarios.random 
			   INNER JOIN foto ON foto.idFoto = randomUsuarios.random;
	
	UPDATE Perfiles SET idDirecciones = (SELECT 1 + ROUND(RAND() * (variable - 1)));

	
	DROP TEMPORARY TABLE IF EXISTS randomUsuarios;
	DROP TEMPORARY TABLE IF EXISTS foto;
	DROP TEMPORARY TABLE IF EXISTS nombre;
	DROP TEMPORARY TABLE IF EXISTS apellido;
	DROP TEMPORARY TABLE IF EXISTS fecha;
	
END $$


DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `llenarUsuarios`() 
BEGIN
 
	DECLARE variable,randomIdPErfil,contador,randomPerfil int;

	DROP TEMPORARY TABLE IF EXISTS tabla_temp;
	DROP TEMPORARY TABLE IF EXISTS tabla_aux;
	DROP TEMPORARY TABLE IF EXISTS randomUsuarios;
	DROP TEMPORARY TABLE IF EXISTS Usuario;
	DROP TEMPORARY TABLE IF EXISTS Contrasenia;
	DROP TEMPORARY TABLE IF EXISTS Correo;
	
CREATE TEMPORARY TABLE Usuario
	(
		id int(11) NOT NULL auto_increment,
		username varchar(200),
		PRIMARY KEY (`id`),
		UNIQUE KEY `id` (`id`)
	) ;

CREATE TEMPORARY TABLE Contrasenia
	(
		id int(11) NOT NULL auto_increment,
		contrasenia varchar(200),
		PRIMARY KEY (`id`),
		UNIQUE KEY `id` (`id`)
	) ;


CREATE TEMPORARY TABLE Correo
	(
		id int(11) NOT NULL auto_increment,
		correo varchar(200),
		PRIMARY KEY (`id`),
		UNIQUE KEY `id` (`id`)
	) ;


CREATE TEMPORARY TABLE randomUsuarios
	(
		idRandom int(11) NOT NULL auto_increment,
		valor int(11),
		PRIMARY KEY (`idRandom`),
		UNIQUE KEY `idRandom` (`idRandom`)
	) ;

CREATE TEMPORARY TABLE tabla_aux
	(
		idRandom int(11) NOT NULL auto_increment,
		usuario varchar(200),
		contrasenia varchar(200),
		correo varchar(200),
		PRIMARY KEY (`idRandom`),
		UNIQUE KEY `idRandom` (`idRandom`)
	) ;

	
	SET randomIdPErfil = (SELECT COUNT(*) FROM Perfiles) ;

	INSERT INTO randomUsuarios (valor) 
	SELECT idPerfiles FROM Perfiles ORDER BY RAND() LIMIT randomIdPErfil;

	INSERT INTO Usuario(username) VALUES 
	("jasson0802"),("daniloTec"),("mariaJCor"),("EltonJ"),("Pagador0101"),
	("MMaroto"),("internet1"),("maeRandom1"),("innovador02"),("julia99"),
	("moradito"),("maeTec"),("RobaIdeas94"),("Plagiador01"),("hackerPichudo"),
	("Jess11"),("pepito"),("cazaIdeas88"),("bobMar"),("cerealKiller");

	
	INSERT INTO Contrasenia(contrasenia) VALUES 
	("dfasfaa879983sd"),("sdfgs6d5fg4s6f"),("87d8d49df9ds6"),("8d9d4c4d9d"),
	("d54sdf49sdf49"),("sd4f5sd54fbgtb"),("89wd4f9d84fttt"),("f44f94f9f4b8w9r"),
	("8r8r794dsd494f"),("d11d6fe69q"),("w89e874d8fv4f8"),("69dfgf48e9w4d"),
	("we98frw9e8ef"),("r9d49d84fs89dfsddsf"),("56d4f65s4d56d4"),("56r4893a1a3a"),
	("9r41d36212x31"),("5646r4613a15s"),("f64gs6d4f9849"),("q9w84zx64h89gfs6");


	INSERT INTO Correo(correo) VALUES 
	("jasson0802@hotmail.com"),("danilo@gmail.com"),("blabla@.itcr.ac.cr"),
	("lololol@hotmail.com"),("pgdr@internet.com"),("mrto@gmail.com"),("intrnt@hotmail.com"),
    ("mRand@internet.com"),("innvdr@correo.com"),	("jla0@correito.com"),
	("mrdt@.internet.com"),("maeTec@hotmail.com"),("rbds@hotmail.com"),
	("plgdr@internet.com"),("hckr@hackerCorreo.com"),("jss@correo.com"),
	("sdca@gmail.com"),("czaId@gmail.com"),("elBob@hotmail.com"),("cralK@correo.com");
	

	INSERT INTO tabla_aux (usuario,contrasenia,correo) 
	SELECT Usuario.username,Contrasenia.contrasenia,Correo.correo
	FROM Usuario INNER JOIN randomUsuarios ON randomUsuarios.valor = Usuario.id
			     INNER JOIN Contrasenia  ON randomUsuarios.valor = Contrasenia.id
				 INNER JOIN Correo  ON randomUsuarios.valor = Correo.id;


	SET variable = (SELECT COUNT(*) FROM TiposCuentas);
	

	INSERT INTO Usuarios (username,password,idPerfiles,email,idTiposCuentas)
	SELECT tabla_aux.usuario,MD5(tabla_aux.contrasenia),randomUsuarios.valor,tabla_aux.correo,1
	FROM tabla_aux,randomUsuarios WHERE tabla_aux.idRandom = randomUsuarios.idRandom;


	UPDATE Usuarios SET idTiposCuentas = (SELECT 1 + ROUND(RAND() * (variable - 1)));
	
	
	DROP TEMPORARY TABLE IF EXISTS tabla_temp;
	DROP TEMPORARY TABLE IF EXISTS tabla_aux;
	DROP TEMPORARY TABLE IF EXISTS randomUsuarios;
	DROP TEMPORARY TABLE IF EXISTS Usuario;
	DROP TEMPORARY TABLE IF EXISTS Contrasenia;
	DROP TEMPORARY TABLE IF EXISTS Correo;

END $$


DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `llenarPublicaciones`()
BEGIN
	DECLARE variable,i,contador,cantidadUsuarios,randomUsu int;
	

	DROP TEMPORARY TABLE IF EXISTS descripciones;
	DROP TEMPORARY TABLE IF EXISTS fechas;
	DROP TEMPORARY TABLE IF EXISTS titulos;
	DROP TEMPORARY TABLE IF EXISTS randomUsuarios;
	DROP TEMPORARY TABLE IF EXISTS tabla_temp;
	
	CREATE TEMPORARY TABLE descripciones
	(
		idDes int(11) NOT NULL auto_increment,
		descripcion varchar(400),
		PRIMARY KEY (`idDes`),
		UNIQUE KEY `idDes` (`idDes`)
	) ;
	
	CREATE TEMPORARY TABLE randomUsuarios
	(
		idRandom int(11) NOT NULL auto_increment,
		valor int(11),
		PRIMARY KEY (`idRandom`),
		UNIQUE KEY `idRandom` (`idRandom`)
	) ;


	CREATE TEMPORARY TABLE fechas
	(
		idFec int(11) NOT NULL auto_increment,
		fecha datetime,
		PRIMARY KEY (`idFec`),
		UNIQUE KEY `idFec` (`idFec`)
	) ;

	CREATE TEMPORARY TABLE titulos
	(
		idTit int(11) NOT NULL auto_increment,
		titulo varchar(400),
		PRIMARY KEY (`idTit`),
		UNIQUE KEY `idTit` (`idTit`)
	) ;
	
	CREATE TEMPORARY TABLE tabla_temp
	(
		id int(11) NOT NULL auto_increment,
		descripcion varchar(400),
		fecha datetime,
		titulo varchar(100),
		PRIMARY KEY (`id`),
		UNIQUE KEY `id` (`id`)
	) ;

	INSERT INTO descripciones (descripcion) VALUES 
	("Quiero saber como evitar desmayarme sobre el teclaahoshoishgsadfgiew"),
	("Quiero saber como convertirme en supersayayin para salvar el mundo"),
	("En mi comunidad existe mucha delincuencia por la falta de oportunidades"),
	("En mi comunidad existe mucha desercion escolar por falta de dinero"),
	("Falta agua potable en mi ciudad por culpa del gobierno"),
	("No existe una biblioteca publica cerca en mi ciudad por culpa de Laura Chinchilla"),
	("Los jovenes de mi barrio consumen drogas por culpa de sus padre"),
	("En mi barrio no existe un lugar de atencion para los adultos mayores por falta de dinero"),
	("En mi comunidad no existen escuelas publicas y los jovenes prefieren trabajar que estudiar"),
	("Quiero crear un smartphone para niños preescolares para que aprendan más rápido, ¿Cuales serian algunas funcionalidades que necesita?"),
	("Buscar maneras ecologicas de mantener los desechos"),
	("Consejos utiles para mantener sanos a sus mascotas"),
	("Como producir energia renovable"),
	("Posibles soluciones para la contaminacion del agua con arsenico"),
	("Consejos practicos para Web Developers"),
	("Como solucionar la falta de energia que se presenta en Talamanca"),
	("Consejos para familias con integrantes en problemas de drogadiccion"),
	("Practicas saludables a la hora de dormir"),
	("Guia basica de como programar en Python"),
	("Como cultivar correctamente su planta preferida");
	

	INSERT INTO fechas (fecha) VALUES
	("2013-01-23"),("2013-05-23"),("2013-09-23"),("2013-01-24"),("2013-05-24"),
	("2013-02-23"),("2013-06-23"),("2013-10-23"),("2013-02-24"),("2013-06-24"),
	("2013-03-23"),("2013-07-23"),("2013-11-23"),("2013-03-24"),("2013-07-24"),
	("2013-04-23"),("2013-08-23"),("2013-12-23"),("2013-04-24"),("2013-08-24");

	INSERT INTO titulos (titulo) VALUES
	("Necesito dejar de dormir sobre el teclado "),("Quiero salvar el mundo "),
	("¿Como ayudar a mi comunidad"),("Ayudar a los niños a estudiar"),
	("No hay agua en mi comunidad"),("Queremos una biblioteca"),
	("Jovenes drogadictos"),("Abandono a adultos mayores"),("No hay escuela"),
	("Smarphone para niños"),("Desechos mas Ecologicos"),("Salud Mascotas"),
	("Energia renovable"),("Contaminacion Agua"),("Web Developers"),("Falta de Energia"),
	("Problemas de Drogas"),("Dormir"),("Iniciar a Programar"),("Cultivo de Plantas");


	INSERT INTO randomUsuarios(valor)
	SELECT idTit FROM titulos ORDER BY RAND() LIMIT 20;

	
	INSERT INTO tabla_temp(DESCRIPCION,FECHA,TITULO) 
	SELECT descripciones.descripcion,fechas.fecha,titulos.titulo
	FROM  descripciones INNER JOIN fechas ON descripciones.idDes=fechas.idFec
						INNER JOIN titulos  ON titulos.idTit=fechas.idFec;

	SET i = (SELECT COUNT(*) FROM CamposControl);

	INSERT INTO Publicaciones (descripcion,fechaCreacion,idTipoPublicacion,idProyectos,Titulo,idUsuarios,idEstadosPublicacion,idCamposControl,idPublicacionesfk) 
	SELECT tabla_temp.descripcion,tabla_temp.fecha,1,NULL,tabla_temp.titulo,randomUsuarios.valor,1,1,tabla_temp.id
	FROM  tabla_temp INNER JOIN randomUsuarios ON tabla_temp.id = randomUsuarios.idRandom;

	UPDATE Publicaciones SET idCamposControl = (SELECT 1 + ROUND(RAND() * (i - 1)));

	DROP TEMPORARY TABLE IF EXISTS descripciones;
	DROP TEMPORARY TABLE IF EXISTS fechas;
	DROP TEMPORARY TABLE IF EXISTS titulos;
	DROP TEMPORARY TABLE IF EXISTS randomUsuarios;
	DROP TEMPORARY TABLE IF EXISTS tabla_temp;

END $$

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `llenarSeguidores`()
BEGIN
 
	DECLARE variable,randomIdPErfil,contador,randomPublicacion int;

	DROP TEMPORARY TABLE IF EXISTS tabla_temp;
	DROP TEMPORARY TABLE IF EXISTS randomUsuarios;
	
CREATE TEMPORARY TABLE randomUsuarios
	(
		idRandom int(11) NOT NULL auto_increment,
		valor int(11),
		idRelacion int(11),
		PRIMARY KEY (`idRandom`),
		UNIQUE KEY `idRandom` (`idRandom`)
	) ;

	SET contador = 1;
	SET randomIdPErfil = (SELECT COUNT(*) FROM Publicaciones WHERE idTipoPublicacion = 1) ;

	WHILE contador <= randomIdPErfil*3  DO 
	
	SET randomPublicacion = (SELECT 1 + ROUND(RAND() * ((SELECT COUNT(*) FROM Publicaciones WHERE idTipoPublicacion = 1) - 1)));
	
		INSERT INTO randomUsuarios (valor,idRelacion) VALUES (randomPublicacion,2);

	SET contador=contador+1;

	END WHILE;

	SET variable = (SELECT COUNT(*) FROM TiposRelaciones);
	
	INSERT INTO Seguidores (idPublicaciones,idTiposRelaciones,Visibilidad) 
	SELECT randomUsuarios.valor,randomUsuarios.idRelacion,1
	FROM randomUsuarios ;

	DROP TEMPORARY TABLE IF EXISTS randomUsuarios;

END $$

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `llenarUsuarios_has_Seguidores`()
BEGIN
 
	DECLARE variable,randomIdPErfil,contador,randomPublicacion int;

	DROP TEMPORARY TABLE IF EXISTS randomUsuarios;
	

CREATE TEMPORARY TABLE randomUsuarios
	(
		idRandom int(11) NOT NULL auto_increment,
		idSeguidor int(11),
		idUsuario int(11),
		PRIMARY KEY (`idRandom`),
		UNIQUE KEY `idRandom` (`idRandom`)
	) ;

	SET contador = 1;
	SET randomIdPErfil = (SELECT COUNT(*) FROM Seguidores) ;

	WHILE contador <= randomIdPErfil DO 
	
	SET randomPublicacion = (SELECT 1 + ROUND(RAND() * ((SELECT COUNT(*) FROM Usuarios) - 1)));
	
	INSERT INTO randomUsuarios (idUsuario,idSeguidor) VALUES (randomPublicacion,contador);

	SET contador=contador+1;

	END WHILE;

	INSERT INTO Usuarios_has_Seguidores (Usuarios_idUsuarios,Seguidores_idSeguidores) 
	SELECT randomUsuarios.idUsuario,randomUsuarios.idSeguidor
	FROM randomUsuarios ;

	DROP TEMPORARY TABLE IF EXISTS randomUsuarios;

END $$


DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `llenarPublicaciones_has_Tags`()
BEGIN
 
	DECLARE variable,cantidadPublicaciones,contador,randomPublicacion int;

	DROP TEMPORARY TABLE IF EXISTS random;
	
CREATE TEMPORARY TABLE random
	(
		idRandom int(11) NOT NULL auto_increment,
		idPublicacion int(11),
		idTag int(11),
		PRIMARY KEY (`idRandom`),
		UNIQUE KEY `idRandom` (`idRandom`)
	) ;

	SET contador = 1;
	SET cantidadPublicaciones = (SELECT COUNT(*) FROM Publicaciones) ;

	WHILE contador <= cantidadPublicaciones * 2  DO 

	SET randomPublicacion = (SELECT idPublicaciones FROM Publicaciones ORDER BY RAND() LIMIT 1);
	SET variable = (SELECT idTags FROM Tags ORDER BY RAND() LIMIT 1);

	IF NOT EXISTS(Select idPublicacion,idTag  from random where random.idPublicacion = randomPublicacion 
					AND random.idTag = variable) THEN
					INSERT INTO random (idPublicacion,idTag) VALUES (randomPublicacion,variable);
	ELSE
		SET contador=contador-1;
	END IF;
	SET contador=contador+1;

	END WHILE;

	INSERT INTO Publicaciones_has_Tags (idPublicaciones,idTags) 
	SELECT random.idPublicacion,random.idTag
	FROM random ;

 
	DROP TEMPORARY TABLE IF EXISTS random;

END $$


DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `llenarCalificaciones`()
BEGIN
 
	DECLARE variable,cantidadPublicaciones,contador,randomPublicacion,i int;

	DROP TEMPORARY TABLE IF EXISTS random;
	DROP TEMPORARY TABLE IF EXISTS tabla_temp;
	DROP TEMPORARY TABLE IF EXISTS tabla_temp1;
	

CREATE TEMPORARY TABLE random
	(
		idRandom int(11) NOT NULL auto_increment,
		valorRandom int(11),
		PRIMARY KEY (`idRandom`),
		UNIQUE KEY `idRandom` (`idRandom`)
	) ;

CREATE TEMPORARY TABLE tabla_temp
	(
		idRandom int(11) NOT NULL auto_increment,
		idUsuario int(11),
		PRIMARY KEY (`idRandom`),
		UNIQUE KEY `idRandom` (`idRandom`)
	) ;

CREATE TEMPORARY TABLE tabla_temp1
	(
		idRandom int(11) NOT NULL auto_increment,
		idUsuario int(11),
		IdPublicacion int(11),
		PRIMARY KEY (`idRandom`),
		UNIQUE KEY `idRandom` (`idRandom`)
	) ;

	
	SET contador = 1;
	SET cantidadPublicaciones = (SELECT COUNT(*) FROM Publicaciones) ;

	INSERT INTO random (valorRandom) 
	(SELECT idPublicaciones FROM Publicaciones ORDER BY RAND() LIMIT cantidadPublicaciones);
    

	SET contador = 1;
	SET cantidadPublicaciones = (SELECT COUNT(*) FROM Usuarios) ;


	INSERT INTO tabla_temp (idUsuario) 
	(SELECT idUsuarios FROM Usuarios ORDER BY RAND() LIMIT cantidadPublicaciones);

	
	INSERT INTO tabla_temp1(idUsuario,IdPublicacion)
	SELECT tabla_temp.idUsuario,random.valorRandom
	FROM random,tabla_temp WHERE random.idRandom = tabla_temp.idRandom;

	SET contador = ((SELECT COUNT(*) FROM tabla_temp)*0.75);
	SET cantidadPublicaciones = ((SELECT COUNT(*) FROM Publicaciones)*0.90) ;
	SET i =1;

	WHILE i<=cantidadPublicaciones DO 
		SET randomPublicacion = (SELECT valorRandom FROM random ORDER BY RAND() limit 1);
		SET contador = (SELECT idUsuario FROM tabla_temp ORDER BY RAND() limit 1);
		
		IF NOT EXISTS(SELECT idUsuario,IdPublicacion  FROM tabla_temp1 
					  WHERE tabla_temp1.idUsuario = randomPublicacion AND 
					  tabla_temp1.idPublicacion = contador) THEN
				INSERT INTO tabla_temp1 (idPublicacion,idUsuario) VALUES(randomPublicacion,contador);
	    ELSE
			SET i=i-1;
		END IF;
		SET i=i+1;
	END WHILE;

	

	INSERT INTO Calificaciones (valor,fechaCalificacion,idUsuarios,idPublicaciones) 
	SELECT 1,CURDATE(),tabla_temp1.idUsuario,tabla_temp1.idPublicacion
	FROM tabla_temp1;

	UPDATE Calificaciones SET valor = (SELECT 1 + ROUND(RAND() * (5 - 1)));

	DROP TEMPORARY TABLE IF EXISTS random;
	DROP TEMPORARY TABLE IF EXISTS tabla_temp;
	DROP TEMPORARY TABLE IF EXISTS tabla_temp1;

END $$




DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `llenarProyectos`()
BEGIN
	DECLARE i,valorRandom,fecha INT;

	DROP TEMPORARY TABLE IF EXISTS random;

	CREATE TEMPORARY TABLE random
	(
		id int(11) NOT NULL auto_increment,
		descripcion INT(11),
		PRIMARY KEY (`id`),
		UNIQUE KEY `id` (`id`)
	) ;
	

	INSERT INTO random(descripcion)
	SELECT idPublicaciones FROM PUBLICACIONES WHERE Publicaciones.idTipoPublicacion = 1 ORDER BY RAND() LIMIT 5;

	SET i = 1;

	WHILE i<= 5
	DO
	SET valorRandom = (SELECT descripcion FROM random WHERE random.id = i);
	SET fecha = (SELECT idDirecciones FROM Direcciones ORDER BY RAND() LIMIT 1);
	INSERT INTO Proyectos (fechaInicio,fechaFinal,idDirecciones) VALUES
	(CURDATE(),CURDATE(),fecha);

	UPDATE Publicaciones SET idProyectos = i
	WHERE valorRandom =  Publicaciones.idPublicaciones;
	UPDATE Publicaciones SET idTipoPublicacion = 5
	WHERE valorRandom =  Publicaciones.idPublicaciones;

	SET i = i+1;
	END WHILE;

END $$

/*#################################################################################*/
/*					Cumplir con los requisitos de  cantidad 		   			   */
/*						 de publicaciones por post								   */								
/*#################################################################################*/

DELIMITER $$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insertarPreguntasRandom`()
BEGIN

   DECLARE i,j,numRegistros,porcentaje,random INT;
   DECLARE valor VARCHAR(400);
	
	DROP TEMPORARY TABLE IF EXISTS tabla_temp;

	CREATE TEMPORARY TABLE tabla_temp
	(
		id int(11) NOT NULL auto_increment,
		descripcion varchar(400),
		PRIMARY KEY (`id`),
		UNIQUE KEY `id` (`id`)
	) ;
	
	INSERT INTO tabla_temp (descripcion) VALUES 
	("Como lo hace?"),("De quien fue la culpa?"),("Leonidas el emperador?"),
	("Es Yokohama una ciudad verde?"),("Casillas el mejor jugador?"),
	("Debe cambiar su forma de pensar la vida?"),("Los operadores del h son de Puriscal?"),
	("Tierra media, el hogar de todo?"),("Es el TEC un lugar en Cartago"),
	("Costa Rica ira al mundial 2014?"),("En La Nave venden Olafos?");
 
    SET i = 1; # se le puede dar cualquier valor menos 0.
	SET j = 1;
 
	SET numRegistros = (SELECT COUNT(*) FROM Publicaciones WHERE Publicaciones.idTipoPublicacion = 1);
	SET porcentaje = numRegistros * 0.70;
	
    # INTRO BUCLE
    WHILE i <= porcentaje+1 DO
		WHILE j <= 3 DO
		
			SET random = (SELECT 1 + ROUND(RAND() * ((SELECT COUNT(*) FROM tabla_temp) - 1)));
			SET valor = (SELECT descripcion from tabla_temp WHERe id = random);

			INSERT INTO Publicaciones(descripcion,fechaCreacion,idTipoPublicacion,Titulo,idUsuarios,idEstadosPublicacion,idCamposControl,idPublicacionesfk) 
			VALUES (valor,CURDATE(),2,"Pregunta",i,1,5,i);
			
			SET j=j+1;

		END WHILE;
		
		SET j = 1;
		SET i = i+1;
 
    END WHILE;
	
	DROP TEMPORARY TABLE IF EXISTS tabla_temp;

END $$


CREATE DEFINER=`root`@`localhost` PROCEDURE `insertarReplanteosRandom`()
BEGIN

   DECLARE i,j,numRegistros,porcentaje,random INT;
   DECLARE valor VARCHAR(400);
	
	DROP TEMPORARY TABLE IF EXISTS tabla_temp;

	CREATE TEMPORARY TABLE tabla_temp
	(
		id int(11) NOT NULL auto_increment,
		descripcion varchar(400),
		PRIMARY KEY (`id`),
		UNIQUE KEY `id` (`id`)
	) ;
	
	INSERT INTO tabla_temp (descripcion) VALUES 
	("Debes enfocar el problema distinto"),("La culpa es de una persona distinta"),
	("Menos Tala de arboles"),("Yokohama radioactiva"),("Puerta Celestial"),
	("La vida se ve linda"),("Vuela Pegaso"),("Invoque un dragon"),
	("Agua de lluvia como generador"),("Deberes Nacionales"),("Cerrar mas tarde La Nave");
 
    SET i = 1; # se le puede dar cualquier valor menos 0.
	SET j = 1;
 
	SET numRegistros = (SELECT COUNT(*) FROM Publicaciones WHERE Publicaciones.idTipoPublicacion = 1);
	SET porcentaje = numRegistros * 0.70;
	
    # INTRO BUCLE
    WHILE i <= porcentaje+1 DO
		WHILE j <= 2 DO
		
			SET random = (SELECT 1 + ROUND(RAND() * ((SELECT COUNT(*) FROM tabla_temp) - 1)));
			SET valor = (SELECT descripcion from tabla_temp WHERe id = random);

			INSERT INTO Publicaciones(descripcion,fechaCreacion,idTipoPublicacion,Titulo,idUsuarios,idEstadosPublicacion,idCamposControl,idPublicacionesfk) 
			VALUES (valor,CURDATE(),4,"Replanteo",i,1,5,i);
			
			SET j=j+1;

		END WHILE;
		
		SET j = 1;
		SET i = i+1;
 
    END WHILE;
	
	DROP TEMPORARY TABLE IF EXISTS tabla_temp;

END $$


CREATE DEFINER=`root`@`localhost` PROCEDURE `insertarSolucionesRandom`()
BEGIN

   #Declaracion de variables
   DECLARE i,j,numRegistros,porcentaje,random INT;
   DECLARE valor VARCHAR(400);
	
	
	DROP TEMPORARY TABLE IF EXISTS tabla_temp; #Borrar tabla temporal si es que existe antes

	CREATE TEMPORARY TABLE tabla_temp
	(
		id int(11) NOT NULL auto_increment,
		descripcion varchar(400),
		PRIMARY KEY (`id`),
		UNIQUE KEY `id` (`id`)
	) ;
	
	INSERT INTO tabla_temp (descripcion) VALUES 
	("Tomar agua todos los dias"),("Comer a diario"),("Ingerir vitamina C al dia siguiente"),
	("Lavar la herida con jabon"),("No manejar en esa condicion"),
	("Alabar al Dios Halford"),("Contratar a Mufasa asesino de leones"),
	("Luchar con un pokemon tipo agua"),("No tocar los cables"),
	("Cargar totalmente su dispositivo"),("Disfrutar su bebida");
 
    SET i = 1; # se le puede dar cualquier valor menos 0.
	SET j = 1;
 
	SET numRegistros = (SELECT COUNT(*) FROM Publicaciones WHERE Publicaciones.idTipoPublicacion = 1);
	SET porcentaje = numRegistros * 0.40;
	
    # INTRO BUCLE
    WHILE i <= porcentaje DO
		WHILE j <= 3 DO
		
			SET random = (SELECT 1 + ROUND(RAND() * ((SELECT COUNT(*) FROM tabla_temp) - 1)));
			SET valor = (SELECT descripcion from tabla_temp WHERe id = random);

			INSERT INTO Publicaciones(descripcion,fechaCreacion,idTipoPublicacion,Titulo,idUsuarios,idEstadosPublicacion,idCamposControl,idPublicacionesfk) 
			VALUES (valor,CURDATE(),3,"Solucion",i,1,5,i);
			
			SET j=j+1;

		END WHILE;
		
		SET j = 1;
		SET i = i+1;
 
    END WHILE;
	
	DROP TEMPORARY TABLE IF EXISTS tabla_temp;#Borrar tabla temporal si es que existe antes

END $$

/*#################################################################################*/
/*						   SP PARA LA										  	   */
/*						  PARTE GRAFICA										   	   */								
/*#################################################################################*/

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `verProyectos`(idUsuario INT)
BEGIN
	SELECT * from
	(SELECT Publicaciones.idPublicaciones,Seguidores.idSeguidores,
	Publicaciones.titulo,Publicaciones.descripcion,Publicaciones.idPublicacionesfk,
    Publicaciones.idUsuarios
	FROM SEGUIDORES INNER JOIN Publicaciones ON Seguidores.idPublicaciones =
	Publicaciones.idPublicaciones Where Publicaciones.idTipoPublicacion = 5)tablaSeguidores
	INNER JOIN
	(SELECT Seguidores_idSeguidores FROM Usuarios_has_Seguidores 
	WHERE Usuarios_has_Seguidores.Usuarios_idUsuarios = idUsuario)tablaUsuario 
	ON tablaSeguidores.idSeguidores = tablaUsuario.Seguidores_idSeguidores;

	/*
	SELECT * from
	(SELECT Publicaciones.idPublicaciones,Seguidores.idSeguidores,
	Publicaciones.titulo,Publicaciones.descripcion,Publicaciones.idPublicacionesfk,
    Publicaciones.idUsuarios,(AVG(Calificaciones.Valor))Promedio
	FROM SEGUIDORES,calificaciones INNER JOIN Publicaciones ON Seguidores.idPublicaciones =
	Publicaciones.idPublicaciones Where Publicaciones.idTipoPublicacion = 5)tablaSeguidores
	INNER JOIN
	(SELECT Seguidores_idSeguidores FROM Usuarios_has_Seguidores 
	WHERE Usuarios_has_Seguidores.Usuarios_idUsuarios = idUsuario)tablaUsuario 
	ON tablaSeguidores.idSeguidores = tablaUsuario.Seguidores_idSeguidores
	ORDER BY PROMEDIO,DATEDIFF(Proyectos.FechaFinal,Proyectos.FechaInico);
*/
END $$


DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `visualizarPosts`()
BEGIN
SELECT * FROM
 (SELECT tabla.IdPublicaciones, (AVG(Calificaciones.Valor))Promedio, tabla.titulo
,tabla.descripcion,tabla.username,tabla.idUsuarios,tabla.idPerfiles
FROM (SELECT Publicaciones.idPublicaciones, Publicaciones.titulo,
Publicaciones.descripcion,Usuarios.username,usuarios.idUsuarios,Publicaciones.idTipoPublicacion,Usuarios.idPerfiles 
FROM Publicaciones INNER JOIN Usuarios ON Usuarios.idUsuarios =
Publicaciones.idUsuarios)tabla 
LEFT JOIN Calificaciones  ON  Calificaciones.idPublicaciones = tabla.IdPublicaciones 
WHERE tabla.idTipoPublicacion=1 
GROUP BY tabla.IdPublicaciones ORDER BY Promedio DESC)Post INNER JOIN Perfiles ON Post.idPerfiles = Perfiles.idPerfiles;

END $$


DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `verPerfil`(idUsuario int)
BEGIN
SELECT Perfiles.fotografia FROM Perfiles
INNER JOIN Usuarios ON Perfiles.idPerfiles = Usuarios.idPerfiles WHERE Usuarios.idUsuarios = idUsuario;
END $$



DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `verPublicacion`(idPublicacion int)
BEGIN

SELECT Publicaciones.IdPublicaciones, (AVG(Calificaciones.Valor))Promedio, Publicaciones.titulo
,publicaciones.descripcion
 FROM Publicaciones LEFT JOIN Calificaciones  ON 
 Calificaciones.idPublicaciones = Publicaciones.IdPublicaciones WHERE idPublicacionesfk=idPublicacion 
 AND (Publicaciones.idTipoPublicacion = 1 OR Publicaciones.idTipoPublicacion = 4)
GROUP BY Publicaciones.IdPublicaciones ORDER BY Promedio DESC ;

END $$


DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `verHijos`(idPublicacion int)
BEGIN

SELECT Publicaciones.IdPublicaciones, (AVG(Calificaciones.Valor))Promedio, Publicaciones.titulo
,publicaciones.descripcion
 FROM Publicaciones LEFT JOIN Calificaciones  ON 
 Calificaciones.idPublicaciones = Publicaciones.IdPublicaciones WHERE idPublicacionesfk=idPublicacion 
 AND NOT(Publicaciones.idTipoPublicacion = 1 OR Publicaciones.idTipoPublicacion = 4)
GROUP BY Publicaciones.IdPublicaciones ORDER BY Promedio DESC ;

END $$


DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `calificar`(idUser int,idPub int, calificacion int)
BEGIN
 IF NOT EXISTS(Select *  from calificaciones where calificaciones.idUsuarios  = idUser AND 
	calificaciones.idPublicaciones = idPub) then
	INSERT INTO CALIFICACIONES (idPublicaciones,idUsuarios, valor, FechaCalificacion) 
	Values(idPub,idUser,calificacion, CURDATE());
	SELECT 1;
ELSE
	SELECT 0;
END IF;

END $$


DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `convertir`(idPost int, fechaI Date, fechaF Date)
BEGIN
 IF NOT EXISTS(Select *  from Publicaciones where Publicaciones.idPublicacionesfk) then
	SELECT 0;
	ELSE UPDATE publicaciones set idTipoPublicacion = 1 
		  where Publicaciones.idPublicacionesfk = idPost AND Publicaciones.idPublicaciones != idPost;
		Update publicaciones set idTipoPublicacion = 5 where Publicaciones.idPublicaciones = idPost;
		Update publicaciones set idPublicacionesfk = Publicaciones.idPublicaciones 
          where Publicaciones.idPublicacionesfk=idPost AND Publicaciones.idPublicaciones!= idPost;
		Insert into Proyectos(FechaInicio,FechaFinal,idDirecciones)Values(fechaI,fechaF,1);
		Update publicaciones set  idProyectos = LAST_INSERT_ID() where Publicaciones.idPublicaciones = idPost;

	
END IF;

END $$



DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `iniciarSesion`(user VARCHAR(200), contrasenia VARCHAR(200))
BEGIN
 DECLARE contraseniaMD5 VARCHAR(200);

 SET contraseniaMD5 = MD5(contrasenia);

 IF EXISTS(SELECT *  FROM Usuarios WHERE Usuarios.username  = user AND 
	Usuarios.password = contraseniaMD5) THEN
	SELECT Usuarios.idUsuarios, Usuarios.username FROM Usuarios WHERE Usuarios.username = user;
 END IF;

END $$

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `registrar`(user varchar(300),contrasenia varchar(300))
BEGIN
 IF NOT EXISTS(Select *  from Usuarios where Usuarios.username  = username) then
	INSERT INTO Perfiles() Values();
	INSERT INTO usuarios(username,password) Values(user,contrasenia);
END IF;

END $$

DELIMITER ;

/*#################################################################################*/
/*						   SP PARA AGREGAR 								           */
/*					SOLUCIONES,REPLANTEOS,PREGUNTAS						           */								 
/*#################################################################################*/
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertarPregunta`(idPublicacionMadre BIGINT, idUsuario BIGINT, descripcion VARCHAR(400))
BEGIN
	IF EXISTS(SELECT * FROM Publicaciones WHERE idTipoPublicacion = 1 AND Publicaciones.idPublicaciones  = idPublicacionMadre) THEN
		IF EXISTS(SELECT * FROM Usuarios WHERE Usuarios.idUsuarios = idUsuario) THEN
			INSERT INTO Publicaciones(descripcion,fechaCreacion,idTipoPublicacion,
			Titulo,idUsuarios,idEstadosPublicacion,idCamposControl,idPublicacionesfk) VALUES 
			(descripcion,CURDATE(),2,"Pregunta",idUsuario,1,1,idPublicacionMadre);
		ELSE 
			SELECT "ERROR!!! USUARIO NO EXISTE" ;
	   END IF;
	ELSE
		SELECT "ERROR!!! PUBLICACION NO EXISTE" ;
	END IF;	
END $$

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertarSolucion`(idPublicacionMadre BIGINT, idUsuario BIGINT, descripcion VARCHAR(400))
BEGIN
	IF EXISTS(SELECT * FROM Publicaciones WHERE idTipoPublicacion = 1 AND Publicaciones.idPublicaciones  = idPublicacionMadre) THEN
		IF EXISTS(SELECT * FROM Usuarios WHERE Usuarios.idUsuarios = idUsuario) THEN
			INSERT INTO Publicaciones(descripcion,fechaCreacion,idTipoPublicacion,
			Titulo,idUsuarios,idEstadosPublicacion,idCamposControl,idPublicacionesfk) VALUES 
			(descripcion,CURDATE(),3,"Solucion",idUsuario,1,1,idPublicacionMadre);
		ELSE 
			SELECT "ERROR!!! USUARIO NO EXISTE" ;
	   END IF;
	ELSE
		SELECT "ERROR!!! PUBLICACION NO EXISTE" ;
	END IF;	
END $$

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertarReplanteo`(idPublicacionMadre BIGINT, idUsuario BIGINT, descripcion VARCHAR(400))
BEGIN
	IF EXISTS(SELECT * FROM Publicaciones WHERE idTipoPublicacion = 1 AND Publicaciones.idPublicaciones  = idPublicacionMadre) THEN
		IF EXISTS(SELECT * FROM Usuarios WHERE Usuarios.idUsuarios = idUsuario) THEN
			INSERT INTO Publicaciones(descripcion,fechaCreacion,idTipoPublicacion,
			Titulo,idUsuarios,idEstadosPublicacion,idCamposControl,idPublicacionesfk) VALUES 
			(descripcion,CURDATE(),4,"Replanteo",idUsuario,1,1,idPublicacionMadre);
		ELSE 
			SELECT "ERROR!!! USUARIO NO EXISTE" ;
	   END IF;
	ELSE
		SELECT "ERROR!!! PUBLICACION NO EXISTE" ;
	END IF;	
END $$


/*#################################################################################*/
/*								TRIGGERS										   */								   */
/*#################################################################################*/

DELIMITER ;

DELIMITER $$											
CREATE TRIGGER TGR_ControlActualizacionPublicacion AFTER UPDATE ON Publicaciones FOR EACH ROW
BEGIN
	INSERT INTO Eventos(fecha,descripcion,computadora,usuario,checkSun,ip,idTiposEvento,idModulos,idSeveridad) 
	VALUES(CURDATE(),"ACTUALIZO PUBLICACION","PCactualizacion","UsuarioaActualizacion","checkSum","ipActualizacion",3,2,2); 
END $$
DELIMITER ;

DELIMITER $$											
CREATE TRIGGER TGR_ControlCreacionPublicacion AFTER INSERT ON Publicaciones FOR EACH ROW
BEGIN
	INSERT INTO Eventos(fecha,descripcion,computadora,usuario,checkSun,ip,idTiposEvento,idModulos,idSeveridad) 
	VALUES(CURDATE(),"INSERTO PUBLICACION","PCinsercion","UsuarioaInsercion","checkSum","ipInsercion",1,1,2); 
END $$

DELIMITER ;


/*#################################################################################*/
/*							  LLAMADA SP										   */								
/*#################################################################################*/

#Llamadas a SP que llenan las tablas miscelaneas
CALL llenadoTipoPublicacion("post-pregunta-solucion-replanteo-replanteo-proyecto-post","-");
CALL llenadoPaises("costaRica-mexico-estadosUnidos-brasil-inglaterra","-");
CALL llenadoTiposCuenta("propio-gmail-facebook","-");
CALL llenadoTiposAdjuntos("fotografia-video-archivoTexto","-");
CALL llenadoTiposLogros("academico-laboral","-");
CALL llenadoEstadosPublicacion("disponible-eliminado","-");
CALL llenadoTiposRelaciones("creada-siguiendo","-");
CALL llenadoTags("peligro-horror-politica-cine-turismo-educacion-mysql-php-añon-puriscal-TEC-carro-moto-coca-piedra-rojo-uña-alianza-fumar-reloj-droga-birra-lapiz-ojos-letra-salud","-");


#Llamadas a SP que llenan las tablas, asignando FK aleatorias
CALL llenarCamposControl();
CALL llenarProvincia();
CALL llenarCiudades();
CALL llenarDirecciones();
CALL llenarInstituciones();
CALL llenarLogros();
CALL llenarPerfiles();
CALL llenarUsuarios();
CALL llenarPublicaciones();
CALL llenarSeguidores();
CALL llenarUsuarios_has_Seguidores();
CALL llenarPublicaciones_has_Tags;


#Llamadas a SP que asigna Replanteos y Preguntas al 70% de las publicaciones
#Ademas de agregar al 50% de las publicaciones soluciones
CALL insertarPreguntasRandom();
CALL insertarSolucionesRandom();
CALL insertarReplanteosRandom();


#STORED PROCEDURE PARA AGREGAR PREGUNTAS,REPLANTEOS Y SOLUCIONES A UNA PUBLICACION
#SE DEBE PASAR COMO PARAMETRO EL ID DE LA PUBLICACION "MADRE", EL ID DEL USUARIO QUE
#REALIZA EL PROCESO Y LA DESCRIPCION
CALL insertarSolucion(1,1,"ESTO ES UNA PRUEBA DE FUEGO");

#CONVIERTE 5 PUBLICACIONES DE TIPO POST EN PROYECTO
CALL llenarProyectos();

#INSERTA CALIFICACIONES  
CALL llenarCalificaciones();

CALL iniciarSesion("EltonJ", "8d9d4c4d9d");

SELECT * from Usuarios;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
