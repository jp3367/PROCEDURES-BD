USE biblioteca_ut4;
-- Procedure 3
-- Creamos un procedimiento para listar libros por editorial pasando como parámetro la Editorial
DELIMITER //
CREATE PROCEDURE listar_libros_por_editorial(IN p_editorial VARCHAR(100))
BEGIN
    SELECT cod_libro, titulo, editorial, cod_autor FROM LIBRO WHERE editorial = p_editorial;
END //
DELIMITER ;
CALL listar_libros_por_editorial('Anaya');

-- Procedure 4
-- creamos un procedimiento para pasarle un titulo de libro y que nos devuelva la editorial
DELIMITER //
CREATE PROCEDURE obtener_editorial_por_titulo (IN p_titulo VARCHAR(150), OUT p_editorial VARCHAR(100))
BEGIN
    SELECT editorial INTO p_editorial FROM LIBRO WHERE titulo = p_titulo;
END //
DELIMITER ;

CALL obtener_editorial_por_titulo('Niebla', @editorial);
SELECT @editorial;

-- Procedure 5
-- Creamos un procedimiento de nombre: autor_del_libro para pasarle un titulo del libro y que nos devuelva el autor del libro
DELIMITER //
CREATE PROCEDURE autor_del_libro(IN  p_titulo  VARCHAR(150), OUT p_autor   VARCHAR(100))
BEGIN
    SELECT A.nombre INTO p_autor FROM LIBRO L JOIN AUTOR A ON L.cod_autor = A.cod_autor WHERE L.titulo = p_titulo;
END //
DELIMITER ;

CALL autor_del_libro('Andanzas', @p_Nombre);
SELECT @p_Nombre;

-- Procedure 6 
-- Creamos un procedimiento que llamaremos libros_en_sala para que nos devuelva una lista de valores 
-- en este caso pasamos una sala y nos devuelve los libros de ella
DELIMITER //
CREATE PROCEDURE libros_en_sala(IN p_sala VARCHAR(100))
BEGIN 
	SELECT DISTINCT L.cod_libro, L.titulo, L.editorial FROM LIBRO L JOIN EJEMPLAR E ON L.cod_libro = E.cod_libro WHERE E.localizacion = p_sala;
END //

DELIMITER ; 
CALL  libros_en_sala('Sala_2');

-- Procedure 7
-- Creamos un procedimiento de nombre: libros_del_autor para pasarle un autor y nos devuelva una lista de libros
DELIMITER //
CREATE PROCEDURE libros_del_autor(IN p_autor VARCHAR(100))
BEGIN
    SELECT L.cod_libro, L.titulo, L.editorial FROM LIBRO L JOIN AUTOR A ON L.cod_autor = A.cod_autor WHERE A.nombre = p_autor;
END //
DELIMITER ;

CALL libros_del_autor('Unamuno');

-- Procedure 8
-- Creamos un procedimiento para actualizar la editorial de un libro pasamos nombre del libro y editorial

DELIMITER //
CREATE PROCEDURE actualizar_editorial(IN p_titulo VARCHAR(100), IN p_editorial VARCHAR(100))
BEGIN
    UPDATE LIBRO SET editorial = p_editorial WHERE titulo = p_titulo;
END //
DELIMITER ;

CALL actualizar_editorial('Niebla', 'Planeta');
SELECT titulo, editorial FROM LIBRO WHERE titulo = 'Niebla'; 

-- Procedure 9 
-- Cambiar la localización de  un ejemplar pasamos un código del ejemplar y nueva localización
DELIMITER //
CREATE PROCEDURE cambiar_localizacion(IN p_cod_ejemplar INT, IN p_localizacion VARCHAR(100))
BEGIN
    UPDATE EJEMPLAR SET localizacion = p_localizacion WHERE cod_ejemplar = p_cod_ejemplar;
END //
DELIMITER ;

CALL cambiar_localizacion(70001, 'Sala_3');
SELECT cod_ejemplar, localizacion FROM EJEMPLAR WHERE cod_ejemplar = 70001;

-- Procedure 10
-- Mostrar libros junto con numero de ejemplares ordenados

DELIMITER //
CREATE PROCEDURE libros_con_ejemplares()
BEGIN
    SELECT L.cod_libro, L.titulo, L.editorial, COUNT(E.cod_ejemplar) AS num_ejemplares FROM LIBRO L LEFT JOIN EJEMPLAR E ON L.cod_libro = E.cod_libro 
    GROUP BY L.cod_libro, L.titulo, L.editorial ORDER BY num_ejemplares;
END //
DELIMITER ;

CALL libros_con_ejemplares();