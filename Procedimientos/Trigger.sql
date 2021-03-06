CREATE OR REPLACE TRIGGER CONTROLHORAS
AFTER INSERT OR UPDATE ON VIAJES FOR EACH ROW
DECLARE
  V_SALIDA VARCHAR2;
  V_ENTRADA VARCHAR2;
  V_HORAS VARCHAR2;
  V_NUMERO NUMBER;
BEGIN
  SELECT MAX(ALBARAN) INTO V_NUMERO FROM VIAJES WHERE PARTE = :NEW.PARTE;
  FOR j IN 1..V_NUMERO LOOP
    SELECT HORASALIDA INTO V_SALIDA FROM VIAJES WHERE PARTE = :NEW.PARTE AND ALBARAN = J;
    SELECT HORALLEGADA INTO V_LLEGADA FROM VIAJES WHERE PARTE = :NEW.PARTE AND ALBARAN = J;
    V_HORAS := HORALLEGADA - HORASALIDA;
  END LOOP;
  IF V_HORAS > '08:00' THEN
    raise_application_error(-20000,'EL NUMERO DE HORAS ES MAYOR DE 8');
  END IF;
END;

  