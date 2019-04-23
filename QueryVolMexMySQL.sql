/* Creación de la Base de Datos con nombre "VolMex" */
DROP DATABASE IF EXISTS VolMex; 

CREATE DATABASE VolMex;

/* Seleccionar "VolMex" como Base de Datos a usar */
USE VolMex;

/* Creación de las tablas dentro de VolMex */

/*Tabla de Voluntarios*/
DROP TABLE IF EXISTS Voluntarios;

CREATE TABLE Voluntarios
(
id INT PRIMARY KEY AUTO_INCREMENT,
nombres NVARCHAR(35) NOT NULL,
apellidos NVARCHAR(35) NOT NULL,
correo NVARCHAR(100) UNIQUE NOT NULL,
nivel CHAR(1) NOT NULL,
usuario NVARCHAR(20) UNIQUE NOT NULL,
contrasenaHash BLOB NOT NULL,
contrasenaSalt BLOB NOT NULL,
tipo CHAR(1) NOT NULL
);

/*Tabla de Empresas*/
DROP TABLE IF EXISTS Empresas;

CREATE TABLE Empresas
(
id INT PRIMARY KEY AUTO_INCREMENT,
nombre NVARCHAR(100) NOT NULL,
rfc NVARCHAR(13) NOT NULL,
direccion NVARCHAR(255) NOT NULL,
telefono NVARCHAR(25) NOT NULL,
correo NVARCHAR(100) UNIQUE NOT NULL,
nivel CHAR(1) NOT NULL,
usuario NVARCHAR(20) UNIQUE NOT NULL,
contrasenaHash BLOB NOT NULL,
contrasenaSalt BLOB NOT NULL
);

/*Tabla de Logros*/
DROP TABLE IF EXISTS Logros;

CREATE TABLE Logros
(
id INT PRIMARY KEY AUTO_INCREMENT,
nombre NVARCHAR(50) NOT NULL
);

/*Tabla de Problemáticas/Propuestas*/
DROP TABLE IF EXISTS Propuestas;

CREATE TABLE Propuestas
(
id INT PRIMARY KEY AUTO_INCREMENT,
nombre NVARCHAR(100) NOT NULL,
descripcion NVARCHAR(255) NOT NULL,
estatus CHAR(1) NOT NULL
);

/*Tabla de Eventos*/
DROP TABLE IF EXISTS Eventos;

CREATE TABLE Eventos
(
id INT PRIMARY KEY AUTO_INCREMENT,
nombre NVARCHAR(100) NOT NULL,
descripcion NVARCHAR(255) NOT NULL,
lugar NVARCHAR(255) NOT NULL,
fecha NVARCHAR(20) NOT NULL,
hora NVARCHAR(20) NOT NULL,
propuesta INT NOT NULL,
FOREIGN KEY (propuesta) REFERENCES Propuestas (id) ON UPDATE CASCADE ON DELETE CASCADE
);

/*Tabla de VoluntariosDonaciones*/
DROP TABLE IF EXISTS VoluntariosDonaciones;

CREATE TABLE VoluntariosDonaciones
(
id INT PRIMARY KEY AUTO_INCREMENT,
idVoluntario INT NOT NULL,
FOREIGN KEY (idVoluntario) REFERENCES Voluntarios (id) ON UPDATE CASCADE ON DELETE CASCADE,
cantidad DECIMAL(10,2) UNSIGNED NOT NULL,
fecha NVARCHAR(20) NOT NULL,
hora NVARCHAR(20) NOT NULL
);

/*Tabla de EmpresasDonaciones*/
DROP TABLE IF EXISTS EmpresasDonaciones;

CREATE TABLE EmpresasDonaciones
(
id INT PRIMARY KEY AUTO_INCREMENT,
idEmpresa INT NOT NULL,
FOREIGN KEY (idEmpresa) REFERENCES Empresas (id) ON UPDATE CASCADE ON DELETE CASCADE,
cantidad DECIMAL(10,2) UNSIGNED NOT NULL,
fecha NVARCHAR(20) NOT NULL,
hora NVARCHAR(20) NOT NULL
);

/*Tabla de VoluntariosLogros*/
DROP TABLE IF EXISTS VoluntariosLogros;

CREATE TABLE VoluntariosLogros
(
idVoluntario INT NOT NULL,
FOREIGN KEY (idVoluntario) REFERENCES Voluntarios (id) ON UPDATE CASCADE ON DELETE CASCADE,
idLogro INT NOT NULL,
FOREIGN KEY (idLogro) REFERENCES Logros (id) ON UPDATE CASCADE ON DELETE CASCADE
);

/*Tabla de EmpresasLogros*/
DROP TABLE IF EXISTS EmpresasLogros;

CREATE TABLE EmpresasLogros
(
idEmpresa INT NOT NULL,
FOREIGN KEY (idEmpresa) REFERENCES Empresas (id) ON UPDATE CASCADE ON DELETE CASCADE,
idLogro INT NOT NULL,
FOREIGN KEY (idLogro) REFERENCES Logros (id) ON UPDATE CASCADE ON DELETE CASCADE
);

