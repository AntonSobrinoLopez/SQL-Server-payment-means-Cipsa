USE Payment_means
GO

DROP PROCEDURE IF EXISTS SP_PROCEDURE_MASTER
GO

CREATE PROCEDURE SP_PROCEDURE_MASTER
AS
BEGIN

BEGIN TRY
	EXEC SP_IMPORTAR_LCX--- IMPORTA A TBL TEMPORAL DE FICHERO CSV TRASPASANDO A ORIGINAL Y BORRANDO TABLA TEMPORAL.

	EXEC SP_IMPORTAR_PayPal_temp--- IMPORTA LOS REGISTROS DEL FICHERO CSV A TABLA TEMPORAL PAYPAL.

	EXEC SP_NULL_MANAGMENT_PP--- ASIGNA LOS VALORES CORRECTOS A LOS  REGISTROS FINANCIEROS DE PAYPAL.

	EXEC SP_WARN_PAYPAL --- A�ADE LOS PEDIDOS PAYPAL CON INCIDENCIA A FICHERO DE TEXTO PARA REPORTAR.

END TRY

BEGIN CATCH
	ROLLBACK
	PRINT ERROR_NUMBER()
	PRINT ERROR_MESSAGE()
END CATCH
END


