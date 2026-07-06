CREATE TABLE ciudades(
	id_ciudad SERIAL PRIMARY KEY NOT NULL,
	nombre VARCHAR(100),
	departamento VARCHAR(100)
);

CREATE TABLE medicamentos(
	id_medicamento SERIAL PRIMARY KEY NOT NULL,
	nombre VARCHAR(100)
);

CREATE TABLE medicos(
	id_medico SERIAL PRIMARY KEY NOT NULL,
	nombre VARCHAR(100),
	especialidad TEXT,
	consultorio VARCHAR(50)
);

CREATE TABLE pacientes(
	id_paciente SERIAL PRIMARY KEY NOT NULL,
	nombre VARCHAR(100),
	documento VARCHAR(50),
	telefono VARCHAR(50),
	id_ciudad INT,
		FOREIGN KEY (id_ciudad) REFERENCES ciudades(id_ciudad)
);

CREATE TABLE citas(
	id_cita SERIAL PRIMARY KEY NOT NULL,
	fecha_cita DATE,
	hora_cita TIME,
	diagnotico TEXT,
	id_paciente INT,
		FOREIGN KEY(id_paciente) REFERENCES pacientes(id_paciente),
	id_medico INT,
		FOREIGN KEY(id_medico) REFERENCES medicos(id_medico)
);

CREATE TABLE recetas(
	id_receta SERIAL PRIMARY KEY NOT NULL,
	id_cita INT,
		FOREIGN KEY(id_cita)REFERENCES citas(id_cita),
	id_medicamento INT,
		FOREIGN KEY(id_medicamento)REFERENCES medicamentos(id_medicamento),
	cantidad INT
);

--Para insertar información
INSERT INTO ciudades (id_ciudad, nombre, departamento)
VALUES (4, 'Medellin', 'Antioquia');

SELECT MAX(id_ciudad)
FROM ciudades;

SELECT setval(
    pg_get_serial_sequence('ciudades', 'id_ciudad'),
    (SELECT MAX(id_ciudad) FROM ciudades)
);


INSERT INTO ciudades (nombre, departamento)
VALUES ('Letizia', 'Amazona');

SELECT * FROM pacientes;

SELECT nombre, documento FROM pacientes;
SELECT * FROM medicos;
SELECT * FROM medicamentos;
SELECT * FROM ciudades;

--mostar pacientes y medicos

SELECT p.nombre AS paciente, m.nombre AS medico
FROM pacientes p
JOIN citas c
ON p.id_paciente = c.id_paciente
JOIN medicos m
ON c.id_medico = m.id_medico;

--Mostrar únicamente los pacientes que viven en Barranquilla.

SELECT pacientes.nombre
FROM pacientes
JOIN ciudades
ON pacientes.id_ciudad = ciudades.id_ciudad
WHERE ciudades.nombre = 'Barranquilla';

SELECT pacientes.nombre, ciudades.nombre
FROM pacientes
JOIN ciudades
ON pacientes.id_ciudad = ciudades.id_ciudad
WHERE ciudades.nombre = 'Barranquilla';


--Mostrar las citas realizadas en julio.
SELECT *
FROM citas
WHERE fecha_cita BETWEEN '2026-07-01' AND '2026-07-31';


--Mostrar todas las consultas cuyo diagnóstico sea Control.
SELECT *
FROM citas
WHERE diagnotico = 'Control';

--Mostrar los medicamentos cuya cantidad entregada sea mayor a 15.
SELECT medicamentos.nombre, recetas.cantidad
FROM medicamentos
JOIN recetas
ON medicamentos.id_medicamento = recetas.id_medicamento
WHERE recetas.cantidad > 15;

--Mostrar los pacientes ordenados por nombre.
SELECT *
FROM pacientes
ORDER BY nombre;

--Mostrar las citas desde la más reciente hasta la más antigua.
SELECT *
FROM citas
ORDER BY fecha_cita;

--¿Cuántos pacientes existen?
SELECT COUNT(*)
FROM pacientes;

--¿Cuántos médicos existen?
SELECT COUNT(*)
FROM medicos;

--¿Cuántas citas existen?
SELECT COUNT(*)
FROM citas;

--¿Cuántos medicamentos diferentes existen?
SELECT COUNT(*)
FROM medicamentos;

--Mostrar: nombre del paciente, médico, fecha, diagnóstico
SELECT pacientes.nombre, medicos.nombre, citas.fecha_cita, citas.diagnotico
FROM pacientes
JOIN citas
ON pacientes.id_paciente = citas.id_paciente
JOIN medicos
ON citas.id_medico = medicos.id_medico;

--Mostrar: paciente, ciudad
SELECT p.nombre, c.nombre
FROM pacientes p
JOIN ciudades c
ON p.id_ciudad = c.id_ciudad;

--Mostrar:paciente, medicamento,cantidad
SELECT p.nombre AS paciente, m.nombre AS medicamento, r.cantidad
FROM pacientes p
JOIN citas c
    ON p.id_paciente = c.id_paciente
