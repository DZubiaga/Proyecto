drop table centros cascade constraints;
drop table trabajadores cascade constraints;
drop table partes cascade constraints;
drop table viajes cascade constraints;
drop table usuarios cascade constraints;
 
DROP SYNONYM c ;
DROP SYNONYM t ;
DROP SYNONYM p ;
DROP SYNONYM v ;
DROP SYNONYM u ;

CREATE TABLE centros(
idCentro NUMBER(3) 
GENERATED ALWAYS AS IDENTITY
                  MINVALUE 1
                  MAXVALUE 999
                  INCREMENT BY 1
                  START WITH 1
                  NOCYCLE NOT NULL ENABLE,                  
nombre VARCHAR2(15) NOT NULL,
telefono VARCHAR2(9) NOT NULL,
calle VARCHAR2(40) NOT NULL,
numero VARCHAR2(2) NOT NULL,
codPostal VARCHAR2(5) NOT NULL,
ciudad VARCHAR2(15) NOT NULL,
provincia VARCHAR2(15) NOT NULL,
  
CONSTRAINT cen_idcen_pk PRIMARY KEY (idCentro)
);
  
CREATE TABLE trabajadores(
dni VARCHAR2(9) NOT NULL,
nombre VARCHAR2(15) NOT NULL,
apellido1 VARCHAR2(20) NOT NULL,
apellido2 VARCHAR2(20) NOT NULL,
calle VARCHAR2(30) NOT NULL,
portal VARCHAR2(3) NOT NULL,
piso VARCHAR2(2) NOT NULL,
mano VARCHAR2(4) NOT NULL,
telefPersonal VARCHAR2(9),
telefEmpresa VARCHAR2(9) NOT NULL,
fechaNac DATE,
salario NUMBER(7,2),
tipoTrabajador VARCHAR2(20) NOT NULL,
centro NUMBER(3) NOT NULL,
usuario VARCHAR2(20) NOT NULL,
  
CONSTRAINT trab_dni_pk PRIMARY KEY (dni),
CONSTRAINT trab_cen_pk FOREIGN KEY (centro)
  REFERENCES centros(idCentro),
CONSTRAINT trab_tipot_ck CHECK (tipoTrabajador IN ('Logistica','Administracion'))
);

CREATE TABLE partes(
idParte NUMBER(10) 
GENERATED ALWAYS AS IDENTITY
                  MINVALUE 1
                  MAXVALUE 9999999999
                  INCREMENT BY 1
                  START WITH 1
                  NOCYCLE NOT NULL ENABLE,
fecha DATE NOT NULL,
kmInicio NUMBER(7) NOT NULL,
kmFinal NUMBER(7) NOT NULL,
gasolina NUMBER(4),
peaje NUMBER(3),
dietas NUMBER(3),
otros NUMBER(4),
incidencia VARCHAR2(255),
estado VARCHAR2(10),
validado VARCHAR2(2) NOT NULL,
trabajador VARCHAR2(9) NOT NULL,
  
CONSTRAINT part_idpart_pk PRIMARY KEY (idParte),
CONSTRAINT part_trab_fk FOREIGN KEY (trabajador)
  REFERENCES trabajadores(dni),
CONSTRAINT part_est_ck CHECK (estado IN ('Abierto','Cerrado')),
CONSTRAINT part_val_ck CHECK (validado IN ('Si','No'))

);
  
CREATE TABLE vehiculos(
matricula VARCHAR2(10),

CONSTRAINT veh_mat_pk PRIMARY KEY (matricula)
);

CREATE TABLE viajes(
albaran NUMBER(1) NOT NULL,
horaSalida VARCHAR2(5) NOT NULL,
horaLlegada VARCHAR2(5) NOT NULL,
matricula VARCHAR2(10) NOT NULL,
parte NUMBER(10) NOT NULL,
  
CONSTRAINT vi_partalb_pk PRIMARY KEY (parte,albaran),
CONSTRAINT vi_part_fk FOREIGN KEY (parte)
  	REFERENCES partes(idParte),
CONSTRAINT vi_mat_fk FOREIGN KEY (matricula)
	REFERENCES vehiculos(matricula) 
);
  
CREATE TABLE usuarios(
idUsuario VARCHAR2(20) NOT NULL,
password VARCHAR2(16) NOT NULL,
trabajador VARCHAR2(9) NOT NULL,
  
CONSTRAINT usu_idusu_pk PRIMARY KEY (idUsuario),
CONSTRAINT usu_trab_fk FOREIGN KEY (trabajador)
  REFERENCES trabajadores(dni)
);

CREATE TABLE informeXML(
idxml NUMBER(6),
xmlclob clob,

CONSTRAINT info_idxml_pk PRIMARY KEY (idxml)
);
 
CREATE SYNONYM c FOR centros;
CREATE SYNONYM t FOR trabajadores;
CREATE SYNONYM p FOR partes;
CREATE SYNONYM v FOR viajes;
CREATE SYNONYM u FOR usuarios;