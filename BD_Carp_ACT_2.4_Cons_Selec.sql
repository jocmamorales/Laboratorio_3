--Actividad 2.4 BASE CARPINTERIA SUBCONSULTAS

--Aclaración: Para resolver esta actividad, ignorar la columna Estado de todas las tablas.

--1 Los pedidos que hayan sido finalizados en menor cantidad de días que la demora promedio
SELECT 
	P.*
	FROM Pedidos AS P where id=1

----resuelto ok
	SELECT 
	AUX1.ID
	FROM 
	(SELECT
	p.ID,	
	DATEDIFf (DAY,P.FechaSolicitud, P.FechaFinalizacion) as PROM
	from pedidos p 
	 )AS AUX1,

	(SELECT AVG (DATEDIFF(DAY,P.FechaSolicitud, P.FechaFinalizacion)) AS PROM 
	FROM Pedidos AS P) AUX2
	WHERE AUX1.PROM < AUX2.PROM
	-------------
	select
	 AVG(DATEDIFF(DAY,FechaSolicitud,FechaFinalizacion)*1.00) as prom
	from Pedidos
	order by
	

	-------
	SELECT ID FROM Pedidos
WHERE DATEDIFF(DAY, FechaSolicitud, FechaFinalizacion) < (
SELECT AVG(DATEDIFF(DAY,FechaSolicitud,FechaFinalizacion)*1) FROM Pedidos
) AND FechaFinalizacion IS NOT NULL
----------------
---PROMEDIO
	SELECT AVG (DATEDIFF(DAY,P.FechaSolicitud, P.FechaFinalizacion)) AS PROMEDIO
	FROM Pedidos AS P
	WHERE P.FechaFinalizacion IS NOT NULL
------
	SELECT AUX.ID
	FROM
	(SELECT A.ID
	--CONSULTA DEMORAS 
	( SELECT P.ID,
		DATEDIFF(DAY,P.FechaSolicitud, P.FechaFinalizacion) AS DEMORAS              
		FROM Pedidos AS P
		WHERE P.FechaFinalizacion IS NOT NULL) AS DEMORA,
	--CONSULTA DEMORA PROMEDIO		
	(SELECT AVG (DATEDIFF(DAY,P.FechaSolicitud, P.FechaFinalizacion)) AS DEMORAPROMEDIO
		FROM Pedidos AS P
		WHERE P.FechaFinalizacion IS NOT NULL) AS DEMPROM
		FROM PEDIDOS AS A) AS AUX  
		
		WHERE AUX.PROMEDIO> AUX.PROM 



--2 Los productos cuyo costo sea mayor que el costo del producto de Roble más caro.
select * from Productos
select * from Materiales
-- el valor de costo max de producto roble 
select TOP 1   
	P.Descripcion,
	MXP.IDMaterial,
	M.Nombre,
	p.Costo
	from Productos P
	inner join Materiales_x_Producto MXP ON MXP.IDProducto=P.ID
	INNER JOIN Materiales M ON M.ID=MXP.IDMaterial
	WHERE Nombre='Roble'
	order by p.Costo desc

---el costo de material roble mas caro


---RESUELTO OK
select 
	AUX1.Descripcion
	FROM
	(select 
		max(p.Costo) as costoK
		from Productos P
		inner join Materiales_x_Producto MXP ON MXP.IDProducto=P.ID
		INNER JOIN Materiales M ON M.ID=MXP.IDMaterial
		where Nombre='Roble') AS AUX,

	(select 
		P.Costo,
		P.Descripcion
		from Productos P ) AS AUX1
		WHERE  AUX1.Costo>AUX.costoK
	



----

select 
	P.Descripcion,
	MXP.IDMaterial,
	M.Nombre,
	p.Costo
	from Productos P
	inner join Materiales_x_Producto MXP ON MXP.IDProducto=P.ID
	INNER JOIN Materiales M ON M.ID=MXP.IDMaterial
	WHERE Nombre not like 'Roble'
	order by p.Costo desc

	
	SELECT 
	pr.Descripcion
	FROM Productos as Pr where (

	select  
	*
	from Productos P
	inner join Materiales_x_Producto MXP ON MXP.IDProducto=P.ID
	INNER JOIN Materiales M ON M.ID=MXP.IDMaterial
	WHERE Nombre LIKE 'ROBLE')as max 	
	(select 
	*
	from Productos  P
	inner join Materiales_x_Producto MXP ON MXP.IDProducto=P.ID
	INNER JOIN Materiales M ON M.ID=MXP.IDMaterial
	WHERE Nombre not like 'Roble'
	) 
	

	

