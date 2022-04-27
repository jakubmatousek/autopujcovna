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
  [vyskaCm] int check(vyskaCm>0 and delkaCm < 10000),
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

ALTER TABLE [sluzbaPropujcky] ADD FOREIGN KEY ([idPropujcky]) REFERENCES [propujcka] ([id])
GO

ALTER TABLE [sluzbaPropujcky] ADD FOREIGN KEY ([idSluzby]) REFERENCES [sluzba] ([id])
GO

ALTER TABLE [propujcka] ADD FOREIGN KEY ([idKlienta]) REFERENCES [klient] ([id])
GO

ALTER TABLE [servisAuta] ADD FOREIGN KEY ([idZamestnance]) REFERENCES [zamestnanec] ([id])
GO

ALTER TABLE [servisAuta] ADD FOREIGN KEY ([idAuta]) REFERENCES [auto] ([id])
GO

ALTER TABLE [propujcka] ADD FOREIGN KEY ([idAuta]) REFERENCES [auto] ([id])
GO

ALTER TABLE [auto] ADD FOREIGN KEY ([idZnacky]) REFERENCES [znacka] ([id])
GO

ALTER TABLE [auto] ADD FOREIGN KEY ([typKarId]) REFERENCES [typKaroserie] ([id])
GO

ALTER TABLE [auto] ADD FOREIGN KEY ([idPohonu]) REFERENCES [typPohonu] ([id])
GO

ALTER TABLE [zavadyAuta] ADD FOREIGN KEY ([idZavady]) REFERENCES [zavady] ([id])
GO

ALTER TABLE [zavadyAuta] ADD FOREIGN KEY ([idAuta]) REFERENCES [auto] ([id])
GO
