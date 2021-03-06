USE [master]
GO
/****** Object:  Database [autopujcovna]    Script Date: 11/11/2021 12:21:13 PM ******/
CREATE DATABASE [autopujcovna]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'autopujcovna', FILENAME = N'C:\Users\Kuba\autopujcovna.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'autopujcovna_log', FILENAME = N'C:\Users\Kuba\autopujcovna_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [autopujcovna] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [autopujcovna].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [autopujcovna] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [autopujcovna] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [autopujcovna] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [autopujcovna] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [autopujcovna] SET ARITHABORT OFF 
GO
ALTER DATABASE [autopujcovna] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [autopujcovna] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [autopujcovna] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [autopujcovna] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [autopujcovna] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [autopujcovna] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [autopujcovna] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [autopujcovna] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [autopujcovna] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [autopujcovna] SET  DISABLE_BROKER 
GO
ALTER DATABASE [autopujcovna] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [autopujcovna] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [autopujcovna] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [autopujcovna] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [autopujcovna] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [autopujcovna] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [autopujcovna] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [autopujcovna] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [autopujcovna] SET  MULTI_USER 
GO
ALTER DATABASE [autopujcovna] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [autopujcovna] SET DB_CHAINING OFF 
GO
ALTER DATABASE [autopujcovna] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [autopujcovna] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [autopujcovna] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [autopujcovna] SET QUERY_STORE = OFF
GO
USE [autopujcovna]
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
USE [autopujcovna]
GO
/****** Object:  Table [dbo].[auto]    Script Date: 11/11/2021 12:21:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[auto](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[idZnacky] [int] NOT NULL,
	[rokUvedeni] [date] NULL,
	[tachometr] [bigint] NULL,
	[vykonKW] [int] NULL,
	[barva] [varchar](30) NULL,
	[STKdo] [date] NULL,
	[typKarId] [int] NULL,
	[idPohonu] [int] NOT NULL,
	[mist] [int] NULL,
	[emise] [varchar](20) NULL,
	[delkaCm] [int] NULL,
	[vyskaCm] [int] NULL,
	[sirkaCm] [int] NULL,
	[cenaDen] [int] NULL,
	[zavady] [text] NULL,
	[poznamka] [text] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[klient]    Script Date: 11/11/2021 12:21:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [klient] (
  [id] int PRIMARY KEY NOT NULL IDENTITY(1, 1),
  [adresa] varchar(150),
  [email] varchar(400),
  [skore] int default 0
)
GO

CREATE TABLE [propujcka] (
  [id] int PRIMARY KEY NOT NULL IDENTITY(1, 1),
  [idKlienta] int NOT NULL,
  [idAuta] int NOT NULL,
  [casZacatku] datetime check(casZacatku>'01-01-2021'),
  [casKonce] datetime ,
  [popis] text
)
GO

CREATE TABLE [auto] (
  [id] int PRIMARY KEY NOT NULL IDENTITY(1, 1),
  [idZnacky] int NOT NULL,
  [rokUvedeni] date,
  [tachometr] bigint,
  [vykonKW] int,
  [barva] varchar(30),
  [STKdo] date,
  [typKarId] int,
  [idPohonu] int not null,
  [mist] int check(mist>=1),
  [emise] varchar(20),
  [delkaCm] int check(delkaCm>0 and delkaCm < 10000),
  [vyskaCm] int check(vyskaCm>0 and vyskaCm < 10000),
  [sirkaCm] int check(sirkaCm>0 and sirkaCm < 10000),
  [cenaDen] int,
  [zavady] text,
  [poznamka] text
)
GO

CREATE TABLE [typKaroserie] (
  [id] int PRIMARY KEY NOT NULL IDENTITY(1, 1),
  [nazev] nvarchar(50)
)
GO

CREATE TABLE [typPohonu] (
  [id] int PRIMARY KEY NOT NULL IDENTITY(1, 1),
  [nazev] nvarchar(50)
)
GO

CREATE TABLE [servisAuta] (
  [id] int PRIMARY KEY NOT NULL IDENTITY(1, 1),
  [idAuta] int NOT NULL,
  [idZamestnance] int NOT NULL,
  [naklady] decimal,
  [popis] text
)
GO

CREATE TABLE [zamestnanec] (
  [id] int PRIMARY KEY NOT NULL IDENTITY(1, 1),
  [rodCis] varchar(20),
  [adresa] varchar(150),
  [email] varchar(400),
  [nazevPozice] nvarchar(50),
  [plat] decimal check(plat>0 and plat<500000)
)
GO

CREATE TABLE [znacka] (
  [id] int PRIMARY KEY NOT NULL IDENTITY(1, 1),
  [nazev] nvarchar(50)
)
GO

CREATE TABLE [sluzbaPropujcky] (
  [id] int PRIMARY KEY NOT NULL IDENTITY(1, 1),
  [idPropujcky] int NOT NULL,
  [idSluzby] int NOT NULL
)
GO

CREATE TABLE [sluzba] (
  [id] int PRIMARY KEY NOT NULL IDENTITY(1, 1),
  [nazev] nvarchar(150),
  [cenaKc] decimal,
  [poznamka] nvarchar(512)
)
GO

CREATE TABLE [zavadyAuta] (
  [id] int PRIMARY KEY NOT NULL IDENTITY(1, 1),
  [idAuta] int NOT NULL,
  [idZavady] int NOT NULL
)
GO

CREATE TABLE [zavady] (
  [id] int PRIMARY KEY NOT NULL IDENTITY(1, 1),
  [datumVzniku] datetime,
  [popis] text
)
GO
SET IDENTITY_INSERT [dbo].[auto] ON 

INSERT [dbo].[auto] ([id], [idZnacky], [rokUvedeni], [tachometr], [vykonKW], [barva], [STKdo], [typKarId], [idPohonu], [mist], [emise], [delkaCm], [vyskaCm], [sirkaCm], [cenaDen], [zavady], [poznamka]) VALUES (1, 5, CAST(N'1998-01-01' AS Date), 192335, 88, N'Stríbrná metalíza', CAST(N'2023-01-01' AS Date), 5, 1, 5, N'Euro 2', 353, 178, 176, 9000, N'Rozkradení', N'')
INSERT [dbo].[auto] ([id], [idZnacky], [rokUvedeni], [tachometr], [vykonKW], [barva], [STKdo], [typKarId], [idPohonu], [mist], [emise], [delkaCm], [vyskaCm], [sirkaCm], [cenaDen], [zavady], [poznamka]) VALUES (2, 6, CAST(N'2002-01-01' AS Date), 156041, 66, N'Cervená', CAST(N'2022-01-01' AS Date), 1, 3, 5, N'Euro 4', 378, 173, 176, 1500, N'Volant zatácí do prava', N'')
INSERT [dbo].[auto] ([id], [idZnacky], [rokUvedeni], [tachometr], [vykonKW], [barva], [STKdo], [typKarId], [idPohonu], [mist], [emise], [delkaCm], [vyskaCm], [sirkaCm], [cenaDen], [zavady], [poznamka]) VALUES (3, 2, CAST(N'2007-01-01' AS Date), 235001, 124, N'Bílá', CAST(N'2022-01-01' AS Date), 4, 4, 7, N'Euro 3', 428, 186, 163, 11000, N'', N'')
INSERT [dbo].[auto] ([id], [idZnacky], [rokUvedeni], [tachometr], [vykonKW], [barva], [STKdo], [typKarId], [idPohonu], [mist], [emise], [delkaCm], [vyskaCm], [sirkaCm], [cenaDen], [zavady], [poznamka]) VALUES (4, 11, CAST(N'2007-01-01' AS Date), 66894, 38, N'Modrá metalíza', CAST(N'2021-01-01' AS Date), 2, 1, 2, N'Euro 3', 221, 176, 168, 3050, N'', N'')
INSERT [dbo].[auto] ([id], [idZnacky], [rokUvedeni], [tachometr], [vykonKW], [barva], [STKdo], [typKarId], [idPohonu], [mist], [emise], [delkaCm], [vyskaCm], [sirkaCm], [cenaDen], [zavady], [poznamka]) VALUES (5, 1, CAST(N'1992-01-01' AS Date), 351264, 78, N'Stríbrná metalíza', CAST(N'2023-01-01' AS Date), 1, 1, 5, N'Euro 1', 308, 185, 150, 790, N'', N'')
INSERT [dbo].[auto] ([id], [idZnacky], [rokUvedeni], [tachometr], [vykonKW], [barva], [STKdo], [typKarId], [idPohonu], [mist], [emise], [delkaCm], [vyskaCm], [sirkaCm], [cenaDen], [zavady], [poznamka]) VALUES (6, 3, CAST(N'2002-01-01' AS Date), 201065, 79, N'Bílá', CAST(N'2021-01-01' AS Date), 3, 3, 5, N'Euro 3', 320, 183, 161, 6500, N'Vuz nebrzdí v kopci', N'')
INSERT [dbo].[auto] ([id], [idZnacky], [rokUvedeni], [tachometr], [vykonKW], [barva], [STKdo], [typKarId], [idPohonu], [mist], [emise], [delkaCm], [vyskaCm], [sirkaCm], [cenaDen], [zavady], [poznamka]) VALUES (7, 5, CAST(N'2009-01-01' AS Date), 132407, 98, N'Bílá', CAST(N'2022-01-01' AS Date), 5, 2, 5, N'Euro 4', 303, 184, 168, 3580, N'', N'')
INSERT [dbo].[auto] ([id], [idZnacky], [rokUvedeni], [tachometr], [vykonKW], [barva], [STKdo], [typKarId], [idPohonu], [mist], [emise], [delkaCm], [vyskaCm], [sirkaCm], [cenaDen], [zavady], [poznamka]) VALUES (8, 7, CAST(N'1999-01-01' AS Date), 446998, 158, N'Stríbrná metalíza', CAST(N'2023-01-01' AS Date), 6, 1, 5, N'Euro 2', 398, 188, 165, 1120, N'', N'')
INSERT [dbo].[auto] ([id], [idZnacky], [rokUvedeni], [tachometr], [vykonKW], [barva], [STKdo], [typKarId], [idPohonu], [mist], [emise], [delkaCm], [vyskaCm], [sirkaCm], [cenaDen], [zavady], [poznamka]) VALUES (9, 4, CAST(N'2002-01-01' AS Date), 178004, 120, N'Žlutá', CAST(N'2023-01-01' AS Date), 2, 4, 2, N'Euro 3', 278, 179, 166, 17500, N'', N'')
INSERT [dbo].[auto] ([id], [idZnacky], [rokUvedeni], [tachometr], [vykonKW], [barva], [STKdo], [typKarId], [idPohonu], [mist], [emise], [delkaCm], [vyskaCm], [sirkaCm], [cenaDen], [zavady], [poznamka]) VALUES (10, 5, CAST(N'2011-01-01' AS Date), 89230, 88, N'Cerná', CAST(N'2024-01-01' AS Date), 6, 5, 5, N'Euro 6', 339, 181, 161, 3600, N'', N'')
INSERT [dbo].[auto] ([id], [idZnacky], [rokUvedeni], [tachometr], [vykonKW], [barva], [STKdo], [typKarId], [idPohonu], [mist], [emise], [delkaCm], [vyskaCm], [sirkaCm], [cenaDen], [zavady], [poznamka]) VALUES (11, 2, CAST(N'2001-01-01' AS Date), 302110, 98, N'Cerná', CAST(N'2021-01-01' AS Date), 5, 4, 5, N'Euro 3', 365, 189, 155, 7800, N'', N'')
INSERT [dbo].[auto] ([id], [idZnacky], [rokUvedeni], [tachometr], [vykonKW], [barva], [STKdo], [typKarId], [idPohonu], [mist], [emise], [delkaCm], [vyskaCm], [sirkaCm], [cenaDen], [zavady], [poznamka]) VALUES (12, 1, CAST(N'1995-01-01' AS Date), 650321, 168, N'Bílá', CAST(N'2022-01-01' AS Date), 4, 1, 7, N'Euro 1', 391, 190, 167, 4500, N'', N'')
INSERT [dbo].[auto] ([id], [idZnacky], [rokUvedeni], [tachometr], [vykonKW], [barva], [STKdo], [typKarId], [idPohonu], [mist], [emise], [delkaCm], [vyskaCm], [sirkaCm], [cenaDen], [zavady], [poznamka]) VALUES (13, 6, CAST(N'2002-01-01' AS Date), 178060, 148, N'Zelená', CAST(N'2022-01-01' AS Date), 5, 1, 5, N'Euro 3', 391, 179, 161, 3580, N'', N't')
INSERT [dbo].[auto] ([id], [idZnacky], [rokUvedeni], [tachometr], [vykonKW], [barva], [STKdo], [typKarId], [idPohonu], [mist], [emise], [delkaCm], [vyskaCm], [sirkaCm], [cenaDen], [zavady], [poznamka]) VALUES (14, 9, CAST(N'2019-01-01' AS Date), 38502, 143, N'Cerná', CAST(N'2023-01-01' AS Date), 4, 6, 7, N'Euro 7', 398, 186, 176, 17500, N'', N'')
INSERT [dbo].[auto] ([id], [idZnacky], [rokUvedeni], [tachometr], [vykonKW], [barva], [STKdo], [typKarId], [idPohonu], [mist], [emise], [delkaCm], [vyskaCm], [sirkaCm], [cenaDen], [zavady], [poznamka]) VALUES (15, 8, CAST(N'2011-01-01' AS Date), 117500, 98, N'', CAST(N'2021-01-01' AS Date), 1, 3, 5, N'Euro 4', 221, 190, 176, 9000, N'', N'')
INSERT [dbo].[auto] ([id], [idZnacky], [rokUvedeni], [tachometr], [vykonKW], [barva], [STKdo], [typKarId], [idPohonu], [mist], [emise], [delkaCm], [vyskaCm], [sirkaCm], [cenaDen], [zavady], [poznamka]) VALUES (16, 5, CAST(N'1998-01-01' AS Date), 608921, 98, N'', CAST(N'2021-01-01' AS Date), 1, 3, 5, N'Euro 2', 339, 185, 168, 3050, N'', N'')
INSERT [dbo].[auto] ([id], [idZnacky], [rokUvedeni], [tachometr], [vykonKW], [barva], [STKdo], [typKarId], [idPohonu], [mist], [emise], [delkaCm], [vyskaCm], [sirkaCm], [cenaDen], [zavady], [poznamka]) VALUES (17, 2, CAST(N'1991-01-01' AS Date), 571224, 168, N'', CAST(N'2021-01-01' AS Date), 5, 2, 5, N'Euro 1', 320, 179, 155, 3580, N'', N'')
INSERT [dbo].[auto] ([id], [idZnacky], [rokUvedeni], [tachometr], [vykonKW], [barva], [STKdo], [typKarId], [idPohonu], [mist], [emise], [delkaCm], [vyskaCm], [sirkaCm], [cenaDen], [zavady], [poznamka]) VALUES (18, 1, CAST(N'1995-01-01' AS Date), 410234, 178, N'', CAST(N'2023-01-01' AS Date), 3, 1, 7, N'Euro 1', 378, 184, 166, 780, N'', N'')
INSERT [dbo].[auto] ([id], [idZnacky], [rokUvedeni], [tachometr], [vykonKW], [barva], [STKdo], [typKarId], [idPohonu], [mist], [emise], [delkaCm], [vyskaCm], [sirkaCm], [cenaDen], [zavady], [poznamka]) VALUES (19, 8, CAST(N'2013-01-01' AS Date), 360100, 138, N'', CAST(N'2023-01-01' AS Date), 1, 4, 5, N'Euro 3', 353, 181, 163, 11200, N'', N'')
INSERT [dbo].[auto] ([id], [idZnacky], [rokUvedeni], [tachometr], [vykonKW], [barva], [STKdo], [typKarId], [idPohonu], [mist], [emise], [delkaCm], [vyskaCm], [sirkaCm], [cenaDen], [zavady], [poznamka]) VALUES (20, 9, CAST(N'2018-01-01' AS Date), 78541, 78, N'Bilá', CAST(N'2025-01-01' AS Date), 3, 5, 5, N'Euro 8', 303, 185, 161, 9850, N'', N't')
SET IDENTITY_INSERT [dbo].[auto] OFF
GO
SET IDENTITY_INSERT [dbo].[klient] ON 

INSERT [dbo].[klient] ([id], [adresa], [email], [skore]) VALUES (1, N'Polenterova 1', N'ontolonto@mail.com', 52)
INSERT [dbo].[klient] ([id], [adresa], [email], [skore]) VALUES (2, N'Pasteriankového 26', N'hombess@seznam.cz', 32)
INSERT [dbo].[klient] ([id], [adresa], [email], [skore]) VALUES (3, N'Lazenská 54', N'tripulkysmrti@seznam.cz', 58)
INSERT [dbo].[klient] ([id], [adresa], [email], [skore]) VALUES (4, N'Nad lažýrském 98', N'podhladinku@mail.com', 98)
INSERT [dbo].[klient] ([id], [adresa], [email], [skore]) VALUES (5, N'Nuodrenova 21', N'tomu@mail.com', 101)
SET IDENTITY_INSERT [dbo].[klient] OFF
GO
SET IDENTITY_INSERT [dbo].[propujcka] ON 

INSERT [dbo].[propujcka] ([id], [idKlienta], [idAuta], [casZacatku], [casKonce], [popis]) VALUES (2, 1, 13, CAST(N'2021-05-02T14:30:00.000' AS DateTime), CAST(N'2021-05-03T12:30:00.000' AS DateTime), N'')
INSERT [dbo].[propujcka] ([id], [idKlienta], [idAuta], [casZacatku], [casKonce], [popis]) VALUES (3, 4, 14, CAST(N'2021-05-04T11:00:00.000' AS DateTime), CAST(N'2021-05-09T12:30:00.000' AS DateTime), N'')
INSERT [dbo].[propujcka] ([id], [idKlienta], [idAuta], [casZacatku], [casKonce], [popis]) VALUES (4, 3, 15, CAST(N'2021-05-02T14:35:00.000' AS DateTime), CAST(N'2021-05-08T12:30:00.000' AS DateTime), N'')
INSERT [dbo].[propujcka] ([id], [idKlienta], [idAuta], [casZacatku], [casKonce], [popis]) VALUES (5, 5, 16, CAST(N'2021-06-02T21:00:00.000' AS DateTime), CAST(N'2021-06-04T14:30:00.000' AS DateTime), N'')
INSERT [dbo].[propujcka] ([id], [idKlienta], [idAuta], [casZacatku], [casKonce], [popis]) VALUES (6, 1, 17, CAST(N'2021-07-02T04:30:00.000' AS DateTime), CAST(N'2021-07-01T04:31:00.000' AS DateTime), N'')
INSERT [dbo].[propujcka] ([id], [idKlienta], [idAuta], [casZacatku], [casKonce], [popis]) VALUES (7, 2, 18, CAST(N'2021-07-24T20:56:00.000' AS DateTime), CAST(N'2021-07-29T14:04:00.000' AS DateTime), N'Klient vrátil vuz ve zanedbalém stavu')
INSERT [dbo].[propujcka] ([id], [idKlienta], [idAuta], [casZacatku], [casKonce], [popis]) VALUES (8, 1, 19, CAST(N'2021-08-01T16:30:00.000' AS DateTime), CAST(N'2021-08-17T16:30:00.000' AS DateTime), N'')
INSERT [dbo].[propujcka] ([id], [idKlienta], [idAuta], [casZacatku], [casKonce], [popis]) VALUES (9, 3, 20, CAST(N'2021-08-01T16:30:00.000' AS DateTime), CAST(N'2021-08-05T18:30:00.000' AS DateTime), N'')
SET IDENTITY_INSERT [dbo].[propujcka] OFF
GO
SET IDENTITY_INSERT [dbo].[servisAuta] ON 

INSERT [dbo].[servisAuta] ([id], [idAuta], [idZamestnance], [naklady], [popis]) VALUES (3, 10, 6, CAST(15360 AS Decimal(18, 0)), NULL)
INSERT [dbo].[servisAuta] ([id], [idAuta], [idZamestnance], [naklady], [popis]) VALUES (4, 2, 4, CAST(850 AS Decimal(18, 0)), NULL)
INSERT [dbo].[servisAuta] ([id], [idAuta], [idZamestnance], [naklady], [popis]) VALUES (5, 3, 2, CAST(8060 AS Decimal(18, 0)), NULL)
INSERT [dbo].[servisAuta] ([id], [idAuta], [idZamestnance], [naklady], [popis]) VALUES (6, 4, 6, CAST(21240 AS Decimal(18, 0)), NULL)
INSERT [dbo].[servisAuta] ([id], [idAuta], [idZamestnance], [naklady], [popis]) VALUES (7, 5, 4, CAST(11200 AS Decimal(18, 0)), NULL)
INSERT [dbo].[servisAuta] ([id], [idAuta], [idZamestnance], [naklady], [popis]) VALUES (8, 6, 4, CAST(650 AS Decimal(18, 0)), NULL)
INSERT [dbo].[servisAuta] ([id], [idAuta], [idZamestnance], [naklady], [popis]) VALUES (9, 7, 2, CAST(770 AS Decimal(18, 0)), NULL)
INSERT [dbo].[servisAuta] ([id], [idAuta], [idZamestnance], [naklady], [popis]) VALUES (10, 8, 3, CAST(5030 AS Decimal(18, 0)), NULL)
INSERT [dbo].[servisAuta] ([id], [idAuta], [idZamestnance], [naklady], [popis]) VALUES (11, 9, 6, CAST(4560 AS Decimal(18, 0)), NULL)
INSERT [dbo].[servisAuta] ([id], [idAuta], [idZamestnance], [naklady], [popis]) VALUES (12, 10, 2, CAST(1120 AS Decimal(18, 0)), NULL)
INSERT [dbo].[servisAuta] ([id], [idAuta], [idZamestnance], [naklady], [popis]) VALUES (13, 11, 2, CAST(9800 AS Decimal(18, 0)), NULL)
INSERT [dbo].[servisAuta] ([id], [idAuta], [idZamestnance], [naklady], [popis]) VALUES (14, 12, 6, CAST(14500 AS Decimal(18, 0)), NULL)
SET IDENTITY_INSERT [dbo].[servisAuta] OFF
GO
SET IDENTITY_INSERT [dbo].[sluzba] ON 

INSERT [dbo].[sluzba] ([id], [nazev], [cenaKc], [poznamka]) VALUES (1, N'dovoz auta na místo', CAST(1499 AS Decimal(18, 0)), NULL)
INSERT [dbo].[sluzba] ([id], [nazev], [cenaKc], [poznamka]) VALUES (2, N'zahrádka', CAST(600 AS Decimal(18, 0)), NULL)
INSERT [dbo].[sluzba] ([id], [nazev], [cenaKc], [poznamka]) VALUES (3, N'zahrádka i s montáží', CAST(1199 AS Decimal(18, 0)), NULL)
INSERT [dbo].[sluzba] ([id], [nazev], [cenaKc], [poznamka]) VALUES (4, N'odvoz auta z jakekoliv lokace', CAST(1499 AS Decimal(18, 0)), N'musi byt v cr')
SET IDENTITY_INSERT [dbo].[sluzba] OFF
GO
SET IDENTITY_INSERT [dbo].[sluzbaPropujcky] ON 

INSERT [dbo].[sluzbaPropujcky] ([id], [idPropujcky], [idSluzby]) VALUES (3, 4, 2)
INSERT [dbo].[sluzbaPropujcky] ([id], [idPropujcky], [idSluzby]) VALUES (4, 2, 2)
INSERT [dbo].[sluzbaPropujcky] ([id], [idPropujcky], [idSluzby]) VALUES (5, 3, 3)
INSERT [dbo].[sluzbaPropujcky] ([id], [idPropujcky], [idSluzby]) VALUES (6, 4, 2)
INSERT [dbo].[sluzbaPropujcky] ([id], [idPropujcky], [idSluzby]) VALUES (7, 5, 3)
INSERT [dbo].[sluzbaPropujcky] ([id], [idPropujcky], [idSluzby]) VALUES (8, 6, 2)
INSERT [dbo].[sluzbaPropujcky] ([id], [idPropujcky], [idSluzby]) VALUES (9, 7, 2)
INSERT [dbo].[sluzbaPropujcky] ([id], [idPropujcky], [idSluzby]) VALUES (10, 8, 3)
SET IDENTITY_INSERT [dbo].[sluzbaPropujcky] OFF
GO
SET IDENTITY_INSERT [dbo].[typKaroserie] ON 

INSERT [dbo].[typKaroserie] ([id], [nazev]) VALUES (1, N'Sedan')
INSERT [dbo].[typKaroserie] ([id], [nazev]) VALUES (2, N'Kupé')
INSERT [dbo].[typKaroserie] ([id], [nazev]) VALUES (3, N'Pick-up')
INSERT [dbo].[typKaroserie] ([id], [nazev]) VALUES (4, N'Dodávka')
INSERT [dbo].[typKaroserie] ([id], [nazev]) VALUES (5, N'Combi')
INSERT [dbo].[typKaroserie] ([id], [nazev]) VALUES (6, N'SUV')
SET IDENTITY_INSERT [dbo].[typKaroserie] OFF
GO
SET IDENTITY_INSERT [dbo].[typPohonu] ON 

INSERT [dbo].[typPohonu] ([id], [nazev]) VALUES (1, N'Benzin')
INSERT [dbo].[typPohonu] ([id], [nazev]) VALUES (2, N'LPG')
INSERT [dbo].[typPohonu] ([id], [nazev]) VALUES (3, N'CNG')
INSERT [dbo].[typPohonu] ([id], [nazev]) VALUES (4, N'Nafta')
INSERT [dbo].[typPohonu] ([id], [nazev]) VALUES (5, N'Elektro')
INSERT [dbo].[typPohonu] ([id], [nazev]) VALUES (6, N'Vodík')
SET IDENTITY_INSERT [dbo].[typPohonu] OFF
GO
SET IDENTITY_INSERT [dbo].[zamestnanec] ON 

INSERT [dbo].[zamestnanec] ([id], [rodCis], [adresa], [email], [nazevPozice], [plat]) VALUES (2, N'980209214', N'Uhlírova 89', N'Jozef@email.com', N'Mechanik', CAST(30689 AS Decimal(18, 0)))
INSERT [dbo].[zamestnanec] ([id], [rodCis], [adresa], [email], [nazevPozice], [plat]) VALUES (3, N'910511336', N'U potoka 17', N'Grower28@seznam.cz', N'Mechanik', CAST(31065 AS Decimal(18, 0)))
INSERT [dbo].[zamestnanec] ([id], [rodCis], [adresa], [email], [nazevPozice], [plat]) VALUES (4, N'881112652', N'Londýnská 11', N'honzadron101@gmail.com', N'Lakýrník', CAST(28640 AS Decimal(18, 0)))
INSERT [dbo].[zamestnanec] ([id], [rodCis], [adresa], [email], [nazevPozice], [plat]) VALUES (5, N'960330502', N'38 Novohradská', N'pepadron101@gmail.com', N'Klepír', CAST(40501 AS Decimal(18, 0)))
INSERT [dbo].[zamestnanec] ([id], [rodCis], [adresa], [email], [nazevPozice], [plat]) VALUES (6, N'880202651', N'Nový háj 8', N'tomtom@seznam.cz', N'Ucetní', CAST(40501 AS Decimal(18, 0)))
INSERT [dbo].[zamestnanec] ([id], [rodCis], [adresa], [email], [nazevPozice], [plat]) VALUES (7, N'781224666', N'Helovského 98', N'maxjotendava@mail.co', N'Elektromechanik', CAST(38645 AS Decimal(18, 0)))
SET IDENTITY_INSERT [dbo].[zamestnanec] OFF
GO
SET IDENTITY_INSERT [dbo].[zavady] ON 

INSERT [dbo].[zavady] ([id], [popis], [datumVzniku]) VALUES (4, N'ukradený katalyzátor, serízení volantu', CAST(N'2020-12-12' AS Date))
INSERT [dbo].[zavady] ([id], [popis], [datumVzniku]) VALUES (5, N'výmena olej. filtru', CAST(N'2020-01-02' AS Date))
INSERT [dbo].[zavady] ([id], [popis], [datumVzniku]) VALUES (6, N'serízení volantu, vyklapání karoserie', CAST(N'2020-11-09' AS Date))
INSERT [dbo].[zavady] ([id], [popis], [datumVzniku]) VALUES (7, N'výmena l. bocního svetla, výmena l. pred. Blatníku', CAST(N'2020-08-30' AS Date))
INSERT [dbo].[zavady] ([id], [popis], [datumVzniku]) VALUES (8, N'vyklepání karoserie, výmena olej. filtru', CAST(N'2020-12-05' AS Date))
INSERT [dbo].[zavady] ([id], [popis], [datumVzniku]) VALUES (9, N'výmena brzdních desticek', CAST(N'2020-12-12' AS Date))
INSERT [dbo].[zavady] ([id], [popis], [datumVzniku]) VALUES (10, N'výmena rozvodu, výmena olej. filtru', CAST(N'2020-01-02' AS Date))
INSERT [dbo].[zavady] ([id], [popis], [datumVzniku]) VALUES (11, N'nahrazení pohonu z benzin na CNG', CAST(N'2021-11-09' AS Date))
INSERT [dbo].[zavady] ([id], [popis], [datumVzniku]) VALUES (12, N'serízení volantu, výmena pred. Skla', CAST(N'2021-08-20' AS Date))
INSERT [dbo].[zavady] ([id], [popis], [datumVzniku]) VALUES (13, N'výmena pred. Skla', CAST(N'2021-12-05' AS Date))
INSERT [dbo].[zavady] ([id], [popis], [datumVzniku]) VALUES (14, N'výmena olej. filtru', CAST(N'2021-12-05' AS Date))
INSERT [dbo].[zavady] ([id], [popis], [datumVzniku]) VALUES (15, N'výmena rozvodu', CAST(N'2021-12-05' AS Date))
SET IDENTITY_INSERT [dbo].[zavady] OFF
GO
SET IDENTITY_INSERT [dbo].[zavadyAuta] ON 

INSERT [dbo].[zavadyAuta] ([id], [idAuta], [idZavady]) VALUES (2, 2, 15)
INSERT [dbo].[zavadyAuta] ([id], [idAuta], [idZavady]) VALUES (3, 3, 4)
INSERT [dbo].[zavadyAuta] ([id], [idAuta], [idZavady]) VALUES (4, 4, 13)
INSERT [dbo].[zavadyAuta] ([id], [idAuta], [idZavady]) VALUES (5, 5, 5)
INSERT [dbo].[zavadyAuta] ([id], [idAuta], [idZavady]) VALUES (6, 6, 6)
INSERT [dbo].[zavadyAuta] ([id], [idAuta], [idZavady]) VALUES (7, 7, 7)
INSERT [dbo].[zavadyAuta] ([id], [idAuta], [idZavady]) VALUES (8, 8, 8)
INSERT [dbo].[zavadyAuta] ([id], [idAuta], [idZavady]) VALUES (9, 9, 9)
INSERT [dbo].[zavadyAuta] ([id], [idAuta], [idZavady]) VALUES (10, 10, 10)
INSERT [dbo].[zavadyAuta] ([id], [idAuta], [idZavady]) VALUES (11, 11, 11)
INSERT [dbo].[zavadyAuta] ([id], [idAuta], [idZavady]) VALUES (12, 12, 12)
SET IDENTITY_INSERT [dbo].[zavadyAuta] OFF
GO
SET IDENTITY_INSERT [dbo].[znacka] ON 

INSERT [dbo].[znacka] ([id], [nazev]) VALUES (1, N'Mercedes Benz')
INSERT [dbo].[znacka] ([id], [nazev]) VALUES (2, N'Volkswagen')
INSERT [dbo].[znacka] ([id], [nazev]) VALUES (3, N'Škoda')
INSERT [dbo].[znacka] ([id], [nazev]) VALUES (4, N'Audi')
INSERT [dbo].[znacka] ([id], [nazev]) VALUES (5, N'Volvo')
INSERT [dbo].[znacka] ([id], [nazev]) VALUES (6, N'Seat')
INSERT [dbo].[znacka] ([id], [nazev]) VALUES (7, N'Tatra')
INSERT [dbo].[znacka] ([id], [nazev]) VALUES (8, N'Jeep')
INSERT [dbo].[znacka] ([id], [nazev]) VALUES (9, N'Subaru')
INSERT [dbo].[znacka] ([id], [nazev]) VALUES (10, N'Range rover')
INSERT [dbo].[znacka] ([id], [nazev]) VALUES (11, N'Smart')
SET IDENTITY_INSERT [dbo].[znacka] OFF
GO
ALTER TABLE [dbo].[klient] ADD  DEFAULT ((0)) FOR [skore]
GO
ALTER TABLE [dbo].[propujcka]  WITH CHECK ADD FOREIGN KEY([idKlienta])
REFERENCES [dbo].[klient] ([id])
GO
ALTER TABLE [dbo].[servisAuta]  WITH CHECK ADD FOREIGN KEY([idZamestnance])
REFERENCES [dbo].[zamestnanec] ([id])
GO
ALTER TABLE [dbo].[sluzbaPropujcky]  WITH CHECK ADD FOREIGN KEY([idPropujcky])
REFERENCES [dbo].[propujcka] ([id])
GO
ALTER TABLE [dbo].[sluzbaPropujcky]  WITH CHECK ADD FOREIGN KEY([idSluzby])
REFERENCES [dbo].[sluzba] ([id])
GO
ALTER TABLE [dbo].[zavadyAuta]  WITH CHECK ADD FOREIGN KEY([idZavady])
REFERENCES [dbo].[zavady] ([id])
GO
ALTER TABLE [dbo].[auto]  WITH CHECK ADD CHECK  (([delkaCm]>(0) AND [delkaCm]<(10000)))
GO
ALTER TABLE [dbo].[auto]  WITH CHECK ADD CHECK  (([mist]>=(1)))
GO
ALTER TABLE [dbo].[auto]  WITH CHECK ADD CHECK  (([sirkaCm]>(0) AND [sirkaCm]<(10000)))
GO
ALTER TABLE [dbo].[auto]  WITH CHECK ADD CHECK  (([vyskaCm]>(0) AND [vyskaCm]<(10000)))
GO
ALTER TABLE [dbo].[propujcka]  WITH CHECK ADD CHECK  (([casZacatku]>'01-01-2021'))
GO
ALTER TABLE [dbo].[zamestnanec]  WITH CHECK ADD CHECK  (([plat]>(0) AND [plat]<(500000)))
GO
USE [master]
GO
ALTER DATABASE [autopujcovna] SET  READ_WRITE 
GO