--3 Los clientes que no hayan solicitado ningún producto de material Pino en el año 2022.

--ACA TODOS LOS QUE PIDIERON EN 2022 PINO
select
	c.Apellidos
	from Clientes c
	inner join Pedidos p on p.IDCliente=c.ID
	inner join Productos pr on pr.ID=p.IDProducto
	inner join Materiales_x_Producto mxp on mxp.IDProducto=pr.ID
	inner join Materiales m on m.ID= mxp.IDMaterial
	where Nombre like 'pino' and (year(p.FechaSolicitud)=2022)
	----
	--BIEN
	select * from 
	Clientes as C
	where C.ID not in(	
	select
	cl.ID
	from Clientes cL
	inner join Pedidos p on p.IDCliente=c.ID
	inner join Productos pr on pr.ID=p.IDProducto
	inner join Materiales_x_Producto mxp on mxp.IDProducto=pr.ID
	inner join Materiales m on m.ID= mxp.IDMaterial
	where Nombre like 'pino' and (year(p.FechaSolicitud)=2022))



--4 Los colaboradores que no hayan realizado ninguna tarea de Lijado en pedidos que se solicitaron en el año 2021.
	select
	*
	from
	Colaboradores C
	inner join Tareas_x_Pedido as txp on c.Legajo=txp.Legajo
	inner join Tareas as t on txp.ID=t.ID
	where t.Nombre like 'Lizado'
	---
	select
	*
	from 
	Tareas
	---
	select * from 
	Colaboradores as C
	--where c.Legajo not in
	
	
	--Los colaboradores que hayan realizado ALGUNA tarea de Lijado en pedidos que se solicitaron en el año 2021.
	SELECT
		co.Apellidos,
		CO.Nombres,
		T.Nombre
		from Colaboradores Co
		INNER JOIN Tareas_x_Pedido as txp on co.Legajo=txp.Legajo
		INNER JOIN Pedidos AS P ON P.ID=txp.IDPedido
		inner join Tareas as t on t.ID=txp.IDTarea
		where year(p.FechaSolicitud)=2021 and t.Nombre='Lizado'
		order by co.Apellidos asc

---respuesta correcta (no trae nada por problemas en la base)
		SELECT
		COL.Apellidos,
		COL.Nombres
		FROM Colaboradores COL
		WHERE COL.Legajo NOT IN
		(SELECT
				co.Legajo
				from Colaboradores Co
				INNER JOIN Tareas_x_Pedido as txp on co.Legajo=txp.Legajo
				INNER JOIN Pedidos AS P ON P.ID=txp.IDPedido
				inner join Tareas as t on t.ID=txp.IDTarea
				WHERE T.Nombre LIKE 'Lizado' AND (year(p.FechaSolicitud)=2021)
				--where year(p.FechaSolicitud)=2021 and t.Nombre='Lizado'
				)
		

	


--5 Los clientes a los que les hayan enviado (no necesariamente entregado) al menos un tercio de sus pedidos.

--SON CLIENTES QUE no tienen fecha de envio pero tienen pedidos 

			--RESUELTO OK
			SELECT
			C.*
			FROM CLIENTES C, 
					(SELECT
						P.IDCliente,
						COUNT(P.ID) AS CANTENVIADOS
						FROM Pedidos P
						INNER JOIN Envios E ON E.IDPedido=P.ID
						--WHERE P.IDCliente=27
						GROUP BY P.IDCliente) AS AUXENV,

					(SELECT
						P.IDCliente,
						COUNT(P.ID)*0.333 AS CANTPEDIDOSTOT
						FROM Pedidos P
						--WHERE P.IDCliente=27
						GROUP BY P.IDCliente) AS AUXTOTPED
			 
			 WHERE AUXENV.IDCliente=c.ID and AUXTOTPED.IDCliente=c.ID and
			 AUXENV.CANTENVIADOS >= AUXTOTPED.CANTPEDIDOSTOT
			 order by c.Apellidos



