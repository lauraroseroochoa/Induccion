-- 0. Creación de la base de datos
-- CREATE DATABASE IF NOT EXISTS entidadesTerritorialesColombia;
-- USE entidadesTerritorialesColombia;

-- Creación de tablas
CREATE TABLE IF NOT EXISTS region (
    idRegion INT PRIMARY KEY AUTO_INCREMENT,
    nombreRegion VARCHAR(250) NOT NULL,
    CONSTRAINT UQ_region_nombre UNIQUE (nombreRegion)
);

CREATE TABLE IF NOT EXISTS departamento (
    idDepartamento INT PRIMARY KEY,
    idRegion INT,
    nombreDepartamento VARCHAR(250) NOT NULL,
    CONSTRAINT fk_departamento_region
        FOREIGN KEY (idRegion) REFERENCES region(idRegion)
);

CREATE TABLE IF NOT EXISTS municipio (
    idMunicipio VARCHAR(20) PRIMARY KEY,
    idDepartamento INT,
    nombreMunicipio VARCHAR(250) NOT NULL,
    CONSTRAINT fk_municipio_departamento
        FOREIGN KEY (idDepartamento) REFERENCES departamento(idDepartamento)
);

-- 1. Cargar Regiones
LOAD DATA LOCAL INFILE '/home/loader/repository/Departamentos_y_municipios_de_Colombia_20241031.csv'
IGNORE
INTO TABLE region
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@nombreRegion, @codDep, @nomDep, @codMun, @nomMun)
SET nombreRegion = @nombreRegion;

-- 2. Cargar departamentos
LOAD DATA LOCAL INFILE '/home/loader/repository/Departamentos_y_municipios_de_Colombia_20241031.csv'
IGNORE
INTO TABLE departamento
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@nombreRegion, @codDep, @nomDep, @codMun, @nomMun)
SET
    idDepartamento     = CAST(@codDep AS UNSIGNED),
    idRegion           = (SELECT idRegion FROM region WHERE nombreRegion = @nombreRegion),
    nombreDepartamento = @nomDep;

-- 3. Cargar municipios
LOAD DATA LOCAL INFILE '/home/loader/repository/Departamentos_y_municipios_de_Colombia_20241031.csv'
IGNORE
INTO TABLE municipio
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@nombreRegion, @codDep, @nomDep, @codMun, @nomMun)
SET
    idMunicipio     = REPLACE(@codMun, '.', '-'),
    idDepartamento  = CAST(SUBSTRING_INDEX(@codMun, '.', 1) AS UNSIGNED),
    nombreMunicipio = @nomMun;