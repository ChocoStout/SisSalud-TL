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
correo NVARCHAR(100) NOT NULL,
nivel CHAR(1) NOT NULL,
usuario NVARCHAR(20) NOT NULL,
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
correo NVARCHAR(100) NOT NULL,
nivel CHAR(1) NOT NULL,
usuario NVARCHAR(20) NOT NULL,
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
FOREIGN KEY (propuesta) REFERENCES Propuestas (id)
);

/*Tabla de VoluntariosDonaciones*/
DROP TABLE IF EXISTS VoluntariosDonaciones;

CREATE TABLE VoluntariosDonaciones
(
id INT PRIMARY KEY AUTO_INCREMENT,
idVoluntario INT NOT NULL,
FOREIGN KEY (idVoluntario) REFERENCES Voluntarios (id),
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
FOREIGN KEY (idEmpresa) REFERENCES Empresas (id),
cantidad DECIMAL(10,2) UNSIGNED NOT NULL,
fecha NVARCHAR(20) NOT NULL,
hora NVARCHAR(20) NOT NULL
);

/*Tabla de VoluntariosLogros*/
DROP TABLE IF EXISTS VoluntariosLogros;

CREATE TABLE VoluntariosLogros
(
idVoluntario INT NOT NULL,
FOREIGN KEY (idVoluntario) REFERENCES Voluntarios (id),
idLogro INT NOT NULL,
FOREIGN KEY (idLogro) REFERENCES Logros (id)
);

/*Tabla de EmpresasLogros*/
DROP TABLE IF EXISTS EmpresasLogros;

CREATE TABLE EmpresasLogros
(
idEmpresa INT NOT NULL,
FOREIGN KEY (idEmpresa) REFERENCES Empresas (id),
idLogro INT NOT NULL,
FOREIGN KEY (idLogro) REFERENCES Logros (id)
);

/*Tabla de VoluntariosPropuestas*/
DROP TABLE IF EXISTS VoluntariosPropuestas;

CREATE TABLE VoluntariosPropuestas
(
idVoluntario INT NOT NULL,
FOREIGN KEY (idVoluntario) REFERENCES Voluntarios (id),
idPropuesta INT NOT NULL,
FOREIGN KEY (idPropuesta) REFERENCES Propuestas (id)
);

/*Tabla de EmpresasPropuestas*/
DROP TABLE IF EXISTS EmpresasPropuestas;

CREATE TABLE EmpresasPropuestas
(
idEmpresa INT NOT NULL,
FOREIGN KEY (idEmpresa) REFERENCES Empresas (id),
idPropuesta INT NOT NULL,
FOREIGN KEY (idPropuesta) REFERENCES Propuestas (id)
);

/*Tabla de VoluntariosEventos*/
DROP TABLE IF EXISTS VoluntariosEventos;

CREATE TABLE VoluntariosEventos
(
idVoluntario INT NOT NULL,
FOREIGN KEY (idVoluntario) REFERENCES Voluntarios (id),
idEvento INT NOT NULL,
FOREIGN KEY (idEvento) REFERENCES Eventos (id)
);

/*Tabla de EmpresasEventos*/
DROP TABLE IF EXISTS EmpresasEventos;

CREATE TABLE EmpresasEventos
(
idEmpresa INT NOT NULL,
FOREIGN KEY (idEmpresa) REFERENCES Empresas (id),
idEvento INT NOT NULL,
FOREIGN KEY (idEvento) REFERENCES Eventos (id)
);