-------------------
select 
	c.ID,
	C.Nombres,
	c.Apellidos,	
	e.FechaEnvio,
	p.ID

	from Clientes as c
	inner join Pedidos as p on p.IDCliente= c.ID
	left join Envios as e on e.IDPedido= p.ID
	WHERE C.ID= 87 and e.FechaEnvio is null

--SON CLIENTES QUE tienen fecha de envio 
select 
	c.ID,
	C.Nombres,
	c.Apellidos,	
	e.FechaEnvio,
	p.ID
	from Clientes as c
	inner join Pedidos as p on p.IDCliente= c.ID
	right join Envios as e on e.IDPedido= p.ID
	WHERE C.ID= 87 


-- todos los pedidos sin fecha de envio
select 
	c.ID,
	c.Apellidos,
	c.Nombres,
	p.*
	from Clientes as c
	inner join Pedidos as p on p.IDCliente= c.ID
	WHERE C.ID= 87



	SELECT 
	--COUNT(C.ID)	
	from Clientes as c
	inner join Pedidos as p on p.IDCliente= c.ID
	inner join Envios as e on e.IDPedido= p.ID
	

--6 Los colaboradores que hayan realizado todas las tareas (no necesariamente en un mismo pedido).

--la cant de tareas realizadas por colaborador, distinto id de tarea
select 
	count (distinct txp.IDTarea) as CantidadTareas
	
	from Colaboradores c
	inner join Tareas_x_Pedido as txp on txp.Legajo=c.Legajo
	
	
	where c.Legajo =21
-----------	
	
	inner join Tareas as t on t.ID=txp.IDTarea
	where c.Legajo =21
--	group by t.ID
	--order by c.Apellidos, t.Nombre asc

--13 tareas
select 
	count(t.ID)
	from Tareas t

---------
	select
	c.Apellidos,
	c.Nombres
	from Colaboradores c
	
	(select
	count (distinct txp.IDTarea) as CantidadTareas
	from Colaboradores c
	inner join Tareas_x_Pedido as txp on txp.Legajo=c.Legajo) as 
	
	(select 
	count(distinct t.ID)
	from Tareas t) as 


--7 Por cada producto, la descripción y la cantidad de colaboradores fulltime que hayan trabajado en él y la cantidad de colaboradores parttime.

	-- PRODUCTO  Y CANTIDAD PART TIME
		select 			
			PR.Descripcion,
			count(distinct c.Legajo) as Cantpart
			from Colaboradores c
			inner join Tareas_x_Pedido as txp on txp.Legajo=c.Legajo
			inner join Pedidos as p on p.ID=txp.IDPedido
			inner join Productos as pr on pr.ID= p.IDProducto
			where c.ModalidadTrabajo='P'
			group by pr.Descripcion
	
	-- PRODUCTO  Y CANTIDAD FULL TIME
		select 
				pr.Descripcion,
				count(distinct c.Legajo) as Cantfull				
				from Colaboradores c
				inner join Tareas_x_Pedido as txp on txp.Legajo=c.Legajo
				inner join Pedidos as p on p.ID=txp.IDPedido
				inner join Productos as pr on pr.ID= p.IDProducto
				where c.ModalidadTrabajo='f'
				--where p.IDCliente=pr.ID and c.ModalidadTrabajo='f'
				group by pr.Descripcion 
	----------------
		
		SELECT 
		aux.
		
		FROM Productos PRO
	
		(select 			
			count(distinct c.Legajo) as Cantpart
			from  Colaboradores c
			inner join Tareas_x_Pedido as txp on txp.Legajo=c.Legajo
			inner join Pedidos as p on p.ID=txp.IDPedido
			inner join Productos as pr on pr.ID= p.IDProducto
			where c.ModalidadTrabajo='P') AS AUX)
			
			,
		
		select 
				count(distinct c.Legajo) as Cantfull				
				from Colaboradores c
				inner join Tareas_x_Pedido as txp on txp.Legajo=c.Legajo
				inner join Pedidos as p on p.ID=txp.IDPedido
				inner join Productos as pr on pr.ID= p.IDProducto
				where p.IDCliente=pr.ID and c.ModalidadTrabajo='f' 
				group by pr.Descripcion 
	--------
	select 
	AUX1.Descripcion
	FROM
	(select 
		max(p.Costo) as costoK
		from Productos P
		inner join Materiales_x_Producto MXP ON MXP.IDProducto=P.ID
		INNER JOIN Materiales M ON M.ID=MXP.IDMaterial
		where Nombre='Roble') AS AUX,

	(select 
		P.Costo,
		P.Descripcion
		from Productos P ) AS AUX1
		WHERE  AUX1.Costo>AUX.costoK
	--------
	SELECT 
	Descripcion, 
	SUM(Colaboradores_FullTime) Colaboradores_FullTime, 
	SUM(Colaboradores_PartTime) Colaboradores_PartTime 
	FROM (
		
		SELECT 
		PROD.ID, 
		PROD.Descripcion AS Descripcion,
				     
				(SELECT 
				COUNT(DISTINCT T.Legajo ) 
				FROM Tareas_x_Pedido T
				INNER JOIN Pedidos PED ON PED.ID = T.IDPedido
				INNER JOIN Colaboradores COL ON COL.Legajo = T.Legajo
				WHERE PED.IDProducto = PROD.ID AND COL.ModalidadTrabajo = 'F') AS Colaboradores_FullTime,
			   (
				SELECT COUNT(DISTINCT T.Legajo ) FROM Tareas_x_Pedido T
				INNER JOIN Pedidos PED ON PED.ID = T.IDPedido
				INNER JOIN Colaboradores COL ON COL.Legajo = T.Legajo
				WHERE PED.IDProducto = PROD.ID AND COL.ModalidadTrabajo = 'P') AS Colaboradores_PartTime
				FROM Productos PROD 
				) AS Productos
		GROUP BY ID, Descripcion


