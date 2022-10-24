--1--cuantas medicas cobran sus honararios de consulta un costo mayor a $1000
--RTA ES 23
				select 
				COUNT (DISTINCT M.IDMEDICO) AS CANTIDAD_COBRAN_MAYOR_A_$1000
				from MEDICOS M
				WHERE M.COSTO_CONSULTA>1000.00 AND M.SEXO='F'


select 
	*	from
	MEDICOS as m
	where m.COSTO_CONSULTA>1000 and m.SEXO='f'

--¿Cuánto tuvo que pagar la consulta el paciente con el turno nro 146?
--Teniendo en cuenta que el paciente debe pagar el costo de la consulta del médico menos lo que cubre la cobertura de la obra social. 
--La cobertura de la obra social está expresado en un valor decimal entre 0 y 1. Siendo 0 el 0% de cobertura y 1 el 100% de la cobertura.
--Si la cobertura de la obra social es 0.2, entonces el paciente debe pagar el 80% de la consulta.
--505 0.20 ///RTA202
						SELECT
						P.APELLIDO,
						m.COSTO_CONSULTA*o.COBERTURA as Pago,
						M.COSTO_CONSULTA AS COSTO_CONSULTA,
						O.COBERTURA
						FROM PACIENTES p
						INNER JOIN TURNOS T ON T.IDTURNO=p.IDPACIENTE
						INNER JOIN MEDICOS M ON M.IDMEDICO=T.IDMEDICO
						INNER JOIN OBRAS_SOCIALES O ON O.IDOBRASOCIAL= P.IDOBRASOCIAL
						where t.IDTURNO=146


--3¿Cuántos turnos fueron atendidos por la doctora Flavia Rice?
--RTA 4
SELECT 
COUNT(DISTINCT T.IDTURNO) AS CANT_TURNOS_DRA
FROM TURNOS T
INNER JOIN MEDICOS M ON M.IDMEDICO=T.IDMEDICO
WHERE M.APELLIDO='RICE'


		SELECT 
		COUNT(DISTINCT T.IDTURNO)CANTIDAD_TURNOS
		 FROM TURNOS T
		 INNER JOIN MEDICOS M ON M.IDMEDICO=T.IDMEDICO
		 WHERE M.NOMBRE='FLAVIA' AND M.APELLIDO='RICE'


--4 ¿Cuál es la cantidad de pacientes que no se atendieron en el año 2015?
--177 PACIENTES
		SELECT 
		count (DISTINCT p.IDPACIENTE) as 'Cantidad no se atendieron en 2015'
		from pacientes p 
		WHERE P.IDPACIENTE not IN
		(select
		P.IDPACIENTE
		FROM PACIENTES P
		INNER JOIN TURNOS T ON T.IDPACIENTE=p.IDPACIENTE
		where (year(t.FECHAHORA)=2015))

		


--¿Cuáles son el/los paciente/s que se atendieron más veces? (indistintamente del sexo del paciente)

