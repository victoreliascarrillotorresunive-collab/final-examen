BEGIN;

-- 0. Limpieza previa
DROP TABLE IF EXISTS notas CASCADE;
DROP TABLE IF EXISTS examenes CASCADE;
DROP TABLE IF EXISTS inscripciones CASCADE;
DROP TABLE IF EXISTS alumnos CASCADE;
DROP TABLE IF EXISTS equipos CASCADE;
DROP TABLE IF EXISTS materias CASCADE;
DROP TABLE IF EXISTS maestros CASCADE;

-- 1. Maestros
CREATE TABLE maestros (
    id SERIAL PRIMARY KEY,
    codigo VARCHAR(10) UNIQUE NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL
);

-- 2. Materias
CREATE TABLE materias (
    id SERIAL PRIMARY KEY,
    codigo VARCHAR(10) UNIQUE NOT NULL,
    nombre VARCHAR(100) NOT NULL
);

-- 3. Equipos (Grupos/Secciones)
CREATE TABLE equipos (
    id SERIAL PRIMARY KEY,
    codigo_grupo VARCHAR(20) UNIQUE NOT NULL,
    asignatura_id INT REFERENCES materias(id) ON DELETE CASCADE,
    docente_id INT REFERENCES maestros(id) ON DELETE CASCADE,
    horario VARCHAR(100) NOT NULL,
    periodo VARCHAR(10) NOT NULL DEFAULT '2026'
);

-- 4. Alumnos
CREATE TABLE alumnos (
    id SERIAL PRIMARY KEY,
    carne VARCHAR(10) UNIQUE NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL
);

-- 5. Inscripciones
CREATE TABLE inscripciones (
    id SERIAL PRIMARY KEY,
    estudiante_id INT REFERENCES alumnos(id) ON DELETE CASCADE,
    grupo_id INT REFERENCES equipos(id) ON DELETE CASCADE,
    UNIQUE(estudiante_id, grupo_id)
);

-- 6. Exámenes
CREATE TABLE examenes (
    id SERIAL PRIMARY KEY,
    grupo_id INT REFERENCES equipos(id) ON DELETE CASCADE,
    nombre VARCHAR(100) NOT NULL,
    porcentaje NUMERIC(5,2) NOT NULL,
    fecha_evaluacion DATE NOT NULL,
    hora TIME NOT NULL,
    estado VARCHAR(20) CHECK (estado IN ('Pendiente', 'En curso', 'Finalizada')) NOT NULL DEFAULT 'Pendiente'
);

-- 7. Notas
CREATE TABLE notas (
    id SERIAL PRIMARY KEY,
    evaluacion_id INT REFERENCES examenes(id) ON DELETE CASCADE,
    estudiante_id INT REFERENCES alumnos(id) ON DELETE CASCADE,
    nota NUMERIC(4,2) CHECK (nota >= 0 AND nota <= 10),
    UNIQUE(evaluacion_id, estudiante_id)
);

-- INSERCIÓN DE DATOS

INSERT INTO maestros (codigo, nombre, apellido, email) VALUES
('DR-2026', 'Diego', 'Rodríguez', 'drodriguez@portal.edu');

INSERT INTO materias (codigo, nombre) VALUES
('PWE', 'Programación Web'),
('BD', 'Bases de Datos'),
('PW2', 'Programación Web II');

INSERT INTO equipos (codigo_grupo, asignatura_id, docente_id, horario, periodo) VALUES
('PWE-2026', 1, 1, 'Lunes · 7:00 AM - 10:00 AM', '2026'),
('BD-2026', 2, 1, 'Martes · 8:00 AM - 11:00 AM', '2026'),
('PW2-2026', 3, 1, 'Miércoles · 7:00 AM - 10:00 AM', '2026');

INSERT INTO examenes (grupo_id, nombre, porcentaje, fecha_evaluacion, hora, estado) VALUES
(1, 'Actividad 1', 15.00, '2026-08-05', '07:00:00', 'Finalizada'),
(1, 'Parcial 1', 30.00, '2026-08-18', '07:00:00', 'Pendiente'),
(2, 'Parcial 1', 30.00, '2026-08-22', '08:00:00', 'Pendiente'),
(3, 'Proyecto final', 40.00, '2026-08-28', '07:00:00', 'En curso');