--8 Por cada producto, la descripción y la cantidad de pedidos enviados y la cantidad de pedidos sin envío.
	
	SELECT 
	p.Descripcion,
	--count (distinct e.IDPedido) as envios
	count (distinct pe.ID) as envioIDpedido
	FROM Productos P
	INNER JOIN Pedidos PE ON PE.IDProducto=P.ID
	--left JOIN Envios E ON E.IDPedido=P.ID
	right JOIN Envios E ON E.IDPedido=P.ID
	--WHERE P.Descripcion='SILLA roma'
	group by p.Descripcion
	
	
	
	SELECT 
	p.Descripcion,
	--count (distinct e.IDPedido) as envios
	count (distinct pe.ID) as envioIDpedido
	FROM Productos P
	INNER JOIN Pedidos PE ON PE.IDProducto=P.ID
	left JOIN Envios E ON E.IDPedido=P.ID
	--right JOIN Envios E ON E.IDPedido=P.ID
	--WHERE P.Descripcion='SILLA roma'
	group by p.Descripcion

		SELECT 
	p.Descripcion,
	--count (distinct e.IDPedido) as envios
	count (distinct pe.ID) as envioIDpedido
	FROM Productos P
	INNER JOIN Pedidos PE ON PE.IDProducto=P.ID
	inner JOIN Envios E ON E.IDPedido=P.ID
	--WHERE P.Descripcion='SILLA roma'
	group by p.Descripcion




	
	-- PEDIDOS ENVIADOS 631
	SELECT 
	count (distinct pe.ID) AS CANTENVIADOS
	FROM Productos P
	INNER JOIN Pedidos PE ON PE.IDProducto=P.ID
	INNER JOIN Envios E ON E.IDPedido=P.ID
	WHERE P.Descripcion='SILLA roma'
	-----
	--CANT PEDIDOS TOTALES 1000---48
	SELECT 
	COUNT (distinct pe.ID) AS CantTOTALdepedidos
	FROM Productos P
	INNER JOIN Pedidos PE ON PE.IDProducto=P.ID
	WHERE P.Descripcion='SILLA roma'
	---
	--2
	SELECT 
	--COUNT (distinct P.ID) AS CANTENVIADOS
	COUNT (distinct E.IDPedido) AS CANTENVIADOS
	--P.Descripcion
	FROM Productos P
	left JOIN Envios E ON E.IDPedido=P.ID
	--right JOIN Envios E ON E.IDPedido=P.ID
	WHERE P.Descripcion='SILLA roma'
	--WHERE P.Descripcion='SILLA PARIS'




	
--9 Por cada cliente, apellidos y nombres y la cantidad de pedidos solicitados en los años 2020, 2021 y 2022.
--(Cada año debe mostrarse en una columna separada)