--Seleccione una o más de una:
--Cattaneo Romina
--Ramírez Soraya **Este 7 masculino
--Marino Arianna ** este 7 femenino
--Moro Silvia
			select 
			*
			from pacientes p
			inner join TURNOS t on t.IDPACIENTE=p.IDPACIENTE
			group by p.IDPACIENTE

			select top 4
			p.IDPACIENTE,
			p.APELLIDO,
			count(distinct t.IDTURNO) as cantidad
			from pacientes p
			inner join TURNOS t on t.IDPACIENTE=p.IDPACIENTE
			--where p.SEXO='m'
			group by p.IDPACIENTE, p.APELLIDO
			order by cantidad desc

			group by p.IDPACIENTE
			
			SELECT 			
			P.NOMBRE,
			P.APELLIDO
			from pacientes p 
			WHERE 
			(
			SELECT 
			P.IDPACIENTE,
			COUNT (DISTINCT T.IDTURNO) AS CANTTURNOS
			FROM PACIENTES P
			INNER JOIN TURNOS T ON T.IDPACIENTE= P.IDPACIENTE		
			WHERE P.SEXO='F'
			GROUP BY P.IDPACIENTE
			

			--group by pA.IDPACIENTE,pA.NOMBRE, pA.APELLIDO
			










---6- ¿Cuántos pacientes distintos se atendieron en turnos que duraron más que la duración promedio?
--Ejemplo hipotético: Si la duración promedio de los turnos fuese 50 minutos. 
--¿Cuántos pacientes distintos se atendieron en turnos que duraron más que 50 minutos?

--RTA 142

				SELECT
				P.IDPACIENTE,
				T.DURACION
				FROM PACIENTES P
				INNER JOIN TURNOS T ON T.IDPACIENTE=P.IDPACIENTE
				WHERE T.DURACION>51
				GROUP BY P.IDPACIENTE, T.DURACION

				--RTA CORRECTA
				SELECT
				COUNT (DISTINCT DUR.IDPACIENTE) AS CANTPACIENTES				
				FROM
				(SELECT 
				AVG(T.DURACION) AS GRALPROM --DUR>DURPROM
				FROM TURNOS T) AS PROM,
				(SELECT
				P.IDPACIENTE,
				T.DURACION
				FROM PACIENTES P
				INNER JOIN TURNOS T ON T.IDPACIENTE=P.IDPACIENTE
				WHERE P.IDPACIENTE=T.IDPACIENTE
				) AS DUR
				WHERE DUR.DURACION >PROM.GRALPROM 
				----------------
				create view tabla1 as
				SELECT
				P.IDPACIENTE,
				T.DURACION
				FROM PACIENTES P
				INNER JOIN TURNOS T ON T.IDPACIENTE=P.IDPACIENTE
				WHERE P.IDPACIENTE=T.IDPACIENTE

				select * from tabla1
				select * from tabla2
				create view tabla2 as
				SELECT
				P.IDPACIENTE,
				T.DURACION
				FROM PACIENTES P
				INNER JOIN TURNOS T ON T.IDPACIENTE=P.IDPACIENTE
				WHERE P.IDPACIENTE=T.IDPACIENTE
				
				create view tabla3 as
				SELECT 
				AVG(T.DURACION) AS GRALPROM --DUR>DURPROM
				FROM TURNOS T

				select * from tabla3
				select * from tabla1
				
				select 
				count(distinct t.DURACION)
				from tabla1 as t
				where t.DURACION>51

				drop view tabla1


--7 ¿Cuál es el apellido del médico (sexo masculino) con más antigüedad de la clínica?


				SELECT TOP 1
				M.APELLIDO
				FROM MEDICOS M
				WHERE M.SEXO='M'
				ORDER BY M.FECHAINGRESO ASC

				--RTA KIM
				select *from MEDICOS
						


--8¿Cuántos médicos tienen la especialidad "Gastroenterología" ó "Pediatría"?
--RTA 6
		
		SELECT 
		COUNT (DISTINCT M.IDMEDICO) AS CANTIDAD
		FROM MEDICOS M
		INNER JOIN ESPECIALIDADES E ON E.IDESPECIALIDAD=M.IDESPECIALIDAD
		WHERE E.NOMBRE='Gastroenterología' OR E.NOMBRE= 'Pediatría'


--9¿¿Cuál es el costo de la consulta promedio de cualquier especialista en "Oftalmología"?
--RTA 739.80
				SELECT
				AVG(M.COSTO_CONSULTA) AS PROMEDIO
				FROM MEDICOS M
				INNER JOIN ESPECIALIDADES E ON E.IDESPECIALIDAD=M.IDESPECIALIDAD
				WHERE E.NOMBRE='Oftalmología'
			


--10¿Qué Obras Sociales cubren a pacientes que se hayan atendido en algún turno con algún médico de especialidad 'Odontología'?
--RTA 
	
	--COBERTURA >0

	SELECT 
	O.NOMBRE
	FROM OBRAS_SOCIALES O
	INNER JOIN PACIENTES P ON P.IDOBRASOCIAL=O.IDOBRASOCIAL
	INNER JOIN TURNOS T ON T.IDPACIENTE=P.IDPACIENTE
	INNER JOIN MEDICOS M ON M.IDMEDICO=T.IDMEDICO
	INNER JOIN ESPECIALIDADES E ON E.IDESPECIALIDAD=M.IDESPECIALIDAD
	WHERE E.NOMBRE='Odontología'--AND O.COBERTURA>0.00

	select * from OBRAS_SOCIALES
---------------------------------------------------------------------------

--1¿Cuánto tuvo que pagar la consulta el paciente con el turno nro 146?
--Teniendo en cuenta que el paciente debe pagar el costo de la consulta del médico
--menos lo que cubre la cobertura de la obra social. La cobertura de la obra social está expresado en un valor decimal entre 0 y 1. 
--Siendo 0 el 0% de cobertura y 1 el 100% de la cobertura.
--Si la cobertura de la obra social es 0.2, entonces el paciente debe pagar el 80% de la consulta.
						
						SELECT
		
						M.COSTO_CONSULTA-(m.COSTO_CONSULTA*o.COBERTURA) as Pago
			
						FROM PACIENTES p
						INNER JOIN TURNOS T ON T.IDTURNO=p.IDPACIENTE
						INNER JOIN MEDICOS M ON M.IDMEDICO=T.IDMEDICO
						INNER JOIN OBRAS_SOCIALES O ON O.IDOBRASOCIAL= P.IDOBRASOCIAL
						where t.IDTURNO=146