INSERT INTO alumnos (carne, nombre, apellido, email) VALUES
('20260001', 'Fernando', 'Calderón', 'fernando.calderon2026@estudiantil.edu'),
('20260002', 'Amadeo', 'Valdelamar', 'amadeo.valdelamar2026@estudiantil.edu'),
('20260003', 'Beltrán', 'Algaba', 'beltran.algaba2026@estudiantil.edu'),
('20260004', 'Calixto', 'Borbón', 'calixto.borbon2026@estudiantil.edu'),
('20260005', 'Demetrio', 'Centeno', 'demetrio.centeno2026@estudiantil.edu'),
('20260006', 'Efraín', 'Dulanto', 'efrain.dulanto2026@estudiantil.edu'),
('20260007', 'Gaspar', 'Escamilla', 'gaspar.escamilla2026@estudiantil.edu'),
('20260008', 'Heliodoro', 'Fuenmayor', 'heliodoro.fuenmayor2026@estudiantil.edu'),
('20260009', 'Ignacio', 'Galíndez', 'ignacio.galindez2026@estudiantil.edu'),
('20260010', 'Jeremías', 'Hurtado', 'jeremias.hurtado2026@estudiantil.edu'),
('20260011', 'Ladislao', 'Iriarte', 'ladislao.iriarte2026@estudiantil.edu'),
('20260012', 'Melquiades', 'Jáuregui', 'melquiades.jauregui2026@estudiantil.edu'),
('20260013', 'Nicanor', 'Larragoiti', 'nicanor.larragoiti2026@estudiantil.edu'),
('20260014', 'Oswaldo', 'Madrigal', 'oswaldo.madrigal2026@estudiantil.edu'),
('20260015', 'Policarpo', 'Noguera', 'policarpo.noguera2026@estudiantil.edu'),
('20260016', 'Quintín', 'Olavarría', 'quintin.olavarria2026@estudiantil.edu'),
('20260017', 'Romualdo', 'Padrón', 'romualdo.padron2026@estudiantil.edu'),
('20260018', 'Silvano', 'Quirós', 'silvano.quiros2026@estudiantil.edu'),
('20260019', 'Tiburcio', 'Rebolledo', 'tiburcio.rebolledo2026@estudiantil.edu'),
('20260020', 'Urbano', 'Santibáñez', 'urbano.santibanez2026@estudiantil.edu'),
('20260021', 'Venancio', 'Talamantes', 'venancio.talamantes2026@estudiantil.edu'),
('20260022', 'Wenceslao', 'Urdaneta', 'wenceslao.urdaneta2026@estudiantil.edu'),
('20260023', 'Xavier', 'Valenzuela', 'xavier.valenzuela2026@estudiantil.edu'),
('20260024', 'Zacarías', 'Yáñez', 'zacarias.yanez2026@estudiantil.edu'),
('20260025', 'Anatolio', 'Zabala', 'anatolio.zabala2026@estudiantil.edu'),
('20260026', 'Adelaida', 'Almodóvar', 'adelaida.almodovar2026@estudiantil.edu'),
('20260027', 'Brunilda', 'Barrientos', 'brunilda.barrientos2026@estudiantil.edu'),
('20260028', 'Casilda', 'Cornejo', 'casilda.cornejo2026@estudiantil.edu'),
('20260029', 'Daria', 'Dávila', 'daria.davila2026@estudiantil.edu'),
('20260030', 'Eulalia', 'Encarnación', 'eulalia.encarnacion2026@estudiantil.edu'),
('20260031', 'Filomena', 'Grajales', 'filomena.grajales2026@estudiantil.edu'),
('20260032', 'Genoveva', 'Huerta', 'genoveva.huerta2026@estudiantil.edu'),
('20260033', 'Ifigenia', 'Inchaustegui', 'ifigenia.inchaustegui2026@estudiantil.edu'),
('20260034', 'Jacinta', 'Jaramillo', 'jacinta.jaramillo2026@estudiantil.edu'),
('20260035', 'Leonor', 'Leguizamón', 'leonor.leguizamon2026@estudiantil.edu'),
('20260036', 'Magnolia', 'Maldonado', 'magnolia.maldonado2026@estudiantil.edu'),
('20260037', 'Nieves', 'Ontiveros', 'nieves.ontiveros2026@estudiantil.edu'),
('20260038', 'Otilia', 'Palomares', 'otilia.palomares2026@estudiantil.edu'),
('20260039', 'Petrona', 'Quintero', 'petrona.quintero2026@estudiantil.edu'),
('20260040', 'Rufina', 'Saldivar', 'rufina.saldivar2026@estudiantil.edu'),
('20260041', 'Serapia', 'Treviño', 'serapia.trevino2026@estudiantil.edu'),
('20260042', 'Tarsila', 'Uribe', 'tarsila.uribe2026@estudiantil.edu'),
('20260043', 'Úrsula', 'Villalobos', 'ursula.villalobos2026@estudiantil.edu'),
('20260044', 'Visitación', 'Zamora', 'visitacion.zamora2026@estudiantil.edu'),
('20260045', 'Zenobia', 'Arrieta', 'zenobia.arrieta2026@estudiantil.edu'),
('20260046', 'Aurelia', 'Bustamante', 'aurelia.bustamante2026@estudiantil.edu'),
('20260047', 'Clementina', 'Castañeda', 'clementina.castaneda2026@estudiantil.edu'),
('20260048', 'Domitila', 'Espinoza', 'domitila.espinoza2026@estudiantil.edu'),
('20260049', 'Enriqueta', 'Fajardo', 'enriqueta.fajardo2026@estudiantil.edu'),
('20260050', 'Griselda', 'Gordillo', 'griselda.gordillo2026@estudiantil.edu');

INSERT INTO inscripciones (estudiante_id, grupo_id)
SELECT id, 1 FROM alumnos WHERE id BETWEEN 1 AND 28;

INSERT INTO inscripciones (estudiante_id, grupo_id)
SELECT id, 2 FROM alumnos WHERE id BETWEEN 15 AND 46;

INSERT INTO inscripciones (estudiante_id, grupo_id)
SELECT id, 3 FROM alumnos WHERE id BETWEEN 20 AND 50;

INSERT INTO notas (evaluacion_id, estudiante_id, nota) VALUES
(1, 1, 8.50),
(1, 2, 9.00),
(1, 3, 7.50),
(1, 4, 10.00),
(1, 5, 6.50);

COMMIT;