SELECT 
*
FROM Clientes

select
	
	count(p.ID) as cantpedidos2020
	from pedidos p
	where year(p.FechaSolicitud)=2020
	group by p.IDCliente


---RESUELTO OK
select 
	c.Apellidos,
	c.Nombres,
	isnull ((select count(*) 
	from Pedidos P
	where year(p.FechaSolicitud)=2020 AND P.IDCliente=C.ID
	group by p.IDCliente), 0) as 'Cant Pedidos Año 2020',
	isnull ((select count(*) 
	from Pedidos P
	where year(p.FechaSolicitud)=2021 AND P.IDCliente=C.ID
	group by p.IDCliente),0) as 'Cant Pedidos Año 2021',
	isnull ((select count(*) 
	from Pedidos P
	where year(p.FechaSolicitud)=2022 AND P.IDCliente=C.ID
	group by p.IDCliente),0) as 'Cant Pedidos Año 2022'
	from Clientes c

---------------OTRA OPCION CUANDO ES NULL AGREGAR TEXTO "VACIO"

--PREGUNTAR
select 
	c.Apellidos,
	c.Nombres,
	COALESCE((select count(*) 
	from Pedidos P
	where year(p.FechaSolicitud)=2020 AND P.IDCliente=C.ID
	group by p.IDCliente), 'VACIO') as 'Cant Pedidos Año 2020',
	(select count(*) 
	from Pedidos P
	where year(p.FechaSolicitud)=2021 AND P.IDCliente=C.ID
	group by p.IDCliente) as 'Cant Pedidos Año 2021',
	(select count(*) 
	from Pedidos P
	where year(p.FechaSolicitud)=2022 AND P.IDCliente=C.ID
	group by p.IDCliente) as 'Cant Pedidos Año 2022'
	from Clientes c


	


--10 Por cada producto, listar la descripción del producto, el costo y los materiales de construcción (en una celda separados por coma)

		--RESUELTO OK
		SELECT 
			P.Descripcion,
			P.Costo,
			STRING_AGG (M.Nombre,',') AS MATERIALES
			FROM Productos P
			INNER JOIN Materiales_x_Producto MXP ON MXP.IDProducto=P.ID
			INNER JOIN Materiales M ON M.ID=MXP.IDMaterial 
			GROUP BY P.Descripcion, P.Costo


			

--11 Por cada pedido, listar el ID, la fecha de solicitud, el nombre del producto, los apellidos y nombres
--de los colaboradores que trabajaron en el pedido y la/s tareas que el colaborador haya realizado (en una celda separados por coma)

			--RESUELTO OK
			select 
			p.ID,
			p.FechaSolicitud,
			pr.Descripcion,
			c.Apellidos,
			c.Nombres,
			STRING_AGG(t.Nombre,',') as 'Tareas realizadas'
			from Pedidos p
			inner join Productos pr on pr.ID=p.IDProducto
			inner join Tareas_x_Pedido txp on txp.IDPedido=p.ID
			inner join Tareas t on t.ID=txp.IDTarea
			inner join Colaboradores c on c.Legajo=Txp.Legajo
			group by p.ID,p.FechaSolicitud, pr.Descripcion, c.Apellidos,c.Nombres

		

--12 Las descripciones de los productos que hayan requerido el doble de colaboradores fulltime que colaboradores partime.

					---RESUELTO OK
					SELECT
					P.Descripcion
					FROM
					Productos P,
							
							(select
							p.ID,
							count(distinct c.Legajo) as cantColfULL
							from Productos p
							inner join Pedidos Ped on ped.IDProducto=p.ID
							inner join Tareas_x_Pedido txp on ped.ID=txp.IDPedido
							inner join Colaboradores C on c.Legajo= txp.Legajo
							WHERE C.ModalidadTrabajo='F'
							group by p.ID) AS AUXCANTFULL,					---8 ESTE TIENE QUE SER EL = 2XCANTCOLPART

							(select	--4
							p.ID,
							count(distinct c.Legajo) as cantCol
							from Productos p
							inner join Pedidos Ped on ped.IDProducto=p.ID
							inner join Tareas_x_Pedido txp on ped.ID=txp.IDPedido
							inner join Colaboradores C on c.Legajo= txp.Legajo
							WHERE C.ModalidadTrabajo='P'
							group by p.ID) AS AUXCANTPART
							
							WHERE AUXCANTFULL.ID=p.ID and AUXCANTPART.ID=p.ID and (AUXCANTFULL.cantColfULL*0.50) = AUXCANTPART.cantCol


