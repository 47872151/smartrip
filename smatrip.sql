USE [master]
GO
/****** Object:  Database [SMARTRIP]    Script Date: 23/5/2025 10:39:15 ******/
CREATE DATABASE [SMARTRIP]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'SMARTRIP', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\SMARTRIP.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'SMARTRIP_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\SMARTRIP_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [SMARTRIP] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [SMARTRIP].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [SMARTRIP] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [SMARTRIP] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [SMARTRIP] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [SMARTRIP] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [SMARTRIP] SET ARITHABORT OFF 
GO
ALTER DATABASE [SMARTRIP] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [SMARTRIP] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [SMARTRIP] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [SMARTRIP] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [SMARTRIP] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [SMARTRIP] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [SMARTRIP] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [SMARTRIP] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [SMARTRIP] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [SMARTRIP] SET  ENABLE_BROKER 
GO
ALTER DATABASE [SMARTRIP] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [SMARTRIP] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [SMARTRIP] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [SMARTRIP] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [SMARTRIP] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [SMARTRIP] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [SMARTRIP] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [SMARTRIP] SET RECOVERY FULL 
GO
ALTER DATABASE [SMARTRIP] SET  MULTI_USER 
GO
ALTER DATABASE [SMARTRIP] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [SMARTRIP] SET DB_CHAINING OFF 
GO
ALTER DATABASE [SMARTRIP] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [SMARTRIP] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [SMARTRIP] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'SMARTRIP', N'ON'
GO
ALTER DATABASE [SMARTRIP] SET QUERY_STORE = OFF
GO
USE [SMARTRIP]
GO
/****** Object:  User [alumno]    Script Date: 23/5/2025 10:39:16 ******/
CREATE USER [alumno] FOR LOGIN [alumno] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  Table [dbo].[CONSULTAS]    Script Date: 23/5/2025 10:39:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CONSULTAS](
	[id] [int] NOT NULL,
	[idUsuario] [int] NOT NULL,
	[fecha] [date] NOT NULL,
	[hora] [time](7) NOT NULL,
	[origenLatitud] [varchar](255) NOT NULL,
	[origenLongitud] [varchar](255) NOT NULL,
	[destinoLatitud] [varchar](255) NOT NULL,
	[destinoLongitud] [varchar](255) NOT NULL,
 CONSTRAINT [PK_CONSULTAS] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DIRECCIONES]    Script Date: 23/5/2025 10:39:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DIRECCIONES](
	[id] [int] NOT NULL,
	[nombre] [varchar](255) NOT NULL,
	[direccion] [varchar](500) NOT NULL,
	[latitud] [varchar](50) NOT NULL,
	[longitud] [varchar](50) NOT NULL,
 CONSTRAINT [PK_DIRECCIONES] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DIRECCIONES_FRECUENTES]    Script Date: 23/5/2025 10:39:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DIRECCIONES_FRECUENTES](
	[id] [int] NOT NULL,
	[idUsuario] [int] NOT NULL,
	[nombre] [varchar](50) NOT NULL,
	[latitud] [varchar](255) NOT NULL,
	[longitud] [varchar](255) NOT NULL,
 CONSTRAINT [PK_DIRECCIONES_FRECUENTES] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EMPRESA]    Script Date: 23/5/2025 10:39:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EMPRESA](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](50) NOT NULL,
	[CantidadAutos] [int] NOT NULL,
 CONSTRAINT [PK_EMPRESA] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PAGOS]    Script Date: 23/5/2025 10:39:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PAGOS](
	[IDPago] [int] IDENTITY(1,1) NOT NULL,
	[IDViaje] [int] NOT NULL,
	[Costo] [decimal](10, 2) NOT NULL,
	[FechaPago] [date] NOT NULL,
	[MetodoPago] [varchar](50) NOT NULL,
 CONSTRAINT [PK_PAGOS] PRIMARY KEY CLUSTERED 
(
	[IDPago] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PRECIOS]    Script Date: 23/5/2025 10:39:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PRECIOS](
	[id] [int] NOT NULL,
	[idUsuario] [int] NOT NULL,
	[idEmpresa] [int] NOT NULL,
	[origenLatitud] [varchar](255) NOT NULL,
	[origenLongitud] [varchar](255) NOT NULL,
	[destinoLatitud] [varchar](255) NOT NULL,
	[destinoLongitud] [varchar](255) NOT NULL,
	[precioEstimado] [decimal](18, 0) NOT NULL,
	[tiempoEstimado] [time](7) NOT NULL,
	[metodoPago] [varchar](50) NOT NULL,
	[fechaConsulta] [date] NOT NULL,
 CONSTRAINT [PK_PRECIOS] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PREFERENCIAS]    Script Date: 23/5/2025 10:39:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PREFERENCIAS](
	[id] [int] NOT NULL,
	[idUsuario] [int] NOT NULL,
	[modo_transporte_preferido] [varchar](255) NOT NULL,
	[moneda_preferida] [varchar](255) NOT NULL,
	[recordar_direcciones_frecuentes] [varchar](255) NOT NULL,
 CONSTRAINT [PK_PREFERENCIAS] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[USUARIO]    Script Date: 23/5/2025 10:39:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[USUARIO](
	[nombre] [varchar](50) NOT NULL,
	[apellido] [varchar](50) NOT NULL,
	[fechaNacimiento] [date] NOT NULL,
	[genero] [varchar](10) NOT NULL,
	[email] [varchar](50) NULL,
	[telefono] [int] NULL,
	[contrasena] [varchar](50) NOT NULL,
	[idUsuario] [int] IDENTITY(1,1) NOT NULL,
	[premium] [bit] NULL,
 CONSTRAINT [PK_USUARIO] PRIMARY KEY CLUSTERED 
(
	[idUsuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[EMPRESA] ON 
GO
INSERT [dbo].[EMPRESA] ([ID], [Nombre], [CantidadAutos]) VALUES (1, N'Uber', 50)
GO
INSERT [dbo].[EMPRESA] ([ID], [Nombre], [CantidadAutos]) VALUES (2, N'Cabify', 40)
GO
INSERT [dbo].[EMPRESA] ([ID], [Nombre], [CantidadAutos]) VALUES (3, N'DiDi', 30)
GO
SET IDENTITY_INSERT [dbo].[EMPRESA] OFF
GO
SET IDENTITY_INSERT [dbo].[USUARIO] ON 
GO
INSERT [dbo].[USUARIO] ([nombre], [apellido], [fechaNacimiento], [genero], [email], [telefono], [contrasena], [idUsuario], [premium]) VALUES (N'Aaron', N'Selener', CAST(N'2008-01-01' AS Date), N'Hombre', N'aaronaxiel@gmail.com', 549117722, N'eugeTeAmo12', 3, NULL)
GO
INSERT [dbo].[USUARIO] ([nombre], [apellido], [fechaNacimiento], [genero], [email], [telefono], [contrasena], [idUsuario], [premium]) VALUES (N'Aaron', N'Selener', CAST(N'2008-01-01' AS Date), N'Hombre', N'aaronaxiel@gmail.com', 549117722, N'eugeTeAmo12', 11, NULL)
GO
INSERT [dbo].[USUARIO] ([nombre], [apellido], [fechaNacimiento], [genero], [email], [telefono], [contrasena], [idUsuario], [premium]) VALUES (N'Beatriz', N'L?pez', CAST(N'1995-05-12' AS Date), N'Mujer', N'beatrizlopez@example.com', 549117723, N'contrase?a123', 12, NULL)
GO
INSERT [dbo].[USUARIO] ([nombre], [apellido], [fechaNacimiento], [genero], [email], [telefono], [contrasena], [idUsuario], [premium]) VALUES (N'Carlos', N'Mart?nez', CAST(N'1988-11-23' AS Date), N'Hombre', N'carlosmartinez@example.com', 549117724, N'1234abcd', 13, NULL)
GO
INSERT [dbo].[USUARIO] ([nombre], [apellido], [fechaNacimiento], [genero], [email], [telefono], [contrasena], [idUsuario], [premium]) VALUES (N'Diana', N'Garc?a', CAST(N'1992-07-30' AS Date), N'Mujer', N'dianagarcia@example.com', 549117725, N'miContrase?a!', 14, NULL)
GO
INSERT [dbo].[USUARIO] ([nombre], [apellido], [fechaNacimiento], [genero], [email], [telefono], [contrasena], [idUsuario], [premium]) VALUES (N'Eduardo', N'Fern?ndez', CAST(N'1985-03-16' AS Date), N'Hombre', N'eduardofernandez@example.com', 549117726, N'Edu12345', 15, NULL)
GO
INSERT [dbo].[USUARIO] ([nombre], [apellido], [fechaNacimiento], [genero], [email], [telefono], [contrasena], [idUsuario], [premium]) VALUES (N'Fernanda', N'P?rez', CAST(N'1990-09-05' AS Date), N'Mujer', N'fernandaperez@example.com', 549117727, N'P@ssw0rd', 16, NULL)
GO
INSERT [dbo].[USUARIO] ([nombre], [apellido], [fechaNacimiento], [genero], [email], [telefono], [contrasena], [idUsuario], [premium]) VALUES (N'Gabriel', N'S?nchez', CAST(N'1979-12-02' AS Date), N'Hombre', N'gabrielsanchez@example.com', 549117728, N'g@briel99', 17, NULL)
GO
INSERT [dbo].[USUARIO] ([nombre], [apellido], [fechaNacimiento], [genero], [email], [telefono], [contrasena], [idUsuario], [premium]) VALUES (N'Helena', N'Ram?rez', CAST(N'1998-04-18' AS Date), N'Mujer', N'helenaramirez@example.com', 549117729, N'Helena2023!', 18, NULL)
GO
INSERT [dbo].[USUARIO] ([nombre], [apellido], [fechaNacimiento], [genero], [email], [telefono], [contrasena], [idUsuario], [premium]) VALUES (N'Ignacio', N'Torres', CAST(N'1983-10-21' AS Date), N'Hombre', N'ignacioramirez@example.com', 549117730, N'Ignacio1234', 19, NULL)
GO
INSERT [dbo].[USUARIO] ([nombre], [apellido], [fechaNacimiento], [genero], [email], [telefono], [contrasena], [idUsuario], [premium]) VALUES (N'Jazm?n', N'Hern?ndez', CAST(N'1996-02-14' AS Date), N'Mujer', N'jazminhernandez@example.com', 549117731, N'Jazmin!2023', 20, NULL)
GO
INSERT [dbo].[USUARIO] ([nombre], [apellido], [fechaNacimiento], [genero], [email], [telefono], [contrasena], [idUsuario], [premium]) VALUES (N'Kevin', N'Jim?nez', CAST(N'1987-08-29' AS Date), N'Hombre', N'kevinjimenez@example.com', 549117732, N'K3vin!', 21, NULL)
GO
INSERT [dbo].[USUARIO] ([nombre], [apellido], [fechaNacimiento], [genero], [email], [telefono], [contrasena], [idUsuario], [premium]) VALUES (N'Laura', N'Morales', CAST(N'1994-06-11' AS Date), N'Mujer', N'lauramorales@example.com', 549117733, N'Laura123', 22, NULL)
GO
INSERT [dbo].[USUARIO] ([nombre], [apellido], [fechaNacimiento], [genero], [email], [telefono], [contrasena], [idUsuario], [premium]) VALUES (N'Miguel', N'Cruz', CAST(N'1980-01-15' AS Date), N'Hombre', N'miguelcruz@example.com', 549117734, N'M1guel!', 23, NULL)
GO
INSERT [dbo].[USUARIO] ([nombre], [apellido], [fechaNacimiento], [genero], [email], [telefono], [contrasena], [idUsuario], [premium]) VALUES (N'Natalia', N'Vargas', CAST(N'1991-03-27' AS Date), N'Mujer', N'natialiavargas@example.com', 549117735, N'N@tal!a', 24, NULL)
GO
INSERT [dbo].[USUARIO] ([nombre], [apellido], [fechaNacimiento], [genero], [email], [telefono], [contrasena], [idUsuario], [premium]) VALUES (N'Oscar', N'Rojas', CAST(N'1986-09-09' AS Date), N'Hombre', N'oscarrojas@example.com', 549117736, N'Osc@r2023', 25, NULL)
GO
INSERT [dbo].[USUARIO] ([nombre], [apellido], [fechaNacimiento], [genero], [email], [telefono], [contrasena], [idUsuario], [premium]) VALUES (N'Paola', N'Reyes', CAST(N'1993-12-05' AS Date), N'Mujer', N'paolareyes@example.com', 549117737, N'Paola!123', 26, NULL)
GO
INSERT [dbo].[USUARIO] ([nombre], [apellido], [fechaNacimiento], [genero], [email], [telefono], [contrasena], [idUsuario], [premium]) VALUES (N'Ricardo', N'Castillo', CAST(N'1984-07-20' AS Date), N'Hombre', N'ricardocastillo@example.com', 549117738, N'R1cardo!', 27, NULL)
GO
INSERT [dbo].[USUARIO] ([nombre], [apellido], [fechaNacimiento], [genero], [email], [telefono], [contrasena], [idUsuario], [premium]) VALUES (N'Sof?a', N'Mendoza', CAST(N'1997-11-11' AS Date), N'Mujer', N'sofimendoza@example.com', 549117739, N'Sof?a2023!', 28, NULL)
GO
INSERT [dbo].[USUARIO] ([nombre], [apellido], [fechaNacimiento], [genero], [email], [telefono], [contrasena], [idUsuario], [premium]) VALUES (N'Tom?s', N'Ponce', CAST(N'1981-05-17' AS Date), N'Hombre', N'tomponce@example.com', 549117740, N'T0m@5!', 29, NULL)
GO
INSERT [dbo].[USUARIO] ([nombre], [apellido], [fechaNacimiento], [genero], [email], [telefono], [contrasena], [idUsuario], [premium]) VALUES (N'Valentina', N'Salazar', CAST(N'1999-08-30' AS Date), N'Mujer', N'valentinasalazar@example.com', 549117741, N'Valen123!', 30, NULL)
GO
INSERT [dbo].[USUARIO] ([nombre], [apellido], [fechaNacimiento], [genero], [email], [telefono], [contrasena], [idUsuario], [premium]) VALUES (N'Ulises', N'Cordero', CAST(N'1989-02-22' AS Date), N'Hombre', N'ulisescordero@example.com', 549117742, N'Uli$es!', 31, NULL)
GO
INSERT [dbo].[USUARIO] ([nombre], [apellido], [fechaNacimiento], [genero], [email], [telefono], [contrasena], [idUsuario], [premium]) VALUES (N'Ximena', N'V?lez', CAST(N'1990-10-10' AS Date), N'Mujer', N'ximenavelez@example.com', 549117743, N'Xim3na!', 32, NULL)
GO
INSERT [dbo].[USUARIO] ([nombre], [apellido], [fechaNacimiento], [genero], [email], [telefono], [contrasena], [idUsuario], [premium]) VALUES (N'Yago', N'Lara', CAST(N'1992-04-04' AS Date), N'Hombre', N'yagolara@example.com', 549117744, N'Y@go2023', 33, NULL)
GO
INSERT [dbo].[USUARIO] ([nombre], [apellido], [fechaNacimiento], [genero], [email], [telefono], [contrasena], [idUsuario], [premium]) VALUES (N'Zoe', N'Berm?dez', CAST(N'1995-01-01' AS Date), N'Mujer', N'zoebermudez@example.com', 549117745, N'Zoe!2023', 34, NULL)
GO
INSERT [dbo].[USUARIO] ([nombre], [apellido], [fechaNacimiento], [genero], [email], [telefono], [contrasena], [idUsuario], [premium]) VALUES (N'Andr?s', N'Mora', CAST(N'1980-06-06' AS Date), N'Hombre', N'andresmora@example.com', 549117746, N'Andr?s123!', 35, NULL)
GO
INSERT [dbo].[USUARIO] ([nombre], [apellido], [fechaNacimiento], [genero], [email], [telefono], [contrasena], [idUsuario], [premium]) VALUES (N'Bianca', N'Paz', CAST(N'1998-07-07' AS Date), N'Mujer', N'biancapaz@example.com', 549117747, N'Bianca@2023', 36, NULL)
GO
INSERT [dbo].[USUARIO] ([nombre], [apellido], [fechaNacimiento], [genero], [email], [telefono], [contrasena], [idUsuario], [premium]) VALUES (N'Cristian', N'Gonz?lez', CAST(N'1982-03-03' AS Date), N'Hombre', N'cristiangonzalez@example.com', 549117748, N'Cris1234!', 37, NULL)
GO
INSERT [dbo].[USUARIO] ([nombre], [apellido], [fechaNacimiento], [genero], [email], [telefono], [contrasena], [idUsuario], [premium]) VALUES (N'Dulce', N'N??ez', CAST(N'1993-08-08' AS Date), N'Mujer', N'dulcenunez@example.com', 549117749, N'Dulce2023!', 38, NULL)
GO
INSERT [dbo].[USUARIO] ([nombre], [apellido], [fechaNacimiento], [genero], [email], [telefono], [contrasena], [idUsuario], [premium]) VALUES (N'Esteban', N'Palacios', CAST(N'1985-12-12' AS Date), N'Hombre', N'estebanpalacios@example.com', 549117750, N'Est3ban!', 39, NULL)
GO
INSERT [dbo].[USUARIO] ([nombre], [apellido], [fechaNacimiento], [genero], [email], [telefono], [contrasena], [idUsuario], [premium]) VALUES (N'Fabiola', N'Cisneros', CAST(N'1991-05-05' AS Date), N'Mujer', N'fabiolacisneros@example.com', 549117751, N'Fabiola123!', 40, NULL)
GO
INSERT [dbo].[USUARIO] ([nombre], [apellido], [fechaNacimiento], [genero], [email], [telefono], [contrasena], [idUsuario], [premium]) VALUES (N'Gustavo', N'Alvarado', CAST(N'1978-11-22' AS Date), N'Hombre', N'gustavoalvarado@example.com', 549117752, N'Gust@vo!', 41, NULL)
GO
INSERT [dbo].[USUARIO] ([nombre], [apellido], [fechaNacimiento], [genero], [email], [telefono], [contrasena], [idUsuario], [premium]) VALUES (N'Hilda', N'Soto', CAST(N'1994-09-09' AS Date), N'Mujer', N'hildasoto@example.com', 549117753, N'Hilda2023!', 42, NULL)
GO
INSERT [dbo].[USUARIO] ([nombre], [apellido], [fechaNacimiento], [genero], [email], [telefono], [contrasena], [idUsuario], [premium]) VALUES (N'Iv?n', N'Guti?rrez', CAST(N'1986-02-28' AS Date), N'Hombre', N'ivangutierrez@example.com', 549117754, N'Iv?n123!', 43, NULL)
GO
INSERT [dbo].[USUARIO] ([nombre], [apellido], [fechaNacimiento], [genero], [email], [telefono], [contrasena], [idUsuario], [premium]) VALUES (N'Juli?n', N'Cabrera', CAST(N'1990-10-10' AS Date), N'Hombre', N'julian@cabrera.com', 549117755, N'Julian2023!', 44, NULL)
GO
INSERT [dbo].[USUARIO] ([nombre], [apellido], [fechaNacimiento], [genero], [email], [telefono], [contrasena], [idUsuario], [premium]) VALUES (N'Karina', N'Flores', CAST(N'1995-01-01' AS Date), N'Mujer', N'karinaflores@example.com', 549117756, N'Karina@2023', 45, NULL)
GO
INSERT [dbo].[USUARIO] ([nombre], [apellido], [fechaNacimiento], [genero], [email], [telefono], [contrasena], [idUsuario], [premium]) VALUES (N'Leonardo', N'Cano', CAST(N'1984-06-06' AS Date), N'Hombre', N'leonardocano@example.com', 549117757, N'Leonardo123!', 46, NULL)
GO
INSERT [dbo].[USUARIO] ([nombre], [apellido], [fechaNacimiento], [genero], [email], [telefono], [contrasena], [idUsuario], [premium]) VALUES (N'Mariana', N'Quintero', CAST(N'1992-08-08' AS Date), N'Mujer', N'marianaquintero@example.com', 549117758, N'Mariana@2023', 47, NULL)
GO
INSERT [dbo].[USUARIO] ([nombre], [apellido], [fechaNacimiento], [genero], [email], [telefono], [contrasena], [idUsuario], [premium]) VALUES (N'Nicol?s', N'Ceballos', CAST(N'1987-03-03' AS Date), N'Hombre', N'nicolaceballos@example.com', 549117759, N'Nicol?s123!', 48, NULL)
GO
INSERT [dbo].[USUARIO] ([nombre], [apellido], [fechaNacimiento], [genero], [email], [telefono], [contrasena], [idUsuario], [premium]) VALUES (N'Olga', N'Mart?nez', CAST(N'1990-12-12' AS Date), N'Mujer', N'olgacmartinez@example.com', 549117760, N'Olga2023!', 49, NULL)
GO
INSERT [dbo].[USUARIO] ([nombre], [apellido], [fechaNacimiento], [genero], [email], [telefono], [contrasena], [idUsuario], [premium]) VALUES (N'Pablo', N'Hern?ndez', CAST(N'1983-07-07' AS Date), N'Hombre', N'pablohernandez@example.com', 549117761, N'Pablo123!', 50, NULL)
GO
INSERT [dbo].[USUARIO] ([nombre], [apellido], [fechaNacimiento], [genero], [email], [telefono], [contrasena], [idUsuario], [premium]) VALUES (N'Quetzal', N'L?pez', CAST(N'1996-11-11' AS Date), N'Mujer', N'quetzallopez@example.com', 549117762, N'Quetzal2023!', 51, NULL)
GO
INSERT [dbo].[USUARIO] ([nombre], [apellido], [fechaNacimiento], [genero], [email], [telefono], [contrasena], [idUsuario], [premium]) VALUES (N'Ra?l', N'Salinas', CAST(N'1989-04-04' AS Date), N'Hombre', N'raulsalinas@example.com', 549117763, N'Ra?l123!', 52, NULL)
GO
INSERT [dbo].[USUARIO] ([nombre], [apellido], [fechaNacimiento], [genero], [email], [telefono], [contrasena], [idUsuario], [premium]) VALUES (N'Silvia', N'Sierra', CAST(N'1991-05-05' AS Date), N'Mujer', N'silviasierra@example.com', 549117764, N'Silvia2023!', 53, NULL)
GO
INSERT [dbo].[USUARIO] ([nombre], [apellido], [fechaNacimiento], [genero], [email], [telefono], [contrasena], [idUsuario], [premium]) VALUES (N'Tob?as', N'Maldonado', CAST(N'1985-09-09' AS Date), N'Hombre', N'tobiasmaldonado@example.com', 549117765, N'Tobias!123', 54, NULL)
GO
INSERT [dbo].[USUARIO] ([nombre], [apellido], [fechaNacimiento], [genero], [email], [telefono], [contrasena], [idUsuario], [premium]) VALUES (N'Ver?nica', N'Valenzuela', CAST(N'1993-02-02' AS Date), N'Mujer', N'veronicavalenzuela@example.com', 549117766, N'Veronica123!', 55, NULL)
GO
INSERT [dbo].[USUARIO] ([nombre], [apellido], [fechaNacimiento], [genero], [email], [telefono], [contrasena], [idUsuario], [premium]) VALUES (N'Walter', N'Vargas', CAST(N'1988-10-10' AS Date), N'Hombre', N'waltervargas@example.com', 549117767, N'Walter2023!', 56, NULL)
GO
INSERT [dbo].[USUARIO] ([nombre], [apellido], [fechaNacimiento], [genero], [email], [telefono], [contrasena], [idUsuario], [premium]) VALUES (N'X?chitl', N'Reyes', CAST(N'1997-01-01' AS Date), N'Mujer', N'xochitlreyes@example.com', 549117768, N'X?chitl@2023', 57, NULL)
GO
INSERT [dbo].[USUARIO] ([nombre], [apellido], [fechaNacimiento], [genero], [email], [telefono], [contrasena], [idUsuario], [premium]) VALUES (N'Yolanda', N'Cruz', CAST(N'1990-06-06' AS Date), N'Mujer', N'yolandacruz@example.com', 549117769, N'Yolanda2023!', 58, NULL)
GO
INSERT [dbo].[USUARIO] ([nombre], [apellido], [fechaNacimiento], [genero], [email], [telefono], [contrasena], [idUsuario], [premium]) VALUES (N'Zacar?as', N'Ortega', CAST(N'1984-07-07' AS Date), N'Hombre', N'zacariasortega@example.com', 549117770, N'Zacarias123!', 59, NULL)
GO
INSERT [dbo].[USUARIO] ([nombre], [apellido], [fechaNacimiento], [genero], [email], [telefono], [contrasena], [idUsuario], [premium]) VALUES (N'Alfonso', N'Mendoza', CAST(N'1982-03-03' AS Date), N'Hombre', N'alfonsomendoza@example.com', 549117771, N'Alfonso@2023', 60, NULL)
GO
INSERT [dbo].[USUARIO] ([nombre], [apellido], [fechaNacimiento], [genero], [email], [telefono], [contrasena], [idUsuario], [premium]) VALUES (N'Belinda', N'Gonz?lez', CAST(N'1995-12-12' AS Date), N'Mujer', N'belindagonzalez@example.com', 549117772, N'Belinda123!', 61, NULL)
GO
INSERT [dbo].[USUARIO] ([nombre], [apellido], [fechaNacimiento], [genero], [email], [telefono], [contrasena], [idUsuario], [premium]) VALUES (N'C?sar', N'Salazar', CAST(N'1983-08-08' AS Date), N'Hombre', N'cesarsalazar@example.com', 549117773, N'C?sar2023!', 62, NULL)
GO
INSERT [dbo].[USUARIO] ([nombre], [apellido], [fechaNacimiento], [genero], [email], [telefono], [contrasena], [idUsuario], [premium]) VALUES (N'Diana', N'Alonso', CAST(N'1990-05-05' AS Date), N'Mujer', N'dianaalonso@example.com', 549117774, N'Diana123!', 63, NULL)
GO
INSERT [dbo].[USUARIO] ([nombre], [apellido], [fechaNacimiento], [genero], [email], [telefono], [contrasena], [idUsuario], [premium]) VALUES (N'Eduardo', N'P?rez', CAST(N'1985-09-09' AS Date), N'Hombre', N'eduardoperez@example.com', 549117775, N'Eduardo@2023', 64, NULL)
GO
INSERT [dbo].[USUARIO] ([nombre], [apellido], [fechaNacimiento], [genero], [email], [telefono], [contrasena], [idUsuario], [premium]) VALUES (N'Fabi?n', N'Morales', CAST(N'1991-11-11' AS Date), N'Hombre', N'fabianmorales@example.com', 549117776, N'Fabi?n2023!', 65, NULL)
GO
INSERT [dbo].[USUARIO] ([nombre], [apellido], [fechaNacimiento], [genero], [email], [telefono], [contrasena], [idUsuario], [premium]) VALUES (N'Gabriela', N'C?rdova', CAST(N'1994-04-04' AS Date), N'Mujer', N'gabrielacordova@example.com', 549117777, N'Gabriela123!', 66, NULL)
GO
INSERT [dbo].[USUARIO] ([nombre], [apellido], [fechaNacimiento], [genero], [email], [telefono], [contrasena], [idUsuario], [premium]) VALUES (N'Hugo', N'S?nchez', CAST(N'1988-02-02' AS Date), N'Hombre', N'hugosanchez@example.com', 549117778, N'Hugo@2023', 67, NULL)
GO
INSERT [dbo].[USUARIO] ([nombre], [apellido], [fechaNacimiento], [genero], [email], [telefono], [contrasena], [idUsuario], [premium]) VALUES (N'Isabel', N'P?rez', CAST(N'1992-01-01' AS Date), N'Mujer', N'isabelperez@example.com', 549117779, N'Isabel2023!', 68, NULL)
GO
INSERT [dbo].[USUARIO] ([nombre], [apellido], [fechaNacimiento], [genero], [email], [telefono], [contrasena], [idUsuario], [premium]) VALUES (N'Javier', N'Ram?rez', CAST(N'1985-06-06' AS Date), N'Hombre', N'javierramirez@example.com', 549117780, N'Javier123!', 69, NULL)
GO
INSERT [dbo].[USUARIO] ([nombre], [apellido], [fechaNacimiento], [genero], [email], [telefono], [contrasena], [idUsuario], [premium]) VALUES (N'Karla', N'Gonz?lez', CAST(N'1990-03-03' AS Date), N'Mujer', N'karlagonzalez@example.com', 549117781, N'Karla@2023', 70, NULL)
GO
INSERT [dbo].[USUARIO] ([nombre], [apellido], [fechaNacimiento], [genero], [email], [telefono], [contrasena], [idUsuario], [premium]) VALUES (N'Luis', N'Hern?ndez', CAST(N'1994-10-10' AS Date), N'Hombre', N'luishernandez@example.com', 549117782, N'Luis2023!', 71, NULL)
GO
INSERT [dbo].[USUARIO] ([nombre], [apellido], [fechaNacimiento], [genero], [email], [telefono], [contrasena], [idUsuario], [premium]) VALUES (N'Marta', N'Torres', CAST(N'1987-12-12' AS Date), N'Mujer', N'martatorres@example.com', 549117783, N'Marta123!', 72, NULL)
GO
INSERT [dbo].[USUARIO] ([nombre], [apellido], [fechaNacimiento], [genero], [email], [telefono], [contrasena], [idUsuario], [premium]) VALUES (N'N?stor', N'Cruz', CAST(N'1983-08-08' AS Date), N'Hombre', N'nestorcruz@example.com', 549117784, N'N?stor2023!', 73, NULL)
GO
INSERT [dbo].[USUARIO] ([nombre], [apellido], [fechaNacimiento], [genero], [email], [telefono], [contrasena], [idUsuario], [premium]) VALUES (N'Olivia', N'Salas', CAST(N'1995-05-05' AS Date), N'Mujer', N'oliviasalas@example.com', 549117785, N'Olivia@2023', 74, NULL)
GO
INSERT [dbo].[USUARIO] ([nombre], [apellido], [fechaNacimiento], [genero], [email], [telefono], [contrasena], [idUsuario], [premium]) VALUES (N'Pedro', N'Soto', CAST(N'1986-11-11' AS Date), N'Hombre', N'pedrosoto@example.com', 549117786, N'Pedro123!', 75, NULL)
GO
INSERT [dbo].[USUARIO] ([nombre], [apellido], [fechaNacimiento], [genero], [email], [telefono], [contrasena], [idUsuario], [premium]) VALUES (N'Quint?n', N'L?pez', CAST(N'1991-01-01' AS Date), N'Hombre', N'quintinlopez@example.com', 549117787, N'Quint?n2023!', 76, NULL)
GO
INSERT [dbo].[USUARIO] ([nombre], [apellido], [fechaNacimiento], [genero], [email], [telefono], [contrasena], [idUsuario], [premium]) VALUES (N'Roc?o', N'Gonz?lez', CAST(N'1992-02-02' AS Date), N'Mujer', N'rociogonzalez@example.com', 549117788, N'Roc?o123!', 77, NULL)
GO
INSERT [dbo].[USUARIO] ([nombre], [apellido], [fechaNacimiento], [genero], [email], [telefono], [contrasena], [idUsuario], [premium]) VALUES (N'Salvador', N'Mendoza', CAST(N'1984-09-09' AS Date), N'Hombre', N'salvadormendoza@example.com', 549117789, N'Salvador2023!', 78, NULL)
GO
INSERT [dbo].[USUARIO] ([nombre], [apellido], [fechaNacimiento], [genero], [email], [telefono], [contrasena], [idUsuario], [premium]) VALUES (N'Teresa', N'Ceballos', CAST(N'1995-07-07' AS Date), N'Mujer', N'teresaceballos@example.com', 549117790, N'Teresa123!', 79, NULL)
GO
INSERT [dbo].[USUARIO] ([nombre], [apellido], [fechaNacimiento], [genero], [email], [telefono], [contrasena], [idUsuario], [premium]) VALUES (N'Ursula', N'Mart?nez', CAST(N'1990-01-01' AS Date), N'Mujer', N'ursulamartinez@example.com', 549117791, N'Ursula@2023', 80, NULL)
GO
INSERT [dbo].[USUARIO] ([nombre], [apellido], [fechaNacimiento], [genero], [email], [telefono], [contrasena], [idUsuario], [premium]) VALUES (N'V?ctor', N'Alvarado', CAST(N'1988-10-10' AS Date), N'Hombre', N'victoralvarado@example.com', 549117792, N'V?ctor2023!', 81, NULL)
GO
INSERT [dbo].[USUARIO] ([nombre], [apellido], [fechaNacimiento], [genero], [email], [telefono], [contrasena], [idUsuario], [premium]) VALUES (N'Wendy', N'Sierra', CAST(N'1993-04-04' AS Date), N'Mujer', N'wendysierra@example.com', 549117793, N'Wendy123!', 82, NULL)
GO
INSERT [dbo].[USUARIO] ([nombre], [apellido], [fechaNacimiento], [genero], [email], [telefono], [contrasena], [idUsuario], [premium]) VALUES (N'Xavier', N'Salazar', CAST(N'1985-05-05' AS Date), N'Hombre', N'xaviersalazar@example.com', 549117794, N'Xavier@2023', 83, NULL)
GO
INSERT [dbo].[USUARIO] ([nombre], [apellido], [fechaNacimiento], [genero], [email], [telefono], [contrasena], [idUsuario], [premium]) VALUES (N'Yadira', N'Morales', CAST(N'1991-06-06' AS Date), N'Mujer', N'yadiramorales@example.com', 549117795, N'Yadira2023!', 84, NULL)
GO
INSERT [dbo].[USUARIO] ([nombre], [apellido], [fechaNacimiento], [genero], [email], [telefono], [contrasena], [idUsuario], [premium]) VALUES (N'Zulema', N'Cruz', CAST(N'1994-12-12' AS Date), N'Mujer', N'zulemacruz@example.com', 549117796, N'Zulema@2023', 85, NULL)
GO
INSERT [dbo].[USUARIO] ([nombre], [apellido], [fechaNacimiento], [genero], [email], [telefono], [contrasena], [idUsuario], [premium]) VALUES (N'Alberto', N'L?pez', CAST(N'1980-08-08' AS Date), N'Hombre', N'albertolopez@example.com', 549117797, N'Alberto2023!', 86, NULL)
GO
INSERT [dbo].[USUARIO] ([nombre], [apellido], [fechaNacimiento], [genero], [email], [telefono], [contrasena], [idUsuario], [premium]) VALUES (N'B?rbara', N'P?rez', CAST(N'1996-04-04' AS Date), N'Mujer', N'barbaraperez@example.com', 549117798, N'B?rbara123!', 87, NULL)
GO
INSERT [dbo].[USUARIO] ([nombre], [apellido], [fechaNacimiento], [genero], [email], [telefono], [contrasena], [idUsuario], [premium]) VALUES (N'Cecilia', N'Gonz?lez', CAST(N'1982-11-11' AS Date), N'Mujer', N'ceciagonzalez@example.com', 549117799, N'Cecilia2023!', 88, NULL)
GO
INSERT [dbo].[USUARIO] ([nombre], [apellido], [fechaNacimiento], [genero], [email], [telefono], [contrasena], [idUsuario], [premium]) VALUES (N'Diego', N'Hern?ndez', CAST(N'1984-03-03' AS Date), N'Hombre', N'diegohernandez@example.com', 549117800, N'Diego123!', 89, NULL)
GO
INSERT [dbo].[USUARIO] ([nombre], [apellido], [fechaNacimiento], [genero], [email], [telefono], [contrasena], [idUsuario], [premium]) VALUES (N'Elena', N'Mart?nez', CAST(N'1989-01-01' AS Date), N'Mujer', N'elenamartinez@example.com', 549117801, N'Elena@2023', 90, NULL)
GO
INSERT [dbo].[USUARIO] ([nombre], [apellido], [fechaNacimiento], [genero], [email], [telefono], [contrasena], [idUsuario], [premium]) VALUES (N'Fernando', N'Cruz', CAST(N'1981-10-10' AS Date), N'Hombre', N'fernandocruz@example.com', 549117802, N'Fernando2023!', 91, NULL)
GO
INSERT [dbo].[USUARIO] ([nombre], [apellido], [fechaNacimiento], [genero], [email], [telefono], [contrasena], [idUsuario], [premium]) VALUES (N'Gabriela', N'Salazar', CAST(N'1993-06-06' AS Date), N'Mujer', N'gabrielasalazar@example.com', 549117803, N'Gabriela123!', 92, NULL)
GO
INSERT [dbo].[USUARIO] ([nombre], [apellido], [fechaNacimiento], [genero], [email], [telefono], [contrasena], [idUsuario], [premium]) VALUES (N'H?ctor', N'L?pez', CAST(N'1985-05-05' AS Date), N'Hombre', N'hectorlopez@example.com', 549117804, N'H?ctor@2023', 93, NULL)
GO
INSERT [dbo].[USUARIO] ([nombre], [apellido], [fechaNacimiento], [genero], [email], [telefono], [contrasena], [idUsuario], [premium]) VALUES (N'Ivana', N'Gonz?lez', CAST(N'1994-12-12' AS Date), N'Mujer', N'ivanagonzalez@example.com', 549117805, N'Ivana2023!', 94, NULL)
GO
INSERT [dbo].[USUARIO] ([nombre], [apellido], [fechaNacimiento], [genero], [email], [telefono], [contrasena], [idUsuario], [premium]) VALUES (N'Jorge', N'Mendoza', CAST(N'1988-07-07' AS Date), N'Hombre', N'jorgemendoza@example.com', 549117806, N'Jorge123!', 95, NULL)
GO
INSERT [dbo].[USUARIO] ([nombre], [apellido], [fechaNacimiento], [genero], [email], [telefono], [contrasena], [idUsuario], [premium]) VALUES (N'Karina', N'Guti?rrez', CAST(N'1992-11-11' AS Date), N'Mujer', N'karinagutierrez@example.com', 549117807, N'Karina2023!', 96, NULL)
GO
INSERT [dbo].[USUARIO] ([nombre], [apellido], [fechaNacimiento], [genero], [email], [telefono], [contrasena], [idUsuario], [premium]) VALUES (N'Luis', N'Alvarado', CAST(N'1983-03-03' AS Date), N'Hombre', N'luisalvarado@example.com', 549117808, N'Luis@2023', 97, NULL)
GO
INSERT [dbo].[USUARIO] ([nombre], [apellido], [fechaNacimiento], [genero], [email], [telefono], [contrasena], [idUsuario], [premium]) VALUES (N'M?nica', N'P?rez', CAST(N'1990-06-06' AS Date), N'Mujer', N'monicaperez@example.com', 549117809, N'M?nica123!', 98, NULL)
GO
INSERT [dbo].[USUARIO] ([nombre], [apellido], [fechaNacimiento], [genero], [email], [telefono], [contrasena], [idUsuario], [premium]) VALUES (N'Nicol?s', N'Sierra', CAST(N'1987-12-12' AS Date), N'Hombre', N'nicolassierra@example.com', 549117810, N'Nicol?s@2023', 99, NULL)
GO
INSERT [dbo].[USUARIO] ([nombre], [apellido], [fechaNacimiento], [genero], [email], [telefono], [contrasena], [idUsuario], [premium]) VALUES (N'Olivia', N'Salas', CAST(N'1995-08-08' AS Date), N'Mujer', N'oliviasalas@example.com', 549117811, N'Olivia2023!', 100, NULL)
GO
INSERT [dbo].[USUARIO] ([nombre], [apellido], [fechaNacimiento], [genero], [email], [telefono], [contrasena], [idUsuario], [premium]) VALUES (N'Pablo', N'Cruz', CAST(N'1986-04-04' AS Date), N'Hombre', N'pablocruz@example.com', 549117812, N'Pablo123!', 101, NULL)
GO
INSERT [dbo].[USUARIO] ([nombre], [apellido], [fechaNacimiento], [genero], [email], [telefono], [contrasena], [idUsuario], [premium]) VALUES (N'Quimera', N'Hern?ndez', CAST(N'1991-10-10' AS Date), N'Mujer', N'quimerahernandez@example.com', 549117813, N'Quimera2023!', 102, NULL)
GO
INSERT [dbo].[USUARIO] ([nombre], [apellido], [fechaNacimiento], [genero], [email], [telefono], [contrasena], [idUsuario], [premium]) VALUES (N'Rafael', N'L?pez', CAST(N'1989-05-05' AS Date), N'Hombre', N'rafaellopez@example.com', 549117814, N'Rafael123!', 103, NULL)
GO
INSERT [dbo].[USUARIO] ([nombre], [apellido], [fechaNacimiento], [genero], [email], [telefono], [contrasena], [idUsuario], [premium]) VALUES (N'Sof?a', N'Gonz?lez', CAST(N'1993-01-01' AS Date), N'Mujer', N'sofiagonzalez@example.com', 549117815, N'Sof?a2023!', 104, NULL)
GO
INSERT [dbo].[USUARIO] ([nombre], [apellido], [fechaNacimiento], [genero], [email], [telefono], [contrasena], [idUsuario], [premium]) VALUES (N'Tom?s', N'Maldonado', CAST(N'1984-02-02' AS Date), N'Hombre', N'tomasmaldonado@example.com', 549117816, N'Tom?s123!', 105, NULL)
GO
INSERT [dbo].[USUARIO] ([nombre], [apellido], [fechaNacimiento], [genero], [email], [telefono], [contrasena], [idUsuario], [premium]) VALUES (N'Ursula', N'Mart?nez', CAST(N'1990-06-06' AS Date), N'Mujer', N'ursulammartinez@example.com', 549117817, N'Ursula', 106, NULL)
GO
INSERT [dbo].[USUARIO] ([nombre], [apellido], [fechaNacimiento], [genero], [email], [telefono], [contrasena], [idUsuario], [premium]) VALUES (N'Joaquin', N'Paterno', CAST(N'2000-07-02' AS Date), N'Hombre', N'a@gmail.com', NULL, N'Avenida2', 107, NULL)
GO
INSERT [dbo].[USUARIO] ([nombre], [apellido], [fechaNacimiento], [genero], [email], [telefono], [contrasena], [idUsuario], [premium]) VALUES (N'Joaquin', N'Paterno', CAST(N'2000-01-02' AS Date), N'Hombre', N'a@gmail.com', NULL, N'</div>', 108, NULL)
GO
INSERT [dbo].[USUARIO] ([nombre], [apellido], [fechaNacimiento], [genero], [email], [telefono], [contrasena], [idUsuario], [premium]) VALUES (N'Joaquin', N'Paterno', CAST(N'2000-01-08' AS Date), N'Hombre', N'a@gmail.com', NULL, N'</div>', 109, NULL)
GO
INSERT [dbo].[USUARIO] ([nombre], [apellido], [fechaNacimiento], [genero], [email], [telefono], [contrasena], [idUsuario], [premium]) VALUES (N'Joaquin', N'Paterno', CAST(N'2008-03-18' AS Date), N'Hombre', N'a@gmail.com', NULL, N'</div>', 110, NULL)
GO
INSERT [dbo].[USUARIO] ([nombre], [apellido], [fechaNacimiento], [genero], [email], [telefono], [contrasena], [idUsuario], [premium]) VALUES (N'Joaquin', N'Paterno', CAST(N'2008-03-18' AS Date), N'Hombre', N'a@gmail.com', NULL, N'</div>', 111, NULL)
GO
INSERT [dbo].[USUARIO] ([nombre], [apellido], [fechaNacimiento], [genero], [email], [telefono], [contrasena], [idUsuario], [premium]) VALUES (N'Joaquin', N'Paterno', CAST(N'2008-03-18' AS Date), N'Hombre', N'a@gmail.com', NULL, N'</div>', 112, NULL)
GO
INSERT [dbo].[USUARIO] ([nombre], [apellido], [fechaNacimiento], [genero], [email], [telefono], [contrasena], [idUsuario], [premium]) VALUES (N'Joaquin', N'Paterno', CAST(N'2008-03-18' AS Date), N'Hombre', N'a@gmail.com', NULL, N'name = "precio"', 113, NULL)
GO
INSERT [dbo].[USUARIO] ([nombre], [apellido], [fechaNacimiento], [genero], [email], [telefono], [contrasena], [idUsuario], [premium]) VALUES (N'Joaquin', N'Paterno', CAST(N'2008-03-18' AS Date), N'Hombre', N'a@gmail.com', NULL, N'    precio.value = precioCalculado;', 114, NULL)
GO
INSERT [dbo].[USUARIO] ([nombre], [apellido], [fechaNacimiento], [genero], [email], [telefono], [contrasena], [idUsuario], [premium]) VALUES (N'Joaquin', N'Paterno', CAST(N'2008-03-18' AS Date), N'Hombre', N'a@gmail.com', NULL, N'name = "costo"', 115, NULL)
GO
SET IDENTITY_INSERT [dbo].[USUARIO] OFF
GO
USE [master]
GO
ALTER DATABASE [SMARTRIP] SET  READ_WRITE 
GO