/*Tabla de VoluntariosPropuestas*/
DROP TABLE IF EXISTS VoluntariosPropuestas;

CREATE TABLE VoluntariosPropuestas
(
idVoluntario INT NOT NULL,
FOREIGN KEY (idVoluntario) REFERENCES Voluntarios (id) ON UPDATE CASCADE ON DELETE CASCADE,
idPropuesta INT NOT NULL,
FOREIGN KEY (idPropuesta) REFERENCES Propuestas (id) ON UPDATE CASCADE ON DELETE CASCADE
);

/*Tabla de EmpresasPropuestas*/
DROP TABLE IF EXISTS EmpresasPropuestas;

CREATE TABLE EmpresasPropuestas
(
idEmpresa INT NOT NULL,
FOREIGN KEY (idEmpresa) REFERENCES Empresas (id) ON UPDATE CASCADE ON DELETE CASCADE,
idPropuesta INT NOT NULL,
FOREIGN KEY (idPropuesta) REFERENCES Propuestas (id) ON UPDATE CASCADE ON DELETE CASCADE
);

/*Tabla de VoluntariosEventos*/
DROP TABLE IF EXISTS VoluntariosEventos;

CREATE TABLE VoluntariosEventos
(
idVoluntario INT NOT NULL,
FOREIGN KEY (idVoluntario) REFERENCES Voluntarios (id) ON UPDATE CASCADE ON DELETE CASCADE,
idEvento INT NOT NULL,
FOREIGN KEY (idEvento) REFERENCES Eventos (id) ON UPDATE CASCADE ON DELETE CASCADE
);

/*Tabla de EmpresasEventos*/
DROP TABLE IF EXISTS EmpresasEventos;

CREATE TABLE EmpresasEventos
(
idEmpresa INT NOT NULL,
FOREIGN KEY (idEmpresa) REFERENCES Empresas (id) ON UPDATE CASCADE ON DELETE CASCADE,
idEvento INT NOT NULL,
FOREIGN KEY (idEvento) REFERENCES Eventos (id) ON UPDATE CASCADE ON DELETE CASCADE
);

/* Creación de INSERT's, UPDATE's, DELETE's y SELECT's de las tablas de la Base de Datos */

/*CRUD Voluntarios*/
INSERT INTO Voluntarios VALUES (?nombres, ?apellidos, ?correo, ?nivel, ?usuario, ?contrasenaHash, ?contrasenaSalt, ?tipo); 
UPDATE Voluntarios SET nombres = ?nombres, apellidos = ?apellidos, correo = ?correo, nivel = ?nivel, usuario = ?usuario, contrasenaHash = ?contrasenaHash, contrasenaSalt = ?contrasenaSalt, tipo = ?tipo WHERE id = ?id;
DELETE FROM Voluntarios WHERE id = ?id;
SELECT * FROM Voluntarios;
SELECT * FROM Voluntarios WHERE id = ?id;

/*CRUD Empresas*/
INSERT INTO Empresas VALUES (?nombre, ?rfc, ?direccion, ?telefono, ?correo, ?nivel, ?usuario, ?contrasenaHash, ?contrasenaSalt);
UPDATE Empresas SET nombre = ?nombre, rfc = ?rfc, direccion = ?direccion, telefono = ?telefono, correo = ?correo, nivel = ?nivel, usuario = ?usuario, contrasenaHash = ?contrasenaHash, contrasenaSalt = ?contrasenaSalt WHERE id = ?id;
DELETE FROM Empresas WHERE id = ?id;
SELECT * FROM Empresas;
SELECT * FROM Empresas WHERE id = ?id;

/*CRUD Logros*/
INSERT INTO Logros VALUES (?nombre);
UPDATE Logros SET nombre = ?nombre WHERE id = ?id;
DELETE FROM Logros WHERE id = ?id;
SELECT * FROM Logros;
SELECT * FROM Logros WHERE id = ?id;

/*CRUD Propuestas*/
INSERT INTO Propuestas VALUES (?nombre, ?descripcion, ?estatus);
UPDATE Propuestas SET nombre = ?nombre, descripcion = ?descripcion, estatus = ?estatus WHERE id = ?id;
DELETE FROM Propuestas WHERE id = ?id;
SELECT * FROM Propuestas;
SELECT * FROM Propuestas WHERE id = ?id;

/*CRUD Eventos*/
INSERT INTO Eventos VALUES (?nombre, ?descripcion, ?lugar, ?fecha, ?hora, ?propuesta);
UPDATE Eventos SET nombre = ?nombre, descripcion = ?descripcion, lugar = ?lugar, fecha = ?fecha, hora = ?hora, propuesta = ?propuesta WHERE id = ?id;
DELETE FROM Eventos WHERE id = ?id;
SELECT * FROM Eventos;
SELECT * FROM Eventos WHERE id = ?id;

