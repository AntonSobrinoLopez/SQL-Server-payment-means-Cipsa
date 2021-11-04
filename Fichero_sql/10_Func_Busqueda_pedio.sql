use Payment_means
go

CREATE FUNCTION Func_Busqueda_pedido
(
	@MypEDIDO VARCHAR(8)
)
RETURNS TABLE
AS 
RETURN
(
	SELECT	MyTbl.CentroVenta,MyTbl.NumPedidoOnline,MyTbl.FechaVenta,MYTBL.[Medio de pago],MyTbl.NumFactura, FORMAT (SUM(MyImporte), '######,###.## €') SALDO 
	FROM
	(
		SELECT LOP.CentroVenta,LOP.FechaVenta,LOP.NumPedidoOnline,LOP.[Medio de pago],LOP.NumFactura,
		CASE 
		WHEN LOP.NumFactura like 'FRA%' THEN LOP.ImporteDocumento
		WHEN LOP.NumFactura like 'AB%' THEN LOP.ImporteDocumento *(-1)
		WHEN LOP.NumFactura ='NO FRA' THEN  CAST( LOP.ImporteDocumento AS numeric (7,2) )
		END MyImporte
		FROM LISTADO_OPERACIONES_DIA LOP
	) MyTbl
	WHERE MyTbl.NumPedidoOnline=@MypEDIDO --- 1234_095
	GROUP BY MyTbl.CentroVenta,MyTbl.FechaVenta,MyTbl.NumPedidoOnline,MYTBL.[Medio de pago],MyTbl.NumFactura
)

----select * from dbo.Func_Busqueda_pedido ('1234_095')