--13 Las descripciones de los productos que tuvieron más pedidos sin envíos que con envíos pero que al menos tuvieron un pedido enviado.
--productos-- con envios
--
select  
COUNT (distinct e.IDPedido) as 'pedido entregado'
from Envios e
where e.Entregado=1 --25 entregado--


select 
COUNT (distinct e.IDPedido) as 'pedido no entregado'
from Envios e
where e.Entregado=0 --113 no entregado

select 
P.IDProducto,
COUNT(DISTINCT P.ID) AS 'CANTIDAD DE PEDIDOS POR PRODUCTO NO ENTREGADOS'
from Pedidos p
INNER JOIN Envios E ON E.IDPedido=P.ID
WHERE E.Entregado=0
GROUP BY P.IDProducto
ORDER BY P.IDProducto

select 
P.IDProducto,
COUNT(DISTINCT P.ID) AS 'CANTIDAD DE PEDIDOS POR PRODUCTO ENTREGADOS'
from Pedidos p
INNER JOIN Envios E ON E.IDPedido=P.ID
WHERE E.Entregado=1
GROUP BY P.IDProducto
ORDER BY P.IDProducto


select 
P.*
FROM Productos P


--14 Los nombre y apellidos de los clientes que hayan realizado pedidos en los años 2020, 2021 y 2022
--pero que la cantidad de pedidos haya decrecido en cada año. Añadirle al listado aquellos clientes 
--que hayan realizado exactamente la misma cantidad de pedidos en todos los años y que dicha cantidad no sea cero.

--CANTPED20 MENOR A CANTPED21 MENOR A CANTPED22 
--CANTPED20 == CANTPED21 == CANTPED22  
--AND CANTPED20 <>0 AND CANTPED21 <>0 AND CANTPED22<>0
--resultado angel 16 clientes a mi me da 21
					select 
						C.Apellidos,
						C.Nombres,
						aux20.CANTP20 AS CANTIDAD20,
						aux21.CANTP21 AS CANTIDAD21,
						AUX22.CANTP22 AS CANT22

						FROM CLIENTES C,
						
						(SELECT 
						P.IDCliente,
						count(DISTINCT P.ID) AS CANTP20
						from Pedidos P
						INNER JOIN Clientes C ON C.ID=P.IDCliente
						where year(p.FechaSolicitud)=2020 
						group by p.IDCliente) AS aux20,
						
						(SELECT 
						P.IDCliente,
						count(DISTINCT P.ID) AS CANTP21
						from Pedidos P
						INNER JOIN Clientes C ON C.ID=P.IDCliente
						where year(p.FechaSolicitud)=2021
						group by p.IDCliente ) aux21,

						(SELECT 
						P.IDCliente,
						count(DISTINCT P.ID) AS CANTP22
						from Pedidos P
						INNER JOIN Clientes C ON C.ID=P.IDCliente
						where year(p.FechaSolicitud)=2022 
						group by p.IDCliente) aux22 
						WHERE aux20.IDCliente=C.ID AND aux21.IDCliente=c.ID and aux22.IDCliente=c.ID 
						and aux20.CANTP20 IS NOT NULL AND aux21.CANTP21 is not null AND aux22.CANTP22 IS NOT NULL  and 
						aux20.CANTP20>aux21.CANTP21 and aux21.CANTP21>aux22.CANTP22 
						Order by c.Apellidos
						
						---0-0-0 Tcant >0
						---1-1-1 a=b y b=c
						--CON EL >= ME DA 21 SIN EL = ME DA 10


------
	select 
	AUX1.Descripcion
	FROM
	(select 
		max(p.Costo) as costoK
		from Productos P
		inner join Materiales_x_Producto MXP ON MXP.IDProducto=P.ID
		INNER JOIN Materiales M ON M.ID=MXP.IDMaterial
		where Nombre='Roble') AS AUX,

	(select 
		P.Costo,
		P.Descripcion
		from Productos P ) AS AUX1
		WHERE  AUX1.Costo>AUX.costoK
----


