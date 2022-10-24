-- Listado con todos los datos de todas las películas
select * from Peliculas
-- Listado con todas las películas ordenadas por título ascendentemente
select * from Peliculas as p
order by P.Nombre asc 

-- Listado con título de la película y año de estreno
select
	P.Nombre,
	year(P.FechaEstrenoMundial) as AñoEstreno
from Peliculas as P 


-- Listado con título de la película, año de estreno y cuánto tiempo pasó (en días) entre el estreno y la fecha actual
SELECT 
	P.Nombre as TituloPelicula,
	year(P.FechaEstrenoMundial) as AñoEstreno,
	datediff(day,P.FechaEstrenoMundial,getdate()) AS DiasTranscurridosDesdeElEstreno
	FROM Peliculas AS P
	
select 
	P.Nombre,
	year(P.FechaEstrenoMundial) as AñoEstreno,
	datediff(day,P.FechaEstrenoMundial,GETDATE()) as DiasTrascurridos
	from Peliculas as p
	order by DiasTrascurridos asc
-- Listado con título de la película y año de estreno ordenado por año de mayor a menor y luego por título de menor a mayor
	select
	P.Nombre,
	P.FechaEstrenoMundial
	from Peliculas as P
	order by 
	P.FechaEstrenoMundial asc, p.Nombre desc
-- Listado con título y fecha de estreno de la película más antigua
	select distinct top 1
		P.Nombre AS TITULO,
		P.FechaEstrenoMundial AS FECHAESTRENO
	from Peliculas as P 	
	ORDER BY P.FechaEstrenoMundial	ASC

-- Listado con título y duración de la película más extensa. Si existen varias películas que cumplan esta condición, incluirlas a todas.
	select distinct
	P.Nombre as Titulo,
	P.Duracion as Duracion
	from Peliculas as P
	order by P.Duracion desc

-- Listado de todos los datos de las películas que tengan una duración mayor a 150 minutos
	select
	P.Nombre as Titulo,
	P.Duracion as DuracionMayorA150min

	from Peliculas as P
	where p.Duracion > 150
	order by p.Duracion asc
-- Listado de todos los datos de las películas que tengan una duración entre 60 y 120 minutos
	select
	P.Nombre as Titulo,
	P.Duracion as DuracionMayorA150min

	from Peliculas as P
	where p.Duracion > 60 and p.Duracion < 120 
	order by p.Duracion asc
-- Listado de todos los datos de las películas que pertenezcan a las categorías 1, 3 y  5
	select 
	P.* 
	from Peliculas as P
	WHERE P.IDCategoria = 1 OR P.IDCategoria=3 OR P.IDCategoria=5
	
	SELECT P.* 
	FROM Peliculas AS P
	WHERE P.IDCategoria IN (1,3,5)

-- Listado de todos los datos de las películas que no pertenezcan a las categorías 1, 3 y  5
	SELECT P.* 
	FROM Peliculas AS P
	WHERE not (P.IDCategoria=1 or P.IDCategoria= 3 or p.IDCategoria= 5)

	select p.*
	from Peliculas as P
	where P.IDCategoria <> 1 and P.IDCategoria <> 3 and p.IDCategoria <> 5
	
	Select * From Peliculas Where IDCategoria <> 1 And IDCategoria <> 3 And IDCategoria <> 5

	select * from Peliculas where IDCategoria not in (1,3,5)

-- Listado con título de la película, duración y tipo de duración siendo:
    -- Cortometraje - Hasta 30 minutos
    -- Mediometraje - Hasta 75 minutos
    -- Largometraje - Mayor a 75 minutos

	SELECT distinct
	P.Nombre AS TITULO,
	Duracion, 	
	CASE
		WHEN Duracion <=30 THEN 'CORTOMETRAJE'
		WHEN Duracion <=75 THEN 'MEDIOMETRAJE'
		ELSE 'LARGOMETRAJE' 
		END AS tipoDuracion
	FROM PELICULAS AS P
	
	ORDER BY p.Nombre asc,Duracion asc
	
	
	
-- Listado de todos los datos de todos los clientes que no indicaron un celular
	select 
	C.*
	from Clientes as C
	WHERE C.Celular IS NULL 

-- Listado de todos los datos de todos los clientes que indicaron un mail pero no un celular
	select 
	C.*
	from Clientes as C
	WHERE C.Email IS NOT NULL AND C.Celular IS NULL

-- Listado de apellidos y nombres de los clientes y su información de contacto. 
--La información de contacto debe ser el mail en primer lugar, si no tiene mail el celular y si no tiene celular el domicilio.
	SELECT top 1
	C.Apellidos,
	C.Nombres,
	ISNULL (c.Email, isnull(c.Celular,c.Direccion)) AS InfoContacto
	FROM Clientes AS C
	order by InfoContacto asc
-- Listado de todos los clientes cuyo apellido es Smith
	select 
	C.*
	from Clientes as c
	where c.Apellidos= 'Smith'

	select * from Clientes where apellidos like 'smith'

-- Listado de todos los datos de todos los clientes cuyo apellido finalice con 'Son'.
	select 
	c.*
	from Clientes as C
	where c.Apellidos like '%son'


-- Listado de todos los datos de todos los clientes cuyo apellido comience con vocal y finalice con vocal.
	select 
	C.*
	from Clientes as C
	where c.Apellidos like '[AEIOU]%[AEIOU]'

-- Listado de todos los datos de todos los clientes cuyo apellido contenga 5 carácteres.
	select 
	C.*
	from Clientes as C
	where c.Apellidos like '_____' order by c.Apellidos asc

	select 
	C.*
	from Clientes as C
	where len(trim(c.Apellidos))=5

-- Listado de clientes con apellidos, nombres y mail de aquellos clientes que tengan un mail con dominio .jp
	select 
	C.Apellidos,
	C.Nombres,
	C.Email
	from Clientes as C
	WHERE C.Email LIKE '%.JP'
	order by c.Nombres asc

-- Listado de clientes con apellidos, nombres y mail de aquellos clientes que tengan un mail cuya organización comience con vocal.
	select 
	C.Apellidos,
	C.Nombres,
	C.Email
	from Clientes as C
	where c.Email like '[AEIOU]%'

-- Listado de clientes con apellidos, nombre y mail de aquellos clientes que tengan un mail cuyo nombre de usuario comience con E 
--y tenga 9 carácteres en total pero no sea de tipo '.COM'
	select 
	C.Apellidos,
	C.Nombres,
	C.Email
	from Clientes as C
	where C.Email like 'E_________%'AND C.Email NOT LIKE '%.COM'
	



-- Listado con todos los apellidos sin repetir
	select DISTINCT
	C.Apellidos
	from Clientes as C
	