JOIN recetas r
    ON c.id_cita = r.id_cita
JOIN medicamentos m
    ON r.id_medicamento = m.id_medicamento;

--Mostrar:médico, especialidad, paciente
SELECT m.nombre AS medico, m.especialidad, p.nombre AS paciente
FROM pacientes p
JOIN citas c
	ON p.id_paciente = c.id_paciente
JOIN medicos m
	ON c.id_medico = m.id_medico;

--Mostrar el historial completo de cada paciente.
--Debe verse algo como:| Paciente | Médico | Fecha | Diagnóstico | Medicamento | Cantidad |
SELECT p.nombre AS Paciente, m.nombre AS Médico, 
	c.fecha_cita AS Fecha, c.diagnotico AS Diagnóstico,
	me.nombre AS Medicamento, r.cantidad
FROM pacientes p
JOIN citas c
	ON p.id_paciente = c.id_paciente
JOIN medicos m
	ON c.id_medico = m.id_medico
JOIN recetas r
	ON c.id_cita = r.id_cita
JOIN medicamentos me
	ON r.id_medicamento = me.id_medicamento;

--¿Cuántas citas tuvo cada médico?
SELECT m.nombre AS medico,
       COUNT(*) AS total_citas
FROM medicos m
JOIN citas c
    ON m.id_medico = c.id_medico
GROUP BY m.nombre;

--¿Cuántos pacientes hay por ciudad?
SELECT c.nombre AS ciudad,
	   COUNT(*) AS total_paciente
FROM ciudades c
JOIN pacientes p
	ON c.id_ciudad = p.id_ciudad
GROUP BY c.nombre;

--¿Cuántas consultas hubo por diagnóstico?
SELECT c.diagnotico AS diagnostico,
		COUNT(*) AS total_consulta
FROM citas c
GROUP BY c.diagnotico;

--¿Cuál medicamento fue el más entregado?
SELECT me.nombre AS medicamento,
    SUM(r.cantidad) AS total_entregado
FROM medicamentos me
JOIN recetas r
    ON me.id_medicamento = r.id_medicamento
GROUP BY me.nombre
ORDER BY total_entregado DESC
LIMIT 1;

--¿Cuántas consultas tuvo cada paciente?
SELECT p.nombre AS paciente,
	COUNT(*) AS total_citas
FROM pacientes p
JOIN citas c
	ON p.id_paciente = c.id_paciente
GROUP BY p.nombre;

--Mostrar los médicos que atendieron más de 2 consulta.
SELECT m.nombre AS medico,
	COUNT(c.id_cita) AS total_consulta
FROM medicos m
JOIN citas c
	ON m.id_medico = c.id_medico
GROUP BY m.nombre
HAVING COUNT(c.id_cita) > 2;

--Mostrar los pacientes que tuvieron más de una cita.
SELECT p.nombre AS paciente,
	COUNT(c.id_cita) AS total_cita
FROM pacientes p
JOIN citas c
	ON p.id_paciente = c.id_paciente
GROUP BY p.nombre
HAVING COUNT(c.id_cita) > 1;

--Mostrar los diagnósticos que aparecen más de una vez.
SELECT c.diagnotico AS diagnostico,
	COUNT(c.diagnotico) AS total
FROM citas c
GROUP BY c.diagnotico
HAVING COUNT(c.diagnotico) > 1;

--vw_pacientes
CREATE VIEW vw_pacientes AS
SELECT * FROM pacientes;
--vw_citas
CREATE VIEW vw_citas AS
SELECT * FROM citas;
--vw_historial_paciente
CREATE VIEW vw_historial_paciente AS
SELECT p.nombre AS Paciente, m.nombre AS Médico, 
	c.fecha_cita AS Fecha, c.diagnotico AS Diagnóstico,
	me.nombre AS Medicamento, r.cantidad
FROM pacientes p
JOIN citas c
	ON p.id_paciente = c.id_paciente
JOIN medicos m
	ON c.id_medico = m.id_medico
JOIN recetas r
	ON c.id_cita = r.id_cita
JOIN medicamentos me
	ON r.id_medicamento = me.id_medicamento;
--vw_consultas_por_medico
CREATE VIEW vw_consultas_por_medico AS
SELECT m.nombre AS medico,
	COUNT(c.id_cita) AS total_consultas
FROM medicos m
JOIN citas c
	ON m.id_medico = c.id_medico
GROUP BY m.nombre;
--vw_consultas_por_ciudad
CREATE VIEW vw_consultas_por_ciudad AS
SELECT ci.nombre AS consultas,
	COUNT(c.id_cita) AS total_cita
FROM ciudades ci
JOIN pacientes p
	ON ci.id_ciudad = p.id_ciudad
JOIN citas c
	ON p.id_paciente = c.id_paciente
GROUP BY ci.nombre;

--vw_medicamentos_entregados


--Para ver las vistas
SELECT *
FROM vw_pacientes;








