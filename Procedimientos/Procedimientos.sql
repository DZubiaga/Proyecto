create or replace PACKAGE PACKFASE3 IS

type g_cursor is ref cursor;

    PROCEDURE VER_TRABAJADOR_DNI(P_DNI IN TRABAJADORES.DNI%TYPE, T_CURSOR OUT g_cursor);
    PROCEDURE VER_CENTROS(T_CURSOR OUT g_cursor);
    PROCEDURE VER_TRABAJADORES(P_ID_CENTRO IN CENTROS.IDCENTRO%TYPE, T_CURSOR OUT g_cursor);

END PACKFASE3;


create or replace PACKAGE BODY PACKFASE3 IS

PROCEDURE VER_TRABAJADOR_DNI(P_DNI IN TRABAJADORES.DNI%TYPE, T_CURSOR OUT g_cursor) IS
BEGIN
    OPEN T_CURSOR FOR SELECT * FROM TRABAJADORES WHERE DNI = P_DNI;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR (-20000,'Error: NO EXISTE EL DNI INTRODUCIDO');
END;

PROCEDURE VER_CENTROS(T_CURSOR OUT g_cursor) IS
BEGIN
    OPEN T_CURSOR FOR SELECT * FROM CENTROS;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR (-20001,'Error: Error al recuperar los datos de los centros');
END;

PROCEDURE VER_TRABAJADORES(P_ID_CENTRO IN CENTROS.IDCENTRO%TYPE, T_CURSOR OUT g_cursor) IS
BEGIN
    OPEN T_CURSOR FOR SELECT * FROM TRABAJADORES WHERE CENTRO = P_ID_CENTRO;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR (-20002,'Error: NO EXISTE EL ID DEL CENTRO INTRODUCIDO');
END;

END PACKFASE3;