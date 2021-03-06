USE [master]
GO
/****** Object:  Database [LevelUp]    Script Date: 25/10/2013 06:01:58 p.m. ******/
CREATE DATABASE [LevelUp]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'LevelUp', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\LevelUp.mdf' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'LevelUp_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\LevelUp_log.ldf' , SIZE = 11200KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [LevelUp] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [LevelUp].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [LevelUp] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [LevelUp] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [LevelUp] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [LevelUp] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [LevelUp] SET ARITHABORT OFF 
GO
ALTER DATABASE [LevelUp] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [LevelUp] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [LevelUp] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [LevelUp] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [LevelUp] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [LevelUp] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [LevelUp] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [LevelUp] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [LevelUp] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [LevelUp] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [LevelUp] SET  DISABLE_BROKER 
GO
ALTER DATABASE [LevelUp] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [LevelUp] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [LevelUp] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [LevelUp] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [LevelUp] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [LevelUp] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [LevelUp] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [LevelUp] SET RECOVERY FULL 
GO
ALTER DATABASE [LevelUp] SET  MULTI_USER 
GO
ALTER DATABASE [LevelUp] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [LevelUp] SET DB_CHAINING OFF 
GO
ALTER DATABASE [LevelUp] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [LevelUp] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [LevelUp]
GO
/****** Object:  UserDefinedTableType [dbo].[tablaTipoPais]    Script Date: 25/10/2013 06:02:00 p.m. ******/
CREATE TYPE [dbo].[tablaTipoPais] AS TABLE(
	[id] [int] NULL,
	[nombreTipo] [nvarchar](50) NULL
)
GO
/****** Object:  StoredProcedure [dbo].[LUSP_AgregarXML]    Script Date: 25/10/2013 06:02:01 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[LUSP_AgregarXML]  --<Prefijo>SP_accionObjeto
	@textoXML VARCHAR(600)

AS	
	SET NOCOUNT ON  -- apagar el envio de metadatos
	
	-- Variables para control de transaccion
	DECLARE @ErrorNumber INT, @ErrorSeverity INT, @ErrorState INT, @CustomError INT
	DECLARE @Message VARCHAR(200)
	DECLARE @InicieTransaccion BIT

	-- Realizar todas las operaciones de lectura posibles y precalculos que 
	-- no sean parte o que puedan realizarse fuera de la transaccion
	
	
	SET @InicieTransaccion = 0 -- control de transacciones
	IF @@TRANCOUNT=0 BEGIN
		SET @InicieTransaccion = 1
		SET TRANSACTION ISOLATION LEVEL READ COMMITTED
		BEGIN TRANSACTION		
	END			
	
	BEGIN TRY -- control de excepciones
		-- aca mi codigo de transaccion	
		DECLARE @mydoc xml
		set @mydoc= CONVERT(XML,@textoXML)
		INSERT INTO PalabrasXIdioma (idIdioma,palabraTraducida,idPalabras) (SELECT idIdioma,traduccion,idPalabras FROM(
		SELECT Palabra,traduccion,idIdioma FROM(SELECT Palabra   = T.Item.value('@PALABRA', 'nchar(60)'),      
		traduccion = T.Item.value('@TRADUCCION', 'nchar(60)'),      
		idioma  = T.Item.value('@idioma',  'varchar(30)')
		FROM   @mydoc.nodes('Palabras/Palabra') AS T(Item))tablaTemporal INNER JOIN Idiomas ON tablaTemporal.Idioma = Idiomas.nombre)tablaIntermedia INNER JOIN Palabras ON
		Palabras.palabra = tablaIntermedia.Palabra)

		PRINT CONVERT(nvarchar(600),@mydoc)


		IF @InicieTransaccion=1 BEGIN
			COMMIT
		END		
	END TRY
	BEGIN CATCH
		SET @ErrorNumber = ERROR_NUMBER()
		SET @ErrorSeverity = ERROR_SEVERITY()
		SET @ErrorState = ERROR_STATE()
		SET @Message = ERROR_MESSAGE()
		
		IF @InicieTransaccion=1 BEGIN
			ROLLBACK
		END
		RAISERROR('%s - Error Number: %i', 
			@ErrorSeverity, @ErrorState, @Message, @CustomError)
	END CATCH	
	
RETURN 0
GO
/****** Object:  StoredProcedure [dbo].[LUSP_CrearRegla]    Script Date: 25/10/2013 06:02:03 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[LUSP_CrearRegla]  --<Prefijo>SP_accionObjeto
	@descripcion NVARCHAR(400),
	@titulo NVARCHAR(100),
	@fechaInicio DATETIME,
	@idTipoRegla INT,
	@fechaFinal DATETIME,
	@cantidad INT,
	@monto FLOAT,
	@idTipoPeriodo INT,
	@idLogro INT
	

	
AS	
	SET NOCOUNT ON  -- apagar el envio de metadatos
	
	-- Variables para control de transaccion
	DECLARE @ErrorNumber INT, @ErrorSeverity INT, @ErrorState INT, @CustomError INT
	DECLARE @Message VARCHAR(200)
	DECLARE @InicieTransaccion BIT

	-- Realizar todas las operaciones de lectura posibles y precalculos que 
	-- no sean parte o que puedan realizarse fuera de la transaccion
	
	
	SET @InicieTransaccion = 0 -- control de transacciones
	IF @@TRANCOUNT=0 BEGIN
		SET @InicieTransaccion = 1
		SET TRANSACTION ISOLATION LEVEL READ COMMITTED
		BEGIN TRANSACTION		
	END			
	
	BEGIN TRY -- control de excepciones
	
		INSERT INTO Palabras (palabra)
		VALUES (@titulo),(@descripcion)

		INSERT INTO Reglas (fechaInicio,idTipoRegla,fechaFinal,enabled,idPalabraTitulo,idPalabraDescripcion)
		VALUES (@fechaInicio,@idTipoRegla,@fechaFinal,1,(SELECT idPalabras FROM Palabras WHERE palabra =@titulo),
			   (SELECT idPalabras FROM Palabras WHERE palabra = @descripcion))
		

		INSERT INTO DetalleRegla(cantidad,monto,idTipoPeriodo,idRegla,idLogro)
		VALUES (@cantidad,@monto,@idTipoPeriodo,(SELECT IDENT_CURRENT('Reglas')),@idLogro)   


	
	
		IF @InicieTransaccion=1 BEGIN
			COMMIT
		END		
	END TRY
	BEGIN CATCH
		SET @ErrorNumber = ERROR_NUMBER()
		SET @ErrorSeverity = ERROR_SEVERITY()
		SET @ErrorState = ERROR_STATE()
		SET @Message = ERROR_MESSAGE()
		
		IF @InicieTransaccion=1 BEGIN
			ROLLBACK
		END
		RAISERROR('%s - Error Number: %i', 
			@ErrorSeverity, @ErrorState, @Message, @CustomError)
	END CATCH	
	
RETURN 0

EXEC LUSP_CrearRegla'descripcion','titulo',GETDATE,1,GETDATE,3,7000.000,1,1

DROP PROCEDURE LUSP_CrearRegla





GO
/****** Object:  StoredProcedure [dbo].[LUSP_CrearRegla2]    Script Date: 25/10/2013 06:02:03 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[LUSP_CrearRegla2]  --<Prefijo>SP_accionObjeto
	@descripcion NVARCHAR(400),
	@titulo NVARCHAR(100),
	@fechaInicio DATETIME,
	@idTipoRegla INT,
	@fechaFinal DATETIME,
	@cantidad INT,
	@monto FLOAT,
	@idTipoPeriodo INT,
	@idLogro INT
	

	
AS	
	SET NOCOUNT ON  -- apagar el envio de metadatos
	
	-- Variables para control de transaccion
	DECLARE @ErrorNumber INT, @ErrorSeverity INT, @ErrorState INT, @CustomError INT
	DECLARE @Message VARCHAR(200)
	DECLARE @InicieTransaccion BIT

	-- Realizar todas las operaciones de lectura posibles y precalculos que 
	-- no sean parte o que puedan realizarse fuera de la transaccion
	
	
	SET @InicieTransaccion = 0 -- control de transacciones
	IF @@TRANCOUNT=0 BEGIN
		SET @InicieTransaccion = 1
		SET TRANSACTION ISOLATION LEVEL READ COMMITTED
		BEGIN TRANSACTION		
	END			
	
	BEGIN TRY -- control de excepciones
	
		INSERT INTO Palabras (palabra)
		VALUES (@titulo),(@descripcion)

		INSERT INTO Reglas (fechaInicio,idTipoRegla,fechaFinal,enabled,idPalabraTitulo,idPalabraDescripcion)
		VALUES (CONVERT(datetime,@fechaInicio),@idTipoRegla,CONVERT(datetime,@fechaFinal),1,(SELECT idPalabras FROM Palabras WHERE palabra =@titulo),
			   (SELECT idPalabras FROM Palabras WHERE palabra = @descripcion))
		

		INSERT INTO DetalleRegla(cantidad,monto,idTipoPeriodo,idRegla,idLogro)
		VALUES (@cantidad,@monto,@idTipoPeriodo,(SELECT IDENT_CURRENT('Reglas')),@idLogro)   

		SELECT * FROM DetalleRegla
	
	
		IF @InicieTransaccion=1 BEGIN
			COMMIT
		END		
	END TRY
	BEGIN CATCH
		SET @ErrorNumber = ERROR_NUMBER()
		SET @ErrorSeverity = ERROR_SEVERITY()
		SET @ErrorState = ERROR_STATE()
		SET @Message = ERROR_MESSAGE()
		
		IF @InicieTransaccion=1 BEGIN
			ROLLBACK
		END
		RAISERROR('%s - Error Number: %i', 
			@ErrorSeverity, @ErrorState, @Message, @CustomError)
	END CATCH	
	
RETURN 0







GO
/****** Object:  StoredProcedure [dbo].[LUSP_CrearRegla3]    Script Date: 25/10/2013 06:02:03 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[LUSP_CrearRegla3]  --<Prefijo>SP_accionObjeto
	@descripcion NVARCHAR(400),
	@titulo NVARCHAR(100),
	@fechaInicio DATETIME,
	@idTipoRegla INT,
	@fechaFinal DATETIME,
	@cantidad INT,
	@monto FLOAT,
	@idTipoPeriodo INT,
	@idLogro INT
	

	
AS	
	SET NOCOUNT ON  -- apagar el envio de metadatos
	
	-- Variables para control de transaccion
	DECLARE @ErrorNumber INT, @ErrorSeverity INT, @ErrorState INT, @CustomError INT
	DECLARE @Message VARCHAR(200)
	DECLARE @InicieTransaccion BIT

	-- Realizar todas las operaciones de lectura posibles y precalculos que 
	-- no sean parte o que puedan realizarse fuera de la transaccion
	
	
	SET @InicieTransaccion = 0 -- control de transacciones
	IF @@TRANCOUNT=0 BEGIN
		SET @InicieTransaccion = 1
		SET TRANSACTION ISOLATION LEVEL READ COMMITTED
		BEGIN TRANSACTION		
	END			
	
	BEGIN TRY -- control de excepciones
	
		INSERT INTO Palabras (palabra)
		VALUES (@titulo),(@descripcion)

		INSERT INTO Reglas (fechaInicio,idTipoRegla,fechaFinal,enabled,idPalabraTitulo,idPalabraDescripcion)
		VALUES (@fechaInicio,@idTipoRegla,@fechaFinal,1,(SELECT idPalabras FROM Palabras WHERE palabra =@titulo),
			   (SELECT idPalabras FROM Palabras WHERE palabra = @descripcion))
		

		INSERT INTO DetalleRegla(cantidad,monto,idTipoPeriodo,idRegla,idLogro)
		VALUES (@cantidad,@monto,@idTipoPeriodo,(SELECT IDENT_CURRENT('Reglas')),@idLogro)   

		SELECT * FROM DetalleRegla
	
	
		IF @InicieTransaccion=1 BEGIN
			COMMIT
		END		
	END TRY
	BEGIN CATCH
		SET @ErrorNumber = ERROR_NUMBER()
		SET @ErrorSeverity = ERROR_SEVERITY()
		SET @ErrorState = ERROR_STATE()
		SET @Message = ERROR_MESSAGE()
		
		IF @InicieTransaccion=1 BEGIN
			ROLLBACK
		END
		RAISERROR('%s - Error Number: %i', 
			@ErrorSeverity, @ErrorState, @Message, @CustomError)
	END CATCH	
	
RETURN 0







GO
/****** Object:  StoredProcedure [dbo].[LUSP_CrearRegla4]    Script Date: 25/10/2013 06:02:03 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[LUSP_CrearRegla4]  --<Prefijo>SP_accionObjeto
	@descripcion NCHAR(10),
	@titulo NCHAR(10),
	@fechaInicio DATETIME,
	@idTipoRegla INT,
	@fechaFinal DATETIME,
	@cantidad INT,
	@monto FLOAT,
	@idTipoPeriodo INT,
	@idLogro INT
	

	
AS	
	SET NOCOUNT ON  -- apagar el envio de metadatos
	
	-- Variables para control de transaccion
	DECLARE @ErrorNumber INT, @ErrorSeverity INT, @ErrorState INT, @CustomError INT
	DECLARE @Message VARCHAR(200)
	DECLARE @InicieTransaccion BIT

	-- Realizar todas las operaciones de lectura posibles y precalculos que 
	-- no sean parte o que puedan realizarse fuera de la transaccion
	
	
	SET @InicieTransaccion = 0 -- control de transacciones
	IF @@TRANCOUNT=0 BEGIN
		SET @InicieTransaccion = 1
		SET TRANSACTION ISOLATION LEVEL READ COMMITTED
		BEGIN TRANSACTION		
	END			
	
	BEGIN TRY -- control de excepciones
	
		INSERT INTO Palabras (palabra)
		VALUES (@titulo),(@descripcion)

		INSERT INTO Reglas (fechaInicio,idTipoRegla,fechaFinal,enabled,idPalabraTitulo,idPalabraDescripcion)
		VALUES (@fechaInicio,@idTipoRegla,@fechaFinal,1,(SELECT idPalabras FROM Palabras WHERE palabra =@titulo),
			   (SELECT idPalabras FROM Palabras WHERE palabra = @descripcion))
		

		INSERT INTO DetalleRegla(cantidad,monto,idTipoPeriodo,idRegla,idLogro)
		VALUES (@cantidad,@monto,@idTipoPeriodo,(SELECT IDENT_CURRENT('Reglas')),@idLogro)   

		SELECT * FROM DetalleRegla
	
	
		IF @InicieTransaccion=1 BEGIN
			COMMIT
		END		
	END TRY
	BEGIN CATCH
		SET @ErrorNumber = ERROR_NUMBER()
		SET @ErrorSeverity = ERROR_SEVERITY()
		SET @ErrorState = ERROR_STATE()
		SET @Message = ERROR_MESSAGE()
		
		IF @InicieTransaccion=1 BEGIN
			ROLLBACK
		END
		RAISERROR('%s - Error Number: %i', 
			@ErrorSeverity, @ErrorState, @Message, @CustomError)
	END CATCH	
	
RETURN 0







GO
/****** Object:  StoredProcedure [dbo].[lUSP_InsertarXML]    Script Date: 25/10/2013 06:02:03 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[lUSP_InsertarXML]  --<Prefijo>SP_accionObjeto
	@textoXML VARCHAR(600)

AS	
	SET NOCOUNT ON  -- apagar el envio de metadatos
	
	-- Variables para control de transaccion
	DECLARE @ErrorNumber INT, @ErrorSeverity INT, @ErrorState INT, @CustomError INT
	DECLARE @Message VARCHAR(200)
	DECLARE @InicieTransaccion BIT

	-- Realizar todas las operaciones de lectura posibles y precalculos que 
	-- no sean parte o que puedan realizarse fuera de la transaccion
	
	
	SET @InicieTransaccion = 0 -- control de transacciones
	IF @@TRANCOUNT=0 BEGIN
		SET @InicieTransaccion = 1
		SET TRANSACTION ISOLATION LEVEL READ COMMITTED
		BEGIN TRANSACTION		
	END			
	
	BEGIN TRY -- control de excepciones
		-- aca mi codigo de transaccion	
		DECLARE @mydoc xml
		set @mydoc= CONVERT(XML,@textoXML)
		INSERT INTO PalabrasXIdioma (idIdioma,palabraTraducida,idPalabras) (SELECT idIdioma,traduccion,idPalabras FROM(
		SELECT Palabra,traduccion,idIdioma FROM(SELECT Palabra   = T.Item.value('@PALABRA', 'int'),      
		traduccion = T.Item.value('@traduccion', 'nchar(60)'),      
		idioma  = T.Item.value('@idioma',  'varchar(30)')
		FROM   @mydoc.nodes('Palabras/Palabra') AS T(Item))tablaTemporal INNER JOIN Idiomas ON tablaTemporal.Idioma = Idiomas.nombre)tablaIntermedia INNER JOIN Palabras ON
		Palabras.palabra = tablaIntermedia.Palabra)


		IF @InicieTransaccion=1 BEGIN
			COMMIT
		END		
	END TRY
	BEGIN CATCH
		SET @ErrorNumber = ERROR_NUMBER()
		SET @ErrorSeverity = ERROR_SEVERITY()
		SET @ErrorState = ERROR_STATE()
		SET @Message = ERROR_MESSAGE()
		
		IF @InicieTransaccion=1 BEGIN
			ROLLBACK
		END
		RAISERROR('%s - Error Number: %i', 
			@ErrorSeverity, @ErrorState, @Message, @CustomError)
	END CATCH	
	
RETURN 0
GO
/****** Object:  Table [dbo].[Aplicaciones]    Script Date: 25/10/2013 06:02:03 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Aplicaciones](
	[idAplicaciones] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [nvarchar](40) NOT NULL,
 CONSTRAINT [PK_Aplicaciones] PRIMARY KEY CLUSTERED 
(
	[idAplicaciones] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[bar]    Script Date: 25/10/2013 06:02:05 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bar](
	[col1] [int] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Categorias]    Script Date: 25/10/2013 06:02:05 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Categorias](
	[idCategoria] [int] IDENTITY(1,1) NOT NULL,
	[idPalabras] [int] NOT NULL,
	[imagen] [varchar](50) NOT NULL,
	[idTipoCategoria] [int] NOT NULL,
	[idDepartamento] [int] NOT NULL,
 CONSTRAINT [PK_Categorias] PRIMARY KEY CLUSTERED 
(
	[idCategoria] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CategoriasXEmpleado]    Script Date: 25/10/2013 06:02:05 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CategoriasXEmpleado](
	[idCategoriasXEmpleado] [int] IDENTITY(1,1) NOT NULL,
	[idCategoria] [int] NOT NULL,
	[idExpediente] [int] NOT NULL,
	[fecha] [datetime] NOT NULL,
 CONSTRAINT [PK_CategoriasXEmpleado] PRIMARY KEY CLUSTERED 
(
	[idCategoriasXEmpleado] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Ciudades]    Script Date: 25/10/2013 06:02:05 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Ciudades](
	[idCiudad] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](80) NOT NULL,
	[idProvincia] [int] NOT NULL,
 CONSTRAINT [PK_Ciudades] PRIMARY KEY CLUSTERED 
(
	[idCiudad] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Condecoraciones]    Script Date: 25/10/2013 06:02:05 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Condecoraciones](
	[idCondecoracion] [int] NOT NULL,
	[idTipoCondecoracion] [int] NOT NULL,
	[idExpediente] [int] NOT NULL,
	[idRegla] [int] NOT NULL,
 CONSTRAINT [PK_Condecoraciones] PRIMARY KEY CLUSTERED 
(
	[idCondecoracion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Contratos]    Script Date: 25/10/2013 06:02:05 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Contratos](
	[idContrato] [int] IDENTITY(1,1) NOT NULL,
	[fechaInicio] [datetime] NOT NULL,
	[descripcion] [varchar](200) NOT NULL,
	[idExpediente] [int] NOT NULL,
	[fechaFinal] [datetime] NOT NULL,
	[idEmpleadoAutoriza] [int] NOT NULL,
	[fechaAutorizo] [datetime] NOT NULL,
	[idEmpleadoInserta] [int] NOT NULL,
	[fechaInserta] [datetime] NOT NULL,
	[idTiposContrato] [int] NOT NULL,
 CONSTRAINT [PK_Contratos] PRIMARY KEY CLUSTERED 
(
	[idContrato] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Currencies]    Script Date: 25/10/2013 06:02:05 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Currencies](
	[idCurrency] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [nvarchar](100) NOT NULL,
	[simbolo] [nvarchar](50) NOT NULL,
	[currentExchangeRate] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Currencies] PRIMARY KEY CLUSTERED 
(
	[idCurrency] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Departamentos]    Script Date: 25/10/2013 06:02:05 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Departamentos](
	[idDepartamento] [int] IDENTITY(1,1) NOT NULL,
	[idPalabras] [int] NOT NULL,
	[idEmpresa] [int] NOT NULL,
 CONSTRAINT [PK_Departamentos] PRIMARY KEY CLUSTERED 
(
	[idDepartamento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DetalleRegla]    Script Date: 25/10/2013 06:02:05 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DetalleRegla](
	[cantidad] [int] NOT NULL,
	[monto] [float] NOT NULL,
	[idTipoPeriodo] [int] NOT NULL,
	[idDetalleRegla] [int] IDENTITY(1,1) NOT NULL,
	[idRegla] [int] NOT NULL,
	[idLogro] [int] NOT NULL,
 CONSTRAINT [PK_DetalleRegla] PRIMARY KEY CLUSTERED 
(
	[idDetalleRegla] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Direcciones]    Script Date: 25/10/2013 06:02:05 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Direcciones](
	[idDireccion] [int] IDENTITY(1,1) NOT NULL,
	[detalle1] [varchar](100) NOT NULL,
	[detalle2] [varchar](100) NOT NULL,
	[zipcode] [int] NOT NULL,
	[latitud] [float] NOT NULL,
	[longitud] [float] NOT NULL,
	[idCiudad] [int] NOT NULL,
 CONSTRAINT [PK_Direcciones] PRIMARY KEY CLUSTERED 
(
	[idDireccion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Empleados]    Script Date: 25/10/2013 06:02:05 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Empleados](
	[idEmpleado] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](50) NOT NULL,
	[apellido1] [varchar](50) NOT NULL,
	[apellido2] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Empleados] PRIMARY KEY CLUSTERED 
(
	[idEmpleado] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Empresa]    Script Date: 25/10/2013 06:02:05 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Empresa](
	[idEmpresa] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](50) NOT NULL,
	[idDireccion] [int] NOT NULL,
	[descripcion] [varchar](200) NOT NULL,
	[logo] [nvarchar](400) NOT NULL,
 CONSTRAINT [PK_Organizaciones] PRIMARY KEY CLUSTERED 
(
	[idEmpresa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Eventos]    Script Date: 25/10/2013 06:02:05 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Eventos](
	[idEvento] [int] IDENTITY(1,1) NOT NULL,
	[fecha] [datetime] NOT NULL,
	[idTipoEvento] [int] NOT NULL,
	[idSeveridad] [int] NOT NULL,
	[idAplicacion] [int] NOT NULL,
	[descripcion] [varchar](100) NOT NULL,
	[computadora] [varchar](20) NOT NULL,
	[usuario] [nvarchar](20) NOT NULL,
	[checksum] [varchar](40) NOT NULL,
	[ip] [varchar](40) NOT NULL,
	[referencia1] [int] NOT NULL,
	[referencia2] [int] NOT NULL,
 CONSTRAINT [PK_Eventos] PRIMARY KEY CLUSTERED 
(
	[idEvento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ExchangeRateHistories]    Script Date: 25/10/2013 06:02:05 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ExchangeRateHistories](
	[idExchangeRateHistory] [int] IDENTITY(1,1) NOT NULL,
	[currencyId1] [int] NOT NULL,
	[currencyId2] [int] NOT NULL,
	[exchangeIdRate] [int] NOT NULL,
	[fechaInicial] [datetime] NOT NULL,
	[fechaFinal] [datetime] NOT NULL,
	[current] [float] NOT NULL,
 CONSTRAINT [PK_ExchangeRateHistories] PRIMARY KEY CLUSTERED 
(
	[idExchangeRateHistory] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ExchangeRates]    Script Date: 25/10/2013 06:02:05 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ExchangeRates](
	[idExchangeRate] [int] IDENTITY(1,1) NOT NULL,
	[currencyId1] [int] NOT NULL,
	[currencyId2] [int] NOT NULL,
	[exchangeRate] [float] NOT NULL,
 CONSTRAINT [PK_ExchangeRates] PRIMARY KEY CLUSTERED 
(
	[idExchangeRate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Expedientes]    Script Date: 25/10/2013 06:02:05 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Expedientes](
	[idExpediente] [int] IDENTITY(1,1) NOT NULL,
	[fechaIngreso] [datetime] NOT NULL,
	[idEmpleado] [int] NOT NULL,
	[idPuesto] [int] NOT NULL,
 CONSTRAINT [PK_Expedientes] PRIMARY KEY CLUSTERED 
(
	[idExpediente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[foo]    Script Date: 25/10/2013 06:02:05 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[foo](
	[col1] [int] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[HistorialCambios]    Script Date: 25/10/2013 06:02:05 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HistorialCambios](
	[idHistorialCambio] [int] NOT NULL,
	[fecha] [datetime] NOT NULL,
	[valor] [float] NOT NULL,
	[idMoneda] [int] NOT NULL,
 CONSTRAINT [PK_HistorialCambios] PRIMARY KEY CLUSTERED 
(
	[idHistorialCambio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Idiomas]    Script Date: 25/10/2013 06:02:05 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Idiomas](
	[idIdioma] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Idiomas] PRIMARY KEY CLUSTERED 
(
	[idIdioma] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Instituciones]    Script Date: 25/10/2013 06:02:05 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Instituciones](
	[idInstitucion] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](50) NOT NULL,
	[idDireccion] [int] NOT NULL,
 CONSTRAINT [PK_Instituciones] PRIMARY KEY CLUSTERED 
(
	[idInstitucion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Logros]    Script Date: 25/10/2013 06:02:05 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Logros](
	[idLogro] [int] IDENTITY(1,1) NOT NULL,
	[idTipoLogro] [int] NOT NULL,
	[idExpediente] [int] NOT NULL,
	[idRegla] [int] NOT NULL,
	[idPalabraTitulo] [int] NOT NULL,
	[idPalabraDescripcion] [int] NOT NULL,
 CONSTRAINT [PK_Logros] PRIMARY KEY CLUSTERED 
(
	[idLogro] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[LogrosXEmpleado]    Script Date: 25/10/2013 06:02:05 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LogrosXEmpleado](
	[idLogrosXEmpleado] [int] IDENTITY(1,1) NOT NULL,
	[idLogro] [int] NOT NULL,
	[idEmpleado] [int] NOT NULL,
 CONSTRAINT [PK_LogrosXEmpleado] PRIMARY KEY CLUSTERED 
(
	[idLogrosXEmpleado] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Modulos]    Script Date: 25/10/2013 06:02:05 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Modulos](
	[idModulo] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [nchar](10) NOT NULL,
	[idAplicaciones] [int] NOT NULL,
 CONSTRAINT [PK_Modulos] PRIMARY KEY CLUSTERED 
(
	[idModulo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Observaciones]    Script Date: 25/10/2013 06:02:05 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Observaciones](
	[idObservacion] [int] IDENTITY(1,1) NOT NULL,
	[descripcion] [varchar](200) NOT NULL,
	[idExpediente] [int] NOT NULL,
 CONSTRAINT [PK_Observaciones] PRIMARY KEY CLUSTERED 
(
	[idObservacion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Organizacion]    Script Date: 25/10/2013 06:02:05 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Organizacion](
	[idOrganizacion] [nchar](10) NULL,
	[nombre] [nchar](10) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Paises]    Script Date: 25/10/2013 06:02:05 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Paises](
	[idPais] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](80) NOT NULL,
 CONSTRAINT [PK_Paises] PRIMARY KEY CLUSTERED 
(
	[idPais] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Palabras]    Script Date: 25/10/2013 06:02:05 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Palabras](
	[idPalabras] [int] IDENTITY(1,1) NOT NULL,
	[palabra] [nchar](10) NOT NULL,
 CONSTRAINT [PK_Palabras] PRIMARY KEY CLUSTERED 
(
	[idPalabras] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PalabrasXIdioma]    Script Date: 25/10/2013 06:02:05 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PalabrasXIdioma](
	[idPalabrasXIdioma] [int] IDENTITY(1,1) NOT NULL,
	[idIdioma] [int] NOT NULL,
	[palabraTraducida] [varchar](60) NOT NULL,
	[idPalabras] [int] NOT NULL,
 CONSTRAINT [PK_PalabrasXIdioma] PRIMARY KEY CLUSTERED 
(
	[idPalabrasXIdioma] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Permisos]    Script Date: 25/10/2013 06:02:05 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Permisos](
	[idPermisos] [int] IDENTITY(1,1) NOT NULL,
	[descripcion] [nchar](10) NOT NULL,
	[codigo] [nchar](10) NOT NULL,
	[codigoMapa] [int] NOT NULL,
	[idModulo] [int] NOT NULL,
 CONSTRAINT [PK_Permisos] PRIMARY KEY CLUSTERED 
(
	[idPermisos] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PermisosXGrupo]    Script Date: 25/10/2013 06:02:05 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PermisosXGrupo](
	[idPermisosXGrupo] [int] IDENTITY(1,1) NOT NULL,
	[enabled] [bit] NOT NULL,
	[idPermisos] [int] NOT NULL,
	[idTipoUsuarios] [int] NOT NULL,
 CONSTRAINT [PK_PermisosXGrupo] PRIMARY KEY CLUSTERED 
(
	[idPermisosXGrupo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PermisosXUsuario]    Script Date: 25/10/2013 06:02:05 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PermisosXUsuario](
	[idPermisosXUsuario] [int] IDENTITY(1,1) NOT NULL,
	[idPermisos] [int] NOT NULL,
	[enabled] [bit] NOT NULL,
	[idUsuario] [int] NOT NULL,
 CONSTRAINT [PK_PermisosXUsuario] PRIMARY KEY CLUSTERED 
(
	[idPermisosXUsuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Premios]    Script Date: 25/10/2013 06:02:05 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Premios](
	[idPremio] [int] IDENTITY(1,1) NOT NULL,
	[idTipoPremio] [int] NOT NULL,
	[idExpediente] [int] NOT NULL,
	[idRegla] [int] NOT NULL,
	[idPalabraTitulo] [int] NOT NULL,
	[idPalabraDescripcion] [int] NOT NULL,
	[imagen] [varchar](400) NOT NULL,
	[cantidad] [int] NOT NULL,
	[monto] [float] NOT NULL,
	[descuento] [float] NOT NULL,
	[idDepartamento] [int] NOT NULL,
	[idCurrency] [int] NOT NULL,
 CONSTRAINT [PK_Premios] PRIMARY KEY CLUSTERED 
(
	[idPremio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PremiosXExpediente]    Script Date: 25/10/2013 06:02:05 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PremiosXExpediente](
	[idPremiosXExpediente] [int] IDENTITY(1,1) NOT NULL,
	[idExpediente] [int] NOT NULL,
	[idPremio] [int] NOT NULL,
 CONSTRAINT [PK_PremiosXExpediente] PRIMARY KEY CLUSTERED 
(
	[idPremiosXExpediente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PremiosXRegla]    Script Date: 25/10/2013 06:02:05 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PremiosXRegla](
	[idPremio] [int] NOT NULL,
	[idRegla] [int] NOT NULL,
	[idPremiosXRegla] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_PremiosXRegla] PRIMARY KEY CLUSTERED 
(
	[idPremiosXRegla] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Provincias]    Script Date: 25/10/2013 06:02:05 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Provincias](
	[idProvincia] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](80) NOT NULL,
	[idPais] [int] NOT NULL,
 CONSTRAINT [PK_Provincias] PRIMARY KEY CLUSTERED 
(
	[idProvincia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Puestos]    Script Date: 25/10/2013 06:02:05 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Puestos](
	[idPuesto] [int] IDENTITY(1,1) NOT NULL,
	[idTipoPuesto] [int] NOT NULL,
	[idPalabras] [int] NOT NULL,
	[idDepartamento] [int] NOT NULL,
 CONSTRAINT [PK_Puestos] PRIMARY KEY CLUSTERED 
(
	[idPuesto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PuntajesAcumulados]    Script Date: 25/10/2013 06:02:05 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PuntajesAcumulados](
	[idPuntaje] [int] NOT NULL,
	[valor] [int] NOT NULL,
	[idExpediente] [int] NOT NULL,
 CONSTRAINT [PK_Puntajes] PRIMARY KEY CLUSTERED 
(
	[idPuntaje] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Reglas]    Script Date: 25/10/2013 06:02:05 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Reglas](
	[idRegla] [int] IDENTITY(1,1) NOT NULL,
	[fechaInicio] [datetime] NOT NULL,
	[idTipoRegla] [int] NOT NULL,
	[fechaFinal] [datetime] NOT NULL,
	[enabled] [bit] NOT NULL,
	[idPalabraTitulo] [int] NOT NULL,
	[idPalabraDescripcion] [int] NOT NULL,
 CONSTRAINT [PK_Reglas] PRIMARY KEY CLUSTERED 
(
	[idRegla] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Severidades]    Script Date: 25/10/2013 06:02:05 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Severidades](
	[idSeveridad] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Severidades] PRIMARY KEY CLUSTERED 
(
	[idSeveridad] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TipoCategorias]    Script Date: 25/10/2013 06:02:05 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TipoCategorias](
	[idTipoCategorias] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](50) NOT NULL,
	[puntaje] [int] NOT NULL,
 CONSTRAINT [PK_TipoCategorias] PRIMARY KEY CLUSTERED 
(
	[idTipoCategorias] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TipoCondecoraciones]    Script Date: 25/10/2013 06:02:05 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TipoCondecoraciones](
	[idTipoCondecoracion] [int] NOT NULL,
	[nombre] [varchar](50) NOT NULL,
	[icono] [varchar](50) NOT NULL,
	[idDepartamento] [int] NOT NULL,
 CONSTRAINT [PK_TipoCondecoraciones] PRIMARY KEY CLUSTERED 
(
	[idTipoCondecoracion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TipoEventos]    Script Date: 25/10/2013 06:02:05 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TipoEventos](
	[idTipoEvento] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [nvarchar](40) NOT NULL,
	[idSeveridad] [int] NOT NULL,
 CONSTRAINT [PK_TipoEventos] PRIMARY KEY CLUSTERED 
(
	[idTipoEvento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TipoLogros]    Script Date: 25/10/2013 06:02:05 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TipoLogros](
	[idTipoLogro] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](100) NOT NULL,
 CONSTRAINT [PK_TipoLogros] PRIMARY KEY CLUSTERED 
(
	[idTipoLogro] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TipoMonedas]    Script Date: 25/10/2013 06:02:05 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TipoMonedas](
	[idMoneda] [int] NOT NULL,
	[nombre] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Monedas] PRIMARY KEY CLUSTERED 
(
	[idMoneda] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TipoPeriodo]    Script Date: 25/10/2013 06:02:05 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TipoPeriodo](
	[idTipoPeriodo] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](50) NOT NULL,
 CONSTRAINT [PK_TipoPeriodo] PRIMARY KEY CLUSTERED 
(
	[idTipoPeriodo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TipoPremios]    Script Date: 25/10/2013 06:02:05 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TipoPremios](
	[idTipoPremio] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_TipoPremios] PRIMARY KEY CLUSTERED 
(
	[idTipoPremio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TipoPuestos]    Script Date: 25/10/2013 06:02:05 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TipoPuestos](
	[idTipoPuesto] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](50) NOT NULL,
 CONSTRAINT [PK_TipoPuestos] PRIMARY KEY CLUSTERED 
(
	[idTipoPuesto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TipoReglas]    Script Date: 25/10/2013 06:02:05 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TipoReglas](
	[idTipoRegla] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](100) NOT NULL,
 CONSTRAINT [PK_TipoReglas] PRIMARY KEY CLUSTERED 
(
	[idTipoRegla] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TiposContrato]    Script Date: 25/10/2013 06:02:05 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TiposContrato](
	[idTiposContrato] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](50) NOT NULL,
 CONSTRAINT [PK_TiposContrato] PRIMARY KEY CLUSTERED 
(
	[idTiposContrato] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TiposTransaccion]    Script Date: 25/10/2013 06:02:05 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TiposTransaccion](
	[idTiposTransaccion] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](50) NOT NULL,
 CONSTRAINT [PK_TiposTransaccion] PRIMARY KEY CLUSTERED 
(
	[idTiposTransaccion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TipoUsuarios]    Script Date: 25/10/2013 06:02:05 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TipoUsuarios](
	[idTipoUsuarios] [int] NOT NULL,
	[nombre] [varchar](50) NOT NULL,
 CONSTRAINT [PK_TipoUsuarios] PRIMARY KEY CLUSTERED 
(
	[idTipoUsuarios] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Titulos]    Script Date: 25/10/2013 06:02:05 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Titulos](
	[idTitulo] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](50) NOT NULL,
	[fechaInicio] [datetime] NOT NULL,
	[fechaFinal] [datetime] NOT NULL,
	[idExpediente] [int] NOT NULL,
	[idInstitucion] [int] NOT NULL,
 CONSTRAINT [PK_Titulos] PRIMARY KEY CLUSTERED 
(
	[idTitulo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TransaccionesDeReglas]    Script Date: 25/10/2013 06:02:05 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TransaccionesDeReglas](
	[idTransaccionesDeReglas] [int] IDENTITY(1,1) NOT NULL,
	[descripcion] [varchar](400) NOT NULL,
	[fecha] [datetime] NOT NULL,
	[checksum] [int] NOT NULL,
	[computadora] [varchar](60) NOT NULL,
	[usuario] [varchar](60) NOT NULL,
	[monto] [float] NOT NULL,
	[cantidad] [int] NOT NULL,
	[voucherDocNo] [int] NOT NULL,
	[idEmpleadoAdmin] [int] NOT NULL,
	[idTiposTransaccion] [int] NOT NULL,
	[idRegla] [int] NOT NULL,
	[idEmpleadoTran] [int] NOT NULL,
	[idPremio] [int] NOT NULL,
 CONSTRAINT [PK_TransaccionesDeReglas] PRIMARY KEY CLUSTERED 
(
	[idTransaccionesDeReglas] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Usuarios]    Script Date: 25/10/2013 06:02:05 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Usuarios](
	[idUsuario] [int] IDENTITY(1,1) NOT NULL,
	[username] [varchar](50) NOT NULL,
	[password] [varchar](50) NOT NULL,
	[idEmpleado] [int] NOT NULL,
	[idTipoUsuario] [int] NOT NULL,
 CONSTRAINT [PK_Usuarios] PRIMARY KEY CLUSTERED 
(
	[idUsuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[UsuariosXTipo]    Script Date: 25/10/2013 06:02:05 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UsuariosXTipo](
	[idUsuariosXTipo] [int] IDENTITY(1,1) NOT NULL,
	[idUsuario] [int] NOT NULL,
	[idTipoUsuarios] [int] NOT NULL,
 CONSTRAINT [PK_UsuariosXTipo] PRIMARY KEY CLUSTERED 
(
	[idUsuariosXTipo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  View [dbo].[Vista]    Script Date: 25/10/2013 06:02:05 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[Vista]
WITH SCHEMABINDING
AS 
SELECT (Direcciones.detalle1) AS direccion, (Ciudades.nombre)AS ciudad, (Provincias.nombre)AS provincia, (Paises.nombre) pais
FROM dbo.Direcciones INNER JOIN dbo.Ciudades ON Direcciones.idCiudad = Ciudades.idCiudad
				 INNER JOIN dbo.Provincias ON Ciudades.idProvincia = Provincias.idProvincia
				 INNER JOIN dbo.Paises ON Provincias.idPais = Paises.idPais						

GO
SET ARITHABORT ON
SET CONCAT_NULL_YIELDS_NULL ON
SET QUOTED_IDENTIFIER ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
SET NUMERIC_ROUNDABORT OFF

GO
/****** Object:  Index [indice]    Script Date: 25/10/2013 06:02:05 p.m. ******/
CREATE UNIQUE CLUSTERED INDEX [indice] ON [dbo].[Vista]
(
	[direccion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Categorias]  WITH CHECK ADD  CONSTRAINT [FK_Categorias_Departamentos] FOREIGN KEY([idDepartamento])
REFERENCES [dbo].[Departamentos] ([idDepartamento])
GO
ALTER TABLE [dbo].[Categorias] CHECK CONSTRAINT [FK_Categorias_Departamentos]
GO
ALTER TABLE [dbo].[Categorias]  WITH CHECK ADD  CONSTRAINT [FK_Categorias_Palabras] FOREIGN KEY([idPalabras])
REFERENCES [dbo].[Palabras] ([idPalabras])
GO
ALTER TABLE [dbo].[Categorias] CHECK CONSTRAINT [FK_Categorias_Palabras]
GO
ALTER TABLE [dbo].[Categorias]  WITH CHECK ADD  CONSTRAINT [FK_Categorias_TipoCategorias] FOREIGN KEY([idTipoCategoria])
REFERENCES [dbo].[TipoCategorias] ([idTipoCategorias])
GO
ALTER TABLE [dbo].[Categorias] CHECK CONSTRAINT [FK_Categorias_TipoCategorias]
GO
ALTER TABLE [dbo].[CategoriasXEmpleado]  WITH CHECK ADD  CONSTRAINT [FK_CategoriasXEmpleado_Categorias] FOREIGN KEY([idCategoria])
REFERENCES [dbo].[Categorias] ([idCategoria])
GO
ALTER TABLE [dbo].[CategoriasXEmpleado] CHECK CONSTRAINT [FK_CategoriasXEmpleado_Categorias]
GO
ALTER TABLE [dbo].[CategoriasXEmpleado]  WITH CHECK ADD  CONSTRAINT [FK_CategoriasXEmpleado_Expedientes] FOREIGN KEY([idExpediente])
REFERENCES [dbo].[Expedientes] ([idExpediente])
GO
ALTER TABLE [dbo].[CategoriasXEmpleado] CHECK CONSTRAINT [FK_CategoriasXEmpleado_Expedientes]
GO
ALTER TABLE [dbo].[Ciudades]  WITH CHECK ADD  CONSTRAINT [FK_Ciudades_Provincias] FOREIGN KEY([idProvincia])
REFERENCES [dbo].[Provincias] ([idProvincia])
GO
ALTER TABLE [dbo].[Ciudades] CHECK CONSTRAINT [FK_Ciudades_Provincias]
GO
ALTER TABLE [dbo].[Condecoraciones]  WITH CHECK ADD  CONSTRAINT [FK_Condecoraciones_Expedientes] FOREIGN KEY([idExpediente])
REFERENCES [dbo].[Expedientes] ([idExpediente])
GO
ALTER TABLE [dbo].[Condecoraciones] CHECK CONSTRAINT [FK_Condecoraciones_Expedientes]
GO
ALTER TABLE [dbo].[Condecoraciones]  WITH CHECK ADD  CONSTRAINT [FK_Condecoraciones_Reglas] FOREIGN KEY([idRegla])
REFERENCES [dbo].[Reglas] ([idRegla])
GO
ALTER TABLE [dbo].[Condecoraciones] CHECK CONSTRAINT [FK_Condecoraciones_Reglas]
GO
ALTER TABLE [dbo].[Condecoraciones]  WITH CHECK ADD  CONSTRAINT [FK_Condecoraciones_TipoCondecoraciones] FOREIGN KEY([idTipoCondecoracion])
REFERENCES [dbo].[TipoCondecoraciones] ([idTipoCondecoracion])
GO
ALTER TABLE [dbo].[Condecoraciones] CHECK CONSTRAINT [FK_Condecoraciones_TipoCondecoraciones]
GO
ALTER TABLE [dbo].[Contratos]  WITH CHECK ADD  CONSTRAINT [FK_Contratos_Empleados] FOREIGN KEY([idEmpleadoAutoriza])
REFERENCES [dbo].[Empleados] ([idEmpleado])
GO
ALTER TABLE [dbo].[Contratos] CHECK CONSTRAINT [FK_Contratos_Empleados]
GO
ALTER TABLE [dbo].[Contratos]  WITH CHECK ADD  CONSTRAINT [FK_Contratos_Empleados1] FOREIGN KEY([idEmpleadoInserta])
REFERENCES [dbo].[Empleados] ([idEmpleado])
GO
ALTER TABLE [dbo].[Contratos] CHECK CONSTRAINT [FK_Contratos_Empleados1]
GO
ALTER TABLE [dbo].[Contratos]  WITH CHECK ADD  CONSTRAINT [FK_Contratos_Expedientes] FOREIGN KEY([idExpediente])
REFERENCES [dbo].[Expedientes] ([idExpediente])
GO
ALTER TABLE [dbo].[Contratos] CHECK CONSTRAINT [FK_Contratos_Expedientes]
GO
ALTER TABLE [dbo].[Contratos]  WITH CHECK ADD  CONSTRAINT [idTiposContrato] FOREIGN KEY([idTiposContrato])
REFERENCES [dbo].[TiposContrato] ([idTiposContrato])
GO
ALTER TABLE [dbo].[Contratos] CHECK CONSTRAINT [idTiposContrato]
GO
ALTER TABLE [dbo].[Departamentos]  WITH CHECK ADD  CONSTRAINT [FK_Departamentos_Empresa] FOREIGN KEY([idEmpresa])
REFERENCES [dbo].[Empresa] ([idEmpresa])
GO
ALTER TABLE [dbo].[Departamentos] CHECK CONSTRAINT [FK_Departamentos_Empresa]
GO
ALTER TABLE [dbo].[Departamentos]  WITH CHECK ADD  CONSTRAINT [FK_Departamentos_Palabras] FOREIGN KEY([idPalabras])
REFERENCES [dbo].[Palabras] ([idPalabras])
GO
ALTER TABLE [dbo].[Departamentos] CHECK CONSTRAINT [FK_Departamentos_Palabras]
GO
ALTER TABLE [dbo].[DetalleRegla]  WITH CHECK ADD  CONSTRAINT [FK_DetalleRegla_Logros] FOREIGN KEY([idLogro])
REFERENCES [dbo].[Logros] ([idLogro])
GO
ALTER TABLE [dbo].[DetalleRegla] CHECK CONSTRAINT [FK_DetalleRegla_Logros]
GO
ALTER TABLE [dbo].[DetalleRegla]  WITH CHECK ADD  CONSTRAINT [FK_DetalleRegla_Reglas] FOREIGN KEY([idRegla])
REFERENCES [dbo].[Reglas] ([idRegla])
GO
ALTER TABLE [dbo].[DetalleRegla] CHECK CONSTRAINT [FK_DetalleRegla_Reglas]
GO
ALTER TABLE [dbo].[DetalleRegla]  WITH CHECK ADD  CONSTRAINT [FK_DetalleRegla_TipoPeriodo] FOREIGN KEY([idTipoPeriodo])
REFERENCES [dbo].[TipoPeriodo] ([idTipoPeriodo])
GO
ALTER TABLE [dbo].[DetalleRegla] CHECK CONSTRAINT [FK_DetalleRegla_TipoPeriodo]
GO
ALTER TABLE [dbo].[Direcciones]  WITH CHECK ADD  CONSTRAINT [FK_Direcciones_Ciudades] FOREIGN KEY([idCiudad])
REFERENCES [dbo].[Ciudades] ([idCiudad])
GO
ALTER TABLE [dbo].[Direcciones] CHECK CONSTRAINT [FK_Direcciones_Ciudades]
GO
ALTER TABLE [dbo].[Empresa]  WITH CHECK ADD  CONSTRAINT [FK_Empresa_Direcciones] FOREIGN KEY([idDireccion])
REFERENCES [dbo].[Direcciones] ([idDireccion])
GO
ALTER TABLE [dbo].[Empresa] CHECK CONSTRAINT [FK_Empresa_Direcciones]
GO
ALTER TABLE [dbo].[Eventos]  WITH CHECK ADD  CONSTRAINT [FK_Eventos_Aplicaciones] FOREIGN KEY([idAplicacion])
REFERENCES [dbo].[Aplicaciones] ([idAplicaciones])
GO
ALTER TABLE [dbo].[Eventos] CHECK CONSTRAINT [FK_Eventos_Aplicaciones]
GO
ALTER TABLE [dbo].[Eventos]  WITH CHECK ADD  CONSTRAINT [FK_Eventos_Severidades] FOREIGN KEY([idSeveridad])
REFERENCES [dbo].[Severidades] ([idSeveridad])
GO
ALTER TABLE [dbo].[Eventos] CHECK CONSTRAINT [FK_Eventos_Severidades]
GO
ALTER TABLE [dbo].[Eventos]  WITH CHECK ADD  CONSTRAINT [FK_Eventos_TipoEventos] FOREIGN KEY([idTipoEvento])
REFERENCES [dbo].[TipoEventos] ([idTipoEvento])
GO
ALTER TABLE [dbo].[Eventos] CHECK CONSTRAINT [FK_Eventos_TipoEventos]
GO
ALTER TABLE [dbo].[ExchangeRateHistories]  WITH CHECK ADD  CONSTRAINT [FK_ExchangeRateHistories_Currencies] FOREIGN KEY([currencyId1])
REFERENCES [dbo].[Currencies] ([idCurrency])
GO
ALTER TABLE [dbo].[ExchangeRateHistories] CHECK CONSTRAINT [FK_ExchangeRateHistories_Currencies]
GO
ALTER TABLE [dbo].[ExchangeRateHistories]  WITH CHECK ADD  CONSTRAINT [FK_ExchangeRateHistories_Currencies1] FOREIGN KEY([currencyId2])
REFERENCES [dbo].[Currencies] ([idCurrency])
GO
ALTER TABLE [dbo].[ExchangeRateHistories] CHECK CONSTRAINT [FK_ExchangeRateHistories_Currencies1]
GO
ALTER TABLE [dbo].[ExchangeRates]  WITH CHECK ADD  CONSTRAINT [FK_ExchangeRates_Currencies] FOREIGN KEY([currencyId1])
REFERENCES [dbo].[Currencies] ([idCurrency])
GO
ALTER TABLE [dbo].[ExchangeRates] CHECK CONSTRAINT [FK_ExchangeRates_Currencies]
GO
ALTER TABLE [dbo].[ExchangeRates]  WITH CHECK ADD  CONSTRAINT [FK_ExchangeRates_Currencies1] FOREIGN KEY([currencyId2])
REFERENCES [dbo].[Currencies] ([idCurrency])
GO
ALTER TABLE [dbo].[ExchangeRates] CHECK CONSTRAINT [FK_ExchangeRates_Currencies1]
GO
ALTER TABLE [dbo].[Expedientes]  WITH CHECK ADD  CONSTRAINT [FK_Expedientes_Empleados] FOREIGN KEY([idEmpleado])
REFERENCES [dbo].[Empleados] ([idEmpleado])
GO
ALTER TABLE [dbo].[Expedientes] CHECK CONSTRAINT [FK_Expedientes_Empleados]
GO
ALTER TABLE [dbo].[Expedientes]  WITH CHECK ADD  CONSTRAINT [FK_Expedientes_Puestos] FOREIGN KEY([idPuesto])
REFERENCES [dbo].[Puestos] ([idPuesto])
GO
ALTER TABLE [dbo].[Expedientes] CHECK CONSTRAINT [FK_Expedientes_Puestos]
GO
ALTER TABLE [dbo].[HistorialCambios]  WITH CHECK ADD  CONSTRAINT [FK_HistorialCambios_TipoMonedas] FOREIGN KEY([idMoneda])
REFERENCES [dbo].[TipoMonedas] ([idMoneda])
GO
ALTER TABLE [dbo].[HistorialCambios] CHECK CONSTRAINT [FK_HistorialCambios_TipoMonedas]
GO
ALTER TABLE [dbo].[Instituciones]  WITH CHECK ADD  CONSTRAINT [FK_Instituciones_Direcciones] FOREIGN KEY([idDireccion])
REFERENCES [dbo].[Direcciones] ([idDireccion])
GO
ALTER TABLE [dbo].[Instituciones] CHECK CONSTRAINT [FK_Instituciones_Direcciones]
GO
ALTER TABLE [dbo].[Logros]  WITH CHECK ADD  CONSTRAINT [FK_Logros_Palabras] FOREIGN KEY([idPalabraTitulo])
REFERENCES [dbo].[Palabras] ([idPalabras])
GO
ALTER TABLE [dbo].[Logros] CHECK CONSTRAINT [FK_Logros_Palabras]
GO
ALTER TABLE [dbo].[Logros]  WITH CHECK ADD  CONSTRAINT [FK_Logros_PalabrasDescripcion] FOREIGN KEY([idPalabraDescripcion])
REFERENCES [dbo].[Palabras] ([idPalabras])
GO
ALTER TABLE [dbo].[Logros] CHECK CONSTRAINT [FK_Logros_PalabrasDescripcion]
GO
ALTER TABLE [dbo].[Logros]  WITH CHECK ADD  CONSTRAINT [FK_Logros_TipoLogros] FOREIGN KEY([idTipoLogro])
REFERENCES [dbo].[TipoLogros] ([idTipoLogro])
GO
ALTER TABLE [dbo].[Logros] CHECK CONSTRAINT [FK_Logros_TipoLogros]
GO
ALTER TABLE [dbo].[LogrosXEmpleado]  WITH CHECK ADD  CONSTRAINT [FK_LogrosXEmpleado_Empleados] FOREIGN KEY([idEmpleado])
REFERENCES [dbo].[Empleados] ([idEmpleado])
GO
ALTER TABLE [dbo].[LogrosXEmpleado] CHECK CONSTRAINT [FK_LogrosXEmpleado_Empleados]
GO
ALTER TABLE [dbo].[LogrosXEmpleado]  WITH CHECK ADD  CONSTRAINT [FK_LogrosXEmpleado_Logros] FOREIGN KEY([idLogro])
REFERENCES [dbo].[Logros] ([idLogro])
GO
ALTER TABLE [dbo].[LogrosXEmpleado] CHECK CONSTRAINT [FK_LogrosXEmpleado_Logros]
GO
ALTER TABLE [dbo].[Modulos]  WITH CHECK ADD  CONSTRAINT [FK_Modulos_Aplicaciones] FOREIGN KEY([idAplicaciones])
REFERENCES [dbo].[Aplicaciones] ([idAplicaciones])
GO
ALTER TABLE [dbo].[Modulos] CHECK CONSTRAINT [FK_Modulos_Aplicaciones]
GO
ALTER TABLE [dbo].[Observaciones]  WITH CHECK ADD  CONSTRAINT [FK_Observaciones_Expedientes] FOREIGN KEY([idExpediente])
REFERENCES [dbo].[Expedientes] ([idExpediente])
GO
ALTER TABLE [dbo].[Observaciones] CHECK CONSTRAINT [FK_Observaciones_Expedientes]
GO
ALTER TABLE [dbo].[PalabrasXIdioma]  WITH CHECK ADD  CONSTRAINT [FK_PalabrasXIdioma_Idiomas] FOREIGN KEY([idIdioma])
REFERENCES [dbo].[Idiomas] ([idIdioma])
GO
ALTER TABLE [dbo].[PalabrasXIdioma] CHECK CONSTRAINT [FK_PalabrasXIdioma_Idiomas]
GO
ALTER TABLE [dbo].[PalabrasXIdioma]  WITH CHECK ADD  CONSTRAINT [FK_PalabrasXIdioma_Palabras] FOREIGN KEY([idPalabras])
REFERENCES [dbo].[Palabras] ([idPalabras])
GO
ALTER TABLE [dbo].[PalabrasXIdioma] CHECK CONSTRAINT [FK_PalabrasXIdioma_Palabras]
GO
ALTER TABLE [dbo].[Permisos]  WITH CHECK ADD  CONSTRAINT [FK_Permisos_Modulos] FOREIGN KEY([idModulo])
REFERENCES [dbo].[Modulos] ([idModulo])
GO
ALTER TABLE [dbo].[Permisos] CHECK CONSTRAINT [FK_Permisos_Modulos]
GO
ALTER TABLE [dbo].[PermisosXGrupo]  WITH CHECK ADD  CONSTRAINT [FK_idTipoUsuarios] FOREIGN KEY([idTipoUsuarios])
REFERENCES [dbo].[TipoUsuarios] ([idTipoUsuarios])
GO
ALTER TABLE [dbo].[PermisosXGrupo] CHECK CONSTRAINT [FK_idTipoUsuarios]
GO
ALTER TABLE [dbo].[PermisosXGrupo]  WITH CHECK ADD  CONSTRAINT [FK_Permisos] FOREIGN KEY([idPermisos])
REFERENCES [dbo].[Permisos] ([idPermisos])
GO
ALTER TABLE [dbo].[PermisosXGrupo] CHECK CONSTRAINT [FK_Permisos]
GO
ALTER TABLE [dbo].[PermisosXUsuario]  WITH CHECK ADD  CONSTRAINT [FK_PermisosXUsuario_Usuarios] FOREIGN KEY([idUsuario])
REFERENCES [dbo].[Usuarios] ([idUsuario])
GO
ALTER TABLE [dbo].[PermisosXUsuario] CHECK CONSTRAINT [FK_PermisosXUsuario_Usuarios]
GO
ALTER TABLE [dbo].[PermisosXUsuario]  WITH CHECK ADD  CONSTRAINT [idPermisos] FOREIGN KEY([idPermisos])
REFERENCES [dbo].[Permisos] ([idPermisos])
GO
ALTER TABLE [dbo].[PermisosXUsuario] CHECK CONSTRAINT [idPermisos]
GO
ALTER TABLE [dbo].[Premios]  WITH CHECK ADD  CONSTRAINT [FK_Premios_Currencies] FOREIGN KEY([idCurrency])
REFERENCES [dbo].[Currencies] ([idCurrency])
GO
ALTER TABLE [dbo].[Premios] CHECK CONSTRAINT [FK_Premios_Currencies]
GO
ALTER TABLE [dbo].[Premios]  WITH CHECK ADD  CONSTRAINT [FK_Premios_Departamentos] FOREIGN KEY([idDepartamento])
REFERENCES [dbo].[Departamentos] ([idDepartamento])
GO
ALTER TABLE [dbo].[Premios] CHECK CONSTRAINT [FK_Premios_Departamentos]
GO
ALTER TABLE [dbo].[Premios]  WITH CHECK ADD  CONSTRAINT [FK_Premios_Palabras] FOREIGN KEY([idPalabraTitulo])
REFERENCES [dbo].[Palabras] ([idPalabras])
GO
ALTER TABLE [dbo].[Premios] CHECK CONSTRAINT [FK_Premios_Palabras]
GO
ALTER TABLE [dbo].[Premios]  WITH CHECK ADD  CONSTRAINT [FK_Premios_PalabrasDescripcion] FOREIGN KEY([idPalabraDescripcion])
REFERENCES [dbo].[Palabras] ([idPalabras])
GO
ALTER TABLE [dbo].[Premios] CHECK CONSTRAINT [FK_Premios_PalabrasDescripcion]
GO
ALTER TABLE [dbo].[Premios]  WITH CHECK ADD  CONSTRAINT [FK_Premios_TipoPremios] FOREIGN KEY([idTipoPremio])
REFERENCES [dbo].[TipoPremios] ([idTipoPremio])
GO
ALTER TABLE [dbo].[Premios] CHECK CONSTRAINT [FK_Premios_TipoPremios]
GO
ALTER TABLE [dbo].[PremiosXExpediente]  WITH CHECK ADD  CONSTRAINT [FK_PremiosXExpediente_Expedientes] FOREIGN KEY([idExpediente])
REFERENCES [dbo].[Expedientes] ([idExpediente])
GO
ALTER TABLE [dbo].[PremiosXExpediente] CHECK CONSTRAINT [FK_PremiosXExpediente_Expedientes]
GO
ALTER TABLE [dbo].[PremiosXExpediente]  WITH CHECK ADD  CONSTRAINT [FK_PremiosXExpediente_Premios] FOREIGN KEY([idPremio])
REFERENCES [dbo].[Premios] ([idPremio])
GO
ALTER TABLE [dbo].[PremiosXExpediente] CHECK CONSTRAINT [FK_PremiosXExpediente_Premios]
GO
ALTER TABLE [dbo].[PremiosXRegla]  WITH CHECK ADD  CONSTRAINT [idPremio] FOREIGN KEY([idPremio])
REFERENCES [dbo].[Premios] ([idPremio])
GO
ALTER TABLE [dbo].[PremiosXRegla] CHECK CONSTRAINT [idPremio]
GO
ALTER TABLE [dbo].[PremiosXRegla]  WITH CHECK ADD  CONSTRAINT [idRegla] FOREIGN KEY([idRegla])
REFERENCES [dbo].[Reglas] ([idRegla])
GO
ALTER TABLE [dbo].[PremiosXRegla] CHECK CONSTRAINT [idRegla]
GO
ALTER TABLE [dbo].[Provincias]  WITH CHECK ADD  CONSTRAINT [FK_Provincias_Paises] FOREIGN KEY([idPais])
REFERENCES [dbo].[Paises] ([idPais])
GO
ALTER TABLE [dbo].[Provincias] CHECK CONSTRAINT [FK_Provincias_Paises]
GO
ALTER TABLE [dbo].[Puestos]  WITH CHECK ADD  CONSTRAINT [FK_Puestos_Departamentos] FOREIGN KEY([idDepartamento])
REFERENCES [dbo].[Departamentos] ([idDepartamento])
GO
ALTER TABLE [dbo].[Puestos] CHECK CONSTRAINT [FK_Puestos_Departamentos]
GO
ALTER TABLE [dbo].[Puestos]  WITH CHECK ADD  CONSTRAINT [FK_Puestos_Palabras] FOREIGN KEY([idPalabras])
REFERENCES [dbo].[Palabras] ([idPalabras])
GO
ALTER TABLE [dbo].[Puestos] CHECK CONSTRAINT [FK_Puestos_Palabras]
GO
ALTER TABLE [dbo].[Puestos]  WITH CHECK ADD  CONSTRAINT [FK_Puestos_TipoPuestos] FOREIGN KEY([idTipoPuesto])
REFERENCES [dbo].[TipoPuestos] ([idTipoPuesto])
GO
ALTER TABLE [dbo].[Puestos] CHECK CONSTRAINT [FK_Puestos_TipoPuestos]
GO
ALTER TABLE [dbo].[PuntajesAcumulados]  WITH CHECK ADD  CONSTRAINT [FK_Puntajes_Expedientes] FOREIGN KEY([idExpediente])
REFERENCES [dbo].[Expedientes] ([idExpediente])
GO
ALTER TABLE [dbo].[PuntajesAcumulados] CHECK CONSTRAINT [FK_Puntajes_Expedientes]
GO
ALTER TABLE [dbo].[Reglas]  WITH CHECK ADD  CONSTRAINT [FK_Reglas_PalabrasDescripcion] FOREIGN KEY([idPalabraDescripcion])
REFERENCES [dbo].[Palabras] ([idPalabras])
GO
ALTER TABLE [dbo].[Reglas] CHECK CONSTRAINT [FK_Reglas_PalabrasDescripcion]
GO
ALTER TABLE [dbo].[Reglas]  WITH CHECK ADD  CONSTRAINT [FK_Reglas_PalabrasTitulo] FOREIGN KEY([idPalabraTitulo])
REFERENCES [dbo].[Palabras] ([idPalabras])
GO
ALTER TABLE [dbo].[Reglas] CHECK CONSTRAINT [FK_Reglas_PalabrasTitulo]
GO
ALTER TABLE [dbo].[Reglas]  WITH CHECK ADD  CONSTRAINT [FK_Reglas_TipoReglas] FOREIGN KEY([idTipoRegla])
REFERENCES [dbo].[TipoReglas] ([idTipoRegla])
GO
ALTER TABLE [dbo].[Reglas] CHECK CONSTRAINT [FK_Reglas_TipoReglas]
GO
ALTER TABLE [dbo].[TipoCondecoraciones]  WITH CHECK ADD  CONSTRAINT [FK_TipoCondecoraciones_Departamentos1] FOREIGN KEY([idDepartamento])
REFERENCES [dbo].[Departamentos] ([idDepartamento])
GO
ALTER TABLE [dbo].[TipoCondecoraciones] CHECK CONSTRAINT [FK_TipoCondecoraciones_Departamentos1]
GO
ALTER TABLE [dbo].[TipoEventos]  WITH CHECK ADD  CONSTRAINT [FK_TipoEventos_Severidades] FOREIGN KEY([idSeveridad])
REFERENCES [dbo].[Severidades] ([idSeveridad])
GO
ALTER TABLE [dbo].[TipoEventos] CHECK CONSTRAINT [FK_TipoEventos_Severidades]
GO
ALTER TABLE [dbo].[Titulos]  WITH CHECK ADD  CONSTRAINT [FK_Titulos_Expedientes] FOREIGN KEY([idExpediente])
REFERENCES [dbo].[Expedientes] ([idExpediente])
GO
ALTER TABLE [dbo].[Titulos] CHECK CONSTRAINT [FK_Titulos_Expedientes]
GO
ALTER TABLE [dbo].[Titulos]  WITH CHECK ADD  CONSTRAINT [FK_Titulos_Instituciones] FOREIGN KEY([idInstitucion])
REFERENCES [dbo].[Instituciones] ([idInstitucion])
GO
ALTER TABLE [dbo].[Titulos] CHECK CONSTRAINT [FK_Titulos_Instituciones]
GO
ALTER TABLE [dbo].[TransaccionesDeReglas]  WITH CHECK ADD  CONSTRAINT [FK_TransaccionesDeReglas_Empleados] FOREIGN KEY([idEmpleadoAdmin])
REFERENCES [dbo].[Empleados] ([idEmpleado])
GO
ALTER TABLE [dbo].[TransaccionesDeReglas] CHECK CONSTRAINT [FK_TransaccionesDeReglas_Empleados]
GO
ALTER TABLE [dbo].[TransaccionesDeReglas]  WITH CHECK ADD  CONSTRAINT [FK_TransaccionesDeReglas_Empleados1] FOREIGN KEY([idEmpleadoTran])
REFERENCES [dbo].[Empleados] ([idEmpleado])
GO
ALTER TABLE [dbo].[TransaccionesDeReglas] CHECK CONSTRAINT [FK_TransaccionesDeReglas_Empleados1]
GO
ALTER TABLE [dbo].[TransaccionesDeReglas]  WITH CHECK ADD  CONSTRAINT [FK_TransaccionesDeReglas_Premios] FOREIGN KEY([idPremio])
REFERENCES [dbo].[Premios] ([idPremio])
GO
ALTER TABLE [dbo].[TransaccionesDeReglas] CHECK CONSTRAINT [FK_TransaccionesDeReglas_Premios]
GO
ALTER TABLE [dbo].[TransaccionesDeReglas]  WITH CHECK ADD  CONSTRAINT [FK_TransaccionesDeReglas_Reglas] FOREIGN KEY([idRegla])
REFERENCES [dbo].[Reglas] ([idRegla])
GO
ALTER TABLE [dbo].[TransaccionesDeReglas] CHECK CONSTRAINT [FK_TransaccionesDeReglas_Reglas]
GO
ALTER TABLE [dbo].[TransaccionesDeReglas]  WITH CHECK ADD  CONSTRAINT [idTiposTransaccion] FOREIGN KEY([idTiposTransaccion])
REFERENCES [dbo].[TiposTransaccion] ([idTiposTransaccion])
GO
ALTER TABLE [dbo].[TransaccionesDeReglas] CHECK CONSTRAINT [idTiposTransaccion]
GO
ALTER TABLE [dbo].[Usuarios]  WITH CHECK ADD  CONSTRAINT [FK_Usuarios_Empleados] FOREIGN KEY([idEmpleado])
REFERENCES [dbo].[Empleados] ([idEmpleado])
GO
ALTER TABLE [dbo].[Usuarios] CHECK CONSTRAINT [FK_Usuarios_Empleados]
GO
ALTER TABLE [dbo].[UsuariosXTipo]  WITH CHECK ADD  CONSTRAINT [FK_UsuariosXTipo_TipoUsuarios] FOREIGN KEY([idTipoUsuarios])
REFERENCES [dbo].[TipoUsuarios] ([idTipoUsuarios])
GO
ALTER TABLE [dbo].[UsuariosXTipo] CHECK CONSTRAINT [FK_UsuariosXTipo_TipoUsuarios]
GO
ALTER TABLE [dbo].[UsuariosXTipo]  WITH CHECK ADD  CONSTRAINT [FK_UsuariosXTipo_Usuarios] FOREIGN KEY([idUsuario])
REFERENCES [dbo].[Usuarios] ([idUsuario])
GO
ALTER TABLE [dbo].[UsuariosXTipo] CHECK CONSTRAINT [FK_UsuariosXTipo_Usuarios]
GO
USE [master]
GO
ALTER DATABASE [LevelUp] SET  READ_WRITE 
GO
