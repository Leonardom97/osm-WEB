/*
 Navicat Premium Data Transfer

 Source Server         : osm_postgres
 Source Server Type    : PostgreSQL
 Source Server Version : 90525 (90525)
 Source Host           : 192.168.125.25:5432
 Source Catalog        : web_osm
 Source Schema         : public

 Target Server Type    : PostgreSQL
 Target Server Version : 90525 (90525)
 File Encoding         : 65001

 Date: 20/10/2025 11:23:40
*/


-- ----------------------------
-- Sequence structure for adm_usuario_roles_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."adm_usuario_roles_id_seq";
CREATE SEQUENCE "public"."adm_usuario_roles_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for agr_fecha_corte_id_fc_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."agr_fecha_corte_id_fc_seq";
CREATE SEQUENCE "public"."agr_fecha_corte_id_fc_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for asistente_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."asistente_id_seq";
CREATE SEQUENCE "public"."asistente_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for formulario_asistente_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."formulario_asistente_id_seq";
CREATE SEQUENCE "public"."formulario_asistente_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for formulario_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."formulario_id_seq";
CREATE SEQUENCE "public"."formulario_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for lugar_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."lugar_id_seq";
CREATE SEQUENCE "public"."lugar_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for proceso_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."proceso_id_seq";
CREATE SEQUENCE "public"."proceso_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for roles_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."roles_id_seq";
CREATE SEQUENCE "public"."roles_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for tema_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."tema_id_seq";
CREATE SEQUENCE "public"."tema_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for tipo_actividad_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."tipo_actividad_id_seq";
CREATE SEQUENCE "public"."tipo_actividad_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for usuarios_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."usuarios_id_seq";
CREATE SEQUENCE "public"."usuarios_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Table structure for adm_cargos
-- ----------------------------
DROP TABLE IF EXISTS "public"."adm_cargos";
CREATE TABLE "public"."adm_cargos" (
  "id_cargo" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "cargo" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "rango_cargo" varchar(255) COLLATE "pg_catalog"."default"
)
;

-- ----------------------------
-- Records of adm_cargos
-- ----------------------------
INSERT INTO "public"."adm_cargos" VALUES ('141', 'ANALISTA AGRONOMICO', 'ANALISTAS');
INSERT INTO "public"."adm_cargos" VALUES ('135', 'DIBUJANTE TECNICO', 'ANALISTAS');
INSERT INTO "public"."adm_cargos" VALUES ('122', 'LIDER ANALISTA', 'ANALISTAS');
INSERT INTO "public"."adm_cargos" VALUES ('137', 'TECNOLOGO AGRICOLA', 'ANALISTAS');
INSERT INTO "public"."adm_cargos" VALUES ('011', 'TESORERO', 'ANALISTAS');
INSERT INTO "public"."adm_cargos" VALUES ('116', 'ANALISTA DE INFORMACION', 'ANALISTAS');
INSERT INTO "public"."adm_cargos" VALUES ('027', 'ASISTENTE ADMNISTRATIVO', 'ASISTENTES');
INSERT INTO "public"."adm_cargos" VALUES ('114', 'ASISTENTE CONTABLE', 'ASISTENTES');
INSERT INTO "public"."adm_cargos" VALUES ('014', 'ASISTENTE DE ALMACEN Y COMPRAS', 'ASISTENTES');
INSERT INTO "public"."adm_cargos" VALUES ('100', 'ASISTENTE DE MANTENIMIENTO', 'ASISTENTES');
INSERT INTO "public"."adm_cargos" VALUES ('017', 'ASISTENTE DE SISTEMAS', 'ASISTENTES');
INSERT INTO "public"."adm_cargos" VALUES ('125', 'ASISTENTE PRODUCCION INDUSTRIAL', 'ASISTENTES');
INSERT INTO "public"."adm_cargos" VALUES ('119', 'PLANEADOR MANTENIMIENTO', 'ASISTENTES');
INSERT INTO "public"."adm_cargos" VALUES ('085', 'AUXILIAR ADMINISTRATIVO', 'AUXILIARES');
INSERT INTO "public"."adm_cargos" VALUES ('013', 'AUXILIAR CONTABLE', 'AUXILIARES');
INSERT INTO "public"."adm_cargos" VALUES ('052', 'AUXILIAR DE LABORATORIO', 'AUXILIARES OPERATIVOS');
INSERT INTO "public"."adm_cargos" VALUES ('030', 'AUXILIAR DE SUPERVISION AGRICOLA', 'AUXILIARES OPERATIVOS');
INSERT INTO "public"."adm_cargos" VALUES ('024', 'CONDUCTOR ', 'CONDUCTORES');
INSERT INTO "public"."adm_cargos" VALUES ('018', 'CONDUCTOR -MENSAJERO', 'CONDUCTORES');
INSERT INTO "public"."adm_cargos" VALUES ('129', 'COORDINADOR ADMINISTRATIVO', 'COORDINADORES');
INSERT INTO "public"."adm_cargos" VALUES ('081', 'COORDINADOR CONTABLE', 'COORDINADORES');
INSERT INTO "public"."adm_cargos" VALUES ('105', 'COORDINADOR DE PROYECTOS', 'COORDINADORES');
INSERT INTO "public"."adm_cargos" VALUES ('128', 'INGENIERA AGRICOLA', 'COORDINADORES');
INSERT INTO "public"."adm_cargos" VALUES ('091', 'COORDINADOR DE LOGISTICA', 'COORDINADORES');
INSERT INTO "public"."adm_cargos" VALUES ('076', 'COORDINADOR PRODUCCION INDUSTRIAL', 'COORDINADORES');
INSERT INTO "public"."adm_cargos" VALUES ('136', 'COORDINADOR AGRONOMO', 'COORDINADORES');
INSERT INTO "public"."adm_cargos" VALUES ('117', 'DIRECTOR DE MANTENIMIENTO INDUSTRIAL', 'DIRECTORES');
INSERT INTO "public"."adm_cargos" VALUES ('043', 'DIRECTOR DE PLANTA', 'DIRECTORES');
INSERT INTO "public"."adm_cargos" VALUES ('068', 'DIRECTOR LOGISTICA, COSECHA Y MANTENIMIENTO', 'DIRECTORES');
INSERT INTO "public"."adm_cargos" VALUES ('127', 'DIRECTORA ADMINISTRATIVA Y FINANCIERA', 'DIRECTORES');
INSERT INTO "public"."adm_cargos" VALUES ('007', 'JEFE DE COMPRAS', 'JEFES');
INSERT INTO "public"."adm_cargos" VALUES ('126', 'JEFE DE VENTAS', 'JEFES');
INSERT INTO "public"."adm_cargos" VALUES ('140', 'AUXILIAR DE APOYO', 'OPERATIVOS ADMINISTRATIVOS');
INSERT INTO "public"."adm_cargos" VALUES ('020', 'AUXILIAR DE SERVICIOS GENERALES I', 'OPERATIVOS ADMINISTRATIVOS');
INSERT INTO "public"."adm_cargos" VALUES ('054', 'AUXILIAR DE MANTENIMIENTO Y SOLDADURA', 'OPERATIVOS MANTENIMIENTO');
INSERT INTO "public"."adm_cargos" VALUES ('046', 'ELECTROMECANICO', 'OPERATIVOS MANTENIMIENTO');
INSERT INTO "public"."adm_cargos" VALUES ('118', 'OPERARIO ENERGIA', 'OPERATIVOS MANTENIMIENTO');
INSERT INTO "public"."adm_cargos" VALUES ('049', 'SOLDADOR MECANICO', 'OPERATIVOS MANTENIMIENTO');
INSERT INTO "public"."adm_cargos" VALUES ('031', 'OPERARIO DE MAQUINARIA AGRICOLA', 'OPERATIVOS PLANTA EXT');
INSERT INTO "public"."adm_cargos" VALUES ('055', 'OPERARIO DE PLANTA I', 'OPERATIVOS PLANTA EXT');
INSERT INTO "public"."adm_cargos" VALUES ('058', 'OPERARIO DE PLANTA II', 'OPERATIVOS PLANTA EXT');
INSERT INTO "public"."adm_cargos" VALUES ('033', 'OFICIOS VARIOS II', 'OPERATIVOS PRODUCCION AGRICOLA');
INSERT INTO "public"."adm_cargos" VALUES ('029', 'OFICIOS VARIOS III', 'OPERATIVOS PRODUCCION AGRICOLA');
INSERT INTO "public"."adm_cargos" VALUES ('095', 'OFICIOS VARIOS IV', 'OPERATIVOS PRODUCCION AGRICOLA');
INSERT INTO "public"."adm_cargos" VALUES ('104', 'OPERARIO DE LOGISTICA Y COSECHA', 'OPERATIVOS PRODUCCION AGRICOLA');
INSERT INTO "public"."adm_cargos" VALUES ('073', 'POLINIZADOR', 'OPERATIVOS PRODUCCION AGRICOLA');
INSERT INTO "public"."adm_cargos" VALUES ('130', 'SUPERVISOR DE LABORATORIO', 'SUPERVISORES');
INSERT INTO "public"."adm_cargos" VALUES ('089', 'SUPERVISOR DE LOGISTICA I', 'SUPERVISORES');
INSERT INTO "public"."adm_cargos" VALUES ('047', 'SUPERVISOR DE PROCESO', 'SUPERVISORES');
INSERT INTO "public"."adm_cargos" VALUES ('072', 'SUPERVISOR DE PRODUCCION', 'SUPERVISORES');
INSERT INTO "public"."adm_cargos" VALUES ('112', 'SUPERVISOR DE MANTENIMIENTO INDUSTRIAL', 'SUPERVISORES');
INSERT INTO "public"."adm_cargos" VALUES ('123', 'SUPERVISOR DE TOPOGRAFIA', 'SUPERVISORES');
INSERT INTO "public"."adm_cargos" VALUES ('004', 'DIRECTOR DE PROYECTOS', 'NO DEFINIDO');
INSERT INTO "public"."adm_cargos" VALUES ('008', 'COORDINADOR DE GESTION HUMANA', 'NO DEFINIDO');
INSERT INTO "public"."adm_cargos" VALUES ('016', 'ASISTENTE DE SEGURIDAD Y SALUD EN EL TRABAJO', 'NO DEFINIDO');
INSERT INTO "public"."adm_cargos" VALUES ('078', 'AUXILIAR SERVICIOS GENERALES II', 'NO DEFINIDO');
INSERT INTO "public"."adm_cargos" VALUES ('005', 'DIRECTORA CONTABLE', 'NO DEFINIDO');
INSERT INTO "public"."adm_cargos" VALUES ('003', 'GERENTE ADMINISTRATIVO', 'NO DEFINIDO');
INSERT INTO "public"."adm_cargos" VALUES ('006', 'COORDINADOR DE SISTEMAS', 'NO DEFINIDO');
INSERT INTO "public"."adm_cargos" VALUES ('001', 'GERENTE GENERAL', 'NO DEFINIDO');
INSERT INTO "public"."adm_cargos" VALUES ('009', 'ANALISTA CONTABLE  1', 'NO DEFINIDO');
INSERT INTO "public"."adm_cargos" VALUES ('019', 'MENSAJERO', 'NO DEFINIDO');
INSERT INTO "public"."adm_cargos" VALUES ('077', 'ASISTENTE ADMINISTRATIVO II', 'NO DEFINIDO');
INSERT INTO "public"."adm_cargos" VALUES ('010', 'COORDINADOR AMBIENTAL Y SO', 'NO DEFINIDO');
INSERT INTO "public"."adm_cargos" VALUES ('015', 'ASISTENTE ADMINISTRATIVA I', 'NO DEFINIDO');
INSERT INTO "public"."adm_cargos" VALUES ('021', 'ESTUDIANTE SENA ETAPA PRODUCTIVA', 'NO DEFINIDO');
INSERT INTO "public"."adm_cargos" VALUES ('040', 'ESTUDIANTE SENA ETAPA ELECTIVA', 'NO DEFINIDO');
INSERT INTO "public"."adm_cargos" VALUES ('093', 'COORDINADOR DE SEGURIDAD Y SALUD EN EL TRABAJO', 'NO DEFINIDO');
INSERT INTO "public"."adm_cargos" VALUES ('084', 'AUXILIAR DE SISTEMAS', 'NO DEFINIDO');
INSERT INTO "public"."adm_cargos" VALUES ('106', 'AUXILIAR ADMINISTRATIVAIII', 'NO DEFINIDO');
INSERT INTO "public"."adm_cargos" VALUES ('107', 'AUXILIAR DE CONSTRUCCION', 'NO DEFINIDO');
INSERT INTO "public"."adm_cargos" VALUES ('108', 'ASISTENTE AMBIENTAL', 'NO DEFINIDO');
INSERT INTO "public"."adm_cargos" VALUES ('111', 'OPERARIO PRODUCCION FIBRAS PRIMIUM', 'NO DEFINIDO');
INSERT INTO "public"."adm_cargos" VALUES ('124', 'ANALISTA ADMINISTRATIVO', 'NO DEFINIDO');
INSERT INTO "public"."adm_cargos" VALUES ('096', 'PASANTE UNIVERSITARIO', 'NO DEFINIDO');
INSERT INTO "public"."adm_cargos" VALUES ('039', 'JARDINERO', 'NO DEFINIDO');
INSERT INTO "public"."adm_cargos" VALUES ('066', 'SOLDADOR', 'NO DEFINIDO');
INSERT INTO "public"."adm_cargos" VALUES ('065', 'OPERADOR DE BASCULA', 'NO DEFINIDO');
INSERT INTO "public"."adm_cargos" VALUES ('115', 'INSPECTOR HSE', 'NO DEFINIDO');
INSERT INTO "public"."adm_cargos" VALUES ('094', 'ANALISTA PRODUCCION AGRICOLA', 'NO DEFINIDO');
INSERT INTO "public"."adm_cargos" VALUES ('022', 'OFICIOS VARIOS I', 'NO DEFINIDO');
INSERT INTO "public"."adm_cargos" VALUES ('034', 'AYUDANTE DE SANIDAD', 'NO DEFINIDO');
INSERT INTO "public"."adm_cargos" VALUES ('032', 'VAQUERO', 'NO DEFINIDO');
INSERT INTO "public"."adm_cargos" VALUES ('035', 'OPERARIO DE PLUMA', 'NO DEFINIDO');
INSERT INTO "public"."adm_cargos" VALUES ('041', 'CONVENIO', 'NO DEFINIDO');
INSERT INTO "public"."adm_cargos" VALUES ('036', 'TECNICO MANTENIMIENTO I', 'NO DEFINIDO');
INSERT INTO "public"."adm_cargos" VALUES ('074', 'DIRECTOR DE PRODUCCION', 'NO DEFINIDO');
INSERT INTO "public"."adm_cargos" VALUES ('026', 'ASISTENTE AGRONOMICO', 'NO DEFINIDO');
INSERT INTO "public"."adm_cargos" VALUES ('060', 'PEPERO', 'NO DEFINIDO');
INSERT INTO "public"."adm_cargos" VALUES ('061', 'RACIMERO', 'NO DEFINIDO');
INSERT INTO "public"."adm_cargos" VALUES ('062', 'GANCHERO', 'NO DEFINIDO');
INSERT INTO "public"."adm_cargos" VALUES ('051', 'ALMACENISTA', 'NO DEFINIDO');
INSERT INTO "public"."adm_cargos" VALUES ('090', 'SUPERVISOR DE LOGISTICA II', 'NO DEFINIDO');
INSERT INTO "public"."adm_cargos" VALUES ('097', 'SUPERVISOR PLANTA DE COMPOSTAJE', 'NO DEFINIDO');
INSERT INTO "public"."adm_cargos" VALUES ('099', 'ASISTENTE ADMINISTRATIVO III', 'NO DEFINIDO');
INSERT INTO "public"."adm_cargos" VALUES ('102', 'TOPÓGRAFO', 'NO DEFINIDO');
INSERT INTO "public"."adm_cargos" VALUES ('109', 'SUPERVISOR DE TALLER AGRICOLA', 'NO DEFINIDO');
INSERT INTO "public"."adm_cargos" VALUES ('131', 'ANALISTA DE INVESTIGACION', 'NO DEFINIDO');
INSERT INTO "public"."adm_cargos" VALUES ('138', 'COORDINADOR DE PROYECTOS', 'NO DEFINIDO');
INSERT INTO "public"."adm_cargos" VALUES ('088', 'OPERARIO MAQUINARIA AGRICOLA I', 'NO DEFINIDO');
INSERT INTO "public"."adm_cargos" VALUES ('042', 'COORDINADOR DE PRODUCCIÓN', 'NO DEFINIDO');
INSERT INTO "public"."adm_cargos" VALUES ('063', 'RECOGEDOR', 'NO DEFINIDO');
INSERT INTO "public"."adm_cargos" VALUES ('079', 'ALISTADOR', 'NO DEFINIDO');
INSERT INTO "public"."adm_cargos" VALUES ('023', 'GERENTE AGRONOMICO', 'NO DEFINIDO');
INSERT INTO "public"."adm_cargos" VALUES ('002', 'GERENTE FINANCIERO', 'NO DEFINIDO');
INSERT INTO "public"."adm_cargos" VALUES ('064', 'COORDINADOR DE PROCESOS Y CALIDAD', 'NO DEFINIDO');
INSERT INTO "public"."adm_cargos" VALUES ('110', 'DIRECTOR ADMINISTRATIVO', 'NO DEFINIDO');
INSERT INTO "public"."adm_cargos" VALUES ('069', 'TECNICO MANTENIMIENTO AGRICOLA', 'NO DEFINIDO');
INSERT INTO "public"."adm_cargos" VALUES ('075', 'TECNICO ELECTROMECANICO', 'NO DEFINIDO');
INSERT INTO "public"."adm_cargos" VALUES ('050', 'OPERARIO MINICARGADOR', 'NO DEFINIDO');
INSERT INTO "public"."adm_cargos" VALUES ('083', 'OFICIAL DE CONSTRUCCION', 'NO DEFINIDO');
INSERT INTO "public"."adm_cargos" VALUES ('098', 'ELECTROMECANICO II', 'NO DEFINIDO');
INSERT INTO "public"."adm_cargos" VALUES ('132', 'OPERARIO MANTENIMIENTO LOCATIVO', 'NO DEFINIDO');
INSERT INTO "public"."adm_cargos" VALUES ('087', 'ASISTENTE DE LABORATORIO', 'NO DEFINIDO');
INSERT INTO "public"."adm_cargos" VALUES ('120', 'ANALISTA DE SISTEMA DE GESTION DE MANTENIMIENTO', 'NO DEFINIDO');
INSERT INTO "public"."adm_cargos" VALUES ('139', 'TECNICO EN SISTEMA HADRAULICO', 'NO DEFINIDO');
INSERT INTO "public"."adm_cargos" VALUES ('143', 'COORDINADOR DE ANALITICA Y SISTEMAS', 'NO DEFINIDO');

-- ----------------------------
-- Table structure for adm_colaboradores
-- ----------------------------
DROP TABLE IF EXISTS "public"."adm_colaboradores";
CREATE TABLE "public"."adm_colaboradores" (
  "ac_id" int4 NOT NULL DEFAULT nextval('asistente_id_seq'::regclass),
  "ac_cedula" varchar(20) COLLATE "pg_catalog"."default" NOT NULL,
  "ac_nombre1" varchar(200) COLLATE "pg_catalog"."default" NOT NULL,
  "ac_empresa" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "ac_id_cargo" varchar(255) COLLATE "pg_catalog"."default",
  "ac_id_area" varchar(255) COLLATE "pg_catalog"."default",
  "ac_id_situación" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "ac_contraseña" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "ac_sub_area" varchar(255) COLLATE "pg_catalog"."default",
  "ac_rango" varchar(255) COLLATE "pg_catalog"."default",
  "ac_nombre2" varchar(255) COLLATE "pg_catalog"."default",
  "ac_apellido1" varchar(255) COLLATE "pg_catalog"."default",
  "ac_apellido2" varchar(255) COLLATE "pg_catalog"."default",
  "ac_id_rol" int4 NOT NULL DEFAULT 1
)
;

-- ----------------------------
-- Records of adm_colaboradores
-- ----------------------------
INSERT INTO "public"."adm_colaboradores" VALUES (68, '1122136493', 'BRANDON', '1', '040', '000', 'E', '38518TSBJ', '000', 'NO DEFINIDO', 'JAIR', 'TOVAR', 'SANCHEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (69, '1122136493', 'BRANDON', '1', '021', '000', 'E', '38518TSBJ', '000', 'NO DEFINIDO', 'JAIR', 'TOVAR', 'SANCHEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (70, '1122145093', 'ERIKA', '1', '021', '000', 'E', '47118GAET', '000', 'NO DEFINIDO', 'TATIANA', 'GONZALEZ', 'ALFONSO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (71, '1022938169', 'FRANCISCO', '1', '021', '000', 'E', '40194GOF', '000', 'NO DEFINIDO', '', 'GARZON', 'OLIVOS', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (72, '1122145093', 'ERIKA', '1', '015', '005', 'X', '47118GAET', '005', 'NO DEFINIDO', 'TATIANA', 'GONZALEZ', 'ALFONSO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (469, '1123116532', 'XIMENA', '1', '073', '002', 'E', '18557HPXC', '002', 'OPERATIVOS PRODUCCION AGRICOLA', 'CAROLINA', 'HERRERA', 'PARRA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (470, '1123084139', 'MARIA', '1', '073', '001', 'E', '86164FGMG', '001', 'OPERATIVOS PRODUCCION AGRICOLA', 'GUADALUPE', 'FAJARDO', 'GOMEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (471, '1121825153', 'MARIA', '1', '073', '001', 'E', '27178BAMT', '001', 'OPERATIVOS PRODUCCION AGRICOLA', 'TATIANA', 'BERMUDEZ', 'ALZA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (7, '51943764', 'LUZ', '1', '078', '000', 'E', '45789VPLM', '000', 'NO DEFINIDO', 'MERY', 'VACA', 'PALACIOS', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (8, '52795113', 'SANDRA', '1', '011', '000', 'E', '97138ACSC', '000', 'ANALISTAS', 'CONSTANZA', 'ACUÑA', 'CHAVEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (9, '52971630', 'DIANA', '1', '005', '000', 'E', '73655GADG', '000', 'NO DEFINIDO', 'GINETH', 'GARCIA', 'ARBOLEDA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (10, '66917031', 'SANDRA', '1', '003', '000', 'E', '19056AOSP', '000', 'NO DEFINIDO', 'PATRICIA', 'ACOSTA', 'OLMOS', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (11, '75104165', 'LEANDRO', '1', '014', '005', 'E', '6190RBLJ', '005', 'ASISTENTES', 'JAVIER', 'ROMERO', 'BELTRAN', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (12, '79647460', 'JHON', '1', '006', '000', 'E', '49485VDJA', '000', 'NO DEFINIDO', 'ALEXANDER', 'VARGAS', 'DAZA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (19, '1121880805', 'HERNANDO', '1', '011', '000', 'E', '82830NMH', '000', 'ANALISTAS', '', 'NEIVA', 'MARIÑO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (20, '1121881871', 'DIANA', '1', '010', '000', 'E', '83896CSDY', '000', 'NO DEFINIDO', 'YURANY', 'CABALLERO', 'SANCHEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (23, '1122131465', 'LUIS', '1', '021', '000', 'E', '33490MBLB', '000', 'NO DEFINIDO', 'BERTULFO', 'MARIN', 'BALLEN', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (24, '52231234', 'GLORIA', '1', '003', '000', 'E', '33259PPGP', '000', 'NO DEFINIDO', 'PATRICIA', 'PINTO', 'PUENTES', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (25, '1118197909', 'NORIDA', '1', '015', '005', 'E', '99934CBN', '005', 'NO DEFINIDO', '', 'CANO', 'BURITICA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (26, '1122133205', 'MARIA', '1', '040', '000', 'E', '35230HRMF', '000', 'NO DEFINIDO', 'FERNANDA', 'HURTADO', 'RAMOS', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (27, '1120369160', 'LUIS', '1', '021', '000', 'E', '71185TDLC', '000', 'NO DEFINIDO', 'CARLOS', 'TRUJILLO', 'DE LA VILLA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (28, '53095774', 'DIANA', '1', '016', '000', 'X', '97799GVDF', '000', 'NO DEFINIDO', 'FERNANDA', 'GUERRERO', 'VALDERRAMA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (36, '1122130558', 'YURI', '1', '084', '000', 'E', '32583RAYJ', '000', 'NO DEFINIDO', 'JOHANA', 'RODRIGUEZ', 'ARIAS', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (37, '40434891', 'YULI', '1', '085', '005', 'E', '36916DMYA', '005', 'AUXILIARES', 'ANDREA', 'DEAZA', 'MURIEL', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (38, '1123115569', 'NATALIA', '1', '021', '005', 'E', '17594BUN', '005', 'NO DEFINIDO', '', 'BARRETO', 'URIBE', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (56, '1121817694', 'VICTOR', '1', '018', '005', 'E', '19719VPVA', '005', 'CONDUCTORES', 'ALFONSO', 'VALLEJO', 'PARRADO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (57, '1116805369', 'ARLEX', '1', '108', '005', 'E', '7394DAA', '005', 'NO DEFINIDO', '', 'DIAZ', 'ACEVEDO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (58, '1122239349', 'WILMER', '1', '021', '005', 'E', '41374AOWY', '005', 'NO DEFINIDO', 'YESID', 'ALVAREZ', 'OROZCO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (59, '19000809', 'JHON', '1', '111', '005', 'E', '2834GVJJ', '005', 'NO DEFINIDO', 'JAIRO', 'GALEANO', 'VALDOMERO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (60, '1122130077', 'CAROL', '1', '021', '000', 'E', '32102LMCX', '000', 'NO DEFINIDO', 'XIMENA', 'LARGO', 'MONTOYA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (13, '79785328', 'JORGE', '1', '001', '005', 'A', '87353RMJH', '005', 'NO DEFINIDO', 'HERNANDO', 'RIVEROS', 'MOYANO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (14, '1018434379', 'VERONICA', '1', '009', '000', 'E', '36404RQVJ', '000', 'NO DEFINIDO', 'JOHANA', 'RODRIGUEZ', 'QUIROGA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (15, '1073232752', 'JULIAN', '1', '019', '000', 'E', '34777APJG', '000', 'NO DEFINIDO', 'GUILLERMO', 'AREVALO', 'PEREZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (16, '1111199263', 'YAMNA', '1', '077', '000', 'E', '101288LBYZ', '000', 'NO DEFINIDO', 'ZULEIMA', 'LOZANO', 'BARRIOS', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (17, '1121830969', 'ADRIANA', '1', '008', '000', 'E', '32994ALAM', '000', 'NO DEFINIDO', 'MARIA', 'ACOSTA', 'LOZADA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (18, '1121866104', 'ALBA', '1', '127', '005', 'V', '68129SRAL', '005', 'DIRECTORES', 'LUCIA', 'SALCEDO', 'RIVAS', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (29, '7838138', 'VIONNEY', '1', '018', '000', 'E', '40163VPV', '000', 'CONDUCTORES', '', 'VARON', 'PARRA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (30, '1123114665', 'CAMILA', '1', '081', '012', 'A', '16690BDC', '012', 'COORDINADORES', '', 'BAEZ', 'DUEÑAS', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (32, '1122133205', 'MARIA', '1', '016', '005', 'E', '35230HRMF', '005', 'NO DEFINIDO', 'FERNANDA', 'HURTADO', 'RAMOS', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (33, '1006838624', 'LINA', '1', '021', '003', 'E', '40649GJLP', '003', 'NO DEFINIDO', 'PAOLA', 'GUTIERREZ', 'JARA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (61, '1121958533', 'DENILSON', '1', '021', '005', 'E', '60558ICD', '005', 'NO DEFINIDO', '', 'IZAJAR', 'CARABALI', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (62, '1123085836', 'LIZETH', '1', '021', '005', 'E', '87861BRLV', '005', 'NO DEFINIDO', 'VERONICA', 'BONILLA', 'RAMOS', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (34, '1005827897', 'YEIMI', '1', '021', '005', 'E', '29922LIYL', '005', 'NO DEFINIDO', 'LORENA', 'LONDOÑO', 'ITE', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (35, '46454101', 'CLARA', '1', '093', '005', 'E', '56126BRCL', '005', 'NO DEFINIDO', 'LILIANA', 'BELTRAN', 'REYES', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (63, '1000115363', 'LISSETH', '1', '021', '005', 'E', '17388CGLN', '005', 'NO DEFINIDO', 'NATALIA', 'CARO', 'GRISALES', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (65, '1120384709', 'LEIDY', '1', '021', '005', 'E', '86734MGLN', '005', 'NO DEFINIDO', 'NATALIA', 'MEDINA', 'GARCIA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (66, '1016077570', 'JUAN', '1', '107', '005', 'E', '79595FCJC', '005', 'NO DEFINIDO', 'CAMILO', 'FUENTES', 'CETINA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (67, '1122135701', 'ALIXON', '1', '021', '000', 'E', '37726SVAD', '000', 'NO DEFINIDO', 'DAYANA', 'SANCHEZ', 'VARGAS', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (472, '1122139934', 'DISNARDA', '1', '073', '009', 'V', '41959SGDM', '009', 'OPERATIVOS PRODUCCION AGRICOLA', 'MARIA', 'SANABRIA', 'GUACARAPARE', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (473, '1006555318', 'ORLANDO', '1', '073', '009', 'A', '57343GO', '009', 'OPERATIVOS PRODUCCION AGRICOLA', '', 'GONZALEZ', '', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (474, '1123086261', 'GLADYS', '1', '073', '001', 'E', '88286CMGY', '001', 'OPERATIVOS PRODUCCION AGRICOLA', 'YOLANDA', 'CARVAJAL', 'MENDEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (475, '52850723', 'ELIZABETH', '1', '073', '009', 'A', '52748RGE', '009', 'OPERATIVOS PRODUCCION AGRICOLA', '', 'ROSAS', 'GIRALDO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (476, '1144083562', 'ANGELICA', '1', '073', '001', 'E', '85587HSA', '001', 'OPERATIVOS PRODUCCION AGRICOLA', '', 'HERNANDEZ', 'SALAMANCA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (477, '1118027885', 'DIANA', '1', '073', '001', 'E', '29910LPDE', '001', 'OPERATIVOS PRODUCCION AGRICOLA', 'ESNEIRA', 'LOPEZ', 'PARRA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (478, '40434381', 'OVIDIA', '1', '073', '009', 'A', '36406MMO', '009', 'OPERATIVOS PRODUCCION AGRICOLA', '', 'MENDOZA', 'MALAGON', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (661, '1048993096', 'YULEIMER', '1', '104', '001', 'E', '95121DBY', '001', 'OPERATIVOS PRODUCCION AGRICOLA', '', 'DE LA ROSA', 'BARBA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (662, '1030586340', 'MIGUEL', '1', '104', '000', 'E', '88365MMMA', '000', 'OPERATIVOS PRODUCCION AGRICOLA', 'ANGEL', 'MARTINEZ', 'MARTINEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (663, '1123115579', 'ARNOLD', '1', '104', '000', 'E', '17604EMAG', '000', 'OPERATIVOS PRODUCCION AGRICOLA', 'GUSTAVO', 'ENCISO', 'MARTINEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (664, '1123115789', 'SAMUEL', '1', '104', '001', 'E', '17814RCSD', '001', 'OPERATIVOS PRODUCCION AGRICOLA', 'DAVID', 'REYES', 'CARANTON', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (665, '17356760', 'ERNESTO', '1', '104', '001', 'E', '58785RCE', '001', 'OPERATIVOS PRODUCCION AGRICOLA', '', 'RODRIGUEZ', 'CARANTON', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (666, '1123116146', 'LUIS', '1', '104', '001', 'E', '18171CCLE', '001', 'OPERATIVOS PRODUCCION AGRICOLA', 'EDUARDO', 'CUERVO', 'CAICEDO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (667, '1123114992', 'HUBER', '1', '104', '001', 'E', '17017CCHA', '001', 'OPERATIVOS PRODUCCION AGRICOLA', 'ANDRES', 'CUERVO', 'CAICEDO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (4, '23621826', 'ANA', '1', '085', '005', 'E', '23851MFAC', '005', 'AUXILIARES', 'CECILIA', 'MOLINA', 'FULA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (5, '40329539', 'LORENA', '1', '008', '000', 'E', '31564OLL', '000', 'NO DEFINIDO', '', 'ORJUELA', 'LOPEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (77, '1006777279', 'ERIKA', '1', '021', '005', 'E', '79304LBEJ', '005', 'NO DEFINIDO', 'JULIANA', 'LOZANO', 'BOHORQUEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (78, '1122130280', 'JENNY', '1', '116', '011', 'A', '32305LAJP', '011', 'ANALISTAS', 'PATRICIA', 'LEMUS', 'ARDILA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (88, '1122118911', 'SANDRA', '1', '027', '005', 'A', '20936GVSL', '005', 'ASISTENTES', 'LILIANA', 'GUEVARA', 'VELASQUEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (89, '1123116616', 'MARTHA', '1', '021', '005', 'E', '18641LNMY', '005', 'NO DEFINIDO', 'YURANIS', 'LOPEZ', 'NOREÑA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (103, '1123510868', 'CAREN', '1', '021', '005', 'E', '12893QACY', '005', 'NO DEFINIDO', 'YULIANA', 'QUEVEDO', 'APONTE', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (104, '1115853757', 'JENIFER', '1', '084', '011', 'A', '55782MMJS', '011', 'NO DEFINIDO', 'SOLANYI', 'MENDIVELSO', 'MORENO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (114, '1122132379', 'JESSICA', '1', '084', '000', 'E', '34404PAJP', '000', 'NO DEFINIDO', 'PAOLA', 'PEREZ', 'AGATON', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (115, '1122141128', 'INGRID', '1', '021', '005', 'E', '43153HRIM', '005', 'NO DEFINIDO', 'MARITZA', 'HERNANDEZ', 'RIOS', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (139, '11350118', 'JOSE', '1', '068', '000', 'E', '52143CRJJ', '000', 'DIRECTORES', 'JOAQUIN', 'CARTAGENA', 'RENGIFO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (140, '15684004', 'JEAN', '1', '031', '003', 'X', '86029GMJC', '003', 'OPERATIVOS PLANTA EXT', 'CARLOS', 'GALLEGO', 'MARQUEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (116, '17292598', 'LUIS', '1', '055', '005', 'E', '94623CALA', '005', 'OPERATIVOS PLANTA EXT', 'ALFREDO', 'CASTRO', 'ACUÑA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (79, '1006778256', 'VICTOR', '1', '021', '005', 'E', '80281MJVM', '005', 'NO DEFINIDO', 'MANUEL', 'MOSQUERA', 'JIMENEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (90, '1003540912', 'ISABEL', '1', '013', '005', 'E', '42937TFIC', '005', 'AUXILIARES', 'CATALINA', 'TRUJILLO', 'FLOREZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (105, '1121946925', 'KELLY', '1', '021', '005', 'A', '48950HPKY', '005', 'NO DEFINIDO', 'YOHANA', 'HOYOS', 'PARRADO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (80, '1006873251', 'EDWARD', '1', '021', '005', 'E', '75276RPEJ', '005', 'NO DEFINIDO', 'JOHAN', 'RACERO', 'PORRAS', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (91, '1006875191', 'ERIC', '1', '013', '012', 'A', '77216RSEY', '012', 'AUXILIARES', 'YAMID', 'RINTA', 'SAENZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (141, '17265471', 'JOSE', '1', '031', '003', 'E', '67496RGJA', '003', 'OPERATIVOS PLANTA EXT', 'ANGEL', 'RAMOS', 'GUZMAN', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (81, '31031907', 'YOR', '1', '124', '005', 'E', '33932VPYM', '005', 'NO DEFINIDO', 'MARY', 'VARON', 'PARRA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (93, '1122137853', 'DENIS', '1', '116', '011', 'A', '39878RTDC', '011', 'ANALISTAS', 'CAROLINA', 'REINA', 'TELLEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (106, '1074130554', 'KAREN', '1', '021', '005', 'A', '32579VRKM', '005', 'NO DEFINIDO', 'MARISOL', 'VIZCAINO', 'RIVEROS', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (107, '3271551', 'HERNANDO', '1', '039', '002', 'E', '73576CCH', '002', 'NO DEFINIDO', '', 'COGOLLO', 'CORDON', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (108, '7837606', 'LEOPOLDO', '1', '039', '005', 'A', '39631RIL', '005', 'NO DEFINIDO', '', 'ROBAYO', 'ISAZA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (109, '7837774', 'GERARDO', '1', '066', '005', 'E', '39799ZVG', '005', 'NO DEFINIDO', '', 'ZARTA', 'VALDES', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (110, '17310850', 'JOSE', '1', '039', '005', 'E', '12875AIJI', '005', 'NO DEFINIDO', 'IGNACIO', 'ACOSTA', 'IBARRA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (111, '17445036', 'ANGEL', '1', '039', '002', 'E', '47061FAAB', '002', 'NO DEFINIDO', 'BENEDICTO', 'FORERO', 'ARIAS', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (132, '7838112', 'YASIN', '1', '030', '001', 'E', '40137RAYA', '001', 'AUXILIARES OPERATIVOS', 'ALEXON', 'RODRIGUEZ', 'ALVARADO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (133, '7838227', 'GERMAN', '1', '030', '002', 'E', '40252ACG', '002', 'AUXILIARES OPERATIVOS', '', 'ACOSTA', 'CAGUEÑO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (134, '8055469', 'YADER', '1', '030', '001', 'E', '57494PRYE', '001', 'AUXILIARES OPERATIVOS', 'ENRIQUE', 'PAZ', 'RAMIREZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (135, '8168423', 'ISIDRO', '1', '095', '017', 'A', '70448CTIA', '017', 'OPERATIVOS PRODUCCION AGRICOLA', 'ANTONIO', 'CHANTACA', 'TORREGLOSA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (136, '8169059', 'LORENZO', '1', '029', '002', 'E', '71084RBLM', '002', 'OPERATIVOS PRODUCCION AGRICOLA', 'MANUEL', 'RIVERA', 'BARRIOS', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (97, '1006822704', 'NATALIA', '1', '021', '005', 'E', '24729FBNI', '005', 'NO DEFINIDO', 'ISABEL', 'FLOREZ', 'BONILLA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (137, '9021844', 'EZEQUIEL', '1', '029', '001', 'E', '23869LBEA', '001', 'OPERATIVOS PRODUCCION AGRICOLA', 'ANTONIO', 'LASTRE', 'BOHORQUEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (479, '1122120601', 'KARIN', '1', '021', '001', 'E', '22626MGKA', '001', 'NO DEFINIDO', 'ALEXA', 'MORENO', 'GIRALDO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (98, '1123510211', 'LAURA', '1', '021', '005', 'E', '12236PULJ', '005', 'NO DEFINIDO', 'JIMENA', 'PARDO', 'URREGO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (480, '1120818192', 'MARYI', '1', '021', '001', 'E', '20217GSMA', '001', 'NO DEFINIDO', 'ALEJANDRA', 'GUARIN', 'SEGURA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (481, '1122142445', 'ANYI', '1', '021', '001', 'E', '44470RSAL', '001', 'NO DEFINIDO', 'LIZETH', 'RAMIREZ', 'SEGURA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (75, '1120368267', 'LEYDER', '1', '085', '005', 'E', '70292HBLX', '005', 'AUXILIARES', 'XIOMARA', 'HERNANDEZ', 'BORJA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (82, '1010241177', 'RICARDO', '1', '116', '005', 'E', '43202UORA', '005', 'ANALISTAS', 'ALFONSO', 'UNDA', 'ORTIZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (83, '1152463054', 'MANUELA', '1', '128', '999', 'E', '65079RRM', '999', 'COORDINADORES', '', 'RESTREPO', 'ROLDAN', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (84, '1120576198', 'ANGELA', '1', '021', '005', 'E', '78223UAY', '005', 'NO DEFINIDO', 'YORLENY', 'URRUTIA', '', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (85, '40329539', 'LORENA', '1', '129', '005', 'E', '31564OLL', '005', 'COORDINADORES', '', 'ORJUELA', 'LOPEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (86, '1122138443', 'JEFREY', '1', '017', '011', 'A', '40468ABJ', '011', 'ASISTENTES', '', 'ANDRADE', 'BOLIVAR', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (99, '1123510757', 'ANYI', '1', '021', '005', 'E', '12782GEAA', '005', 'NO DEFINIDO', 'ALEXANDRA', 'GONZALEZ', 'ESPINOSA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (100, '1007854227', 'ERIKA', '1', '096', '005', 'E', '56252PDEP', '005', 'NO DEFINIDO', 'PAOLA', 'PEREZ', 'DIAZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (101, '1121843124', 'NOHEMY', '1', '021', '005', 'E', '45149ACNP', '005', 'NO DEFINIDO', 'PAOLA', 'ABELLO', 'CABRERA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (102, '1127924851', 'ADRIANA', '1', '021', '005', 'E', '26876PSAM', '005', 'NO DEFINIDO', 'MICHELL', 'PULIDO', 'SANABRIA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (112, '43591285', 'LUZ', '1', '020', '005', 'P', '93310NCLD', '005', 'OPERATIVOS ADMINISTRATIVOS', 'DARY', 'NOREÑA', 'CARDENA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (113, '1120367141', 'YEISON', '1', '017', '005', 'E', '69166CPYF', '005', 'ASISTENTES', 'FERNANDO', 'CHARRY', 'POLANIA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (138, '10166719', 'JOSE', '1', '039', '005', 'A', '68744OAJO', '005', 'NO DEFINIDO', 'OLIVERIO', 'OBANDO', 'ARIAS', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (76, '1006777721', 'BRAYAN', '1', '021', '005', 'E', '79746SGBS', '005', 'NO DEFINIDO', 'STIVEN', 'SOLANO', 'GUEVARA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (87, '1000786430', 'ROSALBA', '1', '021', '005', 'E', '88455SPR', '005', 'NO DEFINIDO', '', 'SANCHEZ', 'PIÑEROS', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (482, '1006859178', 'DANIEL', '1', '029', '001', 'E', '61203OVDR', '001', 'OPERATIVOS PRODUCCION AGRICOLA', 'RICARDO', 'ORTIZ', 'VALERO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (483, '96357774', 'WILMER', '1', '029', '008', 'A', '59799ABW', '008', 'OPERATIVOS PRODUCCION AGRICOLA', '', 'ANTURI', 'BUSTOS', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (485, '1122145747', 'CRISTIAN', '1', '029', '008', 'A', '47772SACI', '008', 'OPERATIVOS PRODUCCION AGRICOLA', 'IGNACIO', 'SILVA', 'ALDANA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (486, '7838219', 'ROBER', '1', '073', '009', 'A', '40244IGRA', '009', 'OPERATIVOS PRODUCCION AGRICOLA', 'ALEXANDER', 'IBAÑEZ', 'GALINDO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (487, '1121820534', 'CRISTIAN', '1', '073', '009', 'P', '22559CFCJ', '009', 'OPERATIVOS PRODUCCION AGRICOLA', 'JULIAN', 'CABALLERO', 'FEO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (489, '1120580430', 'MAIRA', '1', '033', '002', 'E', '82455CVMC', '002', 'OPERATIVOS PRODUCCION AGRICOLA', 'CAMILA', 'CORREDOR', 'VARGAS', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (669, '7837957', 'NELSON', '1', '104', '001', 'X', '39982LMN', '001', 'OPERATIVOS PRODUCCION AGRICOLA', '', 'LOZANO', 'MURILLO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (671, '17420170', 'KIRK', '1', '104', '001', 'E', '22195GHKA', '001', 'OPERATIVOS PRODUCCION AGRICOLA', 'ALAIN', 'GOMEZ', 'HERNANDEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (672, '1084735140', 'ELICIO', '1', '104', '001', 'E', '37165VCEJ', '001', 'OPERATIVOS PRODUCCION AGRICOLA', 'JAVIER', 'VALDES', 'CABARCAS', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (673, '19619269', 'WILDER', '1', '104', '001', 'E', '21294RCWE', '001', 'OPERATIVOS PRODUCCION AGRICOLA', 'ENRIQUE', 'RODRIGUEZ', 'CASTRO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (3, '17338885', 'FABIO', '1', '007', '010', 'A', '40910RCFA', '010', 'JEFES', 'ANGEL', 'RODRIGUEZ', 'CASTRO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (73, '1000972341', 'LEIDY', '1', '021', '000', 'E', '74366AMLE', '000', 'NO DEFINIDO', 'ESTEFANIA', 'APONTE', 'MONTAÑEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (74, '1120368267', 'LEIDER', '1', '021', '000', 'E', '70292HBLX', '000', 'NO DEFINIDO', 'XIOMARA', 'HERNANDEZ', 'BORJA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (490, '1120374274', 'ALDAIR', '1', '029', '008', 'A', '76299ASA', '008', 'OPERATIVOS PRODUCCION AGRICOLA', '', 'ARISMENDI', 'SANCHEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (203, '40448420', 'SANDRA', '1', '073', '000', 'E', '50445RS', '000', 'OPERATIVOS PRODUCCION AGRICOLA', '', 'RAMIREZ', '', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (175, '1118197638', 'JUAN', '1', '031', '001', 'E', '99663GRJ', '001', 'OPERATIVOS PLANTA EXT', '', 'GUERRERO', 'RINCON', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (198, '1148699510', 'GIANCARLO', '1', '073', '000', 'X', '101535QMG', '000', 'OPERATIVOS PRODUCCION AGRICOLA', '', 'QUINTANA', 'MASERI', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (207, '1109419077', 'BIBIA', '1', '073', '002', 'E', '21102HRBA', '002', 'OPERATIVOS PRODUCCION AGRICOLA', 'ALEJANDRA', 'HERRERA', 'RAMIREZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (178, '1121863174', 'SERGIO', '1', '054', '003', 'E', '65199MPS', '003', 'OPERATIVOS MANTENIMIENTO', '', 'MARTINEZ', 'PINEDA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (199, '16848037', 'HERMES', '1', '030', '002', 'E', '50062DPH', '002', 'AUXILIARES OPERATIVOS', '', 'DIAZ', 'PALOMINO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (183, '1122121409', 'LINA', '1', '027', '000', 'E', '23434VHLM', '000', 'ASISTENTES', 'MARCELA', 'VARON', 'HERRERA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (184, '1122121972', 'RAUL', '1', '034', '000', 'X', '23997RSRR', '000', 'NO DEFINIDO', 'RICARDO', 'REYES', 'SANCHEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (176, '1121816510', 'ROGER', '1', '074', '002', 'E', '18535ULRD', '002', 'NO DEFINIDO', 'DE JESUS', 'URREA', 'LOPEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (187, '1122651224', 'NESTOR', '1', '035', '000', 'E', '53249BGNR', '000', 'NO DEFINIDO', 'RODRIGO', 'BRAVO', 'GARZON', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (188, '1123114517', 'ELKIN', '1', '034', '000', 'E', '16542RMEY', '000', 'NO DEFINIDO', 'YECID', 'ROJAS', 'MORENO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (192, '1122121568', 'JUAN', '1', '060', '000', 'E', '23593TPJC', '000', 'NO DEFINIDO', 'CARLOS', 'TRIANA', 'PEREZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (180, '1121883724', 'JULIO', '1', '030', '001', 'A', '85749MJJC', '001', 'AUXILIARES OPERATIVOS', 'CESAR', 'MORENO', 'JIMENEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (193, '1003672947', 'JUAN', '1', '061', '000', 'E', '74972RAJD', '000', 'NO DEFINIDO', 'DIEGO', 'ROMERO', 'AYALA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (674, '14107104', 'JOSE', '1', '104', '001', 'E', '9129GYJM', '001', 'OPERATIVOS PRODUCCION AGRICOLA', 'MANUEL', 'GONGORA', 'YAIMA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (491, '1061777821', 'BRANDON', '1', '073', '002', 'E', '79846VTBA', '002', 'OPERATIVOS PRODUCCION AGRICOLA', 'ALEXIS', 'VIVAS', 'TOMBE', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (492, '1015477571', 'KAREN', '1', '141', '002', 'A', '79596BHKD', '002', 'ANALISTAS', 'DANIELA', 'BERNAL', 'HENDES', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (675, '1122133143', 'WILLIAM', '1', '104', '001', 'E', '35168GLWD', '001', 'OPERATIVOS PRODUCCION AGRICOLA', 'DE JESUS', 'GUARDO', 'LAZARO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (153, '17422976', 'MAURICIO', '1', '089', '001', 'A', '25001GCM', '001', 'SUPERVISORES', '', 'GOMEZ', 'CRUZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (154, '20705111', 'ANGELA', '1', '035', '000', 'E', '7136OAA', '000', 'NO DEFINIDO', '', 'OLARTE', 'ALVAREZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (200, '17422634', 'OSCAR', '1', '033', '000', 'E', '24659VVOE', '000', 'OPERATIVOS PRODUCCION AGRICOLA', 'EDUARDO', 'VARON', 'VARGAS', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (205, '98686765', 'HUMBERTO', '1', '029', '001', 'A', '88790GPHA', '001', 'OPERATIVOS PRODUCCION AGRICOLA', 'ANTONIO', 'GOMEZ', 'PAEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (157, '52532534', 'YANEA', '1', '034', '000', 'E', '34559LBYM', '000', 'NO DEFINIDO', 'MILENA', 'LOPEZ', 'BAQUERO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (158, '74751300', 'JAVIER', '1', '031', '001', 'E', '53325MAJ', '001', 'OPERATIVOS PLANTA EXT', '', 'MORENO', 'ARIAS', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (201, '86069473', 'HECTOR', '1', '068', '001', 'A', '71498RGHG', '001', 'DIRECTORES', 'GEOVANY', 'ROMERO', 'GAVIRIA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (208, '1121912746', 'JUAN', '1', '034', '000', 'E', '14771RCJM', '000', 'NO DEFINIDO', 'MANUEL', 'RIVAS', 'CRUZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (161, '80659063', 'LUIS', '1', '072', '002', 'E', '61088PPLC', '002', 'SUPERVISORES', 'CARLOS', 'PAREDES', 'PIZZA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (162, '83087127', 'JOSE', '1', '089', '001', 'E', '89152CPJ', '001', 'SUPERVISORES', '', 'CORTES', 'PERDOMO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (202, '1121945825', 'ROSEMBER', '1', '021', '000', 'E', '47850CDRA', '000', 'NO DEFINIDO', 'ANDRES', 'CARRILLO', 'DIAZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (165, '94355644', 'DAVID', '1', '034', '000', 'E', '57669QGDJ', '000', 'NO DEFINIDO', 'JAMES', 'QUINTERO', 'GARCIA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (166, '96362641', 'JHON', '1', '030', '001', 'E', '64666CTJF', '001', 'AUXILIARES OPERATIVOS', 'FREDY', 'CANTILLO', 'TENORIO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (168, '98428420', 'CARLOS', '1', '030', '000', 'E', '30445MMCA', '000', 'AUXILIARES OPERATIVOS', 'ALBERTO', 'MURILLO', 'MALAMBA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (169, '98687791', 'LUIS', '1', '034', '000', 'E', '89816MJLM', '000', 'NO DEFINIDO', 'MANUEL', 'MEDRANO', 'JIMENEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (206, '1122651224', 'NESTOR', '1', '094', '002', 'E', '53249BGNR', '002', 'NO DEFINIDO', 'RODRIGO', 'BRAVO', 'GARZON', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (209, '86075326', 'JOSE', '1', '033', '002', 'E', '77351GDJM', '002', 'OPERATIVOS PRODUCCION AGRICOLA', 'MANUEL', 'GONZALEZ', 'DUARTE', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (172, '1024494690', 'WILLIAM', '1', '041', '000', 'E', '96715CTWG', '000', 'NO DEFINIDO', 'GUSTAVO', 'CHAGUALA', 'TABARES', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (156, '40360388', 'MARIA', '1', '033', '002', 'E', '62413ZMI', '002', 'OPERATIVOS PRODUCCION AGRICOLA', 'ISAURA', 'ZULUAGA', '', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (159, '74846079', 'ARISTOBULO', '1', '072', '008', 'A', '48104BMA', '008', 'SUPERVISORES', '', 'BELTRAN', 'MORA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (163, '93065010', 'WENCESLADO', '1', '029', '002', 'E', '67035ECW', '002', 'OPERATIVOS PRODUCCION AGRICOLA', '', 'ESPINOSA', 'CALDERON', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (173, '1087121903', 'ANDERSON', '1', '030', '002', 'E', '23928CPA', '002', 'AUXILIARES OPERATIVOS', '', 'CASTILLO', 'PRECIADO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (167, '97610739', 'JHON', '1', '022', '000', 'E', '12764OPJJ', '000', 'NO DEFINIDO', 'JAIRO', 'OROZCO', 'PAEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (170, '1006838624', 'LINA', '1', '034', '000', 'E', '40649GJLP', '000', 'NO DEFINIDO', 'PAOLA', 'GUTIERREZ', 'JARA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (174, '1102119595', 'CARLOS', '1', '036', '000', 'E', '21620RCCM', '000', 'NO DEFINIDO', 'MARIO', 'RICARDO', 'CALDERA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (177, '1121862676', 'ALEX', '1', '041', '000', 'E', '64701MVAA', '000', 'NO DEFINIDO', 'ANYEL', 'MARTINEZ', 'VALENCIA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (181, '1121932668', 'ANYELA', '1', '021', '000', 'E', '34693TLAM', '000', 'NO DEFINIDO', 'MARCELA', 'TORO', 'LOPEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (185, '1122122892', 'EDWIN', '1', '030', '001', 'A', '24917SAEC', '001', 'AUXILIARES OPERATIVOS', 'CAMILO', 'SALGADO', 'ARANGO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (190, '1123115430', 'HECTOR', '1', '033', '008', 'A', '17455MBHA', '008', 'OPERATIVOS PRODUCCION AGRICOLA', 'ANDRES', 'MEDINA', 'BONILLA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (186, '1122138452', 'KAREN', '1', '026', '002', 'X', '40477BMKJ', '002', 'NO DEFINIDO', 'JOHANA', 'BARRERA', 'MORALES', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (194, '4060864', 'ALVARO', '1', '062', '000', 'E', '62889ECA', '000', 'NO DEFINIDO', '', 'ELIZALDE', 'CORREA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (191, '1123512702', 'YANIDSAT', '1', '073', '002', 'E', '14727FGY', '002', 'OPERATIVOS PRODUCCION AGRICOLA', '', 'FINO', 'GARCIA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (676, '85270689', 'BLADIMIRO', '1', '104', '001', 'E', '72714RTB', '001', 'OPERATIVOS PRODUCCION AGRICOLA', '', 'RANGEL', 'TINOCO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (160, '78320907', 'FREDY', '1', '029', '001', 'E', '22932AHFA', '001', 'OPERATIVOS PRODUCCION AGRICOLA', 'ANTONIO', 'AVILEZ', 'HOYOS', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (164, '93121602', 'RUBEN', '1', '031', '001', 'A', '23627RARD', '001', 'OPERATIVOS PLANTA EXT', 'DARIO', 'RAMIREZ', 'AVILES', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (171, '1018406701', 'LEIDY', '1', '073', '000', 'X', '8726MPL', '000', 'OPERATIVOS PRODUCCION AGRICOLA', '', 'MALDONADO', 'PABON', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (182, '1121932734', 'RUBEN', '1', '021', '000', 'E', '34759RRRC', '000', 'NO DEFINIDO', 'CAMILO', 'RAMIREZ', 'RUIZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (493, '1006721519', 'DABIAN', '1', '137', '004', 'A', '23544APDA', '004', 'ANALISTAS', 'ALEXANDER', 'ARENAS', 'PARRA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (494, '1029983878', 'ANGELICA', '1', '021', '002', 'E', '85903MMAY', '002', 'NO DEFINIDO', 'YULIANA', 'MORENO', 'MACIAS', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (495, '1122120601', 'KARIN', '1', '073', '009', 'A', '22626MGKA', '009', 'OPERATIVOS PRODUCCION AGRICOLA', 'ALEXA', 'MORENO', 'GIRALDO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (195, '1019103601', 'YORDIN', '1', '061', '000', 'E', '5626CAYA', '000', 'NO DEFINIDO', 'ALONSO', 'CAMACHO', 'DELGADO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (196, '1037479936', 'YIMIS', '1', '051', '000', 'E', '81961QMY', '000', 'NO DEFINIDO', '', 'QUINTANA', 'MORELO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (197, '1123530038', 'CARLOS', '1', '034', '000', 'E', '32063BMCA', '000', 'NO DEFINIDO', 'ANDRES', 'BUSTOS', 'MARIN', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (143, '17267125', 'JULIO', '1', '031', '001', 'E', '69150LDJC', '001', 'OPERATIVOS PLANTA EXT', 'CESAR', 'LOZANO', 'DIAZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (152, '17422412', 'PASTOR', '1', '091', '001', 'E', '24437MDPL', '001', 'COORDINADORES', 'LEONARDO', 'MENDEZ', 'DUARTE', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (255, '17421545', 'MISAEL', '1', '031', '001', 'E', '23570MMM', '001', 'OPERATIVOS PLANTA EXT', '', 'MORA', 'MONTENEGRO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (256, '97610739', 'JHON', '1', '031', '003', 'E', '12764OPJJ', '003', 'OPERATIVOS PLANTA EXT', 'JAIRO', 'OROZCO', 'PAEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (257, '17496516', 'LUIS', '1', '029', '001', 'E', '98541RPLA', '001', 'OPERATIVOS PRODUCCION AGRICOLA', 'ALBERTO', 'ROBLES', 'PEREZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (223, '86072558', 'JOSE', '1', '024', '001', 'E', '74583ORJA', '001', 'CONDUCTORES', 'ANTONIO', 'ORBEGOZO', 'RUIZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (224, '1121826418', 'DIANA', '1', '073', '002', 'E', '28443RADF', '002', 'OPERATIVOS PRODUCCION AGRICOLA', 'FAISULY', 'RINCON', 'ARDILA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (225, '41225846', 'GLORIA', '1', '033', '002', 'E', '27871GSGN', '002', 'OPERATIVOS PRODUCCION AGRICOLA', 'NANCY', 'GARZON', 'SANCHEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (226, '97447171', 'JORGE', '1', '074', '002', 'X', '49196RLJA', '002', 'NO DEFINIDO', 'AVELINO', 'RODRIGUEZ', 'LOZADA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (227, '93438893', 'WILSON', '1', '033', '002', 'E', '40918EBWO', '002', 'OPERATIVOS PRODUCCION AGRICOLA', 'ORLANDO', 'ECHEVERRY', 'BEDOYA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (228, '1124831384', 'JULIO', '1', '029', '002', 'E', '33409CVJA', '002', 'OPERATIVOS PRODUCCION AGRICOLA', 'ALEJANDRO', 'CASTAÑO', 'VALLES', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (229, '1070917974', 'FREDY', '1', '029', '002', 'E', '19999BPFS', '002', 'OPERATIVOS PRODUCCION AGRICOLA', 'SMIT', 'BAEZ', 'PERALTA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (230, '1122139054', 'DUMAR', '1', '029', '002', 'E', '41079UBDS', '002', 'OPERATIVOS PRODUCCION AGRICOLA', 'SEBASTIAN', 'UMBARILA', 'BENAVIDES', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (231, '1122136422', 'DUVERNEY', '1', '033', '002', 'E', '38447GSD', '002', 'OPERATIVOS PRODUCCION AGRICOLA', '', 'GARAVITO', 'SARAY', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (232, '17416669', 'HUMBERTO', '1', '031', '001', 'X', '18694SGH', '001', 'OPERATIVOS PLANTA EXT', '', 'SANABRIA', 'GARCIA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (233, '1123115866', 'CRISTIAN', '1', '029', '001', 'E', '17891AMCD', '001', 'OPERATIVOS PRODUCCION AGRICOLA', 'DAVID', 'ALVAREZ', 'MORA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (234, '1122237940', 'FILLER', '1', '029', '001', 'E', '39965GGFA', '001', 'OPERATIVOS PRODUCCION AGRICOLA', 'ALEXIS', 'GARZON', 'GARZON', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (235, '17421364', 'JOSE', '1', '031', '003', 'E', '23389PFJW', '003', 'OPERATIVOS PLANTA EXT', 'WILLIAM', 'POBLADOR', 'FORERO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (236, '94355644', 'DAVID', '1', '033', '002', 'E', '57669QGDJ', '002', 'OPERATIVOS PRODUCCION AGRICOLA', 'JAMES', 'QUINTERO', 'GARCIA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (237, '1123115615', 'OSCAR', '1', '090', '001', 'A', '17640DROI', '001', 'NO DEFINIDO', 'IVAN', 'DUQUE', 'RIAÑO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (238, '7838052', 'RAMIRO', '1', '029', '002', 'E', '40077ADR', '002', 'OPERATIVOS PRODUCCION AGRICOLA', '', 'AVILA', 'DUEÑAS', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (239, '1121938411', 'CLAUDIA', '1', '021', '004', 'E', '40436SCCM', '004', 'NO DEFINIDO', 'MARCELA', 'SIERRA', 'CUERVO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (240, '1121909815', 'CRISTIAN', '1', '021', '001', 'E', '11840GPCG', '001', 'NO DEFINIDO', 'GILDARDO', 'GUTIERREZ', 'PARDO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (241, '1121929068', 'DIEGO', '1', '021', '001', 'E', '31093GRDA', '001', 'NO DEFINIDO', 'ANDRES', 'GOMEZ', 'ROJAS', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (243, '1124190487', 'EDNA', '1', '033', '002', 'E', '92512SCER', '002', 'OPERATIVOS PRODUCCION AGRICOLA', 'ROCIO', 'SANDOVAL', 'CALLEJAS', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (244, '1122132323', 'ANGELA', '1', '029', '002', 'E', '34348OGAP', '002', 'OPERATIVOS PRODUCCION AGRICOLA', 'PATRICIA', 'OCHOA', 'GOMEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (245, '1124218139', 'WILMER', '1', '033', '002', 'E', '20164RRW', '002', 'OPERATIVOS PRODUCCION AGRICOLA', '', 'ROZO', 'RUIZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (246, '91363426', 'DORYAM', '1', '029', '002', 'E', '65451VQDW', '002', 'OPERATIVOS PRODUCCION AGRICOLA', 'WILFREDO', 'VARGAS', 'QUIROGA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (247, '17390081', 'WILLIAM', '1', '029', '002', 'E', '92106HCWF', '002', 'OPERATIVOS PRODUCCION AGRICOLA', 'FRANCISCO', 'HUERTAS', 'CORTES', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (248, '1123512255', 'CARLOS', '1', '029', '001', 'X', '14280LBCG', '001', 'OPERATIVOS PRODUCCION AGRICOLA', 'GREGORIO', 'LLANOS', 'BOLAÑOS', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (249, '1122135991', 'ASTRID', '1', '073', '002', 'E', '38016RLAC', '002', 'OPERATIVOS PRODUCCION AGRICOLA', 'CAROLINA', 'ROA', 'LEON', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (250, '1121923711', 'LUZ', '1', '021', '002', 'E', '25736GSLI', '002', 'NO DEFINIDO', 'IDALIA', 'GOMEZ', 'SOTELO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (251, '1121921499', 'MIGUEL', '1', '040', '003', 'E', '23524DBMA', '003', 'NO DEFINIDO', 'ANGEL', 'DIAZ', 'BELTRAN', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (252, '1123533740', 'CLAUDIA', '1', '021', '002', 'E', '35765VQCP', '002', 'NO DEFINIDO', 'PATRICIA', 'VALENCIA', 'QUIÑONES', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (253, '31021722', 'YULY', '1', '033', '002', 'E', '23747LJYA', '002', 'OPERATIVOS PRODUCCION AGRICOLA', 'ANDREA', 'LEAL', 'JIMENEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (254, '1123114517', 'ELKIN', '1', '033', '002', 'E', '16542RMEY', '002', 'OPERATIVOS PRODUCCION AGRICOLA', 'YECID', 'ROJAS', 'MORENO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (258, '12198472', 'HECTOR', '1', '029', '001', 'E', '100497CUHH', '001', 'OPERATIVOS PRODUCCION AGRICOLA', 'HERNANDO', 'CALDERON', 'URRIAGO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (259, '17420986', 'ARTURO', '1', '031', '003', 'E', '23011LA', '003', 'OPERATIVOS PLANTA EXT', '', 'LONDOÑO', '', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (260, '1123514383', 'CRISTIAN', '1', '029', '002', 'E', '16408MSCJ', '002', 'OPERATIVOS PRODUCCION AGRICOLA', 'JAVIER', 'MARIN', 'SAAVEDRA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (261, '1119890843', 'INGRITH', '1', '033', '002', 'E', '92868LCIG', '002', 'OPERATIVOS PRODUCCION AGRICOLA', 'GINNETH', 'LOPEZ', 'CONTRERAS', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (262, '1123115561', 'ADRIANA', '1', '030', '008', 'A', '17586MMAM', '008', 'AUXILIARES OPERATIVOS', 'MILENA', 'MENDOZA', 'MURCIA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (263, '1151942114', 'CHRISTIAN', '1', '029', '002', 'E', '44139MACA', '002', 'OPERATIVOS PRODUCCION AGRICOLA', 'ALVEIRO', 'MEJIA', 'ARCE', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (264, '1120503811', 'SORLEY', '1', '073', '002', 'E', '5836COSN', '002', 'OPERATIVOS PRODUCCION AGRICOLA', 'NATHALIA', 'CLEVES', 'OVIEDO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (265, '1107093188', 'DIXIE', '1', '021', '001', 'E', '95213AMDK', '001', 'NO DEFINIDO', 'KATHERINE', 'AZA', 'MORALES', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (266, '1121935892', 'MAROLINN', '1', '021', '001', 'E', '37917LHMD', '001', 'NO DEFINIDO', 'DAYANN', 'LOZA', 'HERRERA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (267, '1124826689', 'KELLY', '1', '097', '002', 'E', '28714GGKY', '002', 'NO DEFINIDO', 'YOJANA', 'GONZALEZ', 'GONZALEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (268, '1123114786', 'JUAN', '1', '095', '002', 'E', '16811PHJC', '002', 'OPERATIVOS PRODUCCION AGRICOLA', 'CAMILO', 'PARRA', 'HERRERA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (269, '80324097', 'VICTOR', '1', '029', '002', 'A', '26122BTVM', '002', 'OPERATIVOS PRODUCCION AGRICOLA', 'MANUEL', 'BALLEN', 'TRIANA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (270, '93297612', 'JOSÉ', '1', '095', '002', 'E', '99637LGJF', '002', 'OPERATIVOS PRODUCCION AGRICOLA', 'FILADELFIO', 'LIZCANO', 'GALEANO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (271, '86002691', 'JAIRO', '1', '095', '002', 'E', '4716MCJ', '002', 'OPERATIVOS PRODUCCION AGRICOLA', '', 'MOLINA', 'CONDE', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (496, '1116266182', 'JHONATAN', '1', '073', '009', 'A', '68207BMJ', '009', 'OPERATIVOS PRODUCCION AGRICOLA', '', 'BEDOYA', 'MANRIQUE', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (677, '1121208322', 'DUMAR', '1', '104', '000', 'E', '10347CDDF', '000', 'OPERATIVOS PRODUCCION AGRICOLA', 'FABIAN', 'CARRILLO', 'DURAN', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (215, '86056213', 'JOSE', '1', '033', '008', 'A', '58238VIJS', '008', 'OPERATIVOS PRODUCCION AGRICOLA', 'SAID', 'VARGAS', 'IPUS', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (216, '1113036196', 'ELMIN', '1', '033', '002', 'E', '38221CPEF', '002', 'OPERATIVOS PRODUCCION AGRICOLA', 'FAVITH', 'CANO', 'PALACIOS', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (217, '30389287', 'YASMIN', '1', '073', '002', 'E', '91312RHY', '002', 'OPERATIVOS PRODUCCION AGRICOLA', '', 'RIOS', 'HOYOS', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (218, '1120371909', 'JHON', '1', '021', '001', 'E', '73934MRJA', '001', 'NO DEFINIDO', 'ALEXIS', 'MONTAÑA', 'RODRIGUEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (219, '1119891079', 'DORA', '1', '021', '004', 'E', '93104MLDC', '004', 'NO DEFINIDO', 'CECILIA', 'MARTINEZ', 'LERMA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (220, '7838043', 'YEISON', '1', '033', '002', 'E', '40068RAYA', '002', 'OPERATIVOS PRODUCCION AGRICOLA', 'ALEXANDER', 'RODRIGUEZ', 'ALVARADO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (221, '17265720', 'EDILSON', '1', '033', '002', 'E', '67745VLE', '002', 'OPERATIVOS PRODUCCION AGRICOLA', '', 'VALLEJO', 'LOZANO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (222, '1039694937', 'JUAN', '1', '021', '001', 'E', '96962BMJC', '001', 'NO DEFINIDO', 'CAMILO', 'BARRAGAN', 'MOLA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (213, '1120871785', 'IVAN', '1', '021', '002', 'E', '73810CRIA', '002', 'NO DEFINIDO', 'ANDRES', 'CANO', 'RIOS', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (214, '1024570083', 'DEIBY', '1', '021', '002', 'E', '72108MTDP', '002', 'NO DEFINIDO', 'PAOLA', 'MOSQUERA', 'TAPIAS', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (317, '11524306', 'CARLOS', '1', '029', '000', 'E', '26331ESCF', '000', 'OPERATIVOS PRODUCCION AGRICOLA', 'FERNANDO', 'ESPEJO', 'SIERRA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (318, '80414210', 'JESUS', '1', '031', '003', 'E', '16235PLJA', '003', 'OPERATIVOS PLANTA EXT', 'ALBERTO', 'PEREZ', 'LOPEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (319, '1122138020', 'EMILIO', '1', '029', '001', 'E', '40045GCEA', '001', 'OPERATIVOS PRODUCCION AGRICOLA', 'ANDRES', 'GUEVARA', 'CABANZO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (285, '17423246', 'JUAN', '1', '102', '002', 'E', '25271RMJC', '002', 'NO DEFINIDO', 'CARLOS', 'ROJAS', 'MURILLO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (286, '1122142624', 'BRAYAN', '1', '029', '001', 'E', '44649BABF', '001', 'OPERATIVOS PRODUCCION AGRICOLA', 'FERNANDO', 'BOLAÑOS', 'ARANGO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (287, '1121915924', 'ARTURO', '1', '095', '001', 'E', '17949RMAD', '001', 'OPERATIVOS PRODUCCION AGRICOLA', 'DAVID', 'RIVERA', 'MORA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (288, '1123116395', 'YEISON', '1', '029', '002', 'E', '18420ARYF', '002', 'OPERATIVOS PRODUCCION AGRICOLA', 'FERNANDO', 'ACOSTA', 'RIAÑO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (289, '1123116044', 'EDWAR', '1', '031', '003', 'E', '18069RREE', '003', 'OPERATIVOS PLANTA EXT', 'ESNEYDER', 'RESTREPO', 'RAMOS', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (290, '1122655444', 'FABIAN', '1', '021', '002', 'E', '57469FGFS', '002', 'NO DEFINIDO', 'STEVEN', 'FAJARDO', 'GUTIERREZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (291, '17420445', 'LUIS', '1', '029', '002', 'E', '22470ALA', '002', 'OPERATIVOS PRODUCCION AGRICOLA', 'ALEXANDER', 'ARIZA', '', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (292, '1120356827', 'ESNEYDER', '1', '029', '002', 'E', '58852BDE', '002', 'OPERATIVOS PRODUCCION AGRICOLA', '', 'BERMUDEZ', 'DUQUE', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (293, '10474099', 'JEFFERSON', '1', '030', '002', 'E', '76124DCJ', '002', 'AUXILIARES OPERATIVOS', '', 'DIAZ', 'CHARRUPI', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (294, '1120374612', 'ROSENBER', '1', '021', '001', 'E', '76637BCRW', '001', 'NO DEFINIDO', 'WILSON', 'BERNAL', 'CANDIL', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (295, '1102229799', 'JADER', '1', '029', '002', 'E', '31824VSJA', '002', 'OPERATIVOS PRODUCCION AGRICOLA', 'ANTONIO', 'VILLEGAS', 'SOTO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (296, '17420372', 'JOSÉ', '1', '066', '003', 'E', '22397GPJN', '003', 'NO DEFINIDO', 'NELSON', 'GONZALEZ', 'PULIDO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (297, '1062305766', 'CRISTIAN', '1', '029', '002', 'E', '7791QICE', '002', 'OPERATIVOS PRODUCCION AGRICOLA', 'EDWIN', 'QUINTANA', 'IPA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (298, '1121902026', 'MARIA', '1', '096', '002', 'E', '4051RCMA', '002', 'NO DEFINIDO', 'ALEJANDRA', 'RESTREPO', 'CHAVEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (299, '1122139454', 'JOSÉ', '1', '031', '003', 'E', '41479MBJD', '003', 'OPERATIVOS PLANTA EXT', 'DUVAN', 'MONTEALEGRE', 'BERMUDEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (300, '1119949699', 'ZULEIDY', '1', '033', '002', 'E', '51724HOZ', '002', 'OPERATIVOS PRODUCCION AGRICOLA', '', 'HERNANDEZ', 'OLAYA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (301, '1123086926', 'ELIZABETH', '1', '021', '002', 'E', '88951CCE', '002', 'NO DEFINIDO', '', 'CACERES', 'CUMACO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (302, '1122124398', 'CATERINE', '1', '021', '002', 'E', '26423CCC', '002', 'NO DEFINIDO', '', 'CACERES', 'CUMACO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (304, '86050603', 'ALEJANDRO', '1', '033', '002', 'E', '52628AMA', '002', 'OPERATIVOS PRODUCCION AGRICOLA', '', 'AVELLANEDA', 'MEDINA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (305, '86072558', 'JOSE', '1', '024', '003', 'E', '74583ORJA', '003', 'CONDUCTORES', 'ANTONIO', 'ORBEGOZO', 'RUIZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (306, '1120498699', 'MIRYAM', '1', '073', '002', 'E', '100724CTML', '002', 'OPERATIVOS PRODUCCION AGRICOLA', 'LUCENA', 'CESPEDES', 'TORRES', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (307, '1122118103', 'NUBIA', '1', '033', '002', 'E', '20128RGN', '002', 'OPERATIVOS PRODUCCION AGRICOLA', '', 'RODRÍGUEZ', 'GARZON', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (308, '1123114911', 'HADER', '1', '095', '002', 'E', '16936VMH', '002', 'OPERATIVOS PRODUCCION AGRICOLA', '', 'VARON', 'MORA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (309, '1123114418', 'YESSIKA', '1', '073', '002', 'E', '16443CCY', '002', 'OPERATIVOS PRODUCCION AGRICOLA', '', 'CALLEJAS', 'CUMBE', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (310, '1069725971', 'JHON', '1', '109', '003', 'E', '27996OHJM', '003', 'NO DEFINIDO', 'MIRLEN', 'OLIVEROS', 'HERNANDEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (311, '1123115004', 'MARIA', '1', '073', '002', 'E', '17029MGMA', '002', 'OPERATIVOS PRODUCCION AGRICOLA', 'ALEJANDRA', 'MORA', 'GUTIERREZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (312, '4438730', 'HENRY', '1', '054', '003', 'E', '40755PSH', '003', 'OPERATIVOS MANTENIMIENTO', '', 'PEREZ', 'SALINAS', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (313, '1122145488', 'LUISA', '1', '021', '001', 'E', '47513GCLC', '001', 'NO DEFINIDO', 'CAMILA', 'GUEVARA', 'CABANZO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (314, '35263682', 'CLAUDIA', '1', '021', '002', 'E', '65707TRCP', '002', 'NO DEFINIDO', 'PATRICIA', 'TELLO', 'RAMIREZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (315, '1121917443', 'NILSON', '1', '096', '002', 'E', '19468LRNA', '002', 'NO DEFINIDO', 'ALEXANDER', 'LOPEZ', 'RODRIGUEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (316, '1122655444', 'FABIAN', '1', '033', '002', 'E', '57469FGFS', '002', 'OPERATIVOS PRODUCCION AGRICOLA', 'STEVEN', 'FAJARDO', 'GUTIERREZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (320, '1122140130', 'EVA', '1', '021', '002', 'E', '42155RGEY', '002', 'NO DEFINIDO', 'YAJAIRA', 'RUIZ', 'GUIZA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (321, '1120874977', 'LEIDY', '1', '073', '002', 'E', '77002RGLD', '002', 'OPERATIVOS PRODUCCION AGRICOLA', 'DANIELA', 'RODRIGUEZ', 'GIRALDO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (322, '1122139711', 'ZOILA', '1', '021', '001', 'E', '41736MMZR', '001', 'NO DEFINIDO', 'ROSA', 'MOTTA', 'MOLINA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (323, '1001198357', 'NANCY', '1', '021', '002', 'E', '100382RONK', '002', 'NO DEFINIDO', 'KATHERINE', 'RODRIGUEZ', 'OSPINA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (324, '52485298', 'NIDIA', '1', '021', '002', 'E', '87323CONP', '002', 'NO DEFINIDO', 'PATRICIA', 'CHISCO', 'ORTIZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (325, '1116438699', 'EDGAR', '1', '029', '000', 'E', '40724LDER', '000', 'OPERATIVOS PRODUCCION AGRICOLA', 'RODOLFO', 'LIBERATO', 'DELGADO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (326, '1006776716', 'YEISON', '1', '029', '002', 'E', '78741PMYA', '002', 'OPERATIVOS PRODUCCION AGRICOLA', 'ANDRES', 'PICO', 'MORENO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (327, '66852732', 'YASMIN', '1', '033', '002', 'E', '54757RRYE', '002', 'OPERATIVOS PRODUCCION AGRICOLA', 'EISER', 'REYES', 'RODRIGUEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (328, '1123115865', 'HEYVER', '1', '033', '002', 'E', '17890AMHD', '002', 'OPERATIVOS PRODUCCION AGRICOLA', 'DUVAN', 'ALVAREZ', 'MORA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (329, '12400882', 'JHON', '1', '032', '002', 'E', '2907CPJJ', '002', 'NO DEFINIDO', 'JAIRO', 'CUADRO', 'PAYARES', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (330, '1121888552', 'JHON', '1', '054', '003', 'E', '90577OPJW', '003', 'OPERATIVOS MANTENIMIENTO', 'WILMAR', 'ORDOÑEZ', 'PEÑA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (331, '49669258', 'LUZ MERY', '1', '021', '001', 'E', '71283PL', '001', 'NO DEFINIDO', '', 'PLATA', '', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (333, '40430705', 'ALEX', '1', '021', '000', 'E', '32730RCA', '000', 'NO DEFINIDO', '', 'ROMERO', 'CHAUX', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (334, '1006697633', 'JIMENA', '1', '073', '002', 'E', '99658TJK', '002', 'OPERATIVOS PRODUCCION AGRICOLA', 'KATHERINE', 'TINOCO', '', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (335, '40433886', 'MERLY', '1', '073', '009', 'A', '35911GAMJ', '009', 'OPERATIVOS PRODUCCION AGRICOLA', 'JOHANA', 'GOMEZ', 'ALVAREZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (678, '1005130452', 'FERLEY', '1', '104', '000', 'E', '32477CDFE', '000', 'OPERATIVOS PRODUCCION AGRICOLA', 'ESTEBAN', 'CARRILLO', 'DURAN', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (274, '86052721', 'MAURICIO', '1', '095', '002', 'E', '54746CVM', '002', 'OPERATIVOS PRODUCCION AGRICOLA', '', 'CANO', 'VALDERRAMA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (276, '13520681', 'EDWAR', '1', '090', '001', 'A', '22706RPEA', '001', 'NO DEFINIDO', 'ARTURO', 'ROJAS', 'PRADA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (277, '1122131357', 'MANUEL', '1', '029', '001', 'E', '33382RQMA', '001', 'OPERATIVOS PRODUCCION AGRICOLA', 'ALEJANDRO', 'REYES', 'QUINTERO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (278, '1119949699', 'ZULAIDY', '1', '021', '002', 'E', '51724HOZ', '002', 'NO DEFINIDO', '', 'HERNANDEZ', 'OLAYA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (279, '1006658545', 'LUDY', '1', '021', '002', 'E', '60570CDLJ', '002', 'NO DEFINIDO', 'JASBLEIDY', 'CIFUENTES', 'DAZA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (280, '1122130915', 'EDISSON', '1', '029', '001', 'E', '32940SEA', '001', 'OPERATIVOS PRODUCCION AGRICOLA', 'ANDRES', 'SANDOBAL', '', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (281, '1123533740', 'CLAUDIA', '1', '099', '002', 'E', '35765VQCP', '002', 'NO DEFINIDO', 'PATRICIA', 'VALENCIA', 'QUIÑONEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (282, '1119888423', 'EUCARYS', '1', '099', '001', 'E', '90448CJE', '001', 'NO DEFINIDO', '', 'CALDAS', 'JIMENEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (283, '1123114785', 'JULIAN', '1', '095', '002', 'E', '16810PHJD', '002', 'OPERATIVOS PRODUCCION AGRICOLA', 'DAVID', 'PARRA', 'HERRERA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (284, '1123115674', 'WILMER', '1', '033', '002', 'E', '17699LCWF', '002', 'OPERATIVOS PRODUCCION AGRICOLA', 'FAVIAN', 'LEON', 'CASTRILLON', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (275, '11323245', 'JOSE', '1', '029', '001', 'E', '25270GRJN', '001', 'OPERATIVOS PRODUCCION AGRICOLA', 'NABOR', 'GUZMAN', 'RAMIREZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (382, '1120874706', 'JEISSON', '1', '096', '002', 'E', '76731SHJS', '002', 'NO DEFINIDO', 'STEVEN', 'SALAMANCA', 'HERRERA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (383, '1120579404', 'LEIDY', '1', '131', '002', 'E', '81429ZBLM', '002', 'NO DEFINIDO', 'MABEL', 'ZARTA', 'BARRETO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (385, '1121934098', 'WINNY', '1', '021', '002', 'E', '36123GOWY', '002', 'NO DEFINIDO', 'YANILA', 'GUEVARA', 'ORTIZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (386, '1122127033', 'CINDI', '1', '033', '008', 'A', '29058GCCL', '008', 'OPERATIVOS PRODUCCION AGRICOLA', 'LORENA', 'GUEVARA', 'CALDERON', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (348, '1122126767', 'ALEXANDER', '1', '054', '000', 'E', '28792MBA', '000', 'OPERATIVOS MANTENIMIENTO', '', 'MONTOYA', 'BUITRAGO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (349, '35286120', 'ANA', '1', '021', '000', 'E', '88145GLAR', '000', 'NO DEFINIDO', 'ROSALBA', 'GUASCA', 'LOPEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (350, '1123436709', 'DARWIN', '1', '100', '000', 'E', '38734PRDL', '000', 'ASISTENTES', 'LEONEL', 'PARRA', 'RUBIO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (351, '1121847329', 'OLGA', '1', '021', '000', 'E', '49354MRON', '000', 'NO DEFINIDO', 'NATALIA', 'MONSALVE', 'ROJAS', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (352, '1120387689', 'MICHELL', '1', '021', '000', 'E', '89714GAM', '000', 'NO DEFINIDO', '', 'GOMEZ', 'ALVAREZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (353, '1010241177', 'RICARDO', '1', '021', '000', 'E', '43202UORA', '000', 'NO DEFINIDO', 'ALFONSO', 'UNDA', 'ORTIZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (354, '1123087178', 'ZULLY', '1', '021', '001', 'E', '89203BRZP', '001', 'NO DEFINIDO', 'PATRICIA', 'BALDION', 'ROJAS', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (356, '1122125826', 'JIRALY', '1', '021', '002', 'E', '27851HNJY', '002', 'NO DEFINIDO', 'YURLEY', 'HERNANDEZ', 'NOVOA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (357, '40433187', 'LUZ', '1', '021', '002', 'E', '35212OTLM', '002', 'NO DEFINIDO', 'MARY', 'OROZCO', 'TORRES', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (358, '1122130397', 'JENNIFER', '1', '033', '002', 'E', '32422BMJE', '002', 'OPERATIVOS PRODUCCION AGRICOLA', 'ELIANA', 'BERNAL', 'MAHECHA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (359, '65801502', 'SANDRA', '1', '073', '002', 'E', '3527SVSM', '002', 'OPERATIVOS PRODUCCION AGRICOLA', 'MILENA', 'SAAVEDRA', 'VERGARA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (360, '1006720150', 'KAREN', '1', '021', '001', 'E', '22175RNKY', '001', 'NO DEFINIDO', 'YARITZA', 'RIVEROS', 'NIETO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (361, '1120579404', 'LEIDY', '1', '096', '002', 'E', '81429ZBLM', '002', 'NO DEFINIDO', 'MABEL', 'ZARTA', 'BARRETO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (362, '1121860660', 'CRISTIAN', '1', '030', '002', 'E', '62685SRCC', '002', 'AUXILIARES OPERATIVOS', 'CAMILO', 'SANCHEZ', 'ROZO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (363, '1122144720', 'DERLI', '1', '021', '001', 'E', '46745GRDY', '001', 'NO DEFINIDO', 'YURANI', 'GARCIA', 'RODRIGUEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (364, '1121951849', 'LEIDY', '1', '021', '002', 'E', '53874PRLV', '002', 'NO DEFINIDO', 'VIVIANA', 'PARRADO', 'ROMERO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (365, '1121949321', 'MARIA', '1', '021', '002', 'E', '51346OFMC', '002', 'NO DEFINIDO', 'CAMILA', 'OTELO', 'FRANCO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (366, '1123114806', 'LUZ', '1', '073', '002', 'E', '16831CSLM', '002', 'OPERATIVOS PRODUCCION AGRICOLA', 'MARY', 'CRISTANCHO', 'SAENZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (367, '1111194516', 'YULI', '1', '073', '009', 'E', '96541CFYP', '009', 'OPERATIVOS PRODUCCION AGRICOLA', 'PAOLA', 'CAMACHO', 'FLOREZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (368, '1123115152', 'PAOLA', '1', '021', '002', 'E', '17177APPA', '002', 'NO DEFINIDO', 'ANDREA', 'ACOSTA', 'PICON', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (369, '1122127448', 'MARYORI', '1', '030', '009', 'A', '29473ASMJ', '009', 'AUXILIARES OPERATIVOS', 'JOHANA', 'ARIAS', 'SANCHEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (370, '1123114218', 'PAOLA', '1', '073', '009', 'A', '16243GLPA', '009', 'OPERATIVOS PRODUCCION AGRICOLA', 'ANDREA', 'GONZALEZ', 'LOPEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (371, '1000616234', 'MARIA', '1', '141', '002', 'A', '18259HBMF', '002', 'ANALISTAS', 'FERNANDA', 'HURTADO', 'BOHORQUEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (372, '20768035', 'CLARA', '1', '030', '017', 'A', '70060GPCY', '017', 'AUXILIARES OPERATIVOS', 'YINETH', 'GAVIRIA', 'PERALTA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (373, '1112781358', 'HUBERNEY', '1', '123', '007', 'A', '83383CPH', '007', 'SUPERVISORES', '', 'CANAVAL', 'POSSO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (374, '1124818470', 'DIDIER', '1', '029', '000', 'E', '20495YMD', '000', 'OPERATIVOS PRODUCCION AGRICOLA', '', 'YEPES', 'MONTENEGRO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (375, '1005776562', 'KONY', '1', '021', '001', 'E', '78587MGKN', '001', 'NO DEFINIDO', 'NATALIA', 'MUÑOZ', 'GARCIA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (376, '1122124446', 'JENNY', '1', '073', '002', 'E', '26471ASJY', '002', 'OPERATIVOS PRODUCCION AGRICOLA', 'YAMILE', 'ARIAS', 'SANCHEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (377, '39950724', 'ANA', '1', '033', '002', 'E', '52749PGAM', '002', 'OPERATIVOS PRODUCCION AGRICOLA', 'MILENA', 'PALACIOS', 'GUTIERREZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (378, '1123116569', 'YILMER', '1', '029', '002', 'E', '18594RCYL', '002', 'OPERATIVOS PRODUCCION AGRICOLA', 'LORENZO', 'RICO', 'CERVANTES', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (379, '1121920173', 'CRISTIAN', '1', '029', '002', 'X', '22198JBCC', '002', 'OPERATIVOS PRODUCCION AGRICOLA', 'CAMILO', 'JIMENEZ', 'BENITO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (380, '1006658935', 'NIDIA', '1', '021', '001', 'E', '60960RRNJ', '001', 'NO DEFINIDO', 'JOHANA', 'REYES', 'RODRIGUEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (381, '86013949', 'FAVER', '1', '090', '001', 'A', '15974HAF', '001', 'NO DEFINIDO', '', 'HERNANDEZ', 'ARREDONDO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (387, '1121875256', 'SOFIA', '1', '027', '001', 'A', '77281CPSP', '001', 'ASISTENTES', 'PAOLA', 'CUBILLOS', 'PATIÑO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (388, '1006774821', 'LIZZETH', '1', '040', '002', 'E', '76846DMLD', '002', 'NO DEFINIDO', 'DANIELA', 'DIAZ', 'MARTINEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (389, '1002623157', 'YESICA', '1', '073', '009', 'A', '25182EUYS', '009', 'OPERATIVOS PRODUCCION AGRICOLA', 'SIRLEY', 'ESPEJO', 'USECHE', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (390, '1006774821', 'LIZZETH', '1', '021', '002', 'E', '76846DMLD', '002', 'NO DEFINIDO', 'DANIELA', 'DIAZ', 'MARTINEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (391, '1122140679', 'YAZMIN', '1', '021', '002', 'E', '42704SPYL', '002', 'NO DEFINIDO', 'LORENA', 'SILVA', 'PEÑA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (392, '1006779558', 'JONATHAN', '1', '033', '002', 'E', '81583DAJE', '002', 'OPERATIVOS PRODUCCION AGRICOLA', 'ENRIQUE', 'DIAZ', 'ALVAREZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (393, '1007221883', 'ISABEL', '1', '128', '004', 'X', '23908RRI', '004', 'COORDINADORES', '', 'RAMIREZ', 'RIOS', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (394, '1006782614', 'ANA', '1', '033', '008', 'A', '84639SMAF', '008', 'OPERATIVOS PRODUCCION AGRICOLA', 'FELIZA', 'SALGADO', 'MARTINEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (395, '35262056', 'ANGELICA', '1', '033', '008', 'A', '64081AAM', '008', 'OPERATIVOS PRODUCCION AGRICOLA', 'MARIA', 'ANZOLA', '', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (396, '1121939838', 'YULY', '1', '131', '002', 'E', '41863VGYA', '002', 'NO DEFINIDO', 'ANDREA', 'VACA', 'GUTIERREZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (397, '1115916468', 'WILMAR', '1', '033', '008', 'A', '18493GAWR', '008', 'OPERATIVOS PRODUCCION AGRICOLA', 'RICARDO', 'GARCIA', 'ACOSTA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (398, '1122131043', 'GLORIA', '1', '021', '002', 'E', '33068RGGC', '002', 'NO DEFINIDO', 'CECILIA', 'RODRIGUEZ', 'GOMEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (399, '9770300', 'EIMER', '1', '030', '001', 'A', '72325OTEY', '001', 'AUXILIARES OPERATIVOS', 'YITZHAK', 'ORTEGA', 'TORRES', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (400, '1121879560', 'DELIO', '1', '030', '001', 'E', '81585LCDF', '001', 'AUXILIARES OPERATIVOS', 'FERNANDO', 'LLANOS', 'CRUZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (401, '1084738901', 'YOSCAR', '1', '029', '002', 'E', '40926CPYM', '002', 'OPERATIVOS PRODUCCION AGRICOLA', 'MANUEL', 'CABALLERO', 'PEREZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (497, '1006838744', 'DEISY', '1', '073', '009', 'A', '40769MGDA', '009', 'OPERATIVOS PRODUCCION AGRICOLA', 'ALEXANDRA', 'MELO', 'GONZALEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (679, '74852977', 'WILSON', '1', '104', '000', 'E', '55002CCWJ', '000', 'OPERATIVOS PRODUCCION AGRICOLA', 'JAIR', 'COMAYAN', 'CETINA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (340, '1122129358', 'JENNY', '1', '021', '000', 'E', '31383MRJK', '000', 'NO DEFINIDO', 'KATERIN', 'MARTINEZ', 'RESTREPO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (342, '1000616234', 'MARIA', '1', '021', '000', 'E', '18259HBMF', '000', 'NO DEFINIDO', 'FERNANDA', 'HURTADO', 'BOHORQUEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (343, '52373396', 'DORA', '1', '021', '000', 'E', '75421BHDI', '000', 'NO DEFINIDO', 'INES', 'BOHORQUEZ', 'HERRERA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (344, '20768035', 'CLARA', '1', '021', '000', 'E', '70060GPCY', '000', 'NO DEFINIDO', 'YINETH', 'GAVIRIA', 'PERALTA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (345, '40432324', 'MARIA', '1', '073', '000', 'E', '34349RGMC', '000', 'OPERATIVOS PRODUCCION AGRICOLA', 'CRISTINA', 'RUIZ', 'GUIZA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (346, '1121888387', 'NEYDI', '1', '021', '000', 'E', '90412SDNV', '000', 'NO DEFINIDO', 'VANEZA', 'SANCHEZ', 'DIAZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (347, '1122130280', 'JENNY', '1', '021', '000', 'E', '32305LAJP', '000', 'NO DEFINIDO', 'PATRICIA', 'LEMUS', 'ARDILA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (338, '1122142057', 'LEIDY', '1', '021', '000', 'E', '44082BRLE', '000', 'NO DEFINIDO', 'EMILSEN', 'BALDION', 'ROJAS', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (339, '1122145462', 'ANGHELA', '1', '021', '000', 'E', '47487MHAJ', '000', 'NO DEFINIDO', 'JULIETH', 'MONTOYA', 'HERNANDEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (449, '1122651477', 'HENRY', '1', '138', '001', 'E', '53502MCHD', '001', 'NO DEFINIDO', 'DAVID', 'MESA', 'CHAPARRO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (450, '40432001', 'CLAUDIA', '1', '029', '001', 'A', '34026CCR', '001', 'OPERATIVOS PRODUCCION AGRICOLA', 'ROCIO', 'CABRERA', '', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (451, '1095843267', 'MARIA', '1', '105', '001', 'A', '45292CCMF', '001', 'COORDINADORES', 'FERNANDA', 'CHINCHILLA', 'CASTELLANOS', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (452, '40775117', 'ROCIO', '1', '073', '009', 'V', '77142CRR', '009', 'OPERATIVOS PRODUCCION AGRICOLA', '', 'CONTRERAS', 'RAMIREZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (419, '1123114051', 'ARGENIDA', '1', '073', '002', 'E', '16076VDA', '002', 'OPERATIVOS PRODUCCION AGRICOLA', '', 'VARGAS', 'DEVIA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (420, '52805686', 'ROSA', '1', '085', '001', 'A', '7711BERM', '001', 'AUXILIARES', 'MARIA', 'BENAVIDES', 'ESPINOSA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (421, '1120472141', 'EIDY', '1', '073', '002', 'E', '74166GOEV', '002', 'OPERATIVOS PRODUCCION AGRICOLA', 'VANESA', 'GRACIA', 'ORTIZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (422, '1010087203', 'JULIAN', '1', '029', '002', 'E', '89228ZPJA', '002', 'OPERATIVOS PRODUCCION AGRICOLA', 'ANDRES', 'ZAPATA', 'PARRA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (423, '1121942062', 'INGRID', '1', '073', '002', 'E', '44087SGIJ', '002', 'OPERATIVOS PRODUCCION AGRICOLA', 'JINETH', 'SANTAFE', 'GALVIS', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (424, '1007703963', 'LAURA', '1', '073', '002', 'E', '5988RCLN', '002', 'OPERATIVOS PRODUCCION AGRICOLA', 'NATALIA', 'RAMIREZ', 'CORDOBA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (425, '1084743593', 'JAVIER', '1', '073', '002', 'E', '45618LUJA', '002', 'OPERATIVOS PRODUCCION AGRICOLA', 'ALFONSO', 'LEAL', 'URINA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (426, '1121951537', 'ANYI', '1', '027', '001', 'E', '53562PAAL', '001', 'ASISTENTES', 'LUZCENIT', 'PRADA', 'AREVALO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (427, '1123114406', 'ARACELY', '1', '073', '002', 'E', '16431OAA', '002', 'OPERATIVOS PRODUCCION AGRICOLA', '', 'ORTIZ', 'ALVARAN', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (428, '1006779056', 'LEIDY', '1', '073', '002', 'E', '81081OGLM', '002', 'OPERATIVOS PRODUCCION AGRICOLA', 'MARCELA', 'OBANDO', 'GIRALDO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (429, '1123116494', 'JAIDI', '1', '073', '002', 'E', '18519PAJT', '002', 'OPERATIVOS PRODUCCION AGRICOLA', 'TATIANA', 'PARRADO', 'ALVARAN', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (430, '1121825154', 'MARIA', '1', '073', '009', 'A', '27179BAMC', '009', 'OPERATIVOS PRODUCCION AGRICOLA', 'CAMILA', 'BERMUDEZ', 'ALZA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (431, '1056769191', 'LEIDY', '1', '073', '002', 'E', '71216GGLN', '002', 'OPERATIVOS PRODUCCION AGRICOLA', 'NATALIA', 'GARCIA', 'GIRALDO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (432, '1006409147', 'PEDRO', '1', '029', '002', 'E', '11172MAPJ', '002', 'OPERATIVOS PRODUCCION AGRICOLA', 'JOSE', 'MURILLO', 'AGUILAR', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (433, '1070603190', 'JONATHAN', '1', '096', '002', 'E', '5215PRJH', '002', 'NO DEFINIDO', 'HARVEY', 'POVEDA', 'RICO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (434, '1007650748', 'LUIS', '1', '029', '002', 'E', '52773VQLA', '002', 'OPERATIVOS PRODUCCION AGRICOLA', 'ANGEL', 'VARGAS', 'QUEVEDO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (435, '1113633734', 'JUAN', '1', '131', '002', 'E', '35759POJA', '002', 'NO DEFINIDO', 'ALBERTO', 'PULGARIN', 'ORTIZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (436, '52446937', 'ZURLAY', '1', '040', '001', 'E', '48962VDZJ', '001', 'NO DEFINIDO', 'JHASBLEYDY', 'VIGOYA', 'DIAZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (437, '1006777187', 'MARIA', '1', '040', '002', 'E', '79212RFMA', '002', 'NO DEFINIDO', 'ANGELA', 'ROBLES', 'FAJARDO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (438, '1023918053', 'MABEL', '1', '040', '002', 'E', '20078SCMA', '002', 'NO DEFINIDO', 'ANDREA', 'SALAZAR', 'CUELLAR', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (440, '52446937', 'ZURLAY', '1', '021', '001', 'E', '48962VDZJ', '001', 'NO DEFINIDO', 'JHASBLEYDY', 'VIGOYA', 'DIAZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (441, '1006777187', 'MARIA', '1', '021', '001', 'E', '79212RFMA', '001', 'NO DEFINIDO', 'ANGELA', 'ROBLES', 'FAJARDO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (442, '1023918053', 'MABEL', '1', '021', '001', 'E', '20078SCMA', '001', 'NO DEFINIDO', 'ANDREA', 'SALAZAR', 'CUELLAR', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (443, '1006729446', 'NAYIVE', '1', '033', '001', 'E', '31471HVN', '001', 'OPERATIVOS PRODUCCION AGRICOLA', '', 'HERNANDEZ', 'VARELA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (444, '1007613918', 'ANDRES', '1', '030', '001', 'A', '15943MMAF', '001', 'AUXILIARES OPERATIVOS', 'FELIPE', 'MELO', 'MEJIA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (445, '1006779061', 'VALENTINA', '1', '073', '009', 'A', '81086CGV', '009', 'OPERATIVOS PRODUCCION AGRICOLA', '', 'CESPEDES', 'GOMEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (446, '1116266182', 'JHONATAN', '1', '073', '002', 'E', '68207BMJ', '002', 'OPERATIVOS PRODUCCION AGRICOLA', '', 'BEDOYA', 'MANRIQUE', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (447, '1096238017', 'SULEIMA', '1', '073', '001', 'E', '40042APSA', '001', 'OPERATIVOS PRODUCCION AGRICOLA', 'ANDREA', 'AMADO', 'PARDO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (448, '1122236712', 'WILMER', '1', '029', '002', 'E', '38737GGWA', '002', 'OPERATIVOS PRODUCCION AGRICOLA', 'ALEXANDER', 'GOMEZ', 'GARZON', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (453, '52966773', 'NILSA', '1', '073', '009', 'A', '68798CYN', '009', 'OPERATIVOS PRODUCCION AGRICOLA', '', 'CAPERA', 'YATE', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (454, '1122139276', 'JHON', '1', '029', '002', 'E', '41301HPJJ', '002', 'OPERATIVOS PRODUCCION AGRICOLA', 'JAIRO', 'HERNANDEZ', 'PINEDA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (455, '1122144833', 'MAYERLI', '1', '073', '002', 'E', '46858VCM', '002', 'OPERATIVOS PRODUCCION AGRICOLA', '', 'VARGAS', 'CADENA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (456, '1022349358', 'JHON', '1', '073', '009', 'A', '51383JVJE', '009', 'OPERATIVOS PRODUCCION AGRICOLA', 'EDINSSON', 'JIMENEZ', 'VALERO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (457, '1122649092', 'MARIA', '1', '073', '002', 'E', '51117MMMI', '002', 'OPERATIVOS PRODUCCION AGRICOLA', 'ISABEL', 'MENDOZA', 'MALAGON', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (458, '1122116265', 'MARIA', '1', '073', '002', 'E', '18290ABMA', '002', 'OPERATIVOS PRODUCCION AGRICOLA', 'ANGELICA', 'ANDRADE', 'BOLIVAR', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (459, '1122117454', 'HENRY', '1', '095', '002', 'E', '19479AJH', '002', 'OPERATIVOS PRODUCCION AGRICOLA', '', 'ACOSTA', 'JIMENEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (460, '1000969908', 'SEBASTIAN', '1', '029', '002', 'E', '71933CES', '002', 'OPERATIVOS PRODUCCION AGRICOLA', '', 'CASTAÑEDA', 'ESGUERRA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (461, '1067715524', 'FELIX', '1', '029', '001', 'E', '17549PBFD', '001', 'OPERATIVOS PRODUCCION AGRICOLA', 'DAVID', 'PIÑERES', 'BORRE', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (463, '1122120798', 'JUAN', '1', '073', '002', 'E', '22823MCJC', '002', 'OPERATIVOS PRODUCCION AGRICOLA', 'CAMILO', 'MARTINEZ', 'CARO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (464, '86078810', 'JEFFERSON', '1', '029', '008', 'A', '80835GGJ', '008', 'OPERATIVOS PRODUCCION AGRICOLA', '', 'GUTIERREZ', 'GAMEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (680, '17414398', 'NELSON', '1', '104', '000', 'X', '16423TLNJ', '000', 'OPERATIVOS PRODUCCION AGRICOLA', 'JAVIER', 'TUNJANO', 'LARA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (681, '17415101', 'EDILBERTO', '1', '104', '000', 'E', '17126YEE', '000', 'OPERATIVOS PRODUCCION AGRICOLA', '', 'YGUINA', 'ESCOBAR', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (409, '1122120878', 'ALEXANDRA', '1', '073', '002', 'E', '22903OGA', '002', 'OPERATIVOS PRODUCCION AGRICOLA', '', 'OBANDO', 'GIRALDO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (410, '1116202263', 'EUSER', '1', '029', '002', 'A', '4288POEH', '002', 'OPERATIVOS PRODUCCION AGRICOLA', 'HUMBERTO', 'POVEDA', 'ORTIZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (411, '1122120195', 'MARIA', '1', '073', '002', 'E', '22220GRMN', '002', 'OPERATIVOS PRODUCCION AGRICOLA', 'NELLY', 'GARCIA', 'ROA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (412, '1010127903', 'ANDRES', '1', '033', '002', 'E', '29928BVAF', '002', 'OPERATIVOS PRODUCCION AGRICOLA', 'FELIPE', 'BAEZ', 'VARON', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (413, '1006779399', 'PAULA', '1', '033', '008', 'A', '81424CPPA', '008', 'OPERATIVOS PRODUCCION AGRICOLA', 'ANDREA', 'CASALLAS', 'PACHECO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (414, '1123116537', 'DANISSA', '1', '033', '008', 'A', '18562VPD', '008', 'OPERATIVOS PRODUCCION AGRICOLA', '', 'VIVEROS', 'PANAMEÑO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (415, '1006875133', 'SEBASTIAN', '1', '029', '008', 'A', '77158RRS', '008', 'OPERATIVOS PRODUCCION AGRICOLA', '', 'RAMIREZ', 'RUIZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (416, '1006838744', 'DEISY', '1', '073', '002', 'E', '40769MGDA', '002', 'OPERATIVOS PRODUCCION AGRICOLA', 'ALEXANDRA', 'MELO', 'GONZALEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (417, '1007780450', 'MANUEL', '1', '095', '017', 'A', '82475DPME', '017', 'OPERATIVOS PRODUCCION AGRICOLA', 'ESTEBAN', 'DIAZ', 'PEREIRA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (418, '16045285', 'WILDER', '1', '029', '002', 'E', '47310ZAW', '002', 'OPERATIVOS PRODUCCION AGRICOLA', '', 'ZAPATA', 'ARIAS', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (462, '1121937616', 'EDWIN', '1', '137', '001', 'E', '39641VCEA', '001', 'ANALISTAS', 'ADRIAN', 'VILLEGAS', 'CARDOZO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (404, '1193139838', 'JENNIFER', '1', '073', '002', 'E', '41863QJ', '002', 'OPERATIVOS PRODUCCION AGRICOLA', '', 'QUIROZ', '', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (408, '1123115528', 'ANGIE', '1', '073', '002', 'E', '17553JEAY', '002', 'OPERATIVOS PRODUCCION AGRICOLA', 'YULIETH', 'JAIME', 'ESPITIA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (683, '85260267', 'RUBEN', '1', '104', '000', 'E', '62292SVRD', '000', 'OPERATIVOS PRODUCCION AGRICOLA', 'DARIO', 'SALCEDO', 'VISBAL', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (704, '1065123031', 'ANTONIO', '1', '104', '001', 'A', '25056VCAR', '001', 'OPERATIVOS PRODUCCION AGRICOLA', 'RAFAEL', 'VALDES', 'CABARCAS', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (705, '1003369097', 'VLADIMIR', '1', '104', '001', 'A', '71122SPV', '001', 'OPERATIVOS PRODUCCION AGRICOLA', '', 'SUAREZ', 'PEÑA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (706, '1063274441', 'ALVARO', '1', '104', '001', 'E', '76466PPAJ', '001', 'OPERATIVOS PRODUCCION AGRICOLA', 'JOSE', 'PATERNINA', 'PEREZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (722, '31031928', 'EDY', '1', '104', '001', 'E', '33953CSEY', '001', 'OPERATIVOS PRODUCCION AGRICOLA', 'YANIRA', 'CRISTANCHO', 'SAENZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (684, '5653664', 'CRISANTO', '1', '104', '001', 'A', '55689GBC', '001', 'OPERATIVOS PRODUCCION AGRICOLA', '', 'GOMEZ', 'BENAVIDES', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (685, '1084735140', 'ELICIO', '1', '104', '000', 'E', '37165VCEJ', '000', 'OPERATIVOS PRODUCCION AGRICOLA', 'JAVIER', 'VALDES', 'CABARCAS', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (686, '19617449', 'MANUEL', '1', '104', '000', 'E', '19474JMMS', '000', 'OPERATIVOS PRODUCCION AGRICOLA', 'SALVADOR', 'JULIO', 'MEZA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (687, '17422139', 'EDWIN', '1', '104', '000', 'E', '24164SGE', '000', 'OPERATIVOS PRODUCCION AGRICOLA', '', 'SANTANA', 'GAMBA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (688, '1006723719', 'STIVEN', '1', '104', '001', 'A', '25744GMSA', '001', 'OPERATIVOS PRODUCCION AGRICOLA', 'ANDRES', 'GOMEZ', 'MOYANO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (689, '1065123031', 'ANTONIO', '1', '104', '000', 'E', '25056VCAR', '000', 'OPERATIVOS PRODUCCION AGRICOLA', 'RAFAEL', 'VALDES', 'CABARCAS', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (690, '1122127274', 'CARLOS', '1', '104', '000', 'E', '29299GDCE', '000', 'OPERATIVOS PRODUCCION AGRICOLA', 'ENRIQUE', 'GONZALEZ', 'DIAZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (691, '19621206', 'JOSE', '1', '104', '001', 'E', '23231PJJL', '001', 'OPERATIVOS PRODUCCION AGRICOLA', 'LUIS', 'POLO', 'JURADO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (692, '10499152', 'JHON', '1', '104', '001', 'A', '101177BCJJ', '001', 'OPERATIVOS PRODUCCION AGRICOLA', 'JAIMER', 'BALANTA', 'CIFUENTES', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (693, '1081795404', 'JUAN', '1', '104', '001', 'E', '97429PIJP', '001', 'OPERATIVOS PRODUCCION AGRICOLA', 'PABLO', 'PAEZ', 'IBAÑEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (694, '72262612', 'MIGUEL', '1', '104', '001', 'A', '64637MBM', '001', 'OPERATIVOS PRODUCCION AGRICOLA', '', 'MIRANDA', 'BERMUDEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (695, '1123510481', 'EDWAR', '1', '104', '001', 'E', '12506PNE', '001', 'OPERATIVOS PRODUCCION AGRICOLA', '', 'PINTO', 'NOVA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (696, '86081442', 'RICARDO', '1', '104', '001', 'E', '83467DDR', '001', 'OPERATIVOS PRODUCCION AGRICOLA', '', 'DIAZ', 'DEVIA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (698, '5136057', 'JAIRO', '1', '104', '001', 'E', '38082CPJA', '001', 'OPERATIVOS PRODUCCION AGRICOLA', 'ALONSO', 'CIENFUEGO', 'PADILLA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (699, '1075539290', 'EMILIANO', '1', '104', '001', 'E', '41315RGE', '001', 'OPERATIVOS PRODUCCION AGRICOLA', '', 'RAMIREZ', 'GARZON', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (700, '19000809', 'JHON', '1', '104', '001', 'A', '2834GVJJ', '001', 'OPERATIVOS PRODUCCION AGRICOLA', 'JAIRO', 'GALEANO', 'VALDOMERO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (701, '1081827188', 'BLAS', '1', '104', '000', 'E', '29213PIBA', '000', 'OPERATIVOS PRODUCCION AGRICOLA', 'ANTONIO', 'PAEZ', 'IBAÑEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (702, '1004335328', 'MIGUEL', '1', '104', '001', 'A', '37353CVME', '001', 'OPERATIVOS PRODUCCION AGRICOLA', 'EDUARDO', 'CARO', 'VILLEGAS', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (703, '1108934349', 'ROQUE', '1', '104', '001', 'E', '36374BGRD', '001', 'OPERATIVOS PRODUCCION AGRICOLA', 'DUBAN', 'BOCANEGRA', 'GOMEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (668, '79890251', 'CARLOS', '1', '104', '001', 'E', '92276NRCO', '001', 'OPERATIVOS PRODUCCION AGRICOLA', 'ORLANDO', 'NIÑO', 'ROJAS', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (720, '1116866658', 'ESNEIDER', '1', '104', '001', 'E', '68683PBEF', '001', 'OPERATIVOS PRODUCCION AGRICOLA', 'FERNEY', 'PASTO', 'BERNAL', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (721, '1007399085', 'HEIKER', '1', '104', '001', 'E', '101110CBHD', '001', 'OPERATIVOS PRODUCCION AGRICOLA', 'DANIEL', 'CAMACHO', 'BOADA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (707, '1122125625', 'HECTOR', '1', '104', '001', 'E', '27650QLHR', '001', 'OPERATIVOS PRODUCCION AGRICOLA', 'RAUL', 'QUEVEDO', 'LEYVA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (708, '1002722082', 'HECTOR', '1', '104', '001', 'E', '24107RLHA', '001', 'OPERATIVOS PRODUCCION AGRICOLA', 'ARBEY', 'ROMERO', 'LEGUIZAMON', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (709, '76007201', 'NELSON', '1', '104', '001', 'E', '9226VVNH', '001', 'OPERATIVOS PRODUCCION AGRICOLA', 'HILARIO', 'VIA', 'VILLANUEVA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (711, '1128187143', 'LUIS', '1', '104', '001', 'E', '89168AZLD', '001', 'OPERATIVOS PRODUCCION AGRICOLA', 'DAVID', 'ALCAZAR', 'ZUÑIGA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (712, '1123114185', 'GERARDO', '1', '104', '001', 'E', '16210BOG', '001', 'OPERATIVOS PRODUCCION AGRICOLA', '', 'BENAVIDES', 'OJEDA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (713, '1069582221', 'HAROLD', '1', '030', '001', 'E', '84246PCHS', '001', 'AUXILIARES OPERATIVOS', 'STEVEN', 'PULIDO', 'CARRILLO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (714, '19563455', 'JORGE', '1', '104', '001', 'A', '65480CJA', '001', 'OPERATIVOS PRODUCCION AGRICOLA', 'ARMANDO', 'CANTILLO', '', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (715, '1084731299', 'JOVANI', '1', '104', '001', 'A', '33324PAJE', '001', 'OPERATIVOS PRODUCCION AGRICOLA', 'ENRIQUE', 'POLO', 'ARIAS', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (716, '1121920902', 'JUAN', '1', '104', '001', 'E', '22927RRJA', '001', 'OPERATIVOS PRODUCCION AGRICOLA', 'ANGEL', 'RODRIGUEZ', 'RIOJAS', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (729, '1123084858', 'RAFAEL', '1', '104', '001', 'A', '86883RORS', '001', 'OPERATIVOS PRODUCCION AGRICOLA', 'STIVEN', 'ROMERO', 'OBANDO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (730, '1049894190', 'YAELIS', '1', '104', '001', 'A', '96215CRY', '001', 'OPERATIVOS PRODUCCION AGRICOLA', '', 'CANTILLO', 'RAMOS', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (731, '1122130992', 'JENNIFER', '1', '104', '001', 'A', '33017LCJ', '001', 'OPERATIVOS PRODUCCION AGRICOLA', '', 'LOPEZ', 'CASTAÑEDA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (723, '1054549131', 'ALEJANDRO', '1', '104', '001', 'A', '51156NMA', '001', 'OPERATIVOS PRODUCCION AGRICOLA', '', 'NIÑO', 'MURC IA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (724, '1121908364', 'CRISTIAN', '1', '104', '001', 'X', '10389RGCL', '001', 'OPERATIVOS PRODUCCION AGRICOLA', 'LEONARDO', 'ROJAS', 'GARCIA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (725, '1081795404', 'JUAN', '1', '104', '001', 'A', '97429PIJP', '001', 'OPERATIVOS PRODUCCION AGRICOLA', 'PABLO', 'PAEZ', 'IBAÑEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (726, '86076533', 'CORNELIO', '1', '104', '001', 'A', '78558SGC', '001', 'OPERATIVOS PRODUCCION AGRICOLA', '', 'SILVA', 'GAITAN', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (727, '1081827188', 'BLAS', '1', '104', '001', 'A', '29213PIBA', '001', 'OPERATIVOS PRODUCCION AGRICOLA', 'ANTONIO', 'PAEZ', 'IBAÑEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (728, '1123510481', 'EDWAR', '1', '104', '001', 'A', '12506PNE', '001', 'OPERATIVOS PRODUCCION AGRICOLA', '', 'PINTO', 'NOVA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (717, '1080426065', 'ANDERSON', '1', '104', '001', 'E', '28090SGAA', '001', 'OPERATIVOS PRODUCCION AGRICOLA', 'ANDRES', 'SALCEDO', 'GUTIERREZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (670, '1128190929', 'JOSE', '1', '104', '001', 'E', '92954ABJM', '001', 'OPERATIVOS PRODUCCION AGRICOLA', 'MIGUEL', 'AHUMADA', 'BOLAÑO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (682, '1128200455', 'JUAN', '1', '104', '001', 'A', '2480MZJC', '001', 'OPERATIVOS PRODUCCION AGRICOLA', 'CARLOS', 'MATUTE', 'ZUÑIGA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (732, '1084728329', 'CARLOS', '1', '104', '001', 'A', '30354JHCA', '001', 'OPERATIVOS PRODUCCION AGRICOLA', 'ANDRES', 'JULIO', 'HERNANDEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (733, '1121935349', 'JAIR', '1', '104', '001', 'X', '37374BRJS', '001', 'OPERATIVOS PRODUCCION AGRICOLA', 'SEBASTIAN', 'BERMUDEZ', 'ROMERO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (734, '1010186065', 'GIOVANNY', '1', '104', '001', 'A', '88090PPGC', '001', 'OPERATIVOS PRODUCCION AGRICOLA', 'CAMILO', 'PADILLA', 'PEREIRA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (735, '1081789015', 'AUGUSTO', '1', '104', '001', 'A', '91040HFAJ', '001', 'OPERATIVOS PRODUCCION AGRICOLA', 'JOSE', 'HERNANDEZ', 'FONSECA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (736, '1006718229', 'ROBERT', '1', '104', '001', 'E', '20254MPRM', '001', 'OPERATIVOS PRODUCCION AGRICOLA', 'MAURICIO', 'MANCHAY', 'PARRA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (737, '7711031', 'JHON', '1', '104', '001', 'A', '13056ORJJ', '001', 'OPERATIVOS PRODUCCION AGRICOLA', 'JAIR', 'OVIEDO', 'RODRIGUEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (738, '1037478252', 'NEIS', '1', '104', '001', 'A', '80277CTND', '001', 'OPERATIVOS PRODUCCION AGRICOLA', 'DAVID', 'CABRERA', 'TAPIA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (142, '17265720', 'EDILSON', '1', '034', '000', 'E', '67745VLE', '000', 'NO DEFINIDO', '', 'VALLEJO', 'LOZANO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (467, '1123433048', 'JUAN', '1', '029', '001', 'E', '35073GGJS', '001', 'OPERATIVOS PRODUCCION AGRICOLA', 'SEBASTIAN', 'GALINDO', 'GONZALEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (468, '1006838737', 'ROSAISELA', '1', '073', '002', 'E', '40762MGR', '002', 'OPERATIVOS PRODUCCION AGRICOLA', '', 'MONGE', 'GALINDO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (741, '17288237', 'ABELARDO', '1', '104', '001', 'A', '90262CMA', '001', 'OPERATIVOS PRODUCCION AGRICOLA', '', 'CARRILLO', 'MEDINA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (742, '1004319912', 'IVAN', '1', '104', '001', 'A', '21937MDIA', '001', 'OPERATIVOS PRODUCCION AGRICOLA', 'ANDRES', 'MONTES', 'DE AGUA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (743, '80159846', 'BENJAMIN', '1', '104', '001', 'A', '61871RJB', '001', 'OPERATIVOS PRODUCCION AGRICOLA', '', 'RIOS', 'JIMENEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (745, '1123114978', 'JAIVER', '1', '104', '001', 'E', '17003RRJE', '001', 'OPERATIVOS PRODUCCION AGRICOLA', 'ESTIVEN', 'RAMIREZ', 'RUIZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (746, '1122117551', 'MADIAN', '1', '104', '001', 'A', '19576JAMB', '001', 'OPERATIVOS PRODUCCION AGRICOLA', 'BRISELIO', 'JIMENEZ', 'ALARCON', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (747, '1007399085', 'HEIKER', '1', '104', '001', 'A', '101110CBHD', '001', 'OPERATIVOS PRODUCCION AGRICOLA', 'DANIEL', 'CAMACHO', 'BOADA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (748, '1123115890', 'JOSE', '1', '104', '001', 'A', '17915ARJL', '001', 'OPERATIVOS PRODUCCION AGRICOLA', 'LUIS', 'ACOSTA', 'RODRIGUEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (749, '19615595', 'RAFAEL', '1', '104', '001', 'A', '17620MVRR', '001', 'OPERATIVOS PRODUCCION AGRICOLA', 'RAMON', 'MARTINEZ', 'VAN STRALEM', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (750, '1006826075', 'JONATHAN', '1', '104', '001', 'A', '28100DLJS', '001', 'OPERATIVOS PRODUCCION AGRICOLA', 'STIVEN', 'DUCUARA', 'LOPEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (751, '1003087759', 'CARLOS', '1', '104', '001', 'A', '89784SACM', '001', 'OPERATIVOS PRODUCCION AGRICOLA', 'MANUEL', 'SOLANO', 'AREVALO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (752, '1005573447', 'HECTOR', '1', '104', '001', 'A', '75472VDH', '001', 'OPERATIVOS PRODUCCION AGRICOLA', '', 'VERGARA', 'DIAZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (754, '74857088', 'NELSON', '1', '104', '001', 'X', '59113GBNF', '001', 'OPERATIVOS PRODUCCION AGRICOLA', 'FERNANDO', 'GOMEZ', 'BLANCO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (755, '1064981517', 'JANIEN', '1', '104', '001', 'A', '83542PAJF', '001', 'OPERATIVOS PRODUCCION AGRICOLA', 'FIDEL', 'PEREZ', 'ARCIRIA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (756, '1064983822', 'EMERSON', '1', '104', '001', 'A', '85847SMED', '001', 'OPERATIVOS PRODUCCION AGRICOLA', 'DAVID', 'SANCHEZ', 'MARTINEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (757, '19597191', 'ELEDIENER', '1', '104', '001', 'A', '99216PIEE', '001', 'OPERATIVOS PRODUCCION AGRICOLA', 'ENRIQUE', 'PAEZ', 'IBAÑEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (758, '1121849448', 'YOAN', '1', '104', '001', 'A', '51473PAYE', '001', 'OPERATIVOS PRODUCCION AGRICOLA', 'ESTEBAN', 'PATIÑO', 'ACOSTA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (759, '79951026', 'DIEGO', '2', '023', '007', 'A', '53051RSDM', '007', 'NO DEFINIDO', 'MANUEL', 'RIVEROS', 'SANTAMARIA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (760, '1121862171', 'CARLOS', '2', '009', '000', 'E', '64196BMCA', '000', 'NO DEFINIDO', 'ARTURO', 'BERNAL', 'MORALES', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (761, '17119106', 'MARCO', '2', '041', '000', 'E', '21131RBMF', '000', 'NO DEFINIDO', 'FIDEL', 'RIVEROS', 'BAQUERO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (762, '1122134068', 'EDWIN', '2', '021', '000', 'E', '36093COEF', '000', 'NO DEFINIDO', 'FERNANDO', 'CONDE', 'OROZCO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (763, '19194455', 'MANUEL', '2', '085', '000', 'E', '96480RBMJ', '000', 'AUXILIARES', 'JOSE', 'RIVEROS', 'BAQUERO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (764, '41342149', 'MARIA', '2', '085', '000', 'E', '44174RBMD', '000', 'AUXILIARES', 'DEL ROSARIO', 'RIVEROS', 'BAQUERO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (765, '51556311', 'MARIA', '2', '085', '000', 'E', '58336MTM', '000', 'AUXILIARES', '', 'MEDINA', 'TORRES', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (766, '1019056420', 'DIANA', '2', '081', '000', 'E', '58445LTDC', '000', 'COORDINADORES', 'CAROLINA', 'LOBATON', 'TORRES', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (767, '1049649229', 'HAROLD', '2', '131', '999', 'E', '51254EVHM', '999', 'NO DEFINIDO', 'MAURICIO', 'ESTEPA', 'VEGA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (768, '1070603190', 'JONATHAN', '2', '136', '007', 'A', '5215PRJH', '007', 'COORDINADORES', 'HARVEY', 'POVEDA', 'RICO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (769, '13520245', 'EDILBERTO', '2', '042', '000', 'E', '22270LGE', '000', 'NO DEFINIDO', '', 'LOPEZ', 'GUALDRON', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (770, '52900115', 'DIANA', '3', '002', '005', 'V', '2140RMDC', '005', 'NO DEFINIDO', 'CONSTANZA', 'RIVEROS', 'MEDINA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (771, '1121833535', 'MONICA', '3', '064', '000', 'X', '35560RCMA', '000', 'NO DEFINIDO', 'ANDREA', 'RAMIREZ', 'CASTEBLANCO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (772, '31031907', 'YOR', '3', '027', '000', 'E', '33932VPYM', '000', 'ASISTENTES', 'MARY', 'VARON', 'PARRA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (773, '1122121389', 'ERIKA', '3', '013', '012', 'P', '23414AAEJ', '012', 'AUXILIARES', 'JOHANNA', 'ALARCON', 'APOLINAR', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (774, '1122648898', 'JASMIN', '3', '014', '000', 'E', '50923PGJ', '000', 'ASISTENTES', '', 'PRADA', 'GUTIERREZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (775, '72208155', 'CRISTOBAL', '3', '110', '000', 'E', '10180RMCA', '000', 'NO DEFINIDO', 'ANTONIO', 'RODRIGUEZ', 'MONTAÑO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (776, '40334822', 'ALBA', '3', '114', '000', 'E', '36847UMAP', '000', 'ASISTENTES', 'PATRICIA', 'ULLOA', 'MARTINEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (777, '1123116041', 'LINA', '3', '100', '000', 'E', '18066SCLD', '000', 'ASISTENTES', 'DAYANNA', 'SARRIA', 'CAPERA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (778, '1125476642', 'INGRID', '3', '027', '005', 'P', '78667JUIT', '005', 'ASISTENTES', 'TATIANA', 'JARAMILLO', 'URIBE', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (779, '1125179605', 'ERLENDY', '3', '021', '012', 'A', '81630VPEB', '012', 'NO DEFINIDO', 'BELLANID', 'VALENCIA', 'POLANIA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (780, '17411199', 'EMILIO', '3', '069', '000', 'E', '13224MVE', '000', 'NO DEFINIDO', '', 'MARIN', 'VARGAS', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (781, '51742339', 'FLOR', '3', '020', '005', 'A', '44364RQFM', '005', 'OPERATIVOS ADMINISTRATIVOS', 'MARIA', 'RAVELO', 'QUINTERO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (782, '1006838624', 'LINA', '3', '143', '011', 'A', '40649GJLP', '011', 'NO DEFINIDO', 'PAOLA', 'GUTIERREZ', 'JARA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (783, '1122129057', 'DUVAR', '3', '031', '000', 'E', '31082AADA', '000', 'OPERATIVOS PLANTA EXT', 'ANDRES', 'ACOSTA', 'AGUIRRE', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (784, '1121880702', 'LUISA', '3', '119', '003', 'A', '82727TTLF', '003', 'ASISTENTES', 'FERNANDA', 'TELLO', 'TOVAR', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (786, '1121874595', 'RAUL', '3', '095', '000', 'E', '76620SZR', '000', 'OPERATIVOS PRODUCCION AGRICOLA', '', 'SAAVEDRA', 'ZARATE', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (787, '1122140130', 'EVA', '3', '014', '000', 'E', '42155RGEY', '000', 'ASISTENTES', 'YAJAIRA', 'RUIZ', 'GUIZA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (788, '4438730', 'HENRY', '3', '049', '000', 'E', '40755PSH', '000', 'OPERATIVOS MANTENIMIENTO', '', 'PEREZ', 'SALINAS', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (789, '1122144833', 'MAYERLI', '3', '021', '000', 'E', '46858VCM', '000', 'NO DEFINIDO', '', 'VARGAS', 'CADENA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (790, '1006723403', 'LUZ', '3', '021', '000', 'E', '25428OGLK', '000', 'NO DEFINIDO', 'KATHERIN', 'OSPINA', 'GARCIA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (791, '4438730', 'HENRRY', '3', '049', '999', 'E', '40755PSH', '999', 'OPERATIVOS MANTENIMIENTO', '', 'PEREZ', 'SALINAS', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (792, '6406181', 'JOSE', '3', '052', '015', 'A', '8206RFJM', '015', 'AUXILIARES OPERATIVOS', 'MARTIN', 'REYES', 'FERNANDEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (793, '7838219', 'ROBER', '3', '058', '000', 'E', '40244IGRA', '000', 'OPERATIVOS PLANTA EXT', 'ALEXANDER', 'IBAÑEZ', 'GALINDO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (794, '8167946', 'ALVARO', '3', '055', '000', 'E', '69971GMA', '000', 'OPERATIVOS PLANTA EXT', '', 'GARCIA', 'MARTINEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (795, '11685251', 'RAFAEL', '3', '021', '000', 'E', '87276RHR', '000', 'NO DEFINIDO', '', 'RODRIGUEZ', 'HENAO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (796, '16473572', 'BERNE', '3', '075', '000', 'E', '75597AVBE', '000', 'NO DEFINIDO', 'ENRIQUE', 'ARANGO', 'VIDAL', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (797, '17268552', 'JAVIER', '3', '031', '000', 'E', '70577BTJI', '000', 'OPERATIVOS PLANTA EXT', 'IGNACIO', 'BELTRAN', 'TRIANA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (798, '17414234', 'FERNANDO', '3', '054', '003', 'A', '16259CVF', '003', 'OPERATIVOS MANTENIMIENTO', '', 'CAÑON', 'VALERO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (799, '17419215', 'ALI', '3', '043', '016', 'A', '21240ALAY', '016', 'DIRECTORES', 'YOVAN', 'AZUERO', 'LOZANO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (800, '17420140', 'ALVARO', '3', '021', '000', 'X', '22165CVA', '000', 'NO DEFINIDO', '', 'CAÑON', 'VALERO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (739, '1128190601', 'JOSE', '1', '104', '001', 'A', '92626RAJL', '001', 'OPERATIVOS PRODUCCION AGRICOLA', 'LUIS', 'RODRIGUEZ', 'AHUMADA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (740, '1121836068', 'ERWIN', '1', '104', '001', 'E', '38093HREF', '001', 'OPERATIVOS PRODUCCION AGRICOLA', 'FERNANDO', 'HERRERA', 'ROJAS', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (657, '1122135032', 'YONER', '1', '104', '001', 'E', '37057PCYA', '001', 'OPERATIVOS PRODUCCION AGRICOLA', 'ALEXANDER', 'PIZA', 'CORDOBA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (658, '74348139', 'FRACISCO', '1', '104', '001', 'E', '50164CNF', '001', 'OPERATIVOS PRODUCCION AGRICOLA', '', 'CASTRO', 'NIÑO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (801, '38361600', 'ANGELA', '3', '043', '000', 'E', '63625SRAS', '000', 'DIRECTORES', 'SOFIA', 'SILVA', 'RAMIREZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (802, '66945678', 'MARCIA', '3', '058', '016', 'A', '47703PRM', '016', 'OPERATIVOS PLANTA EXT', '', 'PANAMEÑO', 'RAMOS', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (803, '74347807', 'CARLOS', '3', '016', '000', 'E', '49832VRCA', '000', 'NO DEFINIDO', 'ALBERTO', 'VARGAS', 'RAMIREZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (656, '86054605', 'JAMES', '1', '104', '001', 'E', '56630MJY', '001', 'OPERATIVOS PRODUCCION AGRICOLA', 'YESIT', 'MORA', '', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (804, '74845106', 'JESUS', '3', '014', '000', 'E', '47131VJA', '000', 'ASISTENTES', 'ANTONIO', 'VARGAS', '', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (805, '79636045', 'EDWIN', '3', '112', '003', 'A', '38070DMEO', '003', 'SUPERVISORES', 'OLIMPO', 'DELGADO', 'MENDOZA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (806, '83230060', 'ADOLFO', '3', '047', '016', 'A', '32085PVA', '016', 'SUPERVISORES', '', 'PARRA', 'VARGAS', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (807, '85261763', 'WILMAR', '3', '016', '000', 'E', '63788GGWE', '000', 'NO DEFINIDO', 'ENRIQUE', 'GONZALEZ', 'GUERRERO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (808, '86005534', 'JAIRO', '3', '058', '000', 'X', '7559BPJ', '000', 'OPERATIVOS PLANTA EXT', '', 'BASTOS', 'PEÑALOZA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (809, '86010357', 'JORGE', '3', '047', '000', 'E', '12382CHJ', '000', 'SUPERVISORES', '', 'CORREDOR', 'HINCAPIE', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (810, '86011153', 'JOSE', '3', '054', '000', 'E', '13178HGJO', '000', 'OPERATIVOS MANTENIMIENTO', 'ORLANDO', 'HERRERA', 'GALINDO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (811, '86013633', 'JOSE', '3', '016', '000', 'E', '15658GCJB', '000', 'NO DEFINIDO', 'BERTULFO', 'GONZALEZ', 'COCA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (812, '86014263', 'LUIS', '3', '049', '000', 'E', '16288AELA', '000', 'OPERATIVOS MANTENIMIENTO', 'ALBERTO', 'AGUIRRE', 'ECHEVERRI', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (813, '86043385', 'JORGE', '3', '117', '003', 'A', '45410SCJA', '003', 'DIRECTORES', 'ALEXANDER', 'SILVA', 'CRUZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (814, '86068662', 'LUIS', '3', '051', '000', 'E', '70687GLJ', '000', 'NO DEFINIDO', 'JARLEY', 'GONZALEZ', '', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (815, '87451815', 'VICENTE', '3', '055', '000', 'E', '53840DYVG', '000', 'OPERATIVOS PLANTA EXT', 'GERMAN', 'DIAZ', 'YELA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (816, '87948678', 'JAVIER', '3', '055', '000', 'E', '50703CJA', '000', 'OPERATIVOS PLANTA EXT', 'ALFREDO', 'CENTENO', '', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (817, '1006838738', 'JOSE', '3', '016', '000', 'E', '40763MGJG', '000', 'NO DEFINIDO', 'GENTIL', 'MONGE', 'GALINDO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (818, '1065905486', 'ALDRITSCH', '3', '058', '000', 'E', '7511PMAF', '000', 'OPERATIVOS PLANTA EXT', 'FERNANDO', 'PARDO', 'MOLINA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (819, '1081785405', 'JAIDER', '3', '058', '000', 'E', '87430DCJE', '000', 'OPERATIVOS PLANTA EXT', 'ENRIQUE', 'DE LA CRUZ', 'CESPEDES', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (820, '1094163398', 'ERWIN', '3', '058', '000', 'E', '65423GE', '000', 'OPERATIVOS PLANTA EXT', '', 'GUERRERO', '', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (821, '1116444180', 'JHON', '3', '055', '000', 'E', '46205LGJE', '000', 'OPERATIVOS PLANTA EXT', 'EDWARD', 'LOPEZ', 'GUTIERREZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (822, '1116866067', 'JAVIER', '3', '058', '000', 'E', '68092JLJ', '000', 'OPERATIVOS PLANTA EXT', '', 'JIMENEZ', 'LOPEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (823, '1118197909', 'NORIDA', '3', '015', '000', 'E', '99934CBN', '000', 'NO DEFINIDO', '', 'CANO', 'BURITICA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (824, '1120363799', 'WILLIAM', '3', '058', '000', 'E', '65824CTW', '000', 'OPERATIVOS PLANTA EXT', '', 'CAICEDO', 'TRIANA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (825, '1120364583', 'SULMAN', '3', '050', '000', 'E', '66608GRSA', '000', 'NO DEFINIDO', 'ANTONIO', 'GALLEGO', 'RODRIGUEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (826, '1120365099', 'JULIO', '3', '058', '000', 'E', '67124BMJC', '000', 'OPERATIVOS PLANTA EXT', 'CESAR', 'BACCA', 'MORENO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (827, '1120366033', 'JOSE', '3', '052', '000', 'X', '68058SVJG', '000', 'AUXILIARES OPERATIVOS', 'GERLEIN', 'SAAVEDRA', 'VILLAMIL', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (828, '1121416929', 'LEONARDO', '3', '049', '000', 'E', '18954MLLA', '000', 'OPERATIVOS MANTENIMIENTO', 'ALIRIO', 'MALAGON', 'LEYVA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (829, '1121841091', 'JUAN', '3', '008', '000', 'E', '43116GLJC', '000', 'NO DEFINIDO', 'CAMILO', 'GALVIZ', 'LOAIZA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (830, '1121914869', 'WILSON', '3', '020', '000', 'E', '16894VPW', '000', 'OPERATIVOS ADMINISTRATIVOS', '', 'VALENZUELA', 'PEREZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (831, '1122124797', 'YEISON', '3', '055', '000', 'E', '26822CGYJ', '000', 'OPERATIVOS PLANTA EXT', 'JAVIER', 'CARRILLO', 'GAMEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (832, '1122127220', 'JORGE', '3', '116', '003', 'A', '29245ABJL', '003', 'ANALISTAS', 'LEONARDO', 'ANDRADE', 'BOLIVAR', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (833, '1122129144', 'DUMAR', '3', '116', '016', 'A', '31169RHDI', '016', 'ANALISTAS', 'ISRAEL', 'ROJAS', 'HERNANDEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (834, '1122129468', 'VICTOR', '3', '055', '000', 'E', '31493CVVA', '000', 'OPERATIVOS PLANTA EXT', 'ALFONSO', 'CALLEJAS', 'VELOZA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (835, '1122132047', 'JORGE', '3', '016', '000', 'E', '34072UBJA', '000', 'NO DEFINIDO', 'ARIEL', 'UMBARILA', 'BENAVIDES', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (836, '1122132739', 'CARLOS', '3', '058', '000', 'E', '34764GTCA', '000', 'OPERATIVOS PLANTA EXT', 'ALBERTO', 'GUTIERREZ', 'TOCARIA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (837, '1122647830', 'GUILLERMO', '3', '014', '000', 'X', '49855MLGA', '000', 'ASISTENTES', 'ARMANDO', 'MONTEALEGRE', 'LOZADA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (838, '1123114444', 'EDISON', '3', '058', '000', 'E', '16469HME', '000', 'OPERATIVOS PLANTA EXT', '', 'HERNANDEZ', 'MORALES', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (839, '1123114695', 'OMAR', '3', '058', '000', 'E', '16720VMOA', '000', 'OPERATIVOS PLANTA EXT', 'ANDRES', 'VILLADA', 'MAHECHA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (840, '1123115108', 'RUBEN', '3', '058', '000', 'E', '17133RMRD', '000', 'OPERATIVOS PLANTA EXT', 'DARIO', 'RUIZ', 'MARTINEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (841, '1123115734', 'ARNOLD', '3', '016', '000', 'E', '17759RGA', '000', 'NO DEFINIDO', '', 'RUBIO', 'GARZON', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (842, '1123862532', 'YONNY', '3', '021', '000', 'E', '64557SVYA', '000', 'NO DEFINIDO', 'ALEXIS', 'SAENZ', 'VILLEGAS', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (843, '1124217820', 'YEISON', '3', '065', '000', 'E', '19845GMYA', '000', 'NO DEFINIDO', 'ANDRES', 'GOMEZ', 'MORENO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (844, '1124244023', 'DUVAN', '3', '016', '000', 'E', '46048GCDS', '000', 'NO DEFINIDO', 'SNEYDER', 'GUEVARA', 'CARDENAS', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (845, '1124848880', 'OSMAN', '3', '031', '016', 'A', '50905BCOF', '016', 'OPERATIVOS PLANTA EXT', 'FABIAN', 'BAMBAGUE', 'CHAVES', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (846, '97111315659', 'YULISA', '3', '021', '000', 'E', '17684MAYF', '000', 'NO DEFINIDO', 'FERNANDA', 'MARTINEZ', 'AGUIRRE', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (847, '11206477', 'FRANK', '3', '058', '000', 'E', '8502BBFS', '000', 'OPERATIVOS PLANTA EXT', 'STIVENSON', 'BRIÑEZ', 'BRIÑEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (849, '86074579', 'ANDRES', '3', '058', '000', 'E', '76604STAM', '000', 'OPERATIVOS PLANTA EXT', 'MAURICIO', 'SALAZAR', 'TORRES', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (850, '53095774', 'DIANA', '3', '021', '000', 'E', '97799GVDF', '000', 'NO DEFINIDO', 'FERNANDA', 'GUERRERO', 'VALDERRAMA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (851, '17357825', 'CESAR', '3', '058', '000', 'E', '59850RRCA', '000', 'OPERATIVOS PLANTA EXT', 'AUGUSTO', 'ROJAS', 'REYES', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (852, '1070809850', 'WILSON', '3', '055', '000', 'E', '11875HSW', '000', 'OPERATIVOS PLANTA EXT', '', 'HERRERA', 'SILGADO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (853, '17641451', 'HOMER', '3', '140', '005', 'A', '43476RTH', '005', 'OPERATIVOS ADMINISTRATIVOS', '', 'RAMIREZ', 'TRUJILLO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (211, '79188550', 'GUILLERMO', '1', '024', '001', 'E', '90575CPG', '001', 'CONDUCTORES', '', 'CASTRO', 'PRIETO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (212, '7837761', 'JESUS', '1', '029', '001', 'E', '39786MCJA', '001', 'OPERATIVOS PRODUCCION AGRICOLA', 'ANTONIO', 'MENDOZA', 'CARDONA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (273, '7838194', 'NESTOR', '1', '030', '001', 'V', '40219HPNJ', '001', 'AUXILIARES OPERATIVOS', 'JULIO', 'HERRERA', 'PARRA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (337, '1122141733', 'YEIMY', '1', '021', '000', 'E', '43758MPYK', '000', 'NO DEFINIDO', 'KATHERINE', 'MARROQUIN', 'PRIETO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (403, '1006658935', 'NIDIA', '1', '027', '001', 'A', '60960RRNJ', '001', 'ASISTENTES', 'JOHANA', 'REYES', 'RODRIGUEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (654, '19617449', 'MANUEL', '1', '104', '001', 'E', '19474JMMS', '001', 'OPERATIVOS PRODUCCION AGRICOLA', 'SALVADOR', 'JULIO', 'MESA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (655, '1122650208', 'EDISSON', '1', '104', '001', 'E', '52233BCEJ', '001', 'OPERATIVOS PRODUCCION AGRICOLA', 'JAVIER', 'BONILLA', 'CASTAÑEDA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (406, '1006838470', 'NASLY', '1', '073', '002', 'E', '40495VNG', '002', 'OPERATIVOS PRODUCCION AGRICOLA', 'GLAVEDIS', 'VIRGUEZ', '', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (466, '1015477571', 'KAREN', '1', '096', '002', 'E', '79596BHKD', '002', 'NO DEFINIDO', 'DANIELA', 'BERNAL', 'HENDES', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (498, '1123512702', 'YANIDSAT', '1', '073', '009', 'A', '14727FGY', '009', 'OPERATIVOS PRODUCCION AGRICOLA', '', 'FINO', 'GARCIA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (499, '1123115004', 'MARIA', '1', '073', '009', 'A', '17029MGMA', '009', 'OPERATIVOS PRODUCCION AGRICOLA', 'ALEJANDRA', 'MORA', 'GUTIERREZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (500, '1006693721', 'VIVIANA', '1', '033', '002', 'E', '95746PMVC', '002', 'OPERATIVOS PRODUCCION AGRICOLA', 'CATERINE', 'PUENTES', 'MAYORGA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (527, '1029986025', 'NATALIA', '1', '073', '009', 'X', '88050ALN', '009', 'OPERATIVOS PRODUCCION AGRICOLA', '', 'ARANDA', 'LARGO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (621, '1065123031', 'ANTONIO', '1', '062', '001', 'E', '25056VCAR', '001', 'NO DEFINIDO', 'RAFAEL', 'VALDES', 'CABARCAS', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (646, '40330756', 'LUZ', '1', '104', '001', 'E', '32781GRLA', '001', 'OPERATIVOS PRODUCCION AGRICOLA', 'ADELA', 'GOMEZ', 'REALES', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (660, '1123530038', 'CARLOS', '1', '104', '001', 'E', '32063BMCA', '001', 'OPERATIVOS PRODUCCION AGRICOLA', 'ANDRES', 'BUSTOS', 'MARIN', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (753, '18235985', 'JOSE', '1', '104', '001', 'A', '38010LRJO', '001', 'OPERATIVOS PRODUCCION AGRICOLA', 'OMAR', 'LEON', 'RODRIGUEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (501, '1120026250', 'ESTEBAN', '1', '033', '008', 'A', '28275GIES', '008', 'OPERATIVOS PRODUCCION AGRICOLA', 'SANTIAGO', 'GUZMAN', 'IPUZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (502, '1122128543', 'EDISNEY', '1', '021', '002', 'E', '30568MBES', '002', 'NO DEFINIDO', 'SLIAN', 'MARTINEZ', 'BUSTOS', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (891, '1121819126', 'RODRIGO', '3', '058', '000', 'E', '21151CARA', '000', 'OPERATIVOS PLANTA EXT', 'ANDRES', 'CARDONA', 'ACOSTA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (918, '1116438699', 'EDGAR', '3', '058', '999', 'E', '40724LDER', '999', 'OPERATIVOS PLANTA EXT', 'RODOLFO', 'LIBERATO', 'DELGADO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (948, '1109294421', 'DIEGO 		', '3', '058', '999', 'E', '96446CMDA', '999', 'OPERATIVOS PLANTA EXT', 'ALEXANDER', 'CRUZ 	', 'MONTEALEGRE', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (975, '86067413', 'EDUARDO', '3', '058', '000', 'E', '69438HTEE', '000', 'OPERATIVOS PLANTA EXT', 'EFREY', 'HERNANDEZ', 'TAPIA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (875, '1120503908', 'ARLEX', '3', '058', '000', 'E', '5933RRAA', '000', 'OPERATIVOS PLANTA EXT', 'ANDRES', 'REYES', 'RODRIGUEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1004, '1123116260', 'ANDERSON', '3', '058', '000', 'E', '18285SGAF', '000', 'OPERATIVOS PLANTA EXT', 'FARID', 'SALCEDO', 'GARCIA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1022, '1123115218', 'YEFRIN', '3', '058', '000', 'E', '17243RZYD', '000', 'OPERATIVOS PLANTA EXT', 'DURFAY', 'RIOS', 'ZAPATA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1029, '1122117851', 'JOHN', '3', '058', '000', 'E', '19876RGJJ', '000', 'OPERATIVOS PLANTA EXT', 'JAIRO', 'RODRIGUEZ', 'GUTIERREZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1060, '1234791972', 'CRISTHIAN', '3', '046', '999', 'E', '93997RCCC', '999', 'OPERATIVOS MANTENIMIENTO', 'CAMILO', 'RAMIREZ', 'CASTRO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (503, '1122141570', 'BRIYID', '1', '021', '002', 'E', '43595AGBY', '002', 'NO DEFINIDO', 'YULIETH', 'AVILA', 'GARCIA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (504, '17423595', 'YEISON', '1', '021', '002', 'E', '25620APYE', '002', 'NO DEFINIDO', 'EDUARDO', 'ANGEL', 'PEREZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (848, '86085633', 'YORGE', '3', '055', '016', 'A', '87658CEYA', '016', 'OPERATIVOS PLANTA EXT', 'ALEXANDER', 'CUBILLOS', 'ESPITIA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (505, '1123114895', 'CLAUDIA', '1', '073', '009', 'A', '16920AVCP', '009', 'OPERATIVOS PRODUCCION AGRICOLA', 'PATRICIA', 'AYALA', 'VEGA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (506, '1123114379', 'DELIDA', '1', '073', '002', 'E', '16404RMD', '002', 'OPERATIVOS PRODUCCION AGRICOLA', '', 'ROA', 'MESA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (507, '1128187143', 'LUIS', '1', '073', '002', 'E', '89168AZLD', '002', 'OPERATIVOS PRODUCCION AGRICOLA', 'DAVID', 'ALCAZAR', 'ZUÑIGA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (508, '1027947140', 'CARLOS', '1', '073', '009', 'A', '49165FGCA', '009', 'OPERATIVOS PRODUCCION AGRICOLA', 'ALBERTO', 'FUENTES', 'GARCIA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (856, '1122131465', 'LUIS', '3', '027', '000', 'E', '33490MBLB', '000', 'ASISTENTES', 'BERTULFO', 'MARIN', 'BALLEN', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (857, '9499110', 'WILLIAM', '3', '058', '000', 'E', '101135HMW', '000', 'OPERATIVOS PLANTA EXT', '', 'HERNANDEZ', 'MARTINEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (858, '1121907918', 'EDWIN', '3', '021', '000', 'E', '9943CSEA', '000', 'NO DEFINIDO', 'ANTONIO', 'CEBALLOS', 'SOLANO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (859, '1094368159', 'RAMIRO', '3', '049', '000', 'X', '70184SPR', '000', 'OPERATIVOS MANTENIMIENTO', '', 'SANTAFE', 'PARADA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (509, '1120473636', 'YEINY', '1', '073', '009', 'E', '75661LVYL', '009', 'OPERATIVOS PRODUCCION AGRICOLA', 'LORENA', 'LOMBANA', 'VALLEJO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (510, '1084791483', 'TIBISAY', '1', '073', '009', 'A', '93508PLT', '009', 'OPERATIVOS PRODUCCION AGRICOLA', '', 'PITRE', 'LAGO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (511, '1121870996', 'MARIA', '1', '033', '008', 'A', '73021AMF', '008', 'OPERATIVOS PRODUCCION AGRICOLA', 'FERNANDA', 'ANZOLA', '', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (512, '1123086261', 'GLADYS', '1', '033', '008', 'A', '88286CMGY', '008', 'OPERATIVOS PRODUCCION AGRICOLA', 'YOLANDA', 'CARVAJAL', 'MENDEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (513, '1084789074', 'JULIETH', '1', '073', '009', 'A', '91099BAJP', '009', 'OPERATIVOS PRODUCCION AGRICOLA', 'PAOLA', 'BOLAÑO', 'ARIZA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (514, '1098100371', 'JENYFER', '1', '033', '008', 'P', '2396RDJA', '008', 'OPERATIVOS PRODUCCION AGRICOLA', 'ALEJANDRA', 'ROJAS', 'DUARTE', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (515, '1122126576', 'YENIFER', '1', '027', '001', 'E', '28601BCYM', '001', 'ASISTENTES', 'MARCELA', 'BERNAL', 'CRUZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (516, '1006878479', 'EVELIN', '1', '073', '009', 'A', '80504MMEJ', '009', 'OPERATIVOS PRODUCCION AGRICOLA', 'JAENI', 'MUÑOZ', 'MUR', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (517, '1000160932', 'YURY', '1', '027', '002', 'A', '62957GOYN', '002', 'ASISTENTES', 'NAYELLY', 'GUALTEROS', 'OSPINA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (854, '93421465', 'HECTOR', '3', '058', '000', 'X', '23490VMH', '000', 'OPERATIVOS PLANTA EXT', '', 'VILLARREAL', 'MANRIQUE', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (855, '1121901125', 'ARNOL', '3', '058', '000', 'E', '3150LOAE', '000', 'OPERATIVOS PLANTA EXT', 'ESTIBEN', 'LOPEZ', 'OSORIO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (870, '1121869274', 'CESAR', '3', '058', '000', 'E', '71299MSCE', '000', 'OPERATIVOS PLANTA EXT', 'ESNEIDER', 'MADERO', 'SANABRIA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (871, '1121931948', 'DUVIER', '3', '021', '000', 'E', '33973TSDS', '000', 'NO DEFINIDO', 'STIVEN', 'TAMAYO', 'SABOGAL', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (872, '1123114785', 'JULIAN', '3', '058', '000', 'X', '16810PHJD', '000', 'OPERATIVOS PLANTA EXT', 'DAVID', 'PARRA', 'HERRERA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (524, '1123533687', 'KATHERINE', '1', '073', '009', 'A', '35712GCK', '009', 'OPERATIVOS PRODUCCION AGRICOLA', '', 'GAMEZ', 'CESPEDES', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (526, '1006902643', 'KEYNY', '1', '073', '009', 'A', '4668CSKD', '009', 'OPERATIVOS PRODUCCION AGRICOLA', 'DANIEL', 'CASTRO', 'SIERRA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (528, '1122135370', 'JESUS', '1', '073', '009', 'A', '37395GMJA', '009', 'OPERATIVOS PRODUCCION AGRICOLA', 'ADELMO', 'GOMEZ', 'MOSQUERA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (529, '17286025', 'GUSTAVO', '1', '095', '017', 'P', '88050GPG', '017', 'OPERATIVOS PRODUCCION AGRICOLA', '', 'GARZON', 'PENAGOS', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (530, '1078368777', 'LUIS', '1', '024', '017', 'A', '70802RTLA', '017', 'CONDUCTORES', 'ALEJANDRO', 'RIVAS', 'TRIANA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (531, '1120499071', 'FELIX', '1', '097', '002', 'E', '101096MOFO', '002', 'NO DEFINIDO', 'OCTAVIO', 'MORENO', 'ORTIZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (532, '1123114524', 'JORGE', '1', '088', '003', 'E', '16549BAJA', '003', 'NO DEFINIDO', 'ANDRES', 'BOCANEGRA', 'ARTEAGA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (533, '16435722', 'FREDY', '1', '088', '003', 'E', '37747CRF', '003', 'NO DEFINIDO', '', 'CARDONA', 'RAMIREZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (534, '1124825227', 'WILLIAM', '1', '090', '001', 'A', '27252AGWY', '001', 'NO DEFINIDO', 'YECID', 'ARREDONDO', 'GAMBOA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (536, '1234788687', 'JEISON', '1', '095', '000', 'E', '90712BCJS', '000', 'OPERATIVOS PRODUCCION AGRICOLA', 'STIVEN', 'BAQUIRO', 'CHICO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (537, '5459456', 'HERIBERTO', '1', '095', '000', 'E', '61481BVH', '000', 'OPERATIVOS PRODUCCION AGRICOLA', '', 'BACA', 'VEGA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (538, '17287753', 'ISIDRO', '1', '095', '017', 'A', '89778GPI', '017', 'OPERATIVOS PRODUCCION AGRICOLA', '', 'GARZON', 'PENAGOS', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (539, '1122119449', 'OLGA', '1', '073', '009', 'A', '21474ROOL', '009', 'OPERATIVOS PRODUCCION AGRICOLA', 'LUCIA', 'RIVEROS', 'ORTEGA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (540, '39760134', 'AYDEE', '1', '029', '001', 'E', '62159QOAO', '001', 'OPERATIVOS PRODUCCION AGRICOLA', 'OLAVE', 'QUIÑONES', 'ORDOÑEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (541, '39008924', 'CANDIDA', '1', '033', '002', 'E', '10949MCCR', '002', 'OPERATIVOS PRODUCCION AGRICOLA', 'ROSA', 'MORENO', 'CARPIO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (861, '1032469690', 'JAMES', '3', '058', '000', 'E', '71715MPJA', '000', 'OPERATIVOS PLANTA EXT', 'ANDRES', 'MOLINA', 'PAEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (862, '17420760', 'ALEXANDER', '3', '058', '000', 'E', '22785LCA', '000', 'OPERATIVOS PLANTA EXT', '', 'LOPEZ', 'CARDENAS', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (863, '11229898', 'SANTOS', '3', '058', '000', 'E', '31923GRSR', '000', 'OPERATIVOS PLANTA EXT', 'RAMON', 'GOMEZ', 'ROCHA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (864, '1121836833', 'CARLOS', '3', '083', '000', 'E', '38858CPCA', '000', 'NO DEFINIDO', 'ANDRES', 'CIFUENTES', 'PRECIADO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (865, '17420510', 'ALVARO', '3', '055', '000', 'E', '22535CA', '000', 'OPERATIVOS PLANTA EXT', '', 'CAÑON', '', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (866, '1052407054', 'YULI', '3', '021', '000', 'E', '9079RCYJ', '000', 'NO DEFINIDO', 'JASBLEIDY', 'RONDEROS', 'CANO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (860, '17420398', 'NEDIER', '3', '058', '000', 'E', '22423HANS', '000', 'OPERATIVOS PLANTA EXT', 'SINEY', 'HINCAPIE', 'ARIAS', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (867, '1121823601', 'DIEGO', '3', '065', '000', 'E', '25626CUDF', '000', 'NO DEFINIDO', 'FERNANDO', 'CAMACHO', 'URUEÑA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (868, '7838138', 'VIONNEY', '3', '058', '000', 'E', '40163VPV', '000', 'OPERATIVOS PLANTA EXT', '', 'VARON', 'PARRA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (518, '1122120878', 'ALEXANDRA', '1', '073', '009', 'A', '22903OGA', '009', 'OPERATIVOS PRODUCCION AGRICOLA', '', 'OBANDO', 'GIRALDO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (519, '1122116022', 'JOHAN', '1', '073', '009', 'A', '18047RAJF', '009', 'OPERATIVOS PRODUCCION AGRICOLA', 'FELIPE', 'RUIZ', 'AGUDELO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (520, '1122124507', 'LUZ', '1', '073', '009', 'E', '26532AQLM', '009', 'OPERATIVOS PRODUCCION AGRICOLA', 'MAYERLI', 'AGUDELO', 'QUEVEDO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (521, '1122122966', 'YURI', '1', '021', '002', 'A', '24991RRYA', '002', 'NO DEFINIDO', 'ALEJANDRA', 'ROMERO', 'RINCON', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (522, '1124242936', 'YUVY', '1', '021', '002', 'A', '44961MVYA', '002', 'NO DEFINIDO', 'ANDREA', 'MAHECHA', 'VALENCIA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (523, '1030599614', 'REINA', '1', '021', '007', 'A', '101639AARL', '007', 'NO DEFINIDO', 'LUCIA', 'AGUJA', 'ASCENCIO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1117, '1193130794', 'FARDEY', '3', '058', '999', 'E', '32819LVF', '999', 'OPERATIVOS PLANTA EXT', '', 'LASSO', 'VALDERRAMA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1158, '1002721425', 'LEYDY', '3', '021', '999', 'E', '23450RGLY', '999', 'NO DEFINIDO', 'YECENIA', 'RAMIREZ', 'GAMEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1118, '11275841', 'WALTER', '3', '058', '016', 'A', '77866LTWA', '016', 'OPERATIVOS PLANTA EXT', 'ANTONIO', 'LOPEZ', 'TABARES', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1119, '1005690575', 'JORGE', '3', '031', '016', 'A', '92600VRJA', '016', 'OPERATIVOS PLANTA EXT', 'ANTONIO', 'VILLALOBOS', 'RIAÑO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1159, '1006863053', 'OSCAR', '3', '118', '003', 'A', '65078SQOE', '003', 'OPERATIVOS MANTENIMIENTO', 'EDUARDO', 'SANTANILLA', 'QUINTERO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1160, '6407157', 'WILLIAM', '3', '058', '999', 'E', '9182RFWA', '999', 'OPERATIVOS PLANTA EXT', 'ANDRES', 'REYES', 'FERNANDEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1161, '1123511714', 'JOHN', '3', '031', '999', 'E', '13739MPJA', '999', 'OPERATIVOS PLANTA EXT', 'ARLEY', 'MEDINA', 'PUENTES', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1124, '1006796762', 'ARLEY', '3', '096', '999', 'E', '98787JAAF', '999', 'NO DEFINIDO', 'FERNANDO', 'JIMENEZ', 'ABELLO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1125, '1006779702', 'JULIAN', '3', '058', '016', 'A', '81727PMJF', '016', 'OPERATIVOS PLANTA EXT', 'FELIPE', 'PINZON', 'MARTINEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1126, '1056769935', 'JHON', '3', '058', '999', 'E', '71960GGJL', '999', 'OPERATIVOS PLANTA EXT', 'LEIDER', 'GUZMAN', 'GALEANO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1127, '1003624974', 'FEDERICO', '3', '058', '999', 'E', '26999VCFF', '999', 'OPERATIVOS PLANTA EXT', 'FABIAN', 'VARGAS', 'CASTILLO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1128, '1123432549', 'KEVIN', '3', '058', '999', 'E', '34574HBKD', '999', 'OPERATIVOS PLANTA EXT', 'DUVAN', 'HERRERA', 'BARRAGAN', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1129, '1123085690', 'GABRIEL', '3', '058', '999', 'E', '87715GAG', '999', 'OPERATIVOS PLANTA EXT', '', 'GUTIERREZ', 'APONTE', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1131, '1123116641', 'ROBINSON', '3', '058', '999', 'E', '18666CARM', '999', 'OPERATIVOS PLANTA EXT', 'MANUEL', 'CASTRO', 'ARIAS', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1132, '1122116683', 'WILMER', '3', '031', '999', 'E', '18708MW', '999', 'OPERATIVOS PLANTA EXT', '', 'MORERA', '', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1133, '1123115647', 'DIEGO', '3', '058', '016', 'A', '17672PVDA', '016', 'OPERATIVOS PLANTA EXT', 'ALEXANDER', 'PEÑA', 'VARELA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1134, '1123115899', 'FRANK', '3', '058', '999', 'E', '17924DPFS', '999', 'OPERATIVOS PLANTA EXT', 'SANTIAGO', 'DELGADO', 'PINTO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1135, '1122652148', 'WILMER', '3', '076', '016', 'A', '54173RLWE', '016', 'COORDINADORES', 'ELIECER', 'ROMERO', 'LOPEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1136, '1123115111', 'JAIR', '3', '058', '999', 'E', '17136RCJA', '999', 'OPERATIVOS PLANTA EXT', 'ANDRES', 'ROJAS', 'CHAVEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1137, '1006776756', 'BRAYAN', '3', '054', '003', 'A', '78781OHBS', '003', 'OPERATIVOS MANTENIMIENTO', 'SMITH', 'ORTEGA', 'HERNANDEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1138, '1006701714', 'ERICK', '3', '058', '999', 'E', '3739RSED', '999', 'OPERATIVOS PLANTA EXT', 'DUVAIT', 'RODRIGUEZ', 'SANCHEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1139, '1006779934', 'LUISA', '3', '027', '016', 'A', '81959CALF', '016', 'ASISTENTES', 'FERNANDA', 'CERA', 'ATEHORTUA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1140, '1121146332', 'JOSE', '3', '058', '999', 'E', '48357MJJA', '999', 'OPERATIVOS PLANTA EXT', 'AGUSTIN', 'MOLINA', 'JIMENEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1141, '1122239747', 'MARLOS', '3', '031', '999', 'E', '41772YFMS', '999', 'OPERATIVOS PLANTA EXT', 'STEVEN', 'YEPES', 'FLORES', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1142, '1022930497', 'JEIDER', '3', '058', '999', 'E', '32522MVJA', '999', 'OPERATIVOS PLANTA EXT', 'ALEJANDRO', 'MORA', 'VARGAS', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1144, '1000158979', 'DEYVHID', '3', '058', '999', 'E', '61004BPDF', '999', 'OPERATIVOS PLANTA EXT', 'FELIPE', 'BARRAGAN', 'PAREDES', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1145, '1006838515', 'ROBERTO', '3', '058', '999', 'E', '40540VRR', '999', 'OPERATIVOS PLANTA EXT', '', 'VILLALOBOS', 'RODRIGUEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1146, '1060586244', 'ADRIAN', '3', '058', '999', 'E', '88269RRA', '999', 'OPERATIVOS PLANTA EXT', '', 'RUIZ', 'RIVERA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1147, '1122146037', 'MIGUEL', '3', '058', '999', 'E', '48062VRME', '999', 'OPERATIVOS PLANTA EXT', 'EDUARDO', 'VILLALOBOS', 'RIAÑO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1148, '1120500027', 'RUBEN', '3', '058', '999', 'E', '2052PTRD', '999', 'OPERATIVOS PLANTA EXT', 'DARIO', 'PEÑA', 'TILANO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1149, '1122139565', 'JHON', '3', '058', '999', 'E', '41590GRJA', '999', 'OPERATIVOS PLANTA EXT', 'ALEXANDER', 'GUTIERREZ', 'ROJAS', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1150, '1123116401', 'NELSON', '3', '058', '016', 'E', '18426MVNM', '016', 'OPERATIVOS PLANTA EXT', 'MAURICIO', 'MORA', 'VARON', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1151, '1007294800', 'JONATHAN', '3', '058', '999', 'E', '96825HMJF', '999', 'OPERATIVOS PLANTA EXT', 'FELIPE', 'HERNANDEZ', 'MEJIA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1152, '1123114330', 'WILVER', '3', '058', '016', 'E', '16355BPW', '016', 'OPERATIVOS PLANTA EXT', '', 'BAQUERO', 'PINEDA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1153, '1006838662', 'JUAN', '3', '118', '003', 'A', '40687RNJC', '003', 'OPERATIVOS MANTENIMIENTO', 'CAMILO', 'RAMIREZ', 'NOGUERA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1154, '1121944108', 'ERIK', '3', '046', '999', 'E', '46133SNEA', '999', 'OPERATIVOS MANTENIMIENTO', 'ALEXANDER', 'SANABRIA', 'NAVAS', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1155, '1019023147', 'WILSON', '3', '021', '999', 'E', '25172RPWS', '999', 'NO DEFINIDO', 'SEBASTIAN', 'RONDON', 'PEREZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1156, '1019023149', 'OSCAR', '3', '021', '999', 'E', '25174RPOJ', '999', 'NO DEFINIDO', 'JAVIER', 'RONDON', 'PEREZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1157, '86085972', 'NELSON', '3', '135', '003', 'A', '87997SNA', '003', 'ANALISTAS', 'ALEJANDRO', 'SANCHEZ', '', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1162, '1006823065', 'ANDREA', '3', '130', '015', 'A', '25090MPAN', '015', 'SUPERVISORES', 'NATALIA', 'MOSQUERA', 'PERDOMO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1163, '1123115517', 'DIDIER', '3', '058', '999', 'E', '17542CADA', '999', 'OPERATIVOS PLANTA EXT', 'ALEXIS', 'CERA', 'ATEHORTUA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1164, '1122508447', 'CARLOS', '3', '058', '999', 'E', '10472GCA', '999', 'OPERATIVOS PLANTA EXT', 'ANDRES', 'GOMEZ', '', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1165, '1120838807', 'MARIA', '3', '021', '999', 'E', '40832MGMJ', '999', 'NO DEFINIDO', 'JOSE', 'MAHECHA', 'GARCIA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1166, '1123531569', 'JOSE', '3', '139', '003', 'A', '33594RYJM', '003', 'NO DEFINIDO', 'MAIRON', 'RUBIANO', 'YATE', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1167, '1006858085', 'CRISTIAN', '3', '096', '999', 'E', '60110PSCF', '999', 'NO DEFINIDO', 'FELIPE', 'PIÑEROS', 'SARMIENTO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1168, '1062355319', 'CAMILO', '3', '021', '999', 'E', '57344VPCA', '999', 'NO DEFINIDO', 'ANDRES', 'VILORIA', 'PEDROZA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1169, '1120839879', 'STHEFANNY', '3', '021', '999', 'E', '41904AVSA', '999', 'NO DEFINIDO', 'ALEXANDRA', 'ARENAS', 'VELASQUEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1170, '1079184819', 'CRISTIAN', '3', '058', '999', 'E', '86844CLCF', '999', 'OPERATIVOS PLANTA EXT', 'FERNANDO', 'CORDOBA', 'LIZCANO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1171, '1122125402', 'EDISNOVER', '3', '058', '999', 'E', '27427VCE', '999', 'OPERATIVOS PLANTA EXT', '', 'VALENCIA', 'CANO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1172, '1063950016', 'DUBAN', '3', '058', '999', 'E', '52041MGDJ', '999', 'OPERATIVOS PLANTA EXT', 'JESUS', 'MONTERO', 'GARCIA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1173, '1010131201', 'DANIEL', '3', '058', '999', 'E', '33226AGDA', '999', 'OPERATIVOS PLANTA EXT', 'ANDREY', 'AGUIRRE', 'GALVIS', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1174, '1087786215', 'KEVIN', '3', '058', '999', 'E', '88240PVKE', '999', 'OPERATIVOS PLANTA EXT', 'ESTEBAN', 'PEÑA', 'VALENCIA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1175, '1123560144', 'ANDRES', '3', '052', '015', 'A', '62169ADAA', '015', 'AUXILIARES OPERATIVOS', 'ALBERTO', 'AYALA', 'DIAZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1176, '1115853757', 'JENIFER', '3', '021', '999', 'E', '55782MMJS', '999', 'NO DEFINIDO', 'SOLANYI', 'MENDIVELSO', 'MORENO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (542, '21088082', 'NOHORA', '1', '073', '002', 'E', '90107LCNE', '002', 'OPERATIVOS PRODUCCION AGRICOLA', 'EMILCE', 'LEON', 'CARDENAS', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1112, '1007546727', 'CESAR', '3', '058', '999', 'E', '48752DPCL', '999', 'OPERATIVOS PLANTA EXT', 'LUIS', 'DIAZ', 'PAEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1120, '1052416137', 'ANGELA', '3', '130', '999', 'E', '18162GBAD', '999', 'SUPERVISORES', 'DAYANA', 'GALINDO', 'BARRERA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1121, '1123117506', 'YOVANIS', '3', '049', '003', 'A', '19531BHYA', '003', 'OPERATIVOS MANTENIMIENTO', 'ALEXIS', 'BARROSO', 'HERRERA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1122, '1123116616', 'MARTHA', '3', '100', '003', 'A', '18641LNMY', '003', 'ASISTENTES', 'YURANIS', 'LOPEZ', 'NOREÑA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1123, '86085972', 'NELSON', '3', '021', '999', 'E', '87997SNA', '999', 'NO DEFINIDO', 'ALEJANDRO', 'SANCHEZ', '', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1208, '1123114633', 'DEIBER', '3', '058', '016', 'A', '16658CRDH', '016', 'OPERATIVOS PLANTA EXT', 'HUMBERTO', 'CARDENAS', 'RICO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1209, '1026257976', 'BRAYAN', '3', '058', '016', 'A', '60001LSBS', '016', 'OPERATIVOS PLANTA EXT', 'STEVEN', 'LOPEZ', 'SERRATO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1210, '1122141585', 'NIXON', '3', '058', '016', 'E', '43610AANB', '016', 'OPERATIVOS PLANTA EXT', 'BALENTIN', 'ARIZA', 'AGUDELO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1211, '1006777925', 'MICHAEL', '3', '058', '016', 'E', '79950SOME', '016', 'OPERATIVOS PLANTA EXT', 'ESTEBAN', 'SAAVEDRA', 'OCHOA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (204, '98686714', 'MANUEL', '1', '033', '002', 'E', '88739TTMD', '002', 'OPERATIVOS PRODUCCION AGRICOLA', 'DE JESUS', 'TORRES', 'TORO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1207, '1120841203', 'YEISON', '3', '058', '016', 'E', '43228DMYS', '016', 'OPERATIVOS PLANTA EXT', 'STIVEN', 'DIAZ', 'MENDOZA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1177, '1123116008', 'MIGUEL', '3', '058', '999', 'E', '18033LBMA', '999', 'OPERATIVOS PLANTA EXT', 'ANGEL', 'LEGUIZAMON', 'BERNAL', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1178, '1000226435', 'MIGUEL', '3', '058', '999', 'E', '28460CBMA', '999', 'OPERATIVOS PLANTA EXT', 'ANGEL', 'CORTES', 'BASTO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1179, '1122120970', 'HAROLD', '3', '058', '016', 'A', '22995CHJ', '016', 'OPERATIVOS PLANTA EXT', 'JHONDANY', 'CRUZ', '', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1182, '1000047346', 'JHON', '3', '058', '016', 'E', '49371GZJA', '016', 'OPERATIVOS PLANTA EXT', 'ALEXANDER', 'GOMEZ', 'ZAMBRANO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1183, '1115790149', 'ANDRES', '3', '058', '016', 'X', '92174RGAM', '016', 'OPERATIVOS PLANTA EXT', 'MAURICIO', 'RIOS', 'GONZALEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1130, '1121836068', 'ERWIN', '3', '058', '999', 'E', '38093HREF', '999', 'OPERATIVOS PLANTA EXT', 'FERNANDO', 'HERRERA', 'ROJAS', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (402, '1006822396', 'ANDRES', '1', '029', '002', 'A', '24421ROAF', '002', 'OPERATIVOS PRODUCCION AGRICOLA', 'FELIPE', 'RINCON', 'ORTIZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (405, '40340107', 'SANDRA', '1', '073', '002', 'E', '42132CSC', '002', 'OPERATIVOS PRODUCCION AGRICOLA', 'CAROLINA', 'CAICEDO', '', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1212, '1123114388', 'DIEGO', '3', '058', '016', 'A', '16413RCDA', '016', 'OPERATIVOS PLANTA EXT', 'ALEXANDER', 'RODRIGUEZ', 'CASTAÑEDA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1213, '1122513183', 'JOHAN', '3', '058', '016', 'A', '15208PGJS', '016', 'OPERATIVOS PLANTA EXT', 'SANTIAGO', 'POBLADOR', 'GONZALEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1214, '1067718738', 'JUAN', '3', '058', '016', 'E', '20763PBJR', '016', 'OPERATIVOS PLANTA EXT', 'RAFAEL', 'PEREZ', 'BARRIOS', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1215, '40433429', 'MARIA', '3', '052', '015', 'A', '35454PPME', '015', 'AUXILIARES OPERATIVOS', 'EDILMA', 'PUENTES', 'PEÑA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (242, '86051270', 'JOSE FREY', '1', '049', '003', 'E', '53295VCJD', '003', 'OPERATIVOS MANTENIMIENTO', 'DAVID', 'VIUCHE', 'CUPITRA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (2, '11052275', 'JOSE', '1', '004', '000', 'E', '54300SRJD', '000', 'NO DEFINIDO', 'DAVID', 'SUAREZ', 'RIVERA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (6, '40434734', 'JANNETH', '1', '016', '005', 'E', '36759UVJR', '005', 'NO DEFINIDO', 'ROCIO', 'UBAQUE', 'VIGOYA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (31, '1120369160', 'LUIS', '1', '085', '005', 'E', '71185TDLC', '005', 'AUXILIARES', 'CARLOS', 'TRUJILLO', 'DE LA VILLA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (64, '1122139206', 'TARIN', '1', '021', '005', 'E', '41231GRTT', '005', 'NO DEFINIDO', 'TATIANA', 'GUARIN', 'ROZO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (92, '1032443022', 'ANLLY', '1', '129', '005', 'E', '45047GRAJ', '005', 'COORDINADORES', 'JULIET', 'GARZON', 'ROJAS', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (119, '40397487', 'LUZ', '1', '020', '005', 'A', '99512ZTLE', '005', 'OPERATIVOS ADMINISTRATIVOS', 'ESTELLA', 'ZARATE', 'TRIANA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (155, '40272218', 'HERCILIA', '1', '030', '002', 'E', '74243AVH', '002', 'AUXILIARES OPERATIVOS', '', 'AYALA', 'VASQUEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (272, '1120500230', 'EDWIN', '1', '031', '002', 'E', '2255GCEL', '002', 'OPERATIVOS PLANTA EXT', 'LEONARDO', 'GARZON', 'CONTRERAS', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (303, '80927256', 'WILLIAN', '1', '095', '999', 'E', '29281SPW', '999', 'OPERATIVOS PRODUCCION AGRICOLA', '', 'SOLER', 'PULIDO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (332, '1123116186', 'JOSE', '1', '031', '001', 'E', '18211GAJN', '001', 'OPERATIVOS PLANTA EXT', 'NICODEMUS', 'GUTIERREZ', 'ARDILA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (336, '1122119953', 'JOHANNA', '1', '021', '000', 'E', '21978HCJA', '000', 'NO DEFINIDO', 'ALEXANDRA', 'HERNANDEZ', 'CARDONA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (355, '1120501574', 'MARIBEL', '1', '030', '001', 'E', '3599VGM', '001', 'AUXILIARES OPERATIVOS', '', 'VILLAMIL', 'GUTIERREZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (384, '1006697696', 'KAREN', '1', '021', '002', 'E', '99721PGKN', '002', 'NO DEFINIDO', 'NATALIA', 'PALACIOS', 'GONZALEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (439, '1006779589', 'LUISA', '1', '021', '002', 'E', '81614RALF', '002', 'NO DEFINIDO', 'FERNANDA', 'RODRIGUEZ', 'ABELLO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (465, '1122134542', 'ALDEMAR', '1', '073', '002', 'E', '36567MVA', '002', 'OPERATIVOS PRODUCCION AGRICOLA', '', 'MONROY', 'VANEGAS', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (488, '1006779589', 'LUISA', '1', '033', '008', 'X', '81614RBLF', '008', 'OPERATIVOS PRODUCCION AGRICOLA', 'FERNANDA', 'RODRIGUEZ', 'BELLO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (525, '1123435956', 'FERNEY', '1', '073', '009', 'A', '37981MOFE', '009', 'OPERATIVOS PRODUCCION AGRICOLA', 'ESTIBEN', 'MORALES', 'OBANDO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (873, '1123114786', 'JUAN', '3', '058', '000', 'X', '16811PHJC', '000', 'OPERATIVOS PLANTA EXT', 'CAMILO', 'PARRA', 'HERRERA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (874, '1123114837', 'VICTOR', '3', '046', '003', 'V', '16862CMVA', '003', 'OPERATIVOS MANTENIMIENTO', 'ALFONSO', 'CORTES', 'MOLINA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1187, '1121973213', 'JOHANDRI', '3', '058', '016', 'E', '75238VVJJ', '016', 'OPERATIVOS PLANTA EXT', 'JOSE', 'VIVANCO', 'VERGARA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1188, '1006877320', 'EDWARD', '3', '058', '999', 'E', '79345ROEE', '999', 'OPERATIVOS PLANTA EXT', 'ESNEIDER', 'RAMIREZ', 'ORREGO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1189, '1029984323', 'HEXUM', '3', '058', '999', 'E', '86348CRHF', '999', 'OPERATIVOS PLANTA EXT', 'FERNEY', 'CERVANTES', 'RICO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1191, '1027943550', 'NICOLE', '3', '021', '005', 'E', '45575BMNA', '005', 'NO DEFINIDO', 'ANDREA', 'BALANTA', 'MARTINEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1192, '1006838564', 'CESAR', '3', '058', '016', 'A', '40589SOCF', '016', 'OPERATIVOS PLANTA EXT', 'FABIAN', 'SAAVEDRA', 'OCHOA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1193, '1146439656', 'ANDRES', '3', '058', '999', 'E', '41681RPA', '999', 'OPERATIVOS PLANTA EXT', '', 'ROJAS', 'PRIETO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1194, '1006799630', 'HERNAN', '3', '058', '016', 'A', '101655SQHD', '016', 'OPERATIVOS PLANTA EXT', 'DARIO', 'SANTANILLA', 'QUINTERO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1195, '1006837429', 'JEFERSON', '3', '058', '016', 'A', '39454LCJS', '016', 'OPERATIVOS PLANTA EXT', 'SNEYDER', 'LEON', 'CASTRILLON', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1196, '1019022428', 'MAICOL', '3', '058', '016', 'A', '24453OBMS', '016', 'OPERATIVOS PLANTA EXT', 'STIVEN', 'OSORIO', 'BAQUERO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1197, '1120361996', 'KEVIN', '3', '058', '016', 'A', '64021CRKD', '016', 'OPERATIVOS PLANTA EXT', 'DAVID', 'CARTAGENA', 'RAMIREZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1198, '1006838441', 'LUIS', '3', '058', '016', 'A', '40466SZLH', '016', 'OPERATIVOS PLANTA EXT', 'HUMBERTO', 'SAAVEDRA', 'ZARATE', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1199, '1122144114', 'BAIRON', '3', '058', '999', 'E', '46139TTBS', '999', 'OPERATIVOS PLANTA EXT', 'STIVEN', 'TRIVIÑO', 'TORRES', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1200, '1120838807', 'MARIA', '3', '085', '005', 'A', '40832MGMJ', '005', 'AUXILIARES', 'JOSE', 'MAHECHA', 'GARCIA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1201, '1121967163', 'DANIEL', '3', '046', '003', 'A', '69188SBDL', '003', 'OPERATIVOS MANTENIMIENTO', 'LEONARDO', 'SUAREZ', 'BUSTOS', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1202, '1006772386', 'ANGELA', '3', '096', '005', 'E', '74411MAAP', '005', 'NO DEFINIDO', 'PATRICIA', 'MENDEZ', 'ALMANZA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1203, '1082974980', 'JESUS', '3', '058', '016', 'X', '77005MTJM', '016', 'OPERATIVOS PLANTA EXT', 'MIGUEL', 'MIRANDA', 'TUNA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1204, '1123114224', 'NICHELZEN', '3', '058', '016', 'A', '16249LDNA', '016', 'OPERATIVOS PLANTA EXT', 'ALEXANDER', 'LOPEZ', 'DIAZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1205, '1006863050', 'DIEGO', '3', '058', '016', 'A', '65075MGDA', '016', 'OPERATIVOS PLANTA EXT', 'ALEJANDRO', 'MOYANO', 'GONZALEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1206, '1006415951', 'JHONATAN', '3', '058', '016', 'A', '17976EMJA', '016', 'OPERATIVOS PLANTA EXT', 'ARLEY', 'ESPEJO', 'MARTINEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (876, '1007168011', 'JORGE', '3', '058', '000', 'E', '70036QJA', '000', 'OPERATIVOS PLANTA EXT', 'ALIRIO', 'QUIJANO', '', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1184, '1123085690', 'GABRIEL', '3', '058', '016', 'A', '87715GAG', '016', 'OPERATIVOS PLANTA EXT', '', 'GUTIERREZ', 'APONTE', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1185, '1123115593', 'JUAN', '3', '058', '016', 'A', '17618RQJD', '016', 'OPERATIVOS PLANTA EXT', 'DAVID', 'ROCHA', 'QUINTERO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1186, '31031839', 'YUDY', '3', '058', '999', 'E', '33864MYA', '999', 'OPERATIVOS PLANTA EXT', 'ADRIANA', 'MARTINEZ', '', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (179, '1121868646', 'RONAL', '1', '031', '002', 'E', '70671HMRD', '002', 'OPERATIVOS PLANTA EXT', 'DE JESUS', 'HERNANDEZ', 'MORALES', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (189, '1123115105', 'DANIELA', '1', '033', '002', 'E', '17130VBDA', '002', 'OPERATIVOS PRODUCCION AGRICOLA', 'ALEJANDRA', 'VILLAMIL', 'BEJARANO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (210, '1124827879', 'ASTRID', '1', '033', '002', 'E', '29904APAK', '002', 'OPERATIVOS PRODUCCION AGRICOLA', 'KATHERINE', 'ALZATE', 'PALMAS', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (407, '1006838669', 'JENNY', '1', '073', '009', 'X', '40694GYJA', '009', 'OPERATIVOS PRODUCCION AGRICOLA', 'ALEXANDRA', 'GUTIERREZ', 'YARA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (535, '1148948024', 'JOSE', '1', '095', '002', 'E', '50049DFJG', '002', 'OPERATIVOS PRODUCCION AGRICOLA', 'GREGORIO', 'DEMOYA', 'FORTICH', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (543, '1121863868', 'CESAR', '1', '029', '001', 'E', '65893ATCF', '001', 'OPERATIVOS PRODUCCION AGRICOLA', 'FERNANDO', 'AGUDELO', 'TERREROS', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (544, '1106894544', 'YINETH', '1', '026', '001', 'E', '96569MMY', '001', 'NO DEFINIDO', '', 'MURCIA', 'MURCIA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (545, '1050951819', 'DEINER', '1', '030', '001', 'V', '53844MPDD', '001', 'AUXILIARES OPERATIVOS', 'DE JESUS', 'MULET', 'PAZO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (546, '18129784', 'JHON', '1', '042', '000', 'E', '31809BCJJ', '000', 'NO DEFINIDO', 'JAIRO', 'BAMBAGUE', 'CHAVEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (547, '7837896', 'LUIS', '1', '052', '000', 'A', '39921GLA', '000', 'AUXILIARES OPERATIVOS', 'ANGEL', 'GUAYARA', '', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (125, '17416230', 'UMAR', '1', '018', '000', 'A', '18255UPU', '000', 'CONDUCTORES', '', 'UMBARILA', 'POVEDA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (575, '78302418', 'HONORIO', '1', '062', '000', 'E', '4443RAHG', '000', 'NO DEFINIDO', 'GABRIEL', 'REYES', 'ARRIETA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (611, '1122142561', 'CRISTIAN', '1', '104', '001', 'E', '44586ERCA', '001', 'OPERATIVOS PRODUCCION AGRICOLA', 'ANDRES', 'ESPINOSA', 'ROBLES', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (648, '1122145567', 'KEVIN', '1', '104', '001', 'E', '47592HVKA', '001', 'OPERATIVOS PRODUCCION AGRICOLA', 'ALEJANDRO', 'HERNANDEZ', 'VARGAS', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (659, '1119887188', 'DARIO', '1', '104', '001', 'A', '89213PADA', '001', 'OPERATIVOS PRODUCCION AGRICOLA', 'ALFONSO', 'PEÑUELA', 'ACOSTA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (697, '19619269', 'WILDER', '1', '104', '001', 'A', '21294RCWE', '001', 'OPERATIVOS PRODUCCION AGRICOLA', 'ENRIQUE', 'RODRIGUEZ', 'CASTRO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (718, '85260267', 'RUBEN', '1', '104', '001', 'E', '62292SVRD', '001', 'OPERATIVOS PRODUCCION AGRICOLA', 'DARIO', 'SALCEDO', 'VISBAL', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (719, '17417340', 'EDILSON', '1', '104', '001', 'A', '19365GME', '001', 'OPERATIVOS PRODUCCION AGRICOLA', '', 'GALINDO', 'MENDOZA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (744, '1006718482', 'KEVIN', '1', '104', '001', 'X', '20507PVKF', '001', 'OPERATIVOS PRODUCCION AGRICOLA', 'FERLEY', 'PIÑEROS', 'VARGAS', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1143, '1006797263', 'DARWIN', '3', '058', '999', 'E', '99288TDDM', '999', 'OPERATIVOS PLANTA EXT', 'MAURICIO', 'TAPIERO', 'DUQUE', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1190, '1193583858', 'CESAR', '3', '058', '999', 'E', '85883ECCE', '999', 'OPERATIVOS PLANTA EXT', 'ESTIVEN', 'ESPITIA', 'CARRILLO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (39, '1121931454', 'MAIKOL', '1', '016', '005', 'E', '33479MMMY', '005', 'NO DEFINIDO', 'YERBEY', 'MORENO', 'MARIN', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (48, '80871563', 'JUAN', '1', '085', '005', 'V', '73588RMJC', '005', 'AUXILIARES', 'CAMILO', 'RIVEROS', 'MOYANO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (95, '1006777244', 'LEIDY', '1', '085', '005', 'E', '79269TVLM', '005', 'AUXILIARES', 'MARCELA', 'TANGARIFE', 'VELASQUEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (96, '1121936919', 'KELLY', '1', '096', '005', 'E', '38944CMKD', '005', 'NO DEFINIDO', 'DAYANNA', 'CASTAÑEDA', 'MORENO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (117, '17418301', 'JAVIER', '1', '126', '013', 'A', '20326MBJ', '013', 'JEFES', '', 'MENDOZA', 'BOJACA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (118, '31031947', 'DIANA', '1', '065', '000', 'E', '33972PSDC', '000', 'NO DEFINIDO', 'CONSTANZA', 'PEREZ', 'SALAZAR', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (120, '40397899', 'SILVIA', '1', '114', '012', 'A', '99924MRS', '012', 'ASISTENTES', '', 'MORALES', 'RAMIREZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (121, '19194455', 'MANUEL', '1', '085', '005', 'V', '96480RBMJ', '005', 'AUXILIARES', 'JOSE', 'RIVEROS', 'BAQUERO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (122, '41342149', 'MARIA', '1', '085', '005', 'V', '44174RBMD', '005', 'AUXILIARES', 'DEL ROSARIO', 'RIVEROS', 'BAQUERO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (123, '51556311', 'MARIA', '1', '085', '005', 'V', '58336MTMN', '005', 'AUXILIARES', 'NANCY', 'MEDINA', 'TORRES', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (124, '1022938169', 'FRANCISCO', '1', '115', '000', 'E', '40194GOF', '000', 'NO DEFINIDO', '', 'GARZON', 'OLIVOS', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (548, '12275158', 'DOUMER', '1', '104', '001', 'A', '77183PMDF', '001', 'OPERATIVOS PRODUCCION AGRICOLA', 'FELIPE', 'PAZ', 'MAJIN', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (549, '4061108', 'PEDRO', '1', '062', '001', 'E', '63133AP', '001', 'NO DEFINIDO', '', 'ALFONSO', '', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (550, '4060414', 'IGNACIO', '1', '062', '001', 'E', '62439SGI', '001', 'NO DEFINIDO', '', 'SILVA', 'GONZALEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (551, '1121857022', 'EDWIN', '1', '062', '001', 'E', '59047BAEO', '001', 'NO DEFINIDO', 'ORLANDO', 'BEJARANO', 'ARENAS', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (552, '17266716', 'JOSE', '1', '104', '001', 'A', '68741TGJA', '001', 'OPERATIVOS PRODUCCION AGRICOLA', 'ARIEL', 'TAPIA', 'GUZMAN', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (553, '1070706178', 'ALEXANDER', '1', '061', '000', 'E', '8203GA', '000', 'NO DEFINIDO', '', 'GOMEZ', '', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (554, '1120369982', 'EDGAR', '1', '062', '000', 'E', '72007DCE', '000', 'NO DEFINIDO', '', 'DIAZ', 'CORREA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (555, '1123116268', 'OSCAR', '1', '029', '001', 'E', '18293MBOF', '001', 'OPERATIVOS PRODUCCION AGRICOLA', 'FABIAN', 'MEDINA', 'BONILLA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (556, '1121853351', 'LUIS', '1', '031', '000', 'E', '55376DGLE', '000', 'OPERATIVOS PLANTA EXT', 'EDUARDO', 'DIAZ', 'GUTIERREZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (557, '1111817716', 'JHON', '1', '104', '001', 'E', '19741DMJF', '001', 'OPERATIVOS PRODUCCION AGRICOLA', 'FREDY', 'DAVID', 'MUÑOZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (558, '17416718', 'FERNANDO', '1', '062', '000', 'X', '18743RMF', '000', 'NO DEFINIDO', '', 'RODRIGUEZ', 'MENDOZA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (559, '1102801231', 'RUBIELA', '1', '060', '000', 'E', '3256ABRM', '000', 'NO DEFINIDO', 'MARIA', 'ARIAS', 'BENITEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (560, '1065125274', 'JORGE', '1', '062', '000', 'E', '27299TCJL', '000', 'NO DEFINIDO', 'LUIS', 'TATIS', 'CUJIA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (561, '17633961', 'ORLANDO', '1', '104', '001', 'E', '35986RAO', '001', 'OPERATIVOS PRODUCCION AGRICOLA', '', 'RAMIREZ', 'AMAYA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (566, '4655193', 'RESULIO', '1', '063', '000', 'E', '57218BAR', '000', 'NO DEFINIDO', '', 'BANGUERO', 'ARARAT', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (877, '1122125418', 'JOHN', '3', '058', '000', 'E', '27443RCJJ', '000', 'OPERATIVOS PLANTA EXT', 'JAIRO', 'RUIZ', 'COCA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (878, '1123114111', 'WUILMER', '3', '058', '000', 'E', '16136HGWA', '000', 'OPERATIVOS PLANTA EXT', 'ARTURO', 'HUESO', 'GALINDO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (879, '7696144', 'RODOLFO', '3', '058', '000', 'X', '98169MHR', '000', 'OPERATIVOS PLANTA EXT', '', 'MENZA', 'HERNANDEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (562, '1134204078', 'MARYURIS', '1', '060', '000', 'E', '6103SMMT', '000', 'NO DEFINIDO', 'TATIANA', 'SANCHEZ', 'MORENO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (563, '10553425', 'CARLOS', '1', '062', '000', 'E', '55450PCM', '000', 'NO DEFINIDO', 'MARINO', 'PARRA', '', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (564, '5653664', 'CRISANTO', '1', '062', '001', 'E', '55689GBC', '001', 'NO DEFINIDO', '', 'GOMEZ', 'BENAVIDES', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (565, '40428558', 'BLANCA', '1', '060', '000', 'E', '30583HBN', '000', 'NO DEFINIDO', 'NIDIA', 'HEREDIA', '', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (880, '1121946894', 'MICHELL', '3', '021', '000', 'E', '48919RRMN', '000', 'NO DEFINIDO', 'NICOLAS', 'RIVEROS', 'RAMIREZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (881, '1120499797', 'EDWIN', '3', '058', '000', 'E', '101822RMER', '000', 'OPERATIVOS PLANTA EXT', 'RICARDO', 'RONCANCIO', 'MOSQUERA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (21, '1122117522', 'LINA', '1', '016', '000', 'E', '19547UCLM', '000', 'NO DEFINIDO', 'MARIA', 'ULLOA', 'CASAS', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (22, '1122128629', 'INGRID', '1', '015', '000', 'E', '30654CGIL', '000', 'NO DEFINIDO', 'LORENA', 'CHAVARRO', 'GOMEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (40, '1120365130', 'ANA', '1', '021', '005', 'E', '67155MMAC', '005', 'NO DEFINIDO', 'CECILIA', 'MORENO', 'MUÑOZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (41, '1014200495', 'PEDRO', '1', '105', '005', 'E', '2520SFPF', '005', 'COORDINADORES', 'FELIPE', 'SUAREZ', 'FLOREZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (42, '1023913922', 'MONICA', '1', '106', '005', 'E', '15947MVMY', '005', 'NO DEFINIDO', 'YISEL', 'MORALES', 'VACA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (43, '1090425325', 'JUAN', '1', '085', '005', 'E', '27350QBJA', '005', 'AUXILIARES', 'ANDRES', 'QUINTERO', 'BUENO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (44, '32794021', 'JACIBE', '1', '008', '005', 'E', '96046CPJP', '005', 'NO DEFINIDO', 'PATRICIA', 'CARO', 'PALOMINO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (45, '1120365174', 'JIMMY', '1', '084', '005', 'E', '67199RSJA', '005', 'NO DEFINIDO', 'ALEXANDER', 'RIVERA', 'SANCHEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (46, '1123513867', 'DANIELA', '1', '021', '005', 'E', '15892PMD', '005', 'NO DEFINIDO', '', 'PEREZ', 'MONTOYA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (47, '17421972', 'JORGE', '1', '107', '005', 'E', '23997TLJE', '005', 'NO DEFINIDO', 'ENRIQUE', 'TRUJILLO', 'LOPEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (49, '1120365130', 'ANA', '1', '013', '005', 'E', '67155MMAC', '005', 'AUXILIARES', 'CECILIA', 'MORENO', 'MUÑOZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (50, '1122138131', 'ERICKA', '1', '021', '999', 'E', '40156MLEM', '999', 'NO DEFINIDO', 'MILENA', 'MEDINA', 'LOPEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (51, '1121927870', 'DANA', '1', '108', '005', 'E', '29895PRDY', '005', 'NO DEFINIDO', 'YISETH', 'PINZON', 'RODRÍGUEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (52, '1115916783', 'JHOJAN', '1', '107', '005', 'X', '18808SLJA', '005', 'NO DEFINIDO', 'ALEJANDRO', 'SUAREZ', 'LOSADA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (53, '1121825954', 'VICTOR', '1', '016', '005', 'E', '27979ELVA', '005', 'NO DEFINIDO', 'ALFONSO', 'ESPINOSA', 'LOZANO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (54, '73166607', 'LUIS', '1', '008', '005', 'E', '68632BVLC', '005', 'NO DEFINIDO', 'CARLOS', 'BUSTOS', 'VERGARA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (55, '1123114432', 'DERLYS', '1', '085', '005', 'E', '16457UCDA', '005', 'AUXILIARES', 'ADELIA', 'USECHE', 'CASTAÑEDA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (94, '1123115885', 'MARIA', '1', '096', '005', 'E', '17910TOMC', '005', 'NO DEFINIDO', 'CAROLINA', 'TIBAQUIRA', 'OLARTE', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (569, '1064707880', 'VICTOR', '1', '079', '000', 'E', '9905NNVM', '000', 'NO DEFINIDO', 'MANUEL', 'NAVARRO', 'NAVARRO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (570, '93206317', 'FREDY', '1', '063', '000', 'E', '8342GAF', '000', 'NO DEFINIDO', '', 'GARCIA', 'ARIAS', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (571, '71949049', 'WILLINTON', '1', '079', '000', 'E', '51074MRW', '000', 'NO DEFINIDO', '', 'MORENO', 'RIVAS', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (572, '7837901', 'JOSE', '1', '062', '000', 'E', '39926LJA', '000', 'NO DEFINIDO', 'ALBERTO', 'LUGO', '', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (583, '1036222353', 'LUIS', '1', '062', '001', 'E', '24378JVLA', '001', 'NO DEFINIDO', 'ANTONIO', 'JARAMILLO', 'VILLEGAS', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (584, '5075470', 'ASDRUBAL', '1', '062', '000', 'E', '77495MGAR', '000', 'NO DEFINIDO', 'RAFAEL', 'MELENDEZ', 'GARCIA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (573, '1123560761', 'BRAYAN', '1', '062', '000', 'E', '62786ABS', '000', 'NO DEFINIDO', 'STIVEN', 'AGUILAR', '', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (574, '19619148', 'JONIER', '1', '062', '000', 'E', '21173BPJE', '000', 'NO DEFINIDO', 'ENRIQUE', 'BERRIO', 'PORRAS', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (576, '1057783604', 'ISLEN', '1', '062', '000', 'E', '85629CGI', '000', 'NO DEFINIDO', '', 'CASTAÑO', 'GALLO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (577, '40431352', 'NELCY', '1', '060', '000', 'E', '33377SN', '000', 'NO DEFINIDO', '', 'SIERRA', '', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (585, '74852977', 'WILSON', '1', '062', '001', 'E', '55002CCWJ', '001', 'NO DEFINIDO', 'JAIR', 'COMAYAN', 'CETINA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (586, '74270794', 'JAIME', '1', '062', '001', 'E', '72819RBJ', '001', 'NO DEFINIDO', '', 'RINCON', 'BERDUGO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (587, '1118167546', 'JEISON', '1', '104', '001', 'A', '69571BBJA', '001', 'OPERATIVOS PRODUCCION AGRICOLA', 'ALEJANDRO', 'BEJARANO', 'BOTIA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (588, '17417534', 'WILSON', '1', '062', '001', 'E', '19559PMWE', '001', 'NO DEFINIDO', 'ENRIQUE', 'PALOMINO', 'MORA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (589, '1104129413', 'LUIS', '1', '062', '001', 'E', '31438VOLE', '001', 'NO DEFINIDO', 'EDUARDO', 'VANEGAS', 'OLIVERO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (590, '17414770', 'GERARDO', '1', '062', '001', 'E', '16795RRG', '001', 'NO DEFINIDO', '', 'ROJAS', 'ROJAS', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (591, '91325367', 'DADVISON', '1', '062', '001', 'E', '27392FCDM', '001', 'NO DEFINIDO', 'MANUEL', 'FLOREZ', 'CARDENAS', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (592, '17416245', 'FRANCISCO', '1', '062', '001', 'E', '18270BRF', '001', 'NO DEFINIDO', '', 'BRICEÑO', 'ROJAS', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (593, '17418415', 'WILSON', '1', '062', '001', 'E', '20440PCW', '001', 'NO DEFINIDO', '', 'PACHON', 'CRUZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (595, '1122121853', 'JOSE', '1', '062', '001', 'E', '23878RMJY', '001', 'NO DEFINIDO', 'YELNER', 'RICO', 'MACHADO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (596, '1120871067', 'BAIRON', '1', '079', '001', 'E', '73092GABJ', '001', 'NO DEFINIDO', 'JAVIER', 'GARCIA', 'AGUIRRE', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (597, '94502808', 'JIMY', '1', '062', '001', 'E', '4833AJ', '001', 'NO DEFINIDO', '', 'ABONIA', '', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (710, '1084735140', 'ELICIO', '1', '104', '001', 'A', '37165VCEJ', '001', 'OPERATIVOS PRODUCCION AGRICOLA', 'JAVIER', 'VALDES', 'CABARCAS', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (785, '1121868646', 'RONAL', '3', '031', '000', 'E', '70671HMRD', '000', 'OPERATIVOS PLANTA EXT', 'DE JESUS', 'HERNANDEZ', 'MORALES', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (869, '94558598', 'JHON', '3', '058', '000', 'E', '60623FMJF', '000', 'OPERATIVOS PLANTA EXT', 'FREDDY', 'FERNANDEZ', 'MAZUERA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1180, '1006692984', 'JUAN', '3', '058', '999', 'E', '95009AMJC', '999', 'OPERATIVOS PLANTA EXT', 'CAMILO', 'AMAYA', 'MORA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1181, '1006718229', 'ROBERT', '3', '058', '999', 'E', '20254MPRM', '999', 'OPERATIVOS PLANTA EXT', 'MAURICIO', 'MANCHAY', 'PARRA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (126, '1119891079', 'DORA', '1', '094', '002', 'E', '93104MLDC', '002', 'NO DEFINIDO', 'CECILIA', 'MARTINEZ', 'LERMA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (127, '1006797944', 'YIRSLY', '1', '096', '001', 'E', '99969FAYD', '001', 'NO DEFINIDO', 'DAHANA', 'FONTECHA', 'ANDRADE', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (128, '2251824', 'ALFREDO', '1', '029', '008', 'A', '53849PMA', '008', 'OPERATIVOS PRODUCCION AGRICOLA', '', 'PEÑALOZA', 'MORALES', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (129, '4272250', 'ISIDRO', '1', '031', '003', 'E', '74275PCI', '003', 'OPERATIVOS PLANTA EXT', '', 'PARRA', 'CARO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (130, '7837479', 'FLAMINIO', '1', '022', '002', 'E', '39504FRF', '002', 'NO DEFINIDO', '', 'FANDIÑO', 'ROJAS', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (131, '7837907', 'FERNANDO', '1', '091', '001', 'A', '39932CPFJ', '001', 'COORDINADORES', 'JAVIER', 'CRUZ', 'PAREDES', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (145, '17410470', 'NESTOR', '1', '032', '001', 'E', '12495RMN', '001', 'NO DEFINIDO', '', 'ROJAS', 'MANTALLANA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (146, '17410777', 'DOMINGO', '1', '024', '003', 'E', '12802OD', '003', 'CONDUCTORES', '', 'ORTIZ', '', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (144, '17332327', 'DAVID', '1', '032', '000', 'X', '34352MRD', '000', 'NO DEFINIDO', '', 'MONTILLA', 'REYES', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (147, '17412481', 'MANUEL', '1', '095', '017', 'A', '14506DRMA', '017', 'OPERATIVOS PRODUCCION AGRICOLA', 'ANTONIO', 'DIAZ', 'RAMIREZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (148, '17413391', 'RIGOBERTO', '1', '030', '001', 'A', '15416PSR', '001', 'AUXILIARES OPERATIVOS', '', 'PIZA', 'SAAVEDRA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (149, '17416669', 'HUMBERTO', '1', '031', '000', 'E', '18694SGH', '000', 'OPERATIVOS PLANTA EXT', '', 'SANABRIA', 'GARCIA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (150, '17417930', 'GERMAN', '1', '030', '001', 'A', '19955BGG', '001', 'AUXILIARES OPERATIVOS', 'GUSTAVO', 'BARRETO', '', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (151, '17420986', 'ARTURO', '1', '030', '000', 'E', '23011LA', '000', 'AUXILIARES OPERATIVOS', '', 'LONDOÑO', '', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (341, '1123114715', 'MARTHA', '1', '073', '000', 'E', '16740FCMP', '000', 'OPERATIVOS PRODUCCION AGRICOLA', 'PATRICIA', 'FUENTES', 'CETINA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (484, '1122128356', 'YEISON', '1', '029', '008', 'A', '30381ACYJ', '008', 'OPERATIVOS PRODUCCION AGRICOLA', 'JAIR', 'ARDILA', 'CASTILLO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (567, '87949315', 'DEITON', '1', '062', '000', 'E', '51340CQDJ', '000', 'NO DEFINIDO', 'JAVIER', 'CASTILLO', 'QUIÑONES', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (568, '1087116564', 'DILSON', '1', '063', '000', 'E', '18589TMDA', '000', 'NO DEFINIDO', 'ALBERTO', 'TORRES', 'MONTAÑO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (578, '16266489', 'PAULO', '1', '079', '001', 'E', '68514MIPA', '001', 'NO DEFINIDO', 'ANTONIO', 'MORENO', 'IBARGUEN', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (579, '1122125882', 'FRANK', '1', '062', '000', 'E', '27907VBFD', '000', 'NO DEFINIDO', 'DIDIER', 'VIVEROS', 'BONILLA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (580, '86088893', 'FABIAN', '1', '062', '000', 'E', '90918RAFR', '000', 'NO DEFINIDO', 'RENET', 'RINCON', 'ARDILA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (581, '1007147555', 'YEFERSON', '1', '061', '000', 'E', '49580GY', '000', 'NO DEFINIDO', '', 'GOMEZ', '', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (582, '1040763812', 'SAMIR', '1', '061', '000', 'E', '65837PFSM', '000', 'NO DEFINIDO', 'MANUEL', 'PICO', 'FERNANDEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (653, '1085106163', 'ALIX', '1', '104', '001', 'E', '8188OCAJ', '001', 'OPERATIVOS PRODUCCION AGRICOLA', 'JOSE', 'OROZCO', 'CARRILLO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (645, '1128189335', 'EVER', '1', '062', '001', 'A', '91360MREA', '001', 'NO DEFINIDO', 'ANTONIO', 'MEJIA', 'REYES', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (600, '1003100571', 'JOSE', '1', '062', '001', 'E', '2596MFJO', '001', 'NO DEFINIDO', 'OSVADIS', 'MARTINEZ', 'FAJARDO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (601, '17420447', 'ALEXANDER', '1', '062', '001', 'E', '22472RBA', '001', 'NO DEFINIDO', '', 'RODRIGUEZ', 'BARRERO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (602, '1122128102', 'JOHATHAN', '1', '062', '001', 'E', '30127LAJ', '001', 'NO DEFINIDO', '', 'LONGA', 'ASPRILLA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (603, '86071038', 'LUIS', '1', '062', '001', 'E', '73063CALH', '001', 'NO DEFINIDO', 'HERNANDO', 'CARDONA', 'ACOSTA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (604, '1045234938', 'LUIS', '1', '062', '001', 'E', '36963GPLF', '001', 'NO DEFINIDO', 'FERNANDO', 'GONZALEZ', 'PEREZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (605, '1123115161', 'FABIAN', '1', '104', '001', 'E', '17186PRF', '001', 'OPERATIVOS PRODUCCION AGRICOLA', '', 'PINEDA', 'RODRIGUEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (606, '1123114855', 'JHON', '1', '104', '001', 'E', '16880JCJE', '001', 'OPERATIVOS PRODUCCION AGRICOLA', 'ESTEBAN', 'JIMENEZ', 'CHAVEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (607, '1120576318', 'JEFFERSON', '1', '104', '001', 'E', '78343NAJA', '001', 'OPERATIVOS PRODUCCION AGRICOLA', 'ANDREY', 'NIÑO', 'AGUIRRE', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (608, '9737074', 'RAUL', '1', '104', '001', 'E', '39099ZPR', '001', 'OPERATIVOS PRODUCCION AGRICOLA', '', 'ZARAZA', 'PEÑA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (609, '1081799860', 'EVER', '1', '104', '001', 'E', '101885AFEL', '001', 'OPERATIVOS PRODUCCION AGRICOLA', 'LUIS', 'ARIAS', 'FIGUEROA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (610, '85261777', 'MILTON', '1', '104', '001', 'A', '63802GJMJ', '001', 'OPERATIVOS PRODUCCION AGRICOLA', 'JULIO', 'GONZALEZ', 'JULIO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (612, '1098100388', 'EDWAR', '1', '062', '001', 'E', '2413BSEM', '001', 'NO DEFINIDO', 'MAURICIO', 'BERMUDEZ', 'SILVA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (613, '71195504', 'YEISON', '1', '062', '001', 'E', '97529LLYE', '001', 'NO DEFINIDO', 'ESTID', 'LOPEZ', 'LOPEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (614, '1120384087', 'NELSON', '1', '104', '001', 'E', '86112GAND', '001', 'OPERATIVOS PRODUCCION AGRICOLA', 'DAVID', 'GUTIERREZ', 'ARTEAGA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (615, '74348139', 'FRANCISCO', '1', '062', '001', 'E', '50164CNF', '001', 'NO DEFINIDO', '', 'CASTRO', 'NIÑO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (616, '17420170', 'KIRK', '1', '062', '001', 'E', '22195GHKA', '001', 'NO DEFINIDO', 'ALAIN', 'GOMEZ', 'HERNANDEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (617, '19621155', 'JAVIER', '1', '062', '001', 'E', '23180GFJF', '001', 'NO DEFINIDO', 'FRANCISCO', 'GUTIERREZ', 'FONTALVO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (618, '7121398', 'JHON', '1', '062', '001', 'E', '23423GRJF', '001', 'NO DEFINIDO', 'FREDY', 'GANTIVA', 'RODRÍGUEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (619, '17420931', 'PEDRO', '1', '062', '001', 'E', '22956RSPJ', '001', 'NO DEFINIDO', 'JESUS', 'RUIZ', 'SOTO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (620, '72054749', 'YAMITH', '1', '062', '001', 'E', '56774CVY', '001', 'NO DEFINIDO', '', 'CHACON', 'VERGEL', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (622, '7062566', 'RODRIGO', '1', '062', '001', 'E', '64591MAR', '001', 'NO DEFINIDO', '', 'MECHE', 'ADAN', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (623, '1122116853', 'ANDRES', '1', '062', '001', 'E', '18878ZMA', '001', 'NO DEFINIDO', '', 'ZARTA', 'MONCALEANO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (624, '17419798', 'ALEXANDER', '1', '104', '001', 'E', '21823ZMA', '001', 'OPERATIVOS PRODUCCION AGRICOLA', '', 'ZARTA', 'MONCALEANO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (625, '1069582221', 'HAROLD', '1', '104', '001', 'E', '84246PCHS', '001', 'OPERATIVOS PRODUCCION AGRICOLA', 'STEVEN', 'PULIDO', 'CARRILLO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (626, '1117323747', 'FAUSTO', '1', '104', '001', 'E', '25772BRFA', '001', 'OPERATIVOS PRODUCCION AGRICOLA', 'ALEXIS', 'BETANCOURTH', 'RIVAS', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (627, '17423182', 'LUIS', '1', '062', '001', 'E', '25207GRLE', '001', 'NO DEFINIDO', 'ERNESTO', 'GUSMAN', 'RESTREPO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (628, '98196303', 'LUIS', '1', '062', '001', 'E', '98328QVLA', '001', 'NO DEFINIDO', 'ALEXANDER', 'QUENGUAN', 'VASQUEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (629, '5075470', 'ASDRUBAL', '1', '104', '001', 'E', '77495MGAR', '001', 'OPERATIVOS PRODUCCION AGRICOLA', 'RAFAEL', 'MELENDEZ', 'GARCIA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (630, '1106399541', 'LUIS', '1', '104', '001', 'E', '101566DRLA', '001', 'OPERATIVOS PRODUCCION AGRICOLA', 'ANGEL', 'DIAZ', 'RICO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (631, '1006776869', 'JULIO', '1', '062', '001', 'E', '78894BCJA', '001', 'NO DEFINIDO', 'ALBERTO', 'BARON', 'CARREÑO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (632, '17422623', 'DUMAR', '1', '104', '001', 'E', '24648NRDA', '001', 'OPERATIVOS PRODUCCION AGRICOLA', 'ALBERTO', 'NIÑO', 'RODRIGUEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (633, '1122139434', 'MARLON', '1', '104', '001', 'E', '41459MAMD', '001', 'OPERATIVOS PRODUCCION AGRICOLA', 'DUVAN', 'MORALES', 'ARBOLEDA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (634, '1123115566', 'DUVAN', '1', '104', '001', 'E', '17591CIDF', '001', 'OPERATIVOS PRODUCCION AGRICOLA', 'FELIPE', 'CARRILLO', 'IZQUIERDO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (635, '1116207904', 'CRISTIAN', '1', '104', '001', 'E', '9929RCCC', '001', 'OPERATIVOS PRODUCCION AGRICOLA', 'CAMILO', 'ROJAS', 'CUELLAR', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (636, '87948648', 'FRANCISCO', '1', '062', '001', 'E', '50673TFM', '001', 'NO DEFINIDO', 'MARINO', 'TORRES', '', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (637, '1125184551', 'JHONATAN', '1', '104', '001', 'E', '86576MCJS', '001', 'OPERATIVOS PRODUCCION AGRICOLA', 'STIVEN', 'MARTINEZ', 'COBALERA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (638, '16892752', 'ROSENDO', '1', '062', '001', 'E', '94777OR', '001', 'NO DEFINIDO', '', 'OCORO', '', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (639, '1050398058', 'CESAR', '1', '062', '001', 'E', '100083RBCA', '001', 'NO DEFINIDO', 'AGUSTO', 'RIZO', 'BENAVIDES', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (640, '1123116498', 'JOSE', '1', '104', '001', 'E', '18523GRJD', '001', 'OPERATIVOS PRODUCCION AGRICOLA', 'DAVID', 'GARCIA', 'RODRIGUEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (641, '1069900257', 'YEISON', '1', '104', '001', 'E', '2282CBY', '001', 'OPERATIVOS PRODUCCION AGRICOLA', '', 'CHALA', 'BEJARANO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (642, '1123114392', 'LUIS', '1', '104', '001', 'E', '16417ORLG', '001', 'OPERATIVOS PRODUCCION AGRICOLA', 'GUILLERMO', 'ORTEGA', 'RUIZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (594, '14699484', 'FELIX', '1', '062', '001', 'E', '101509ACFE', '001', 'NO DEFINIDO', 'ESTEBAN', 'ASPRILLA', 'CACERES', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (598, '17421577', 'JOSE', '1', '062', '001', 'E', '23602AUJR', '001', 'NO DEFINIDO', 'ROBINSON', 'ASPRILLA', 'URRUTIA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (599, '17418393', 'OSCAR', '1', '062', '001', 'E', '20418LAO', '001', 'NO DEFINIDO', '', 'LARA', 'AGUDELO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (647, '40732923', 'LUCELIDA', '1', '104', '001', 'E', '34948FL', '001', 'OPERATIVOS PRODUCCION AGRICOLA', '', 'FAJARDO', '', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (649, '1075211887', 'WILMER', '1', '104', '001', 'E', '13912SGW', '001', 'OPERATIVOS PRODUCCION AGRICOLA', '', 'SANCENO', 'GARCIA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (882, '1120357282', 'RAMIRO', '3', '058', '000', 'E', '59307SPRA', '000', 'OPERATIVOS PLANTA EXT', 'ANDRES', 'SAAVEDRA', 'PENAGOS', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (883, '1122137437', 'JEAN', '3', '031', '000', 'E', '39462GPJC', '000', 'OPERATIVOS PLANTA EXT', 'CARLOS', 'GUTIERREZ', 'PEREZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (884, '86010023', 'WILSON', '3', '058', '000', 'E', '12048MWH', '000', 'OPERATIVOS PLANTA EXT', 'HERNANDO', 'MEDINA', '', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (650, '19620729', 'ANDRES', '1', '104', '001', 'E', '22754SSAM', '001', 'OPERATIVOS PRODUCCION AGRICOLA', 'MANUEL', 'SILVA', 'SLVERA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (651, '17704280', 'BENJAMIN', '1', '104', '001', 'E', '6305CCB', '001', 'OPERATIVOS PRODUCCION AGRICOLA', '', 'COBALEDA', 'CARVAJAL', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (652, '1007720148', 'JORGE', '1', '104', '001', 'E', '22173COJI', '001', 'OPERATIVOS PRODUCCION AGRICOLA', 'IVAN', 'CASTAÑEDA', 'ORTIZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (885, '1122647233', 'JHON', '3', '058', '000', 'X', '49258OLJJ', '000', 'OPERATIVOS PLANTA EXT', 'JORGE', 'OCORO', 'LEON', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (886, '1072026492', 'JONHON', '3', '058', '000', 'E', '28517BRJF', '000', 'OPERATIVOS PLANTA EXT', 'FREDY', 'BOJACA', 'RODRIGUEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (887, '86085548', 'JUAN', '3', '058', '000', 'E', '87573CLJC', '000', 'OPERATIVOS PLANTA EXT', 'CARLOS AUGUSTO', 'CASADIEGO', 'LEON', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (888, '1116545528', 'JORGE', '3', '058', '000', 'E', '47553GCJA', '000', 'OPERATIVOS PLANTA EXT', 'ALBERTO', 'GALVIS', 'CEIJA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (889, '7837896', 'LUIS', '3', '052', '000', 'E', '39921GELA', '000', 'AUXILIARES OPERATIVOS', 'ANGEL', 'GUAYARA', 'ESQUIVEL', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (890, '1122123916', 'MIGUEL', '3', '058', '000', 'E', '25941CUME', '000', 'OPERATIVOS PLANTA EXT', 'ENRIQUE', 'CUBILLOS', 'UMAÑA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (643, '17419959', 'ALFREDO', '1', '104', '001', 'E', '21984GMAA', '001', 'OPERATIVOS PRODUCCION AGRICOLA', 'ALFONSO', 'GARCIA', 'MORA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (644, '17417921', 'JAIRO', '1', '062', '001', 'E', '19946EFJH', '001', 'NO DEFINIDO', 'HUMBERTO', 'ESTEPA', 'FORERO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (894, '1121939006', 'DIDI', '3', '021', '999', 'E', '41031VSDS', '999', 'NO DEFINIDO', 'STEFANIA', 'VILLAMIL', 'SERNA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (895, '1121950237', 'KAREN', '3', '021', '000', 'E', '52262VHKD', '000', 'NO DEFINIDO', 'DAYANA', 'VILLAMARIN', 'HERRERA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (896, '1120374571', 'ZULLY', '3', '021', '000', 'E', '76596FVZM', '000', 'NO DEFINIDO', 'MILEIDY', 'FORERO', 'VERA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (897, '1121850922', 'DILMAR', '3', '058', '999', 'E', '52947MLD', '999', 'OPERATIVOS PLANTA EXT', '', 'MALAGON', 'LEYVA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (898, '1006777437', 'SEBASTIAN', '3', '058', '999', 'E', '79462CBS', '999', 'OPERATIVOS PLANTA EXT', '', 'CAÑON', 'BARRETO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (899, '1033739135', 'PEDRO', '3', '058', '999', 'E', '41160MGP', '999', 'OPERATIVOS PLANTA EXT', '', 'MONGE', 'GALINDO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (900, '1123115843', 'JEHU', '3', '058', '999', 'E', '17868RQJD', '999', 'OPERATIVOS PLANTA EXT', 'DANIEL', 'ROCHA', 'QUINTERO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (901, '6024515', 'LUIS', '3', '140', '999', 'E', '26540UDLE', '999', 'OPERATIVOS ADMINISTRATIVOS', 'ERNESTO', 'URUEÑA', 'DIAZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (902, '16463589', 'JOSE', '3', '058', '999', 'E', '65614CJA', '999', 'OPERATIVOS PLANTA EXT', 'ANDRES', 'CHILITO', '', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (903, '1121834337', 'OSCAR', '3', '118', '003', 'A', '36362MOI', '003', 'OPERATIVOS MANTENIMIENTO', 'IVAN', 'MORA', '', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (904, '1123115759', 'EDDY', '3', '058', '999', 'E', '17784PCED', '999', 'OPERATIVOS PLANTA EXT', 'DAYAN', 'PARRA', 'CALLEJAS', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (905, '1122654519', 'OSCAR', '3', '058', '999', 'E', '56544RPOA', '999', 'OPERATIVOS PLANTA EXT', 'ANDRES', 'ROZO', 'PRADA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (906, '1122138071', 'JESUS', '3', '058', '999', 'E', '40096CBJD', '999', 'OPERATIVOS PLANTA EXT', 'DAVID', 'CONTRERAS', 'BOLIVAR', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (907, '1123116025', 'BRAYAN', '3', '058', '999', 'E', '18050NABS', '999', 'OPERATIVOS PLANTA EXT', 'STIK', 'NIÑO', 'AGUIRRE', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (908, '1075256351', 'JOHAN', '3', '058', '999', 'X', '58376SCJS', '999', 'OPERATIVOS PLANTA EXT', 'SEBASTIAN', 'SANCHEZ', 'CORDOBA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (909, '1122116471', 'CRISTIAN', '3', '058', '999', 'E', '18496MQCJ', '999', 'OPERATIVOS PLANTA EXT', 'JULIAN', 'MELO', 'QUITIAN', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (910, '17423188', 'JULIO', '3', '058', '999', 'E', '25213MAJC', '999', 'OPERATIVOS PLANTA EXT', 'CESAR', 'MUÑOZ', 'ACHURE', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (911, '1123115377', 'OBER', '3', '058', '999', 'E', '17402MBO', '999', 'OPERATIVOS PLANTA EXT', '', 'MELO', 'BAEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (912, '1122129464', 'WILMAR', '3', '058', '999', 'E', '31489VVWY', '999', 'OPERATIVOS PLANTA EXT', 'YESID', 'VELASCO', 'VERANO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (913, '86088570', 'LUIS', '3', '058', '999', 'E', '90595PFLA', '999', 'OPERATIVOS PLANTA EXT', 'ANGEL', 'POBLADOR', 'FORERO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (914, '1006863728', 'JUAN', '3', '021', '999', 'E', '65753IBJD', '999', 'NO DEFINIDO', 'DAVID', 'ISAZA', 'BARON', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (915, '1023954642', 'ANA', '3', '021', '999', 'E', '56667ROAP', '999', 'NO DEFINIDO', 'PAOLA', 'RUIZ', 'OCHOA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (916, '1123114978', 'JAIVER', '3', '058', '999', 'E', '17003RRJE', '999', 'OPERATIVOS PLANTA EXT', 'ESTIVEN', 'RAMIREZ', 'RUIZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (917, '1082805844', 'JHON', '3', '058', '999', 'E', '7869RPJH', '999', 'OPERATIVOS PLANTA EXT', 'HAROL', 'RODRIGUEZ', 'PEÑA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (919, '1121960967', 'JHOAN', '3', '058', '999', 'E', '62992VRJS', '999', 'OPERATIVOS PLANTA EXT', 'SEBASTIAN', 'VARGAS', 'RAMIREZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (920, '1023954642', 'ANA', '3', '027', '999', 'E', '56667ROAP', '999', 'ASISTENTES', 'PAOLA', 'RUIZ', 'OCHOA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (921, '1121936437', 'MILSON', '3', '021', '999', 'E', '38462ARMA', '999', 'NO DEFINIDO', 'ARLEY', 'AVILA', 'RINCON', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (922, '1022940191', 'LUIS', '3', '098', '000', 'E', '42216MMLA', '000', 'NO DEFINIDO', 'ANDRES', 'MORENO', 'MONTAÑA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (923, '1120364757', 'WILLIAM', '3', '058', '999', 'E', '66782OBWA', '999', 'OPERATIVOS PLANTA EXT', 'ALEXANDER', 'OSORIO', 'BONILLA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (924, '93298782', 'RUBEN', '3', '058', '999', 'E', '100807LFR', '999', 'OPERATIVOS PLANTA EXT', '', 'LUIS', 'FERNANDEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (925, '1123115267', 'ARNOLD', '3', '058', '999', 'E', '17292OPAS', '999', 'OPERATIVOS PLANTA EXT', 'STIVEN', 'ORTIZ', 'PEÑA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (926, '1121905221', 'ALEXANDRA', '3', '065', '999', 'E', '7246RUA', '999', 'NO DEFINIDO', '', 'RUIZ', 'ULLOA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (927, '17267915', 'ALEXANDER', '3', '098', '000', 'E', '69940OAA', '000', 'NO DEFINIDO', '', 'ORJUELA', 'ACUÑA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (928, '1121964572', 'JHON', '3', '021', '000', 'E', '66597ROJS', '000', 'NO DEFINIDO', 'SEBASTIAN', 'RUIZ', 'ORTIZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (929, '74849566', 'NELSON', '3', '058', '999', 'E', '51591PNM', '999', 'OPERATIVOS PLANTA EXT', 'MAURICIO', 'PARALES', '', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (930, '1006778581', 'CRISTIAN', '3', '058', '999', 'E', '80606ARCJ', '999', 'OPERATIVOS PLANTA EXT', 'JULIAN', 'ARANGO', 'ROJAS', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (931, '1123115349', 'MIGUEL', '3', '058', '999', 'E', '17374MLMA', '999', 'OPERATIVOS PLANTA EXT', 'ANGEL', 'MAHECHA', 'LUNA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (932, '1123116017', 'CRISTIAN', '3', '058', '999', 'E', '18042SCCA', '999', 'OPERATIVOS PLANTA EXT', 'ALEXANDER', 'SEPULVEDA', 'CORDOBA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (933, '16435722', 'FREDY', '3', '058', '999', 'E', '37747CRF', '999', 'OPERATIVOS PLANTA EXT', '', 'CARDONA', 'RAMIREZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (934, '1122126143', 'VICKY', '3', '100', '999', 'E', '28168RPVJ', '999', 'ASISTENTES', 'JULIETH', 'RODRÍGUEZ', 'PIRABAN', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (935, '1116805369', 'ARLEX', '3', '021', '999', 'E', '7394DAA', '999', 'NO DEFINIDO', '', 'DIAZ', 'ACEVEDO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (936, '1121826424', 'WALTER', '3', '055', '016', 'A', '28449VAWR', '016', 'OPERATIVOS PLANTA EXT', 'ROLANDO', 'VELASQUEZ', 'ALEJO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (937, '1122137652', 'JAILER', '3', '058', '999', 'E', '39677BAJG', '999', 'OPERATIVOS PLANTA EXT', 'GIOVANNY', 'BOLAÑOS', 'ARANGO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (938, '1122511166', 'ROBISON', '3', '058', '999', 'E', '13191ARR', '999', 'OPERATIVOS PLANTA EXT', '', 'ARANGO', 'ROJAS', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (939, '1122678457', 'RAFAEL', '3', '058', '999', 'E', '80482ACRE', '999', 'OPERATIVOS PLANTA EXT', 'ENRIQUE', 'ARDILA', 'CUIZA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (940, '1144201812', 'JUAN', '3', '058', '999', 'E', '3837PQJS', '999', 'OPERATIVOS PLANTA EXT', 'SEBASTIAN', 'PULGARIN', 'QUINTERO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (941, '1123115837', 'OSCAR', '3', '058', '999', 'E', '17862GGOF', '999', 'OPERATIVOS PLANTA EXT', 'FERNANDO', 'GARCIA', 'GOMEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (942, '1006779872', 'ALBERNEPER', '3', '058', '999', 'E', '81897AQA', '999', 'OPERATIVOS PLANTA EXT', '', 'ARDILA', 'QUINTERO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (943, '1123115909', 'MAYCOL', '3', '058', '999', 'E', '17934CAMJ', '999', 'OPERATIVOS PLANTA EXT', 'JAVIER', 'CERA', 'ATEHORTUA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (944, '1122142523', 'FREDMAN 	', '3', '058', '999', 'E', '44548CMFA', '999', 'OPERATIVOS PLANTA EXT', 'ANDRES 	', 'CASTILLO 	', 'MELO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (945, '1123115213', 'JANUARIO', '3', '058', '999', 'E', '17238TSJ', '999', 'OPERATIVOS PLANTA EXT', '', 'TRIGOS', 'SANTANA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (946, '1121919092', 'JENNINSON', '3', '054', '999', 'E', '21117CDJ', '999', 'OPERATIVOS MANTENIMIENTO', '', 'CRISPIN', 'DIAZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (947, '1102362594', 'ANGELO 		', '3', '058', '999', 'E', '64619LAA', '999', 'OPERATIVOS PLANTA EXT', '', 'LANCHEROS 	', 'APONTE', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (949, '80238793', 'NESTOR', '3', '058', '999', 'E', '40818SSNE', '999', 'OPERATIVOS PLANTA EXT', 'ENRIQUE', 'SANABRIA', 'SUAREZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (950, '1119888077', 'JEISSON', '3', '058', '999', 'E', '90102GJE', '999', 'OPERATIVOS PLANTA EXT', 'ENRIQUE', 'GAHONA', '', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (951, '1120357800', 'CESAR', '3', '058', '999', 'E', '59825AGCA', '999', 'OPERATIVOS PLANTA EXT', 'AUGUSTO', 'ACOSTA', 'GARCIA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (952, '1122120289', 'ROBISON', '3', '058', '999', 'E', '22314GRRA', '999', 'OPERATIVOS PLANTA EXT', 'AUGUSTO', 'GONZALEZ', 'RUIZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (953, '1122144517', 'DUVAN', '3', '058', '999', 'E', '46542SADS', '999', 'OPERATIVOS PLANTA EXT', 'STIVEN', 'SANCHEZ', 'ARANGO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (954, '94299562', 'HERNANDO', '3', '058', '999', 'E', '101587BSH', '999', 'OPERATIVOS PLANTA EXT', '', 'BOLAÑOS', 'SOLANO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (955, '1123114600', 'JOSÉ', '3', '058', '999', 'E', '16625GTJD', '999', 'OPERATIVOS PLANTA EXT', 'DUMAR', 'GARCIA', 'TORRES', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (956, '1123115194', 'ALAN', '3', '058', '999', 'E', '17219GTA', '999', 'OPERATIVOS PLANTA EXT', '', 'GARCIA', 'TORRES', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (892, '30946271', 'SANDRA', '3', '021', '000', 'E', '48296TSM', '000', 'NO DEFINIDO', 'MILENA', 'TRUJILLO', '', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (893, '1006838556', 'NICOLAS', '3', '058', '000', 'X', '40581UEN', '000', 'OPERATIVOS PLANTA EXT', '', 'URREGO', 'ESCOBAR', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (959, '1081785405', 'JAIDER', '3', '058', '999', 'E', '87430DCJE', '999', 'OPERATIVOS PLANTA EXT', 'ENRIQUE', 'DE LA CRUZ', 'CESPEDES', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (960, '16864033', 'JHON', '3', '058', '999', 'X', '66058CMJW', '999', 'OPERATIVOS PLANTA EXT', 'WILMER', 'CALDERON', 'MOSQUERA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (961, '1122142279', 'GILBERTO', '3', '058', '999', 'X', '44304AMG', '999', 'OPERATIVOS PLANTA EXT', '', 'ARIAS', 'MARTINEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (962, '3237175', 'BERNARDO', '3', '058', '999', 'E', '39200LCB', '999', 'OPERATIVOS PLANTA EXT', '', 'LEON', 'CARDENAS', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (963, '1006838534', 'DIEGO', '3', '058', '999', 'E', '40559SDF', '999', 'OPERATIVOS PLANTA EXT', 'FERNANDO', 'SANABRIA', '', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (964, '1120365242', 'GUSTAVO', '3', '058', '999', 'E', '67267BRGA', '999', 'OPERATIVOS PLANTA EXT', 'ADOLFO', 'BAQUERO', 'RUBIO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (965, '1122129903', 'ZAHIRA', '3', '021', '999', 'E', '31928GAZF', '999', 'NO DEFINIDO', 'FERNANDA', 'GARZON', 'ARIAS', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (966, '80005448', 'JOSÉ', '3', '058', '999', 'E', '7473MPJH', '999', 'OPERATIVOS PLANTA EXT', 'HERNANDO', 'MARROQUIN', 'PEREZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (967, '80732108', 'LEISER', '3', '058', '000', 'E', '34133OOL', '000', 'OPERATIVOS PLANTA EXT', '', 'ORTIZ', 'ORTIZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (968, '1123514882', 'ALVARO', '3', '021', '999', 'E', '16907FMAE', '999', 'NO DEFINIDO', 'ESTIBEN', 'FONTECHA', 'MENDOZA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (969, '1122140761', 'MARLENY', '3', '021', '999', 'E', '42786CCM', '999', 'NO DEFINIDO', '', 'CAGUA', 'CRUZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (970, '1122122657', 'ANGELA', '3', '021', '000', 'E', '24682QRAM', '000', 'NO DEFINIDO', 'MAYURY', 'QUEVEDO', 'RAMIREZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (971, '1057514779', 'VICTOR', '3', '058', '000', 'E', '16804GVVA', '000', 'OPERATIVOS PLANTA EXT', 'ALFONSO', 'GAMBOA', 'VARGAS', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (972, '1123116377', 'BRAYAN', '3', '058', '000', 'E', '18402LMBS', '000', 'OPERATIVOS PLANTA EXT', 'STIVEN', 'LOZANO', 'MANRIQUE', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (973, '87948678', 'JAVIER', '3', '054', '003', 'A', '50703CJA', '003', 'OPERATIVOS MANTENIMIENTO', 'ALFREDO', 'CENTENO', '', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (974, '1123115573', 'ALEXANDER', '3', '058', '000', 'E', '17598CMA', '000', 'OPERATIVOS PLANTA EXT', '', 'CHAVEZ', 'MURILLO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (976, '1024508601', 'JUAN', '3', '058', '000', 'E', '10626VGJC', '000', 'OPERATIVOS PLANTA EXT', 'CAMILO', 'VIRGUEZ', 'GOMEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (977, '1037480386', 'HENRY', '3', '058', '000', 'E', '82411RBHJ', '000', 'OPERATIVOS PLANTA EXT', 'JESUS', 'RIVERA', 'BARRIOS', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (978, '1121855293', 'LEONARDO', '3', '058', '999', 'X', '57318HL', '999', 'OPERATIVOS PLANTA EXT', '', 'HUERTAS', '', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (979, '1123116415', 'BRANDON', '3', '058', '000', 'E', '18440APBS', '000', 'OPERATIVOS PLANTA EXT', 'SWEN', 'ACOSTA', 'PICON', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (980, '1007441523', 'YANCARLOS', '3', '125', '016', 'A', '43548EMY', '016', 'ASISTENTES', '', 'ESPEJO', 'MARTINEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (981, '1006857250', 'JUAN', '3', '058', '999', 'E', '59275PRJD', '999', 'OPERATIVOS PLANTA EXT', 'DIEGO', 'POSADA', 'RINCON', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (982, '1122146082', 'YOJAN', '3', '058', '000', 'E', '48107RMYE', '000', 'OPERATIVOS PLANTA EXT', 'ESTEBAN', 'ROZO', 'MUÑOZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (983, '1122126475', 'JOSE', '3', '058', '000', 'E', '28500PRJT', '000', 'OPERATIVOS PLANTA EXT', 'TRINIDAD', 'PIRE', 'RIAÑO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (984, '1234790136', 'DANIEL', '3', '021', '999', 'E', '92161CLDS', '999', 'NO DEFINIDO', 'STEBAN', 'CAICEDO', 'LADINO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (985, '1122127133', 'NIDIA', '3', '011', '012', 'A', '29158GON', '012', 'ANALISTAS', '', 'GARCES', 'ORTIZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (986, '1123513779', 'MARLY', '3', '021', '000', 'E', '15804RAMT', '000', 'NO DEFINIDO', 'TATIANA', 'REY', 'ALFONSO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (987, '1122133102', 'OMAR', '3', '058', '999', 'E', '35127NCOY', '999', 'OPERATIVOS PLANTA EXT', 'YECID', 'NOVOA', 'CARDENAL', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (988, '1097162616', 'JUAN', '3', '058', '000', 'E', '64641VTJC', '000', 'OPERATIVOS PLANTA EXT', 'CAMILO', 'VERANO', 'TELLEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (989, '1049027929', 'ANGEL', '3', '058', '000', 'E', '29954HMAH', '000', 'OPERATIVOS PLANTA EXT', 'HEMSLEY', 'HERRERA', 'MANCILLA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (990, '1123115873', 'DARWIN', '3', '058', '000', 'E', '17898MHDR', '000', 'OPERATIVOS PLANTA EXT', 'RODRIGO', 'MOLINA', 'HERNANDEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (991, '5938447', 'HERNAN', '3', '112', '000', 'E', '40472PGH', '000', 'SUPERVISORES', '', 'PALACIO', 'GONZALEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (992, '1122141901', 'HEISY', '3', '021', '000', 'E', '43926HBHD', '000', 'NO DEFINIDO', 'DAYANA', 'HURTADO', 'BOHORQUEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (993, '1006777259', 'CARLOS', '3', '040', '000', 'E', '79284PMCA', '000', 'NO DEFINIDO', 'ANDRES', 'PAREDES', 'MARTINEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (994, '1122136626', 'YEIFER', '3', '040', '000', 'E', '38651MCYB', '000', 'NO DEFINIDO', 'BRAYAM', 'MORENO', 'CRUZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (995, '1006777259', 'CARLOS', '3', '021', '999', 'E', '79284PMCA', '999', 'NO DEFINIDO', 'ANDRES', 'PAREDES', 'MARTINEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (996, '1122136626', 'YEIFER', '3', '021', '999', 'E', '38651MCYB', '999', 'NO DEFINIDO', 'BRAYAM', 'MORENO', 'CRUZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (997, '1006776765', 'JOSE', '3', '058', '000', 'E', '78790FMJM', '000', 'OPERATIVOS PLANTA EXT', 'MIGUEL', 'FAUSTINO', 'MORALES', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (998, '1122146037', 'MIGUEL', '3', '058', '000', 'E', '48062VRME', '000', 'OPERATIVOS PLANTA EXT', 'EDUARDO', 'VILLALOBOS', 'RIAÑO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (999, '1123115161', 'FABIAN', '3', '058', '000', 'E', '17186PRF', '000', 'OPERATIVOS PLANTA EXT', '', 'PINEDA', 'RODRIGUEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1000, '1116864912', 'DARWIN', '3', '058', '000', 'E', '66937TGD', '000', 'OPERATIVOS PLANTA EXT', '', 'TORRES', 'GUERRERO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1001, '1063618832', 'JHON', '3', '058', '999', 'E', '20857RGJJ', '999', 'OPERATIVOS PLANTA EXT', 'JAIRO', 'ROJAS', 'GAMBA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1002, '1124190795', 'JHORMAN', '3', '031', '016', 'A', '92820CVJA', '016', 'OPERATIVOS PLANTA EXT', 'ALEXIS', 'CASTRO', 'VERGARA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1003, '1192763309', 'JOHAN', '3', '058', '000', 'E', '65334GQJS', '000', 'OPERATIVOS PLANTA EXT', 'STEVEN', 'GUZMAN', 'QUEVEDO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1005, '1122130097', 'WILLIAM', '3', '049', '003', 'A', '32122RRWA', '003', 'OPERATIVOS MANTENIMIENTO', 'ALEXANDER', 'REYES', 'ROJAS', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1006, '1122145604', 'JANIER', '3', '058', '000', 'E', '47629RLJN', '000', 'OPERATIVOS PLANTA EXT', 'NICOLAS', 'RODRIGUEZ', 'LOPEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1007, '1122647515', 'LEYDE', '3', '058', '000', 'E', '49540RDLJ', '000', 'OPERATIVOS PLANTA EXT', 'JOHAN', 'ROZO', 'DIAZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1008, '1123115143', 'NILSON', '3', '058', '000', 'E', '17168CCNJ', '000', 'OPERATIVOS PLANTA EXT', 'JAIR', 'CORREA', 'CESPEDES', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1009, '1053779538', 'JUAN', '3', '058', '000', 'E', '81563FCJD', '000', 'OPERATIVOS PLANTA EXT', 'DAVID', 'FRANCO', 'CASTRO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1010, '1122143408', 'CARLOS', '3', '058', '000', 'E', '45433RMCD', '000', 'OPERATIVOS PLANTA EXT', 'DUVAN', 'RAMIREZ', 'MORA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1011, '1121941500', 'JANERSON', '3', '047', '016', 'A', '43525VPJ', '016', 'SUPERVISORES', '', 'VIVEROS', 'PANAMEÑO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1012, '1019151857', 'JOHN', '3', '058', '000', 'E', '53882CPJF', '000', 'OPERATIVOS PLANTA EXT', 'FREDY', 'CASTRO', 'PERILLA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1013, '1094859505', 'JAIRO', '3', '058', '000', 'E', '61530VHJO', '000', 'OPERATIVOS PLANTA EXT', 'OMAR', 'VERA', 'HERNANDEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1014, '1133790704', 'CARLOS', '3', '054', '000', 'E', '92729RSCA', '000', 'OPERATIVOS MANTENIMIENTO', 'ALBERTO', 'ROMERO', 'SOTELO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1015, '1119892202', 'CRISTIAM', '3', '058', '000', 'E', '94227BCC', '000', 'OPERATIVOS PLANTA EXT', '', 'BARRIOS', 'CHAMBUETA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1016, '1123115079', 'JHON', '3', '058', '000', 'E', '17104GCJF', '000', 'OPERATIVOS PLANTA EXT', 'FREDY', 'GUTIERREZ', 'CIFUENTES', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1017, '1121863270', 'AVELINO', '3', '132', '000', 'E', '65295BOA', '000', 'NO DEFINIDO', '', 'BENAVIDES', 'OJEDA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1018, '1123115978', 'ALDOR', '3', '058', '000', 'E', '18003MGA', '000', 'OPERATIVOS PLANTA EXT', '', 'MOSQUERA', 'GOMEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1019, '8527470', 'TEIDER', '3', '058', '000', 'E', '29495PFT', '000', 'OPERATIVOS PLANTA EXT', '', 'PERALTA', 'FRANCO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1020, '1019049987', 'MARLON', '3', '058', '000', 'E', '52012AMMD', '000', 'OPERATIVOS PLANTA EXT', 'DIDI', 'ARIZA', 'MOTTA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1021, '1004632224', 'JHON', '3', '058', '000', 'E', '34249CGJS', '000', 'OPERATIVOS PLANTA EXT', 'SEBASTIAN', 'CRUZ', 'GUERRERO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (957, '1123512296', 'JOSÉ', '3', '058', '999', 'E', '14321AHJM', '999', 'OPERATIVOS PLANTA EXT', 'MAURICIO', 'ACOSTA', 'HERNANDEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (958, '1124190772', 'JULIAN', '3', '058', '999', 'E', '92797MMJA', '999', 'OPERATIVOS PLANTA EXT', 'ANDRES', 'MORA', 'MARTINEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1025, '1123115541', 'JOSE', '3', '058', '000', 'E', '17566GAJJ', '000', 'OPERATIVOS PLANTA EXT', 'JAVIER', 'GAMBINO', 'ARIZA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1026, '1121958533', 'DENILSON', '3', '087', '000', 'E', '60558ICD', '000', 'NO DEFINIDO', '', 'IZAJAR', 'CARABALI', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1027, '1122138801', 'JUAN', '3', '054', '000', 'E', '40826PRJD', '000', 'OPERATIVOS MANTENIMIENTO', 'DAVID', 'PAZ', 'RODRIGUEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1028, '1122141901', 'HEISY', '3', '100', '999', 'E', '43926HBHD', '999', 'ASISTENTES', 'DAYANA', 'HURTADO', 'BOHORQUEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1030, '1006777814', 'DANIEL', '3', '058', '000', 'E', '79839CFDF', '000', 'OPERATIVOS PLANTA EXT', 'FELIPE', 'CHAPARRO', 'FARFAN', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1031, '1047241522', 'EDGAR', '3', '112', '000', 'E', '43547RUEL', '000', 'SUPERVISORES', 'LICIMACO', 'RINCON', 'URDANETA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1032, '1122145497', 'DANIEL', '3', '021', '000', 'E', '47522ARDO', '000', 'NO DEFINIDO', 'ORLANDO', 'ACOSTA', 'ROMERO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1033, '1000972343', 'LAURA', '3', '040', '000', 'E', '74368AMLK', '000', 'NO DEFINIDO', 'KATERIN', 'APONTE', 'MONTAÑEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1034, '1006776624', 'ANDREA', '3', '040', '000', 'E', '78649LAAM', '000', 'NO DEFINIDO', 'MAYERLY', 'LEON', 'ACOSTA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1035, '1000972343', 'LAURA', '3', '021', '000', 'E', '74368AMLK', '000', 'NO DEFINIDO', 'KATERIN', 'APONTE', 'MONTAÑEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1036, '1006776624', 'ANDREA', '3', '021', '000', 'E', '78649LAAM', '000', 'NO DEFINIDO', 'MAYERLY', 'LEON', 'ACOSTA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1037, '30946193', 'JENNY', '3', '014', '000', 'E', '48218QPJP', '000', 'ASISTENTES', 'PAOLA', 'QUEVEDO', 'PINILLA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1038, '1122140440', 'DUVAN', '3', '021', '999', 'E', '42465CMDA', '999', 'NO DEFINIDO', 'ANDRES', 'CASTRO', 'MANAJRRES', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1039, '1006859060', 'NAZLY', '3', '021', '999', 'E', '61085ARNT', '999', 'NO DEFINIDO', 'TATIANA', 'ARENAS', 'RODRIGUEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1040, '1121904325', 'OSCAR', '3', '076', '999', 'X', '6350SROE', '999', 'COORDINADORES', 'ESNEIDER', 'SAAVEDRA', 'REINA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1041, '1118202219', 'MARTHA', '3', '021', '999', 'E', '4244PRMC', '999', 'NO DEFINIDO', 'CECILIA', 'PARRA', 'RODRIGUEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1042, '1122142028', 'EDWIN', '3', '046', '999', 'E', '44053RGEO', '999', 'OPERATIVOS MANTENIMIENTO', 'OSWALDO', 'RIOS', 'GALLO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1043, '1122135749', 'JUAN', '3', '096', '999', 'E', '37774BOJD', '999', 'NO DEFINIDO', 'DIEGO', 'BOLIVAR', 'ORJUELA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1044, '1123114992', 'HUBER', '3', '058', '999', 'E', '17017CCHA', '999', 'OPERATIVOS PLANTA EXT', 'ANDRES', 'CUERVO', 'CAICEDO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1045, '1006780087', 'BRAYAN', '3', '058', '999', 'E', '82112JCBY', '999', 'OPERATIVOS PLANTA EXT', 'YAMID', 'JAIMES', 'CALDERON', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1046, '1122140440', 'DUVAN', '3', '058', '999', 'E', '42465CMDA', '999', 'OPERATIVOS PLANTA EXT', 'ANDRES', 'CASTRO', 'MANJARRES', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1047, '1115850764', 'ALINSON', '3', '021', '999', 'E', '52789HGAI', '999', 'NO DEFINIDO', 'IVAN', 'HERNANDEZ', 'GIRON', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1048, '1005827641', 'SAIRA', '3', '021', '000', 'E', '29666NASV', '000', 'NO DEFINIDO', 'VANESSA', 'NAVARRO', 'AREVALO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1049, '1118560582', 'OLMES', '3', '021', '000', 'E', '62607TZOY', '000', 'NO DEFINIDO', 'YAIR', 'TARAZONA', 'ZORRO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1050, '1002479749', 'LINA', '3', '021', '000', 'E', '81774AHLN', '000', 'NO DEFINIDO', 'NATALIA', 'ACEVEDO', 'HURTADO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1051, '1122135749', 'JUAN', '3', '120', '000', 'E', '37774BOJD', '000', 'NO DEFINIDO', 'DIEGO', 'BOLIVAR', 'ORJUELA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1052, '1006783470', 'ANTONIO', '3', '118', '003', 'A', '85495AMAM', '003', 'OPERATIVOS MANTENIMIENTO', 'MARIA', 'ALCANTAR', 'MONROY', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1053, '1005855799', 'PAULA', '3', '052', '999', 'E', '57824CHPA', '999', 'AUXILIARES OPERATIVOS', 'ANDREA', 'CONDA', 'HERNANDEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1054, '1125476642', 'INGRID', '3', '021', '999', 'E', '78667JUIT', '999', 'NO DEFINIDO', 'TATIANA', 'JARAMILLO', 'URIBE', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1055, '1122133619', 'JEFERSON', '3', '096', '999', 'E', '35644CHJA', '999', 'NO DEFINIDO', 'ALEXANDER', 'CRUZ', 'HERRERA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1056, '1007449224', 'JOSE', '3', '021', '000', 'E', '51249MHJN', '000', 'NO DEFINIDO', 'NICOLAS', 'MONTOYA', 'HERRERA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1057, '1002479749', 'LINA', '3', '125', '999', 'E', '81774AHLN', '999', 'ASISTENTES', 'NATALIA', 'ACEVEDO', 'HURTADO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1058, '1000972341', 'LEIDY', '3', '125', '016', 'A', '74366AMLE', '016', 'ASISTENTES', 'ESTEFANIA', 'APONTE', 'MONTAÑEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1059, '1122126576', 'YENIFER', '3', '015', '999', 'E', '28601BCYM', '999', 'NO DEFINIDO', 'MARCELA', 'BERNAL', 'CRUZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1061, '1024573976', 'MICHAEL', '3', '052', '999', 'E', '76001AGMJ', '999', 'AUXILIARES OPERATIVOS', 'JAVIER', 'AGUIRRE', 'GALVIS', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1062, '1121933967', 'NEIDY', '3', '130', '999', 'E', '35992MTNM', '999', 'SUPERVISORES', 'MARCELA', 'MONROY', 'TINEO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1063, '1007344115', 'CRISTIAN', '3', '058', '999', 'E', '46140PBCO', '999', 'OPERATIVOS PLANTA EXT', 'OCTAVIO', 'PEÑA', 'BUITRAGO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1064, '1006863053', 'OSCAR', '3', '058', '999', 'E', '65078SQOE', '999', 'OPERATIVOS PLANTA EXT', 'EDUARDO', 'SANTANILLA', 'QUINTERO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1065, '1006779702', 'JULIAN', '3', '058', '999', 'E', '81727PMJF', '999', 'OPERATIVOS PLANTA EXT', 'FELIPE', 'PINZON', 'MARTINEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1066, '1006875191', 'ERIC', '3', '021', '999', 'E', '77216RSEY', '999', 'NO DEFINIDO', 'YAMID', 'RINTA', 'SAENZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1067, '1010043103', 'JOSE', '3', '040', '999', 'E', '45128LCJD', '999', 'NO DEFINIDO', 'DANIEL', 'LUNA', 'CAMACHO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1068, '1121869947', 'KELLY', '3', '116', '999', 'E', '71972TRKN', '999', 'ANALISTAS', 'NATALI', 'TORRES', 'RODRIGUEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1069, '1000972343', 'LAURA', '3', '014', '006', 'A', '74368AMLK', '006', 'ASISTENTES', 'KATERIN', 'APONTE', 'MONTAÑEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1070, '1010043103', 'JOSE', '3', '021', '999', 'E', '45128LCJD', '999', 'NO DEFINIDO', 'DANIEL', 'LUNA', 'CAMACHO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1071, '1121823601', 'DIEGO', '3', '027', '016', 'A', '25626CUDF', '016', 'ASISTENTES', 'FERNANDO', 'CAMACHO', 'URUEÑA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1072, '1121921367', 'OSCAR', '3', '021', '999', 'E', '23392OVOM', '999', 'NO DEFINIDO', 'MAURICIO', 'OJEDA', 'VIGOYA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1073, '16045285', 'WILDER', '3', '058', '999', 'E', '47310ZAW', '999', 'OPERATIVOS PLANTA EXT', '', 'ZAPATA', 'ARIAS', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1074, '1070706974', 'HECTOR', '3', '055', '999', 'E', '8999RLHY', '999', 'OPERATIVOS PLANTA EXT', 'YESID', 'RAMIREZ', 'LEAL', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1075, '1006658965', 'YEISON', '3', '052', '015', 'A', '60990MVYA', '015', 'AUXILIARES OPERATIVOS', 'ANDRES', 'MEJIA', 'VALENCIA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1076, '1123114087', 'WILLIAM', '3', '058', '999', 'E', '16112GDWD', '999', 'OPERATIVOS PLANTA EXT', 'DAVID', 'GOMEZ', 'DUQUE', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1077, '1100949150', 'YOJHAN', '3', '058', '999', 'E', '51175MRYE', '999', 'OPERATIVOS PLANTA EXT', 'ELIECER', 'MALDONADO', 'RUIZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1078, '7573592', 'LUIS', '3', '058', '999', 'E', '75617BJLA', '999', 'OPERATIVOS PLANTA EXT', 'ALFREDO', 'BUELVAS', 'JIMENEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1079, '1010088563', 'JUAN', '3', '058', '999', 'E', '90588ORJS', '999', 'OPERATIVOS PLANTA EXT', 'SEBASTIAN', 'OBANDO', 'ROMERO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1080, '1121042091', 'DAYNER', '3', '058', '999', 'E', '44116LPD', '999', 'OPERATIVOS PLANTA EXT', '', 'LASCARRO', 'PEREZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1081, '1006838674', 'YILBER', '3', '058', '999', 'E', '40699FSYF', '999', 'OPERATIVOS PLANTA EXT', 'FLAMINIO', 'FANDIÑO', 'SILVA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1082, '1006863071', 'JHONATAN', '3', '052', '015', 'A', '65096MGJA', '015', 'AUXILIARES OPERATIVOS', 'ALEXANDER', 'MOYANO', 'GONZALEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1083, '1007441419', 'DARLEY', '3', '058', '999', 'E', '43444MJDM', '999', 'OPERATIVOS PLANTA EXT', 'MAURICIO', 'MURCIA', 'JOJOA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1084, '1122122429', 'YORMAN', '3', '052', '015', 'A', '24454TCYA', '015', 'AUXILIARES OPERATIVOS', 'ALBERTO', 'TRIVIÑO', 'CONTRERAS', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1085, '1006838448', 'BRAYAN', '3', '058', '999', 'E', '40473GBS', '999', 'OPERATIVOS PLANTA EXT', 'STIVEN', 'GONZALEZ', '', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1086, '1006718750', 'JOSE', '3', '058', '999', 'E', '20775ONJE', '999', 'OPERATIVOS PLANTA EXT', 'ESTIVEN', 'ORTIZ', 'NIETO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1087, '1193067105', 'DEIVIS', '3', '058', '999', 'E', '69130OPDJ', '999', 'OPERATIVOS PLANTA EXT', 'JOSE', 'OSORIO', 'PEDROZA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1088, '1006773764', 'YOHAN', '3', '058', '999', 'E', '75789CCYS', '999', 'OPERATIVOS PLANTA EXT', 'STIVEN', 'CETINA', 'CETINA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1023, '1006838686', 'YORDAN', '3', '052', '015', 'X', '40711BLY', '015', 'AUXILIARES OPERATIVOS', '', 'BERMUDEZ', 'LEON', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1024, '1061200043', 'WILFRIDO', '3', '058', '000', 'E', '2068CGW', '000', 'OPERATIVOS PLANTA EXT', '', 'CAICEDO', 'GAMBINO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1094, '1006838528', 'JUAN', '3', '058', '999', 'E', '40553CSJC', '999', 'OPERATIVOS PLANTA EXT', 'CAMILO', 'CASTELLANOS', 'SANABRIA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1095, '1055550398', 'YERSON', '3', '058', '999', 'E', '52423EPYA', '999', 'OPERATIVOS PLANTA EXT', 'ALEXANDER', 'ESPEJO', 'PEÑA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1096, '40433429', 'MARIA', '3', '052', '015', 'E', '35454PPME', '015', 'AUXILIARES OPERATIVOS', 'EDILMA', 'PUENTES', 'PEÑA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1097, '1096232581', 'KEVIN', '3', '058', '999', 'E', '34606GHKA', '999', 'OPERATIVOS PLANTA EXT', 'ANDRES', 'GUTIERREZ', 'HERNANDEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1098, '1006863050', 'DIEGO', '3', '058', '999', 'E', '65075MGDA', '999', 'OPERATIVOS PLANTA EXT', 'ALEJANDRO', 'MOYANO', 'GONZALEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1099, '1122119808', 'MIGUEL', '3', '058', '999', 'E', '21833TRMA', '999', 'OPERATIVOS PLANTA EXT', 'ANGEL', 'TORRES', 'RODRIGUEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1100, '1082974980', 'JESUS', '3', '058', '999', 'E', '77005MTJM', '999', 'OPERATIVOS PLANTA EXT', 'MIGUEL', 'MIRANDA', 'TUNA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1101, '1123512154', 'DANILO', '3', '031', '999', 'E', '14179FAD', '999', 'OPERATIVOS PLANTA EXT', '', 'FONTECHA', 'ALFONSO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1102, '1006697266', 'JUAN', '3', '058', '999', 'E', '99291DFJF', '999', 'OPERATIVOS PLANTA EXT', 'FELIPE', 'DEL BASTO', 'FRANCO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1103, '1006838449', 'ANDRES', '3', '049', '003', 'A', '40474CCAD', '003', 'OPERATIVOS MANTENIMIENTO', 'DARIO', 'CASTELLANOS', 'CIFUENTES', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1104, '5895802', 'JOSE', '3', '058', '999', 'E', '97827MCJD', '999', 'OPERATIVOS PLANTA EXT', 'DANIEL', 'MENDEZ', 'COLMENARES', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1105, '1027947140', 'CARLOS', '3', '058', '999', 'E', '49165FGCA', '999', 'OPERATIVOS PLANTA EXT', 'ALBERTO', 'FUENTES', 'GARCIA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1106, '1052083045', 'ALBERTO', '3', '058', '999', 'E', '85070ACAM', '999', 'OPERATIVOS PLANTA EXT', 'MIGUEL', 'ACUÑA', 'CAMARGO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1107, '6350555', 'CESAR', '3', '058', '999', 'E', '52580CVCJ', '999', 'OPERATIVOS PLANTA EXT', 'JOHAN', 'CALDERON', 'VALERO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1109, '1121148970', 'LUIS', '3', '058', '999', 'E', '50995SBLF', '999', 'OPERATIVOS PLANTA EXT', 'FERNANDO', 'SAAVEDRA', 'BARRETO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1110, '1123116409', 'JULIAN', '3', '058', '999', 'E', '18434RMJC', '999', 'OPERATIVOS PLANTA EXT', 'CAMILO', 'RAMIREZ', 'MONTAÑEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1111, '1123114099', 'NHIKOLAS', '3', '058', '999', 'E', '16124RTNA', '999', 'OPERATIVOS PLANTA EXT', 'ANDRES', 'RODRIGUEZ', 'TORRES', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1113, '1123115575', 'MERLY', '3', '085', '999', 'E', '17600MCMD', '999', 'AUXILIARES', 'DAYANA', 'MORENO', 'CARDENAS', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1114, '1122123985', 'JAVIER', '3', '046', '999', 'E', '26010GPJF', '999', 'OPERATIVOS MANTENIMIENTO', 'FELIPE', 'GUAYARA', 'PARRADO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1115, '1068346040', 'DANUIL', '3', '058', '999', 'E', '48065LDDE', '999', 'OPERATIVOS PLANTA EXT', 'EDUARDO', 'LOBO', 'DEL CRISTO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1116, '1010043103', 'JOSE', '3', '046', '999', 'E', '45128LCJD', '999', 'OPERATIVOS MANTENIMIENTO', 'DANIEL', 'LUNA', 'CAMACHO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1108, '1007308741', 'ANDRES', '3', '058', '999', 'E', '10766SBAE', '999', 'OPERATIVOS PLANTA EXT', 'ESTEBAN', 'SALAZAR', 'BENAVIDES', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1089, '16463589', 'JOSE', '3', '054', '999', 'E', '65614CJA', '999', 'OPERATIVOS MANTENIMIENTO', 'ANDRES', 'CHILITO', '', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1090, '1121820534', 'CRISTIAN', '3', '058', '999', 'E', '22559CFCJ', '999', 'OPERATIVOS PLANTA EXT', 'JULIAN', 'CABALLERO', 'FEO', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1091, '1193126923', 'DANIS', '3', '058', '999', 'E', '28948AMDJ', '999', 'OPERATIVOS PLANTA EXT', 'JAVIER', 'ARRIETA', 'MENDEZ', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1092, '1006721519', 'DABIAN', '3', '021', '999', 'E', '23544APDA', '999', 'NO DEFINIDO', 'ALEXANDER', 'ARENAS', 'PARRA', 2);
INSERT INTO "public"."adm_colaboradores" VALUES (1093, '1000047346', 'JHON', '3', '058', '999', 'E', '49371GZJA', '999', 'OPERATIVOS PLANTA EXT', 'ALEXANDER', 'GOMEZ', 'ZAMBRANO', 2);

-- ----------------------------
-- Table structure for adm_empresa
-- ----------------------------
DROP TABLE IF EXISTS "public"."adm_empresa";
CREATE TABLE "public"."adm_empresa" (
  "emp_id" int4 NOT NULL,
  "emp_nombre" varchar(255) COLLATE "pg_catalog"."default" NOT NULL
)
;

-- ----------------------------
-- Records of adm_empresa
-- ----------------------------
INSERT INTO "public"."adm_empresa" VALUES (1, 'OLEAGINOSAS SAN MARCOS');
INSERT INTO "public"."adm_empresa" VALUES (2, 'INVERSIONES');
INSERT INTO "public"."adm_empresa" VALUES (3, 'SEMAG DE LOS LLANOS');

-- ----------------------------
-- Table structure for adm_roles
-- ----------------------------
DROP TABLE IF EXISTS "public"."adm_roles";
CREATE TABLE "public"."adm_roles" (
  "id" int4 NOT NULL DEFAULT nextval('roles_id_seq'::regclass),
  "nombre" varchar(50) COLLATE "pg_catalog"."default" NOT NULL
)
;

-- ----------------------------
-- Records of adm_roles
-- ----------------------------
INSERT INTO "public"."adm_roles" VALUES (1, 'Administrador');
INSERT INTO "public"."adm_roles" VALUES (2, 'Usuario');
INSERT INTO "public"."adm_roles" VALUES (3, 'Capacitador');
INSERT INTO "public"."adm_roles" VALUES (4, 'Aux_Capacitador');
INSERT INTO "public"."adm_roles" VALUES (5, 'Agronómico');
INSERT INTO "public"."adm_roles" VALUES (6, 'Aux_Agronómico');
INSERT INTO "public"."adm_roles" VALUES (7, 'Báscula');
INSERT INTO "public"."adm_roles" VALUES (8, 'Aux_Báscula');
INSERT INTO "public"."adm_roles" VALUES (9, 'Almacén');
INSERT INTO "public"."adm_roles" VALUES (10, 'Aux_Almacén');
INSERT INTO "public"."adm_roles" VALUES (11, 'Sup_logistica1');
INSERT INTO "public"."adm_roles" VALUES (12, 'Editor_logistica1');
INSERT INTO "public"."adm_roles" VALUES (13, 'Sup_logistica2');
INSERT INTO "public"."adm_roles" VALUES (14, 'Sup_topografo');
INSERT INTO "public"."adm_roles" VALUES (15, 'Editor_logistica2');
INSERT INTO "public"."adm_roles" VALUES (16, 'Sup_produccion');
INSERT INTO "public"."adm_roles" VALUES (17, 'Editor_produccion');
INSERT INTO "public"."adm_roles" VALUES (18, 'Sup_logi y transporte');

-- ----------------------------
-- Table structure for adm_situación
-- ----------------------------
DROP TABLE IF EXISTS "public"."adm_situación";
CREATE TABLE "public"."adm_situación" (
  "id" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "situación" varchar(255) COLLATE "pg_catalog"."default" NOT NULL
)
;

-- ----------------------------
-- Records of adm_situación
-- ----------------------------
INSERT INTO "public"."adm_situación" VALUES ('E', 'Egresado');
INSERT INTO "public"."adm_situación" VALUES ('X', 'Preegresado');
INSERT INTO "public"."adm_situación" VALUES ('A', 'Activo');
INSERT INTO "public"."adm_situación" VALUES ('V', 'Vacaciones');
INSERT INTO "public"."adm_situación" VALUES ('P', 'Permiso');

-- ----------------------------
-- Table structure for adm_usuario_roles
-- ----------------------------
DROP TABLE IF EXISTS "public"."adm_usuario_roles";
CREATE TABLE "public"."adm_usuario_roles" (
  "id" int4 NOT NULL DEFAULT nextval('adm_usuario_roles_id_seq'::regclass),
  "usuario_id" int4 NOT NULL,
  "rol_id" int4 NOT NULL
)
;

-- ----------------------------
-- Records of adm_usuario_roles
-- ----------------------------
INSERT INTO "public"."adm_usuario_roles" VALUES (1, 1, 1);
INSERT INTO "public"."adm_usuario_roles" VALUES (2, 2, 1);
INSERT INTO "public"."adm_usuario_roles" VALUES (4, 4, 4);
INSERT INTO "public"."adm_usuario_roles" VALUES (5, 5, 4);
INSERT INTO "public"."adm_usuario_roles" VALUES (6, 6, 4);
INSERT INTO "public"."adm_usuario_roles" VALUES (7, 7, 4);
INSERT INTO "public"."adm_usuario_roles" VALUES (8, 8, 4);
INSERT INTO "public"."adm_usuario_roles" VALUES (9, 9, 4);
INSERT INTO "public"."adm_usuario_roles" VALUES (10, 10, 4);
INSERT INTO "public"."adm_usuario_roles" VALUES (11, 11, 4);
INSERT INTO "public"."adm_usuario_roles" VALUES (12, 12, 4);
INSERT INTO "public"."adm_usuario_roles" VALUES (13, 13, 4);
INSERT INTO "public"."adm_usuario_roles" VALUES (14, 14, 3);
INSERT INTO "public"."adm_usuario_roles" VALUES (15, 15, 3);
INSERT INTO "public"."adm_usuario_roles" VALUES (16, 16, 3);
INSERT INTO "public"."adm_usuario_roles" VALUES (17, 17, 3);
INSERT INTO "public"."adm_usuario_roles" VALUES (18, 18, 3);
INSERT INTO "public"."adm_usuario_roles" VALUES (19, 19, 3);
INSERT INTO "public"."adm_usuario_roles" VALUES (20, 20, 3);
INSERT INTO "public"."adm_usuario_roles" VALUES (21, 21, 3);
INSERT INTO "public"."adm_usuario_roles" VALUES (22, 22, 3);
INSERT INTO "public"."adm_usuario_roles" VALUES (23, 23, 3);
INSERT INTO "public"."adm_usuario_roles" VALUES (24, 24, 3);
INSERT INTO "public"."adm_usuario_roles" VALUES (25, 25, 3);
INSERT INTO "public"."adm_usuario_roles" VALUES (26, 26, 3);
INSERT INTO "public"."adm_usuario_roles" VALUES (27, 27, 3);
INSERT INTO "public"."adm_usuario_roles" VALUES (28, 28, 3);
INSERT INTO "public"."adm_usuario_roles" VALUES (29, 29, 3);
INSERT INTO "public"."adm_usuario_roles" VALUES (30, 30, 3);
INSERT INTO "public"."adm_usuario_roles" VALUES (31, 31, 3);
INSERT INTO "public"."adm_usuario_roles" VALUES (32, 32, 3);
INSERT INTO "public"."adm_usuario_roles" VALUES (33, 33, 3);
INSERT INTO "public"."adm_usuario_roles" VALUES (34, 34, 3);
INSERT INTO "public"."adm_usuario_roles" VALUES (35, 35, 3);
INSERT INTO "public"."adm_usuario_roles" VALUES (36, 36, 3);
INSERT INTO "public"."adm_usuario_roles" VALUES (39, 3, 1);

-- ----------------------------
-- Table structure for adm_usuarios
-- ----------------------------
DROP TABLE IF EXISTS "public"."adm_usuarios";
CREATE TABLE "public"."adm_usuarios" (
  "id" int4 NOT NULL DEFAULT nextval('usuarios_id_seq'::regclass),
  "id_usuario" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "cedula" varchar(20) COLLATE "pg_catalog"."default",
  "nombre1" varchar(100) COLLATE "pg_catalog"."default",
  "nombre2" varchar(100) COLLATE "pg_catalog"."default",
  "apellido1" varchar(100) COLLATE "pg_catalog"."default",
  "apellido2" varchar(100) COLLATE "pg_catalog"."default",
  "contraseña" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "avatar" varchar(255) COLLATE "pg_catalog"."default" DEFAULT 'avatar1.jpeg'::character varying,
  "estado_us" varchar(255) COLLATE "pg_catalog"."default"
)
;

-- ----------------------------
-- Records of adm_usuarios
-- ----------------------------
INSERT INTO "public"."adm_usuarios" VALUES (1, '123456789', '123456789', 'Admin', 'usuario', 'Principal', 'admin', '$2y$10$/fjM7rEnJeRM/YezqFNUn.NRgh7jOHrBA9jSgKwNoiVtY7WTkgVDq', 'avatar1.jpeg', '1');
INSERT INTO "public"."adm_usuarios" VALUES (4, '1000972341', '1000972341', 'Leidy', 'Estefania', 'Aponte', 'Montañez', '$2y$10$CyI63XAZPrOjzq5QM4cYyeUY9Od1OZ81jj0Rni2fc8PFx2sCRwZF6', 'avatar1.jpeg', '1');
INSERT INTO "public"."adm_usuarios" VALUES (5, '1125476642', '1125476642', 'Ingrid', 'Tatiana', 'Jaramillo', 'Uribe', '$2y$10$Mfj8IuUDw60hOA/UTac/mem7yVNVZVpqwJNXr5jNZ9mzFosN6BIVi', 'avatar1.jpeg', '1');
INSERT INTO "public"."adm_usuarios" VALUES (6, '1122138443', '1122138443', 'Jefrey', '', 'Andrade', 'Bolivar', '$2y$10$xdpJcJj35XZurH1elgVvl.aIILOdTRVa2TcD1lXwBhwap3QiMNn26', 'avatar1.jpeg', '1');
INSERT INTO "public"."adm_usuarios" VALUES (7, '1121875256', '1121875256', 'Sofia', 'Paola', 'Cubillos', 'Patiño', '$2y$10$Xjf5rPDfxG8LO2fIzoG5/uYdp33c9EfxYLQZ4fEIbfScuoqTXca1K', 'avatar1.jpeg', '1');
INSERT INTO "public"."adm_usuarios" VALUES (8, '1000972343', '1000972343', 'Laura', 'Katerin', 'Aponte', 'Montañez', '$2y$10$/./GrYNXXfxpLvxVhTfCSOEUKEDOXKZGfZdHjA9s2YJYi9eAejKgS', 'avatar1.jpeg', '1');
INSERT INTO "public"."adm_usuarios" VALUES (9, '1121823601', '1121823601', 'Diego', 'Fernando', 'Camacho', 'Ureña', '$2y$10$sRq.kItF7Qpk/5ioBjtghes3NoNMOnNWuqFmR2w8OH/3R1GZjNc9y', 'avatar1.jpeg', '1');
INSERT INTO "public"."adm_usuarios" VALUES (10, '1122118911', '1122118911', 'Sandra', 'Liliana', 'Guevara', 'Velasquez', '$2y$10$eCx9kB1Uzlo4gA3FtS7Z8uVI0Us1NqeANuGMUnA/mewOQrLWhqiUC', 'avatar1.jpeg', '1');
INSERT INTO "public"."adm_usuarios" VALUES (11, '1006658935', '1006658935', 'Nidia', 'Jhoana', 'Reyes', 'Rodriguez', '$2y$10$B67Ifbzjyv5DS/3DLJny5eLXUp.B13wMUmMtzUVYLIE2DJ7As29o2', 'avatar1.jpeg', '1');
INSERT INTO "public"."adm_usuarios" VALUES (12, '1123116616', '1123116616', 'Martha', 'Yuranis', 'Lopez', 'Noreña', '$2y$10$vMg5R704LXZ3Nj2ppn28/.yEOBtugNOPcXpPiVvVdQuf3ixDbDeT.', 'avatar1.jpeg', '1');
INSERT INTO "public"."adm_usuarios" VALUES (13, '1000160932', '1000160932', 'Yury', 'Nayelly', 'Gualteros', 'Ospina', '$2y$10$aHbUSL3z.cmd79.fVVLhyOrHqzF5qaMv5P2/yCvsbFpFYcqPwEGMO', 'avatar1.jpeg', '1');
INSERT INTO "public"."adm_usuarios" VALUES (14, '74846079', '74846079', 'Aristobulo', '', 'Beltran', 'Mora', '$2y$10$QgqE73g8v6fjfjP5xSYVCeJDFpjsB87oFuq8QGVJqAIew7ubpuzFu', 'avatar1.jpeg', '1');
INSERT INTO "public"."adm_usuarios" VALUES (15, '52900115', '52900115', 'Diana', 'Constanza', 'Rieros', 'Medina', '$2y$10$Z0T9uHya5aa5r65fk6iyXu32Txo5nO12krhF/Fkr/tPGtdOPH1bEC', 'avatar1.jpeg', '1');
INSERT INTO "public"."adm_usuarios" VALUES (16, '79951026', '79951026', 'Diego', 'Manuel', 'Riveros', 'Santamaria', '$2y$10$TVZcNytwFuGJxwHb1mIw5uzGX6tXJp1mN9R9/Ds1EHiFyzlVciVsW', 'avatar1.jpeg', '1');
INSERT INTO "public"."adm_usuarios" VALUES (17, '79636045', '79636045', 'Edwin', 'Olimpo', 'Delgado', 'Mendoza', '$2y$10$yj0iSxeIx0ohz0xIHv/FjOumnzsxgG4fbbvgq.auVcgTn3tr9StPG', 'avatar1.jpeg', '1');
INSERT INTO "public"."adm_usuarios" VALUES (18, '83230060', '83230060', 'Adolfo', '', 'Parra', 'Vargas', '$2y$10$PxtYIkulBZxVjUX5vUZpceqNA9saEcCqMcUCz6/aoW3HyrmJMrvN2', 'avatar1.jpeg', '1');
INSERT INTO "public"."adm_usuarios" VALUES (19, '17419215', '17419215', 'Ali', 'Yovan', 'Azuero', 'Lozano', '$2y$10$APuMVO0563x3HNgGRuXN7u7xUZCVG4S4cAJsuKubhOMf72/SoG0Ze', 'avatar1.jpeg', '1');
INSERT INTO "public"."adm_usuarios" VALUES (20, '86043385', '86043385', 'Jorge', 'Alexander', 'Silva', 'Cruz', '$2y$10$yOh/iMSJ2rdxrk1N0j/DhuBkqtqjcQzUPK483nvmtHIF.ckbS/y0C', 'avatar1.jpeg', '1');
INSERT INTO "public"."adm_usuarios" VALUES (21, '1122129144', '1122129144', 'Dumar', 'Israel', 'Rojas', 'Hernandez', '$2y$10$Y1jZ7soAEa1PEtFyAErHxONXakVdEKU7uXIikIhPShUVyhKnbAnE2', 'avatar1.jpeg', '1');
INSERT INTO "public"."adm_usuarios" VALUES (22, '86069473', '86069473', 'Hector', 'Geovany', 'Romero', 'Gaviria', '$2y$10$l8EWu3I9hFbgnG9VpZfpLebD8tdog23O69swnleK/zgJWqVeuVDXq', 'avatar1.jpeg', '1');
INSERT INTO "public"."adm_usuarios" VALUES (23, '1123114665', '1123114665', 'Camila', '', 'Baez', 'Dueñas', '$2y$10$Gx8PQLUIjFilP.CsDB8J4OH0S7PW/3XfBTvu9m6A/CRWkNbZ1Qv6e', 'avatar1.jpeg', '1');
INSERT INTO "public"."adm_usuarios" VALUES (24, '13520681', '13520681', 'Edwar', 'Arturo', 'Rojas', 'Prada', '$2y$10$AHA7Xa7BpS33Y3EjukzaleazZ0hYxezQUFbUnYZ/IO2uIFmdwpfBK', 'avatar1.jpeg', '1');
INSERT INTO "public"."adm_usuarios" VALUES (25, '1121941500', '1121941500', 'Janerson', '', 'Viveros', 'Panameño', '$2y$10$qDq0k7e21//w/.sMDeSbVeKEdCG43AVUBTYXZaeCLkmWUy2ANKILy', 'avatar1.jpeg', '1');
INSERT INTO "public"."adm_usuarios" VALUES (26, '1122130280', '1122130280', 'Jenny', 'Patricia', 'Lemus', 'Ardila', '$2y$10$2UuiQok..xRhZ47ivG2rMuxeO/ReZPo5uk1by1j.XjHx8gCcW7KTq', 'avatar1.jpeg', '1');
INSERT INTO "public"."adm_usuarios" VALUES (27, '86013949', '86013949', 'Faver', '', 'Hernandez', 'Arredondo', '$2y$10$7P4vjzC8shR.93ExzRnCdOnMBFWIO3.WX8cv7vERw0M3ts2dD0W0W', 'avatar1.jpeg', '1');
INSERT INTO "public"."adm_usuarios" VALUES (28, '1007221883', '1007221883', 'Israel', '', 'Ramirez', 'Rios', '$2y$10$OSVxTipKOwF5kkp1MYjPheQcpfDMiwl4euyurqFe02vHy1eHfW8jy', 'avatar1.jpeg', '1');
INSERT INTO "public"."adm_usuarios" VALUES (29, '1032443022', '1032443022', 'Anlly', 'Julieth', 'Garzon', 'Rojas', '$2y$10$MtmbrXvgX2Tb0z2r4HXkLeKZ0xFx6UgV4Eb275efRNZczu8iU0jJK', 'avatar1.jpeg', '1');
INSERT INTO "public"."adm_usuarios" VALUES (30, '1122137853', '1122137853', 'Denis', 'Carolina', 'Reina', 'Tellez', '$2y$10$yfSSfI9Qu6mRbjtDSuE3J.ATBs6RSoGyYnJYQYm3t4XqJJQ9.kWta', 'avatar1.jpeg', '1');
INSERT INTO "public"."adm_usuarios" VALUES (31, '1122652148', '1122652148', 'Wilmer', 'Eliecer', 'Romero', 'Lopez', '$2y$10$nPAP0E1H93dA4wuLVVglAucVo72qWiU6W2aSOmsqsTPKR0Oz.SVeC', 'avatar1.jpeg', '1');
INSERT INTO "public"."adm_usuarios" VALUES (32, '1070603190', '1070603190', 'Jonathan', 'Harvey', 'Poveda', 'Rico', '$2y$10$4RRak234/NMDKol4abMeLuizf/mqjw0nkbpj.OCb8yDLTDnaV7nu2', 'avatar1.jpeg', '1');
INSERT INTO "public"."adm_usuarios" VALUES (33, '1006823065', '1006823065', 'Andrea', 'Natalia', 'Mosquera', 'Perdomo', '$2y$10$us8/tDauTSnsQMiFNeCzHORatrCuFaoMokTx5SgwS23.P5LrZ/YVS', 'avatar1.jpeg', '1');
INSERT INTO "public"."adm_usuarios" VALUES (34, '1122134580', '1122134580', 'Luz', 'Irene', 'Saavedra', 'Noreña', '$2y$10$vNxir0I2MUhKVaYGW2MgPu/54CcjcJko9CKA03lCeUmSAdP160c4a', 'avatar1.jpeg', '1');
INSERT INTO "public"."adm_usuarios" VALUES (35, '1122127448', '1122127448', 'Maryori', 'Jhoana', 'Arias', 'Sanchez', '$2y$10$ZYpUOddBBjI6HyZzTJE9dewEjTEV0yfGNZuza.PlQ3Djj0mjg.iiW', 'avatar1.jpeg', '1');
INSERT INTO "public"."adm_usuarios" VALUES (36, '17422976', '17422976', 'Mauricio', '', 'Gomez', 'Cruz', '$2y$10$xn1lde2LckF4p3mv9HZV2.H7lFiZNQkOXNQGl0Sc3of4PCxAPNiLS', 'avatar1.jpeg', '1');
INSERT INTO "public"."adm_usuarios" VALUES (3, '1006838624', '1006838624', 'Lina', 'Paola', 'Gutierrez', 'Jara', '$2y$10$5SW0pR5LMUnH5hzOIoZ9c.6Ps.503mDQ19BC38qJxcuDfBDVY4shC', 'avatar1.jpeg', '1');
INSERT INTO "public"."adm_usuarios" VALUES (2, '1121866104', '1121866104', 'Alba', 'Lucia', 'Salcedo', 'Rivas', '$2y$10$yxRThMI0D3bHIezlFmA/6eiBoiVKkKJDDbXw2BJDxe9LAhFD3g3ZK', 'avatar1.jpeg', '1');

-- ----------------------------
-- Table structure for adm_área
-- ----------------------------
DROP TABLE IF EXISTS "public"."adm_área";
CREATE TABLE "public"."adm_área" (
  "id_area" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "area" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "sub_area" varchar(255) COLLATE "pg_catalog"."default"
)
;

-- ----------------------------
-- Records of adm_área
-- ----------------------------
INSERT INTO "public"."adm_área" VALUES ('001', 'LOGISTICA Y COSECHA', 'LOGISTICA Y COSECHA');
INSERT INTO "public"."adm_área" VALUES ('002', 'PRODUCCION AGRICOLA', 'PRODUCCION AGRICOLA');
INSERT INTO "public"."adm_área" VALUES ('003', 'MANTENIMIENTO INDUSTRIAL', 'MANTENIMIENTO INDUSTRIAL');
INSERT INTO "public"."adm_área" VALUES ('004', 'FRUTA PROVEEDORES', 'FRUTA PROVEEDORES');
INSERT INTO "public"."adm_área" VALUES ('005', 'ADMINISTRACION', 'ADMINISTRACION');
INSERT INTO "public"."adm_área" VALUES ('006', 'ADMINISTRACION', 'ALMACEN');
INSERT INTO "public"."adm_área" VALUES ('007', 'AGRONOMICA', 'AGRONOMICA');
INSERT INTO "public"."adm_área" VALUES ('008', 'LOGISTICA Y COSECHA', 'SANIDAD');
INSERT INTO "public"."adm_área" VALUES ('009', 'PRODUCCION AGRICOLA', 'POLINIZACION');
INSERT INTO "public"."adm_área" VALUES ('010', 'ADMINISTRACION', 'COMPRAS');
INSERT INTO "public"."adm_área" VALUES ('011', 'ADMINISTRACION', 'CLIPA - SISTEMAS');
INSERT INTO "public"."adm_área" VALUES ('012', 'ADMINISTRACION', 'CONTABILIDAD');
INSERT INTO "public"."adm_área" VALUES ('013', 'ADMINISTRACION', 'VENTAS');
INSERT INTO "public"."adm_área" VALUES ('014', 'PLANTA EXTRACTORA', 'BASCULA');
INSERT INTO "public"."adm_área" VALUES ('015', 'PLANTA EXTRACTORA', 'LABORATORIO');
INSERT INTO "public"."adm_área" VALUES ('016', 'PLANTA EXTRACTORA', 'PLANTA EXTRACTORA');
INSERT INTO "public"."adm_área" VALUES ('017', 'COMPOST', 'COMPOST');
INSERT INTO "public"."adm_área" VALUES ('999', 'POR ASIGNAR', 'POR ASIGNAR');
INSERT INTO "public"."adm_área" VALUES ('000', '- SIN PROYECTO -', '- SIN PROYECTO -');

-- ----------------------------
-- Table structure for agr_fecha_corte
-- ----------------------------
DROP TABLE IF EXISTS "public"."agr_fecha_corte";
CREATE TABLE "public"."agr_fecha_corte" (
  "id_fc" int4 NOT NULL DEFAULT nextval('agr_fecha_corte_id_fc_seq'::regclass),
  "fecha_corte" date NOT NULL DEFAULT ('now'::text)::date
)
;

-- ----------------------------
-- Records of agr_fecha_corte
-- ----------------------------

-- ----------------------------
-- Table structure for cap_formulario
-- ----------------------------
DROP TABLE IF EXISTS "public"."cap_formulario";
CREATE TABLE "public"."cap_formulario" (
  "id" int4 NOT NULL DEFAULT nextval('formulario_id_seq'::regclass),
  "id_proceso" int4,
  "id_lugar" int4,
  "id_usuario" int4,
  "id_tipo_actividad" int4,
  "id_tema" int4,
  "hora_inicio" time(6),
  "hora_final" time(6),
  "fecha" date,
  "observaciones" text COLLATE "pg_catalog"."default"
)
;

-- ----------------------------
-- Records of cap_formulario
-- ----------------------------
INSERT INTO "public"."cap_formulario" VALUES (2, 8, 6, 35, 1, 26, '07:00:00', '00:00:00', '2024-11-14', '');
INSERT INTO "public"."cap_formulario" VALUES (3, 8, 6, 35, 2, 26, '07:00:00', '14:00:00', '2024-07-05', '');
INSERT INTO "public"."cap_formulario" VALUES (4, 8, 6, 35, 2, 43, '07:00:00', '10:00:00', '2024-07-12', '');
INSERT INTO "public"."cap_formulario" VALUES (5, 8, 6, 35, 2, 1, '07:00:00', '10:00:00', '2024-07-12', '');
INSERT INTO "public"."cap_formulario" VALUES (6, 8, 6, 35, 1, 26, '07:40:00', '10:00:00', '2024-09-03', '');

-- ----------------------------
-- Table structure for cap_formulario_asistente
-- ----------------------------
DROP TABLE IF EXISTS "public"."cap_formulario_asistente";
CREATE TABLE "public"."cap_formulario_asistente" (
  "id" int4 NOT NULL DEFAULT nextval('formulario_asistente_id_seq'::regclass),
  "id_formulario" int4 NOT NULL,
  "cedula" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "estado_aprovacion" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "nombre" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "empresa" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "cargo" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "área" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "sub_área" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "rango" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "situacion" varchar(255) COLLATE "pg_catalog"."default" NOT NULL
)
;

-- ----------------------------
-- Records of cap_formulario_asistente
-- ----------------------------
INSERT INTO "public"."cap_formulario_asistente" VALUES (1, 2, '1022349358', 'aprobo', 'JHON EDINSSON JIMENEZ VALERO', 'OLEAGINOSAS SAN MARCOS', 'POLINIZADOR', 'PRODUCCION AGRICOLA', 'POLINIZACION', 'OPERATIVOS PRODUCCION AGRICOLA', 'Activo');
INSERT INTO "public"."cap_formulario_asistente" VALUES (2, 2, '1006555318', 'aprobo', 'ORLANDO GONZALEZ', 'OLEAGINOSAS SAN MARCOS', 'POLINIZADOR', 'PRODUCCION AGRICOLA', 'POLINIZACION', 'OPERATIVOS PRODUCCION AGRICOLA', 'Activo');
INSERT INTO "public"."cap_formulario_asistente" VALUES (3, 2, '40433886', 'aprobo', 'MERLY JOHANA GOMEZ ALVAREZ', 'OLEAGINOSAS SAN MARCOS', 'POLINIZADOR', 'PRODUCCION AGRICOLA', 'POLINIZACION', 'OPERATIVOS PRODUCCION AGRICOLA', 'Activo');
INSERT INTO "public"."cap_formulario_asistente" VALUES (4, 2, '1121825154', 'aprobo', 'MARIA CAMILA BERMUDEZ ALZA', 'OLEAGINOSAS SAN MARCOS', 'POLINIZADOR', 'PRODUCCION AGRICOLA', 'POLINIZACION', 'OPERATIVOS PRODUCCION AGRICOLA', 'Activo');
INSERT INTO "public"."cap_formulario_asistente" VALUES (7, 2, '52850723', 'aprobo', 'ELIZABETH ROSAS GIRALDO', 'OLEAGINOSAS SAN MARCOS', 'POLINIZADOR', 'PRODUCCION AGRICOLA', 'POLINIZACION', 'OPERATIVOS PRODUCCION AGRICOLA', 'Activo');
INSERT INTO "public"."cap_formulario_asistente" VALUES (8, 2, '1002623157', 'aprobo', 'YESICA SIRLEY ESPEJO USECHE', 'OLEAGINOSAS SAN MARCOS', 'POLINIZADOR', 'PRODUCCION AGRICOLA', 'POLINIZACION', 'OPERATIVOS PRODUCCION AGRICOLA', 'Activo');
INSERT INTO "public"."cap_formulario_asistente" VALUES (6, 2, '1123086261', 'aprobo', 'GLADYS YOLANDA CARVAJAL MENDEZ', 'OLEAGINOSAS SAN MARCOS', 'POLINIZADOR', 'PRODUCCION AGRICOLA', 'POLINIZACION', 'OPERATIVOS PRODUCCION AGRICOLA', 'Activo');
INSERT INTO "public"."cap_formulario_asistente" VALUES (18, 4, '1121825154', 'aprobo', 'MARIA CAMILA BERMUDEZ ALZA', 'OLEAGINOSAS SAN MARCOS', 'POLINIZADOR', 'PRODUCCION AGRICOLA', 'POLINIZACION', 'OPERATIVOS PRODUCCION AGRICOLA', 'Activo');
INSERT INTO "public"."cap_formulario_asistente" VALUES (19, 4, '1006555318', 'aprobo', 'ORLANDO GONZALEZ', 'OLEAGINOSAS SAN MARCOS', 'POLINIZADOR', 'PRODUCCION AGRICOLA', 'POLINIZACION', 'OPERATIVOS PRODUCCION AGRICOLA', 'Activo');
INSERT INTO "public"."cap_formulario_asistente" VALUES (20, 4, '1123086261', 'aprobo', 'GLADYS YOLANDA CARVAJAL MENDEZ', 'OLEAGINOSAS SAN MARCOS', 'OFICIOS VARIOS II', 'LOGISTICA Y COSECHA', 'SANIDAD', 'OPERATIVOS PRODUCCION AGRICOLA', 'Activo');
INSERT INTO "public"."cap_formulario_asistente" VALUES (21, 4, '1122139934', 'aprobo', 'DISNARDA MARIA SANABRIA GUACARAPARE', 'OLEAGINOSAS SAN MARCOS', 'POLINIZADOR', 'PRODUCCION AGRICOLA', 'POLINIZACION', 'OPERATIVOS PRODUCCION AGRICOLA', 'Vacaciones');
INSERT INTO "public"."cap_formulario_asistente" VALUES (22, 4, '52850723', 'aprobo', 'ELIZABETH ROSAS GIRALDO', 'OLEAGINOSAS SAN MARCOS', 'POLINIZADOR', 'PRODUCCION AGRICOLA', 'POLINIZACION', 'OPERATIVOS PRODUCCION AGRICOLA', 'Activo');
INSERT INTO "public"."cap_formulario_asistente" VALUES (23, 4, '1002623157', 'aprobo', 'YESICA SIRLEY ESPEJO USECHE', 'OLEAGINOSAS SAN MARCOS', 'POLINIZADOR', 'PRODUCCION AGRICOLA', 'POLINIZACION', 'OPERATIVOS PRODUCCION AGRICOLA', 'Activo');
INSERT INTO "public"."cap_formulario_asistente" VALUES (10, 3, '1002623157', 'aprobo', 'YESICA SIRLEY ESPEJO USECHE', 'OLEAGINOSAS SAN MARCOS', 'POLINIZADOR', 'PRODUCCION AGRICOLA', 'POLINIZACION', 'OPERATIVOS PRODUCCION AGRICOLA', 'Activo');
INSERT INTO "public"."cap_formulario_asistente" VALUES (11, 3, '52850723', 'aprobo', 'ELIZABETH ROSAS GIRALDO', 'OLEAGINOSAS SAN MARCOS', 'POLINIZADOR', 'PRODUCCION AGRICOLA', 'POLINIZACION', 'OPERATIVOS PRODUCCION AGRICOLA', 'Activo');
INSERT INTO "public"."cap_formulario_asistente" VALUES (14, 3, '1121825154', 'aprobo', 'MARIA CAMILA BERMUDEZ ALZA', 'OLEAGINOSAS SAN MARCOS', 'POLINIZADOR', 'PRODUCCION AGRICOLA', 'POLINIZACION', 'OPERATIVOS PRODUCCION AGRICOLA', 'Activo');
INSERT INTO "public"."cap_formulario_asistente" VALUES (15, 3, '1006555318', 'aprobo', 'ORLANDO GONZALEZ', 'OLEAGINOSAS SAN MARCOS', 'POLINIZADOR', 'PRODUCCION AGRICOLA', 'POLINIZACION', 'OPERATIVOS PRODUCCION AGRICOLA', 'Activo');
INSERT INTO "public"."cap_formulario_asistente" VALUES (16, 3, '40433886', 'aprobo', 'MERLY JOHANA GOMEZ ALVAREZ', 'OLEAGINOSAS SAN MARCOS', 'POLINIZADOR', 'PRODUCCION AGRICOLA', 'POLINIZACION', 'OPERATIVOS PRODUCCION AGRICOLA', 'Activo');
INSERT INTO "public"."cap_formulario_asistente" VALUES (17, 3, '1022349358', 'aprobo', 'JHON EDINSSON JIMENEZ VALERO', 'OLEAGINOSAS SAN MARCOS', 'POLINIZADOR', 'PRODUCCION AGRICOLA', 'POLINIZACION', 'OPERATIVOS PRODUCCION AGRICOLA', 'Activo');
INSERT INTO "public"."cap_formulario_asistente" VALUES (5, 2, '1122139934', 'aprobo', 'DISNARDA MARIA SANABRIA GUACARAPARE', 'OLEAGINOSAS SAN MARCOS', 'POLINIZADOR', 'PRODUCCION AGRICOLA', 'POLINIZACION', 'OPERATIVOS PRODUCCION AGRICOLA', 'Activo');
INSERT INTO "public"."cap_formulario_asistente" VALUES (13, 3, '1122139934', 'aprobo', 'DISNARDA MARIA SANABRIA GUACARAPARE', 'OLEAGINOSAS SAN MARCOS', 'POLINIZADOR', 'PRODUCCION AGRICOLA', 'POLINIZACION', 'OPERATIVOS PRODUCCION AGRICOLA', 'Activo');
INSERT INTO "public"."cap_formulario_asistente" VALUES (24, 5, '1123086261', 'aprobo', 'GLADYS YOLANDA CARVAJAL MENDEZ', 'OLEAGINOSAS SAN MARCOS', 'OFICIOS VARIOS II', 'LOGISTICA Y COSECHA', 'SANIDAD', 'OPERATIVOS PRODUCCION AGRICOLA', 'Activo');
INSERT INTO "public"."cap_formulario_asistente" VALUES (25, 5, '1122139934', 'aprobo', 'DISNARDA MARIA SANABRIA GUACARAPARE', 'OLEAGINOSAS SAN MARCOS', 'POLINIZADOR', 'PRODUCCION AGRICOLA', 'POLINIZACION', 'OPERATIVOS PRODUCCION AGRICOLA', 'Vacaciones');
INSERT INTO "public"."cap_formulario_asistente" VALUES (26, 5, '1006555318', 'aprobo', 'ORLANDO GONZALEZ', 'OLEAGINOSAS SAN MARCOS', 'POLINIZADOR', 'PRODUCCION AGRICOLA', 'POLINIZACION', 'OPERATIVOS PRODUCCION AGRICOLA', 'Activo');
INSERT INTO "public"."cap_formulario_asistente" VALUES (12, 3, '1123086261', 'aprobo', 'GLADYS YOLANDA CARVAJAL MENDEZ', 'OLEAGINOSAS SAN MARCOS', 'POLINIZADOR', 'PRODUCCION AGRICOLA', 'POLINIZACION', 'OPERATIVOS PRODUCCION AGRICOLA', 'Activo');
INSERT INTO "public"."cap_formulario_asistente" VALUES (27, 5, '1121825154', 'aprobo', 'MARIA CAMILA BERMUDEZ ALZA', 'OLEAGINOSAS SAN MARCOS', 'POLINIZADOR', 'PRODUCCION AGRICOLA', 'POLINIZACION', 'OPERATIVOS PRODUCCION AGRICOLA', 'Activo');
INSERT INTO "public"."cap_formulario_asistente" VALUES (28, 5, '52850723', 'aprobo', 'ELIZABETH ROSAS GIRALDO', 'OLEAGINOSAS SAN MARCOS', 'POLINIZADOR', 'PRODUCCION AGRICOLA', 'POLINIZACION', 'OPERATIVOS PRODUCCION AGRICOLA', 'Activo');
INSERT INTO "public"."cap_formulario_asistente" VALUES (29, 5, '1002623157', 'aprobo', 'YESICA SIRLEY ESPEJO USECHE', 'OLEAGINOSAS SAN MARCOS', 'POLINIZADOR', 'PRODUCCION AGRICOLA', 'POLINIZACION', 'OPERATIVOS PRODUCCION AGRICOLA', 'Activo');
INSERT INTO "public"."cap_formulario_asistente" VALUES (30, 5, '40433886', 'aprobo', 'MERLY JOHANA GOMEZ ALVAREZ', 'OLEAGINOSAS SAN MARCOS', 'POLINIZADOR', 'PRODUCCION AGRICOLA', 'POLINIZACION', 'OPERATIVOS PRODUCCION AGRICOLA', 'Activo');
INSERT INTO "public"."cap_formulario_asistente" VALUES (31, 5, '1022349358', 'aprobo', 'JHON EDINSSON JIMENEZ VALERO', 'OLEAGINOSAS SAN MARCOS', 'POLINIZADOR', 'PRODUCCION AGRICOLA', 'POLINIZACION', 'OPERATIVOS PRODUCCION AGRICOLA', 'Activo');
INSERT INTO "public"."cap_formulario_asistente" VALUES (32, 6, '1022349358', 'aprobo', 'JHON EDINSSON JIMENEZ VALERO', 'OLEAGINOSAS SAN MARCOS', 'POLINIZADOR', 'PRODUCCION AGRICOLA', 'POLINIZACION', 'OPERATIVOS PRODUCCION AGRICOLA', 'Activo');
INSERT INTO "public"."cap_formulario_asistente" VALUES (33, 6, '1123086261', 'aprobo', 'GLADYS YOLANDA CARVAJAL MENDEZ', 'OLEAGINOSAS SAN MARCOS', 'OFICIOS VARIOS II', 'LOGISTICA Y COSECHA', 'SANIDAD', 'OPERATIVOS PRODUCCION AGRICOLA', 'Activo');
INSERT INTO "public"."cap_formulario_asistente" VALUES (34, 6, '1006555318', 'aprobo', 'ORLANDO GONZALEZ', 'OLEAGINOSAS SAN MARCOS', 'POLINIZADOR', 'PRODUCCION AGRICOLA', 'POLINIZACION', 'OPERATIVOS PRODUCCION AGRICOLA', 'Activo');
INSERT INTO "public"."cap_formulario_asistente" VALUES (35, 6, '52966773', 'aprobo', 'NILSA CAPERA YATE', 'OLEAGINOSAS SAN MARCOS', 'POLINIZADOR', 'PRODUCCION AGRICOLA', 'POLINIZACION', 'OPERATIVOS PRODUCCION AGRICOLA', 'Activo');
INSERT INTO "public"."cap_formulario_asistente" VALUES (36, 6, '52850723', 'aprobo', 'ELIZABETH ROSAS GIRALDO', 'OLEAGINOSAS SAN MARCOS', 'POLINIZADOR', 'PRODUCCION AGRICOLA', 'POLINIZACION', 'OPERATIVOS PRODUCCION AGRICOLA', 'Activo');
INSERT INTO "public"."cap_formulario_asistente" VALUES (37, 6, '1122119449', 'aprobo', 'OLGA LUCIA RIVEROS ORTEGA', 'OLEAGINOSAS SAN MARCOS', 'POLINIZADOR', 'PRODUCCION AGRICOLA', 'POLINIZACION', 'OPERATIVOS PRODUCCION AGRICOLA', 'Activo');
INSERT INTO "public"."cap_formulario_asistente" VALUES (38, 6, '1111194516', 'aprobo', 'YULI PAOLA CAMACHO FLOREZ', 'OLEAGINOSAS SAN MARCOS', 'POLINIZADOR', 'PRODUCCION AGRICOLA', 'POLINIZACION', 'OPERATIVOS PRODUCCION AGRICOLA', 'Activo');

-- ----------------------------
-- Table structure for cap_lugar
-- ----------------------------
DROP TABLE IF EXISTS "public"."cap_lugar";
CREATE TABLE "public"."cap_lugar" (
  "id" int4 NOT NULL DEFAULT nextval('lugar_id_seq'::regclass),
  "lugar" varchar(100) COLLATE "pg_catalog"."default" NOT NULL
)
;

-- ----------------------------
-- Records of cap_lugar
-- ----------------------------
INSERT INTO "public"."cap_lugar" VALUES (1, 'Sala de Juntas Planta');
INSERT INTO "public"."cap_lugar" VALUES (2, 'Bascula');
INSERT INTO "public"."cap_lugar" VALUES (3, 'Oficina supervisores');
INSERT INTO "public"."cap_lugar" VALUES (4, 'Sala de capacitaciones');
INSERT INTO "public"."cap_lugar" VALUES (5, 'Laboratorio');
INSERT INTO "public"."cap_lugar" VALUES (6, 'Campamento');
INSERT INTO "public"."cap_lugar" VALUES (7, 'Planta Extractora');
INSERT INTO "public"."cap_lugar" VALUES (8, 'Oficina Jefe Ventas');
INSERT INTO "public"."cap_lugar" VALUES (9, 'Oficinas Casa Amarilla');
INSERT INTO "public"."cap_lugar" VALUES (10, 'Inversiones Sol Del Llano');

-- ----------------------------
-- Table structure for cap_proceso
-- ----------------------------
DROP TABLE IF EXISTS "public"."cap_proceso";
CREATE TABLE "public"."cap_proceso" (
  "id" int4 NOT NULL DEFAULT nextval('proceso_id_seq'::regclass),
  "proceso" varchar(200) COLLATE "pg_catalog"."default" NOT NULL
)
;

-- ----------------------------
-- Records of cap_proceso
-- ----------------------------
INSERT INTO "public"."cap_proceso" VALUES (1, 'Producción industrial');
INSERT INTO "public"."cap_proceso" VALUES (2, 'Sostenibilidad');
INSERT INTO "public"."cap_proceso" VALUES (3, 'Talento Humano');
INSERT INTO "public"."cap_proceso" VALUES (4, 'Ventas');
INSERT INTO "public"."cap_proceso" VALUES (5, 'Administrativo');
INSERT INTO "public"."cap_proceso" VALUES (6, 'Compras y almacén');
INSERT INTO "public"."cap_proceso" VALUES (7, 'Gestión contable y financiera ');
INSERT INTO "public"."cap_proceso" VALUES (8, 'Logistica, cosecha y campo');

-- ----------------------------
-- Table structure for cap_tema
-- ----------------------------
DROP TABLE IF EXISTS "public"."cap_tema";
CREATE TABLE "public"."cap_tema" (
  "id" int4 NOT NULL DEFAULT nextval('tema_id_seq'::regclass),
  "nombre" varchar(100) COLLATE "pg_catalog"."default" NOT NULL
)
;

-- ----------------------------
-- Records of cap_tema
-- ----------------------------
INSERT INTO "public"."cap_tema" VALUES (1, 'Trabajo en equipo ');
INSERT INTO "public"."cap_tema" VALUES (2, 'Capacitación a supervisores de proceso');
INSERT INTO "public"."cap_tema" VALUES (3, 'Principios y criterios RSPO ');
INSERT INTO "public"."cap_tema" VALUES (4, 'Inducción Talento humano y gestión administrativa');
INSERT INTO "public"."cap_tema" VALUES (5, 'Procedimiento de despacho');
INSERT INTO "public"."cap_tema" VALUES (6, 'Procedimiento de producto No conforme');
INSERT INTO "public"."cap_tema" VALUES (7, 'Calidad de aceite (Índice en yodo)');
INSERT INTO "public"."cap_tema" VALUES (8, 'Perdidas de almendra');
INSERT INTO "public"."cap_tema" VALUES (9, 'Manual de cadena de suministro y socialización de responsabilidades. ');
INSERT INTO "public"."cap_tema" VALUES (10, 'Llenado de vagones');
INSERT INTO "public"."cap_tema" VALUES (11, 'Mesa de volteo');
INSERT INTO "public"."cap_tema" VALUES (12, 'Esterilización ');
INSERT INTO "public"."cap_tema" VALUES (13, 'Desfrutado, digestión, prensado y desfibrado.');
INSERT INTO "public"."cap_tema" VALUES (14, 'Clarificación ');
INSERT INTO "public"."cap_tema" VALUES (15, 'Almacenamiento y control de tanques de almacenamiento');
INSERT INTO "public"."cap_tema" VALUES (16, 'Palmisteria');
INSERT INTO "public"."cap_tema" VALUES (17, 'Caldera');
INSERT INTO "public"."cap_tema" VALUES (18, 'Proceso de extracción de aceite');
INSERT INTO "public"."cap_tema" VALUES (19, 'Procedimiento de recepción de RFF');
INSERT INTO "public"."cap_tema" VALUES (20, 'Instructivo para operar bascula');
INSERT INTO "public"."cap_tema" VALUES (21, 'Descargue y calificación de fruta');
INSERT INTO "public"."cap_tema" VALUES (22, 'Procedimiento de orden y aseo');
INSERT INTO "public"."cap_tema" VALUES (23, 'BPM e inocuidad alimentaria');
INSERT INTO "public"."cap_tema" VALUES (24, 'Manejo de plaguicidas ');
INSERT INTO "public"."cap_tema" VALUES (25, 'Socialización de instructivos - Monitoreos ');
INSERT INTO "public"."cap_tema" VALUES (26, 'Socialización de instructivos - Polinización');
INSERT INTO "public"."cap_tema" VALUES (27, 'Socialización de instructivos - logística de producción');
INSERT INTO "public"."cap_tema" VALUES (28, 'Socialización de ISCC,RSPO, ORGANICO');
INSERT INTO "public"."cap_tema" VALUES (29, 'Requerimientos Cadena de suministro RSPO');
INSERT INTO "public"."cap_tema" VALUES (30, 'Socialización de procedimiento PQRS');
INSERT INTO "public"."cap_tema" VALUES (31, 'Política de sostenibilidad');
INSERT INTO "public"."cap_tema" VALUES (32, 'MIPE');
INSERT INTO "public"."cap_tema" VALUES (33, 'Socialización de instructivos - Fertilización');
INSERT INTO "public"."cap_tema" VALUES (34, 'Manejo de Insumos orgánicos');
INSERT INTO "public"."cap_tema" VALUES (35, 'Manejo defensivo');
INSERT INTO "public"."cap_tema" VALUES (36, 'Manejo de cybertracker para el envió de información.');
INSERT INTO "public"."cap_tema" VALUES (37, 'Supervisión labores de corte de RFF.');
INSERT INTO "public"."cap_tema" VALUES (38, 'Supervisión de labores de mantenimiento en campo en palma de aceite.');
INSERT INTO "public"."cap_tema" VALUES (39, 'Supervisión de labores de fertilización en palma de aceite.');
INSERT INTO "public"."cap_tema" VALUES (40, 'Logística para cosecha de lotes orgánicos');
INSERT INTO "public"."cap_tema" VALUES (41, 'Uso eficiente de maquinaria agrícola y aplicaciones de agricultura de precisión');
INSERT INTO "public"."cap_tema" VALUES (42, 'Riesgo biológico');
INSERT INTO "public"."cap_tema" VALUES (43, 'Uso adecuado EPP/Sensibilización de limpieza y mantenimiento de epp');
INSERT INTO "public"."cap_tema" VALUES (44, 'Reporte de accidentes laborales, incidentes, y EL');
INSERT INTO "public"."cap_tema" VALUES (45, 'Identificación de riesgos y peligros');
INSERT INTO "public"."cap_tema" VALUES (46, 'Reporte de actos y condiciones inseguras');
INSERT INTO "public"."cap_tema" VALUES (47, 'Autocuidado ');
INSERT INTO "public"."cap_tema" VALUES (48, 'Identificación de peligros');
INSERT INTO "public"."cap_tema" VALUES (49, 'Riesgo Psicosocial');
INSERT INTO "public"."cap_tema" VALUES (50, 'Manejo racional de plaguicidas');
INSERT INTO "public"."cap_tema" VALUES (51, 'Riesgo químico. SGA');
INSERT INTO "public"."cap_tema" VALUES (52, 'Riesgo ergonómico');
INSERT INTO "public"."cap_tema" VALUES (53, 'Inducción y reinducción de seguridad y salud en el trabajo ');
INSERT INTO "public"."cap_tema" VALUES (54, 'Brigadistas de emergencia');
INSERT INTO "public"."cap_tema" VALUES (55, 'Capacitación al COPASST ');
INSERT INTO "public"."cap_tema" VALUES (56, 'Curso de 50 horas/ 20 horas');
INSERT INTO "public"."cap_tema" VALUES (57, 'Comunicación asertiva');
INSERT INTO "public"."cap_tema" VALUES (58, 'Excel');
INSERT INTO "public"."cap_tema" VALUES (59, 'Análisis e datos');
INSERT INTO "public"."cap_tema" VALUES (60, 'Calibración y Mantenimiento de Equipos');
INSERT INTO "public"."cap_tema" VALUES (61, 'Manejo del suelo ');
INSERT INTO "public"."cap_tema" VALUES (62, 'Control de calidad');
INSERT INTO "public"."cap_tema" VALUES (63, 'Diseño Web');
INSERT INTO "public"."cap_tema" VALUES (64, 'Electricidad industrial ');
INSERT INTO "public"."cap_tema" VALUES (65, 'Generación de energía');
INSERT INTO "public"."cap_tema" VALUES (66, 'Herramientas de Google');
INSERT INTO "public"."cap_tema" VALUES (67, 'Herramientas ofimáticas');
INSERT INTO "public"."cap_tema" VALUES (68, 'Manejo de aplicativo ATLAS');
INSERT INTO "public"."cap_tema" VALUES (69, 'Manejo de maquinaria y equipo');
INSERT INTO "public"."cap_tema" VALUES (70, 'Manejo integrado de plagas y enfermedades');
INSERT INTO "public"."cap_tema" VALUES (71, 'Mantenimiento de cámaras');
INSERT INTO "public"."cap_tema" VALUES (72, 'Mantenimientos de primer nivel ');
INSERT INTO "public"."cap_tema" VALUES (73, 'Nomina y seguridad social ');
INSERT INTO "public"."cap_tema" VALUES (74, 'Planeación de labores agrícolas');
INSERT INTO "public"."cap_tema" VALUES (75, 'Power Bi');
INSERT INTO "public"."cap_tema" VALUES (76, 'Rotación de inventario');
INSERT INTO "public"."cap_tema" VALUES (77, 'SAP');

-- ----------------------------
-- Table structure for cap_tipo_actividad
-- ----------------------------
DROP TABLE IF EXISTS "public"."cap_tipo_actividad";
CREATE TABLE "public"."cap_tipo_actividad" (
  "id" int4 NOT NULL DEFAULT nextval('tipo_actividad_id_seq'::regclass),
  "nombre" varchar(100) COLLATE "pg_catalog"."default" NOT NULL
)
;

-- ----------------------------
-- Records of cap_tipo_actividad
-- ----------------------------
INSERT INTO "public"."cap_tipo_actividad" VALUES (1, 'Capacitación');
INSERT INTO "public"."cap_tipo_actividad" VALUES (2, 'Charla');
INSERT INTO "public"."cap_tipo_actividad" VALUES (3, 'Reunión');
INSERT INTO "public"."cap_tipo_actividad" VALUES (4, 'Entrenamiento');
INSERT INTO "public"."cap_tipo_actividad" VALUES (5, 'Inducción');

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."adm_usuario_roles_id_seq"
OWNED BY "public"."adm_usuario_roles"."id";
SELECT setval('"public"."adm_usuario_roles_id_seq"', 39, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."agr_fecha_corte_id_fc_seq"
OWNED BY "public"."agr_fecha_corte"."id_fc";
SELECT setval('"public"."agr_fecha_corte_id_fc_seq"', 1, false);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
SELECT setval('"public"."asistente_id_seq"', 1215, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
SELECT setval('"public"."formulario_asistente_id_seq"', 38, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
SELECT setval('"public"."formulario_id_seq"', 6, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
SELECT setval('"public"."lugar_id_seq"', 10, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
SELECT setval('"public"."proceso_id_seq"', 7, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
SELECT setval('"public"."roles_id_seq"', 18, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
SELECT setval('"public"."tema_id_seq"', 77, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
SELECT setval('"public"."tipo_actividad_id_seq"', 5, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
SELECT setval('"public"."usuarios_id_seq"', 36, true);

-- ----------------------------
-- Indexes structure for table adm_cargos
-- ----------------------------
CREATE INDEX "idx_cargos_rango" ON "public"."adm_cargos" USING btree (
  "rango_cargo" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table adm_cargos
-- ----------------------------
ALTER TABLE "public"."adm_cargos" ADD CONSTRAINT "adm_cargos_pkey" PRIMARY KEY ("id_cargo");

-- ----------------------------
-- Indexes structure for table adm_colaboradores
-- ----------------------------
CREATE INDEX "idx_colaboradores_cedula" ON "public"."adm_colaboradores" USING btree (
  "ac_cedula" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Uniques structure for table adm_colaboradores
-- ----------------------------
ALTER TABLE "public"."adm_colaboradores" ADD CONSTRAINT "unique_colaborador" UNIQUE ("ac_cedula", "ac_id_situación", "ac_sub_area", "ac_id_cargo", "ac_empresa");

-- ----------------------------
-- Primary Key structure for table adm_colaboradores
-- ----------------------------
ALTER TABLE "public"."adm_colaboradores" ADD CONSTRAINT "adm_colaboradores_pkey" PRIMARY KEY ("ac_id");

-- ----------------------------
-- Primary Key structure for table adm_empresa
-- ----------------------------
ALTER TABLE "public"."adm_empresa" ADD CONSTRAINT "adm_empresa_pkey" PRIMARY KEY ("emp_id");

-- ----------------------------
-- Primary Key structure for table adm_roles
-- ----------------------------
ALTER TABLE "public"."adm_roles" ADD CONSTRAINT "adm_roles_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table adm_situación
-- ----------------------------
ALTER TABLE "public"."adm_situación" ADD CONSTRAINT "adm_situación_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Uniques structure for table adm_usuario_roles
-- ----------------------------
ALTER TABLE "public"."adm_usuario_roles" ADD CONSTRAINT "unique_usuario_rol" UNIQUE ("usuario_id", "rol_id");

-- ----------------------------
-- Primary Key structure for table adm_usuario_roles
-- ----------------------------
ALTER TABLE "public"."adm_usuario_roles" ADD CONSTRAINT "adm_usuario_roles_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table adm_usuarios
-- ----------------------------
CREATE INDEX "idx_usuarios_cedula" ON "public"."adm_usuarios" USING btree (
  "cedula" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table adm_usuarios
-- ----------------------------
ALTER TABLE "public"."adm_usuarios" ADD CONSTRAINT "adm_usuarios_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table adm_área
-- ----------------------------
CREATE INDEX "idx_area_area" ON "public"."adm_área" USING btree (
  "area" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table adm_área
-- ----------------------------
ALTER TABLE "public"."adm_área" ADD CONSTRAINT "adm_área_pkey" PRIMARY KEY ("id_area");

-- ----------------------------
-- Primary Key structure for table agr_fecha_corte
-- ----------------------------
ALTER TABLE "public"."agr_fecha_corte" ADD CONSTRAINT "agr_fecha_corte_pkey" PRIMARY KEY ("id_fc");

-- ----------------------------
-- Primary Key structure for table cap_formulario
-- ----------------------------
ALTER TABLE "public"."cap_formulario" ADD CONSTRAINT "cap_formulario_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table cap_formulario_asistente
-- ----------------------------
ALTER TABLE "public"."cap_formulario_asistente" ADD CONSTRAINT "cap_formulario_asistente_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table cap_lugar
-- ----------------------------
ALTER TABLE "public"."cap_lugar" ADD CONSTRAINT "cap_lugar_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table cap_proceso
-- ----------------------------
ALTER TABLE "public"."cap_proceso" ADD CONSTRAINT "cap_proceso_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table cap_tema
-- ----------------------------
ALTER TABLE "public"."cap_tema" ADD CONSTRAINT "cap_tema_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table cap_tipo_actividad
-- ----------------------------
ALTER TABLE "public"."cap_tipo_actividad" ADD CONSTRAINT "cap_tipo_actividad_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Foreign Keys structure for table adm_colaboradores
-- ----------------------------
ALTER TABLE "public"."adm_colaboradores" ADD CONSTRAINT "adm_colaboradores_ac_id_rol_fkey" FOREIGN KEY ("ac_id_rol") REFERENCES "public"."adm_roles" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table adm_usuario_roles
-- ----------------------------
ALTER TABLE "public"."adm_usuario_roles" ADD CONSTRAINT "fk_rol" FOREIGN KEY ("rol_id") REFERENCES "public"."adm_roles" ("id") ON DELETE CASCADE ON UPDATE NO ACTION;
ALTER TABLE "public"."adm_usuario_roles" ADD CONSTRAINT "fk_usuario" FOREIGN KEY ("usuario_id") REFERENCES "public"."adm_usuarios" ("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table cap_formulario
-- ----------------------------
ALTER TABLE "public"."cap_formulario" ADD CONSTRAINT "cap_formulario_id_lugar_fkey" FOREIGN KEY ("id_lugar") REFERENCES "public"."cap_lugar" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "public"."cap_formulario" ADD CONSTRAINT "cap_formulario_id_proceso_fkey" FOREIGN KEY ("id_proceso") REFERENCES "public"."cap_proceso" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "public"."cap_formulario" ADD CONSTRAINT "cap_formulario_id_tema_fkey" FOREIGN KEY ("id_tema") REFERENCES "public"."cap_tema" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "public"."cap_formulario" ADD CONSTRAINT "cap_formulario_id_tipo_actividad_fkey" FOREIGN KEY ("id_tipo_actividad") REFERENCES "public"."cap_tipo_actividad" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "public"."cap_formulario" ADD CONSTRAINT "cap_formulario_id_usuario_fkey" FOREIGN KEY ("id_usuario") REFERENCES "public"."adm_usuarios" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table cap_formulario_asistente
-- ----------------------------
ALTER TABLE "public"."cap_formulario_asistente" ADD CONSTRAINT "cap_formulario_asistente_id_formulario_fkey" FOREIGN KEY ("id_formulario") REFERENCES "public"."cap_formulario" ("id") ON DELETE CASCADE ON UPDATE NO ACTION;