/*CRUD VoluntariosDonaciones*/
INSERT INTO VoluntariosDonaciones VALUES (?idVoluntario, ?cantidad, ?fecha, ?hora);
UPDATE VoluntariosDonaciones SET idVoluntario = ?idVoluntario, cantidad = ?cantidad, fecha = ?fecha, hora = ?hora WHERE id = ?id;
DELETE FROM VoluntariosDonaciones WHERE id = ?id;
SELECT * FROM VoluntariosDonaciones;
SELECT * FROM VoluntariosDonaciones WHERE id = ?id;

/*CRUD EmpresasDonaciones*/
INSERT INTO EmpresasDonaciones VALUES (?idEmpresa, ?cantidad, ?fecha, ?hora);
UPDATE EmpresasDonaciones SET idEmpresa = ?idEmpresa, cantidad = ?cantidad, fecha = ?fecha, hora = ?hora WHERE id = ?id;
DELETE FROM EmpresasDonaciones WHERE id = ?id;
SELECT * FROM EmpresasDonaciones;
SELECT * FROM EmpresasDonaciones WHERE id = ?id;

/*CRUD VoluntariosLogros*/
INSERT INTO VoluntariosLogros VALUES (?idVoluntario, ?idLogro);
UPDATE VoluntariosLogros SET idVoluntario = ?idVoluntario, idLogro = ?idLogro WHERE idVoluntario = ?idVoluntario AND idLogro = ?idLogro;
DELETE FROM VoluntariosLogros WHERE idVoluntario = ?idVoluntario AND idLogro = ?idLogro;
SELECT * FROM VoluntariosLogros;
SELECT * FROM VoluntariosLogros WHERE idVoluntario = ?idVoluntario AND idLogro = ?idLogro;

/*CRUD EmpresasLogros*/
INSERT INTO EmpresasLogros VALUES (?idEmpresa, ?idLogro);
UPDATE EmpresasLogros SET idEmpresa = ?idEmpresa, idLogro = ?idLogro WHERE idEmpresa = ?idEmpresa AND idLogro = ?idLogro;
DELETE FROM EmpresasLogros WHERE idEmpresa = ?idEmpresa AND idLogro = ?idLogro;
SELECT * FROM EmpresasLogros;
SELECT * FROM EmpresasLogros WHERE idEmpresa = ?idEmpresa AND idLogro = ?idLogro;

/*CRUD VoluntariosPropuestas*/
INSERT INTO VoluntariosPropuestas VALUES (?idVoluntario, ?idPropuesta);
UPDATE VoluntariosPropuestas SET idVoluntario = ?idVoluntario, idPropuesta = ?idPropuesta WHERE idVoluntario = ?idVoluntario AND idPropuesta = ?idPropuesta;
DELETE FROM VoluntariosPropuestas WHERE idVoluntario = ?idVoluntario AND idPropuesta = ?idPropuesta;
SELECT * FROM VoluntariosPropuestas;
SELECT * FROM VoluntariosPropuestas WHERE idVoluntario = ?idVoluntario AND idPropuesta = ?idPropuesta;

/*CRUD EmpresasPropuestas*/
INSERT INTO EmpresasPropuestas VALUES (?idEmpresa, ?idPropuesta);
UPDATE EmpresasPropuestas SET idEmpresa = ?idEmpresa, idPropuesta = ?idPropuesta WHERE idEmpresa = ?idEmpresa AND idPropuesta = ?idPropuesta;
DELETE FROM EmpresasPropuestas WHERE idEmpresa = ?idEmpresa AND idPropuesta = ?idPropuesta;
SELECT * FROM EmpresasPropuestas;
SELECT * FROM EmpresasPropuestas WHERE idEmpresa = ?idEmpresa AND idPropuesta = ?idPropuesta;

/*CRUD VoluntariosEventos*/
INSERT INTO VoluntariosEventos VALUES (?idVoluntario, ?idEvento);
UPDATE VoluntariosEventos SET idVoluntario = ?idVoluntario, idEvento = ?idEvento WHERE idVoluntario = ?idVoluntario AND idEvento = ?idEvento;
DELETE FROM VoluntariosEventos WHERE idVoluntario = ?idVoluntario AND idEvento = ?idEvento;
SELECT * FROM VoluntariosEventos;
SELECT * FROM VoluntariosEventos WHERE idVoluntario = ?idVoluntario AND idEvento = ?idEvento;

/*CRUD EmpresasEventos*/
INSERT INTO EmpresasEventos VALUES (?idEmpresa, ?idEvento);
UPDATE EmpresasEventos SET idEmpresa = ?idEmpresa, idEvento = ?idEvento WHERE idEmpresa = ?idEmpresa AND idEvento = ?idEvento;
DELETE FROM EmpresasEventos WHERE idEmpresa = ?idEmpresa AND idEvento = ?idEvento;
SELECT * FROM EmpresasEventos;
SELECT * FROM EmpresasEventos WHERE idEmpresa = ?idEmpresa AND idEvento = ?idEvento;