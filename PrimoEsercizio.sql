-- Creazione dello schema
CREATE SCHEMA mioschema;

-- Creazione della tabella Clienti
CREATE TABLE mioschema.Clienti (
NumeroCliente SERIAL PRIMARY KEY,
Nome TEXT NOT NULL,
Cognome TEXT NOT NULL,
DataNascita DATE NOT NULL,
RegioneResidenza TEXT NOT NULL
);

-- Creazione della tabella Fornitori
CREATE TABLE mioschema.Fornitori (
NumeroFornitore SERIAL PRIMARY KEY,
Denominazione TEXT NOT NULL,
RegioneResidenza TEXT NOT NULL
);

-- Creazione della tabella Fatture
CREATE TABLE mioschema.Fatture (
NumeroFattura SERIAL PRIMARY KEY,
Tipologia TEXT NOT NULL,
Importo NUMERIC NOT NULL,
Iva NUMERIC NOT NULL,
IdCliente INTEGER NOT NULL,
DataFattura DATE NOT NULL,
NumeroFornitore INTEGER NOT NULL,
FOREIGN KEY (IdCliente) REFERENCES mioschema.Clienti(NumeroCliente),
FOREIGN KEY (NumeroFornitore) REFERENCES mioschema.Fornitori(NumeroFornitore)
);

-- Creazione della tabella Prodotti
CREATE TABLE mioschema.Prodotti (
IdProdotto SERIAL PRIMARY KEY,
Descrizione TEXT NOT NULL,
InProduzione BOOLEAN NOT NULL,
InCommercio BOOLEAN NOT NULL,
DataAttivazione DATE NOT NULL,
DataDisattivazione DATE
);

-- Estrarre il nome e cognome dei clienti nati nel 1982:

SELECT Nome, Cognome
FROM mioschema.Clienti
WHERE EXTRACT(YEAR FROM DataNascita) = 1982;


--Estrarre il numero delle fatture con iva al 20%:

SELECT COUNT(*)
FROM mioschema.Fatture
WHERE Iva = 0.2;

--Riportare il numero di fatture e la somma dei relativi importi divisi per anno di fatturazione:

SELECT
EXTRACT(YEAR FROM DataFattura) AS Anno,
COUNT(NumeroFattura) AS NumeroFatture,
SUM(Importo) AS TotaleImporto
FROM mioschema.Fatture
GROUP BY Anno;

  -- Estrarre i prodotti attivati nel 2017 e che sono in produzione oppure in commercio:

SELECT *
FROM mioschema.Prodotti
WHERE EXTRACT(YEAR FROM DataAttivazione) = 2017
AND (InProduzione = TRUE OR InCommercio = TRUE);

   -- Considerando soltanto le fatture con iva al 20%, estrarre il numero di fatture per ogni anno:

SELECT
EXTRACT(YEAR FROM DataFattura) AS Anno,
COUNT(NumeroFattura) AS NumeroFatture
FROM mioschema.Fatture
WHERE Iva = 0.2
GROUP BY Anno;

  --  Estrarre gli anni in cui sono state registrate più di 2 fatture con tipologia "A":

SELECT
EXTRACT(YEAR FROM DataFattura) AS Anno
FROM mioschema.Fatture
WHERE Tipologia = 'A'
GROUP BY Anno
HAVING COUNT(NumeroFattura) > 2;


