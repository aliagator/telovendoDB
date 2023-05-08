DROP TABLE IF EXISTS `telovendoDb`;
CREATE DATABASE `telovendoDb`;
USE `telovendoDb`;
/*
Creacion de usuario con todos los privilegios.
*/
CREATE USER 'doraemon'@'localhost' IDENTIFIED BY 'pass123';
GRANT ALL PRIVILEGES ON telovendoDb.* TO 'doraemon'@'localhost';

DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles` (
  `id_rol` int AUTO_INCREMENT NOT NULL,
  `nombre_rol` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id_rol`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
;
/*
Primera tabla que se crea, "roles". identifica a solo tres entes.
id_rol: El primer valor es auto incremental, int, primary key.
nombre_rol:describe que rol, varchar(45).
1: es para administrador
2: Vendedor
3: cliente.
*/
DROP TABLE IF EXISTS `usuarios`;
CREATE TABLE `usuarios` (
  `id_usuario` int NOT NULL,
  `nombre` varchar(45) DEFAULT NULL,
  `apellido` varchar(45) DEFAULT NULL,
  `contrasena` varchar(45) DEFAULT NULL,
  `zonaHoraria` varchar(45) DEFAULT 'UTC-3',
  `genero` varchar(45) DEFAULT NULL,
  `telefono` int DEFAULT NULL,
  `id_rol` int NOT NULL,
  PRIMARY KEY (`id_usuario`),
  FOREIGN KEY (id_rol) REFERENCES roles(id_rol)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
;
/*
Segunda tabla, "usuarios". Comprende a tanto administrador, vendedor y clientes del sistema.
-`id_usuario`: primer valor, int, primary key.
-`nombre`: nombre del usuario, contienme dos nombres, varchar(45), por defecto vacio.
- `apellido`: apellido del usuario, last naame en ingles, dato varchar(45), por defecto vacio.
- `contrasena`: caracter, de cacater alfanumerico varchar(45), por defecto vario.
- `zonaHoraria` varchar(45), por defecto 'UTC-3',
- `genero`: M o F, de  varchar(45) DEFAULT NULL,
- `telefono`: del tipo int, por defecto nulo.
- `id_rol`: llave foranea, de la  int NOT NULL,
*/
DROP TABLE IF EXISTS `fechaHora`;
CREATE TABLE `fechaHora` (
  `id_ingreso` INT AUTO_INCREMENT PRIMARY KEY,
  `id_usuario` INT NOT NULL,
  `fecha_hora_ingreso` DATETIME DEFAULT NOW(),
  FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
;
/*
Tercera tabla "fechaHora"; Representa el registro de ingresos de usuarios a la aplicacion.
  `id_ingreso`: numero unico, INT, auto incremental y PRIMARY KEY.
  `id_usuario`: numero de isiario que ingresa. INT, NOT NULL, fforeing key.
  `fecha_hora_ingreso`: Fecha de ingreso, con la funcion NOW().
*/
DROP TABLE IF EXISTS `productos`;
CREATE TABLE `productos` (
  `id_producto` INT PRIMARY KEY,
  `nombreProd` varchar(45) DEFAULT NULL,
  `precio`  DECIMAL(10,2), 
  `categoria` VARCHAR(50),
  `proveedor` VARCHAR(50),
  `color` VARCHAR(50),
  `stock` INT DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
;
/*
Caurta tabla, "productos." Representa a los productos que se venden.
  `id_producto`: tipo de dato INT, llave primaria.
  `nombreProd`: Descripcion del producto, tipo de dato varchar(45), por defecto nulo.
  `precio`: Valor del producto, del tipo de dato DECIMAL(10,2). Expresado en moneda chilena clp. 
  `categoria`: Subconjunto al que pertenece, tipo de dato VARCHAR(50).
  `proveedor`: proveedor que entrega el producto, tipo de dato VARCHAR(50).
  `color`: Color del articulo que se vende, tipo de dato VARCHAR(50).
  `stock`: Cantidad de productos que existe de un determinado item, tipo de dato INT, por defecto nulo.
*/
DROP TABLE IF EXISTS `compraventa`;
CREATE TABLE `compraventa` (
  `id_producto` INT,
  `id_usuario` INT,
  `fecha_hora_ingreso` DATETIME DEFAULT NOW(),
  FOREIGN KEY (id_producto) REFERENCES productos(id_producto),
  FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
;
/*
Quinta tabla que se crea, "compraventa". Vincula las tabla de muchos a muchos. productos con usuarios, llevando un registro unico.
  `id_producto`: numero de producto INT, llave foranea.
  `id_usuario`: numero de usuario INT, llave foranea.
  `fecha_hora_ingreso`: fecha de celebracion, tipo de dato, DATETIME, con la fucnionpor defecto NOW().
*/

INSERT INTO roles (id_rol, nombre_rol) VALUES
  (1,'Administrador'),
  (2,'Vendedor'),
  (3,'Cliente')
;

INSERT INTO usuarios (id_usuario, nombre, apellido, contrasena, zonaHoraria, genero, telefono, id_rol) VALUES
  (1, 'Juan', 'Perez', '123456', 'UTC-3', 'M', 12345678, 1),
  (2, 'Maria', 'Gomez', 'qwerty', 'UTC-3', 'F', 23456789, 2),
  (3, 'Pedro', 'Rodriguez', 'abcdef', 'UTC-3', 'M', 345674269, 3),
  (4, 'Antonio', 'Peredo', 'abcdef', 'UTC-3', 'M', 34567856, 3),
  (5, 'Jose', 'Mc Iver', 'abcdef', 'UTC-3', 'M', 34567123, 3),
  (6, 'Rodrigo', 'Amunategui', 'abcdef', 'UTC-3', 'M', 34567463, 3),
  (7, 'Pedro', 'Lira', 'abcdef', 'UTC-3', 'M', 34567856, 3),
  (8, 'Lorenzo', 'Lamas', 'abcdef', 'UTC-3', 'M', 34567888, 3)
;


INSERT INTO `fechaHora`(id_ingreso, id_usuario, fecha_hora_ingreso) VALUES
(NULL,1,NOW()),
(NULL,2,NOW()),
(NULL,3,NOW()),
(NULL,4,NOW()),
(NULL,5,NOW()),
(NULL,6,NOW()),
(NULL,7,NOW()),
(NULL,8,NOW());

INSERT INTO productos (id_producto, nombreProd, precio, Categoria, Proveedor, Color, Stock) VALUES
  (1, 'Laptop ASUS P500', 600000.00, 'Electrónica', 'ASUS', 'Negro', 20),
  (2, 'Celular IPHONE 14', 800000.00, 'Electrónica', 'APPLE', 'Gris', 30),
  (3, 'Zapatillas DC', 30000.00, 'Calzado', 'DC', 'Rojo', 50),
  (4, 'Tablet SONY', 250000.00, 'Electrónica', 'Sony', 'Plata', 15),
  (5, 'Gorra GAP', 30000.00, 'Accesorios', 'GAP', 'Negro', 100),
  (6, 'Bicicleta CANNONDALE', 100000.00, 'Deportes', 'Specialized', 'Verde', 10),
  (7, 'Televisor AOC', 200000.00, 'Electrónica', 'AOC', 'Negro', 25),
  (8, 'Camiseta PSG', 150000.00, 'Ropa', 'Nike', 'Blanco', 80),
  (9, 'Televisor TCL', 300000.00, 'Electrónica', 'TCL', 'Negro', 25),
  (10, 'Camiseta LA', 150000.00, 'Ropa', 'Nike', 'Blanco', 80),
;

INSERT INTO compraventa (id_producto, id_usuario, fecha_hora_ingreso) VALUES
  (1, 1, NOW()),
  (2, 2, NOW()),
  (3, 3, NOW()),
  (3, 4, NOW()),
  (3, 5, NOW()),
  (3, 6, NOW())
;

/*
******************************************CONSULTAS ***************************************************
*/

/*
- Cuál es la categoría de productos que más se repite.
*/
SELECT Categoria, COUNT(*) AS Cantidad FROM productos GROUP BY Categoria ORDER BY Cantidad DESC LIMIT 1;


/*
- Cuáles son los productos con mayor stock
*/
SELECT nombreProd FROM productos ORDER BY stock DESC LIMIT 1;

/*
Qué color de producto es más común en nuestra tienda.
*/
SELECT Color, COUNT(*) AS Cantidad FROM productos GROUP BY Color ORDER BY Cantidad DESC LIMIT 1;

/*
Cual o cuales son los proveedores con menor stock de productos.
*/
SELECT Proveedor, SUM(Stock) AS total_stock 
FROM productos 
GROUP BY Proveedor 
ORDER BY total_stock ASC 
LIMIT 1;

/*
Cambien la categoría de productos más popular por ‘Electrónica y computación’.
*/
UPDATE productos
SET Categoria = 'Electronica y Computación'
WHERE Categoria = 'Electrónica';


/*https://github.com/aliagator/telovendoDB */
