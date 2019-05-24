-- TO REITERATE FROM schemaExploring.sql, we will fix the following : 

/** 
INITIAL FINDINGS WITH TOWN_NAME:
1) Aesch vs. Aesch (BL)... (BL) = "Basel-Landschaft" Municipality. Merge to Aesch
2) ///
3) Altdorf (UR) should be Altdorf, Uri
4) BBern, Berm, Bern_ should be 'Bern'
5) Biel / Bienne & Biel/Bienne to MERGE 'Biel-Bienne'
6) Birmensdorf (ZH) should be Birmensdorf, Zuerich
7) Bremgarten (BE) should be Bremgarten bei Bern
8) Bremgarten AG should be Bremgarten, Aargau
9) Brunnen SZ should be just Brunnen
10) Buch (SH) should be Buch, Schaffhausen
11) Buchs (AG) should be Buchs, Aargau
12) Buchs SG, and Buchs ZH should be Buchs, St. Gallen, and Buchs, Zuerich, respectively. 
13) Carouge (GE), Carouge:Genieve, and Carouge (GE):Geneive should be Carouge, Geneva
14) Celerina / Schlargna should be Celerina-Schlarigna
15) Chambesy (GE) should be Chambesy, Geneva
16) Dickbuch (Hofstetten) should be Dickbuch, Hofstetten
17) Diessbach bei Buuren should be uniform across both != b. buuren merge
18) Ecublens (VD) should be Ecublens MERGE 
19) Erlinsbach (SO), and Erlinsbach SO should be Erlinsbach, Solothurn
20) Eschlikon TG should be Eschlikon, Thurgau
21) Gilly/VD should be Gilly, Vaud
22) Gossau (ZH), should be Gossau, Zuerich 
23) Gossau SG should be, Gossau, St. Gallen
24) Grand-Lancy (GE) should be Grand-Lancy, Geneva
25) Grugnay (Chamoson) should be Grugnay, Chamoson
26) Haag (Rheintal) should be Haag, Rheintal
27) Hergiswil (NW) Should be Hergiswil, Nidwalden
28) Kilchberg ZH and Kilchberg (ZH) should be Kilchberg, Zuerich
29) Lachen (SZ) should be Lachen. Schwyz
30) Langnau i. E. should be Lagnnau
31) Laufenburg (Baden) should be Laufenburg, Baden
32) Le Lignon/GE should be Le Lignon, Geneva
33) Merge Les Ponts de Martel w/ Les Ponts-de-Martel
34) Delete 1 from Lugano 1 to Lugano
35) Marin-Epagnier (cantonname) update to Marin-Epagnier
36) Mettmenstetten ZH to Mettmenstetten, Zuerich 
37) Meyrin/GE to Meyrin, Geneva
38) Molino Nuovo (Lugano) to Molino Nuovo, Lugano
39) Morbio Inferiore to Mobio-Inferiore
40) Morbio Superiore to Mobio-Superiore
41) Merge Muri b. Bern to Muri bei. Bern
42) Update Muri (AG) to Muri, Aargau
43) Oberwangen b. Bern to Oberwangen bei Bern. 
44) Change Ober**geri/Morgarten to ,Mortgarten 
45) Pfuuffikon (SZ)/SZ/ZH to respective canton names
46) Rapperswil (SG) > canton name
47) Rapperswil BE > Canton name
48) Rapperswil SG > Canton name
49) Rapperswil-Jona > Canton Name = St. Gallen
50) Reinach (BL) > Canton Name 
51) Renens (VD) > Canton Name
52) Rickenbach (LU) > Canton Name
53) Roggwil (BE) > Canton Name
54) Roggwil TG > Canton Name
55) Romont (FR) > Canton Name
56) Reggisberg/Oberitschel > Reggisberg-Oberitschel 
57) Rooti (ZH)/ZH > Canton Name
58) Sankt Gellen > Sankt-Gellen
59) Sankt Urser > Sankt-Urser
60) Schmidigen - M% > Schmidigen-M%
61) Merge Sedorf > Seedorf (misspelling)
62) Seewis Dorf > Seewis-Dorf
63) Sempach Station > Sempach-Station
64) Sierre/Siders > Sierre-Siders
65) Merge Solothun > Solothurn (misspelling) 
66) Spiegel b. Bern > Spiegel bei Bern
67) Merge St-Maurica to Saint-Maurice
68) St-Aubin-Sauges > Saint-Subin-Sauges
69) St-Cergue > Saint-Cergue
70) St-Luugier > Saint-Legier
71) St-Pierre-de-Clages > Saint-Pierre-de-Clages
72) Seewis Dorf > Seewis-Dorf
73) Studen SZ > Studen + Canton Name (SZ)
74) Versoix/GE > Versoix + Canton Name
75) Vilette (Le Ch% VS) > Vilette + Canton Name
76) Walterswil (SO) > Walterswil + Canton Name
77) Weil am Rheib > Merge (Weil am Rhein) (misspelling rheib)
78) Wenigen (ZH) > Wenigen (canton name)
79) Wengi/wengli b. Buuren > Wengi bei. Buuren
80) Wetzikon (ZH) > Wetzikon + Canton name
81) Wiezikon b. Sirnach > Wiezikon bei Sirnach
82) Wil (ZH) > Wil + Canton Name
83) Wohlen (AG) > Wohlen + Canton Name
84) Wolhen b. Bern > Wolhen bei Bern
85) Capitalize uncapitalized TOWN_NAMES in ('adelboden','bern','geneva','meggen','oberwil','vernier'
'versoix','wald',woodenswil,'zug','zurich')
**/

-- STEP 1: ADD NEW COLUMN FOR CANTON NAMES 'CANTON_NAME'
ALTER TABLE SWITZERLAND
ADD CANTON_NAME VARCHAR2(100);
-- OUTPUT: Table SWITZERLAND altered.

-- VERIFY NEW COLUMN HAS BEEN ADDED WITH null VALUES
SELECT * FROM SWITZERLAND;

-- STEP 2: UPDATE TOWN_NAMES AND ADD CANTON_NAME WHERE APPROPRIATE

-- Merge Aesch
UPDATE SWITZERLAND 
SET TOWN_NAME = 'Aesch' 
WHERE TOWN_NAME LIKE 'Aesch%';
--OUTPUT: 77 rows updated.

-- Set Aesch Canton Name
UPDATE SWITZERLAND 
SET CANTON_NAME = 'Basel-Landschaft' 
WHERE TOWN_NAME LIKE 'Aesch';
--OUTPUT: 77 rows updated.

UPDATE SWITZERLAND 
SET CANTON_NAME = 'Uri' 
WHERE TOWN_NAME LIKE 'Altdorf';
--OUTPUT: 1 rows updated.

UPDATE SWITZERLAND 
SET TOWN_NAME = 'Altdorf' 
WHERE TOWN_NAME LIKE 'Altdorf (UR)';
--OUTPUT: 1 rows updated.

-- Bern Misspellings
UPDATE SWITZERLAND 
SET TOWN_NAME = 'Bern' 
WHERE TOWN_NAME LIKE 'BBern';
-- OUTPUT : 3 rows updated

UPDATE SWITZERLAND 
SET TOWN_NAME = 'Bern' 
WHERE TOWN_NAME LIKE 'Berm';
-- OUTPUT : 3 rows updated

-- Override Bern spelling for possible Spaces
UPDATE SWITZERLAND 
SET TOWN_NAME = 'Bern' 
WHERE TOWN_NAME LIKE 'Bern%';
-- OUTPUT : 17,470 rows updated.


-- UPDATE BERN CANTON NAME
UPDATE SWITZERLAND 
SET CANTON_NAME = 'Bern' 
WHERE TOWN_NAME LIKE 'Bern';
-- OUTPUT : 17,470 rows updated.

UPDATE SWITZERLAND 
SET TOWN_NAME = 'Biel-Bienne' 
WHERE TOWN_NAME LIKE 'Biel%';
-- OUTPUT : 645 rows updated.

-- UPDATE CANTON FOR BIEL-BIENNE
UPDATE SWITZERLAND 
SET CANTON_NAME = 'Bern' 
WHERE TOWN_NAME LIKE 'Biel-Bienne';
-- OUTPUT : 645 rows updated.

-- REMOVE CANTON ABBRV 
UPDATE SWITZERLAND 
SET TOWN_NAME = 'Birmensdorf' 
WHERE TOWN_NAME LIKE 'Birmensdorf%';
-- OUTPUT : 8 rows updated.

--REPLACE CANTON_NAME
UPDATE SWITZERLAND 
SET CANTON_NAME = 'Zürich' 
WHERE TOWN_NAME LIKE 'Birmensdorf';
-- OUTPUT : 8 rows updated.

UPDATE SWITZERLAND 
SET CANTON_NAME = 'Zürich' 
WHERE TOWN_NAME LIKE 'Bremgarten (ZH)';
-- OUTPUT : 42 rows updated.


UPDATE SWITZERLAND 
SET TOWN_NAME = 'Bremgarten' 
WHERE TOWN_NAME LIKE 'Bremgarten (ZH)';
-- OUTPUT : 42 rows updated.


UPDATE SWITZERLAND 
SET CANTON_NAME = 'Aargau' 
WHERE TOWN_NAME LIKE 'Bremgarten AG';
-- OUTPUT : 61 rows updated.


UPDATE SWITZERLAND 
SET TOWN_NAME = 'Bremgarten' 
WHERE TOWN_NAME LIKE 'Bremgarten AG';
-- OUTPUT : 61 rows updated.

UPDATE SWITZERLAND 
SET CANTON_NAME = 'Ingenbohl' 
WHERE TOWN_NAME LIKE 'Brunnen%';
-- OUTPUT : 1 rows updated.

UPDATE SWITZERLAND 
SET TOWN_NAME = 'Brunnen' 
WHERE TOWN_NAME LIKE 'Brunnen%';
-- OUTPUT : 1 rows updated.

UPDATE SWITZERLAND 
SET CANTON_NAME = 'Schaffhausen' 
WHERE TOWN_NAME LIKE 'Buch (SH)';
-- OUTPUT : 55 rows updated.

UPDATE SWITZERLAND 
SET TOWN_NAME = 'Buch' 
WHERE TOWN_NAME LIKE 'Buch (SH)';
-- OUTPUT : 55 rows updated.

UPDATE SWITZERLAND 
SET CANTON_NAME = 'Aargau' 
WHERE TOWN_NAME LIKE 'Buchs (AG)';
-- OUTPUT : 1 rows updated.

UPDATE SWITZERLAND 
SET TOWN_NAME = 'Buchs' 
WHERE TOWN_NAME LIKE 'Buchs (AG)';
-- OUTPUT : 1 rows updated.

UPDATE SWITZERLAND 
SET CANTON_NAME = 'St. Gallen' 
WHERE TOWN_NAME LIKE 'Buchs (SG)';
-- OUTPUT : 7 rows updated.

UPDATE SWITZERLAND 
SET TOWN_NAME = 'Buchs' 
WHERE TOWN_NAME LIKE 'Buchs (SG)';
-- OUTPUT : 7 rows updated.

UPDATE SWITZERLAND 
SET CANTON_NAME = 'Zürich' 
WHERE TOWN_NAME LIKE 'Buchs ZH';
-- OUTPUT : 9 rows updated.

UPDATE SWITZERLAND 
SET TOWN_NAME = 'Buchs' 
WHERE TOWN_NAME LIKE 'Buchs ZH';
-- OUTPUT : 9 rows updated.

UPDATE SWITZERLAND 
SET CANTON_NAME = 'Geneva' 
WHERE TOWN_NAME LIKE 'Carouge%';
-- OUTPUT : 21 rows updated.

UPDATE SWITZERLAND 
SET TOWN_NAME = 'Carouge' 
WHERE TOWN_NAME LIKE 'Carouge%';
-- OUTPUT : 21 rows updated.

UPDATE SWITZERLAND 
SET TOWN_NAME = 'Celerina-Schlarigna' 
WHERE TOWN_NAME LIKE 'Celerina /%';
-- OUTPUT : 1 rows updated.

UPDATE SWITZERLAND 
SET CANTON_NAME = 'Graubünden' 
WHERE TOWN_NAME LIKE 'Celerina-Schlarigna';
-- OUTPUT : 1 rows updated.


UPDATE SWITZERLAND 
SET TOWN_NAME = 'Chambesy' 
WHERE TOWN_NAME LIKE 'Chambesy%';
-- OUTPUT : 1 rows updated.

UPDATE SWITZERLAND 
SET CANTON_NAME = 'Geneva' 
WHERE TOWN_NAME LIKE 'Chambesy';
-- OUTPUT : 1 rows updated.


UPDATE SWITZERLAND 
SET TOWN_NAME = 'Dickbuch' 
WHERE TOWN_NAME LIKE 'Dickbuch%';
-- OUTPUT : 1 rows updated.

UPDATE SWITZERLAND 
SET CANTON_NAME = 'Hofstetten' 
WHERE TOWN_NAME LIKE 'Dickbuch';
-- OUTPUT : 1 rows updated.

UPDATE SWITZERLAND 
SET TOWN_NAME = 'Diessbach bei Buuren' 
WHERE TOWN_NAME LIKE 'Diessbach b%';
-- OUTPUT : 32 rows updated.

UPDATE SWITZERLAND 
SET CANTON_NAME = 'Bern' 
WHERE TOWN_NAME LIKE 'Diessbach bei Buuren';
-- OUTPUT : 32 rows updated.

UPDATE SWITZERLAND 
SET TOWN_NAME = 'Ecublens' 
WHERE TOWN_NAME LIKE 'Ecublens%';
-- OUTPUT : 9 rows updated.

UPDATE SWITZERLAND 
SET CANTON_NAME = 'Vaud' 
WHERE TOWN_NAME LIKE 'Ecublens';
-- OUTPUT : 9 rows updated.

UPDATE SWITZERLAND 
SET TOWN_NAME = 'Erlinsbach' 
WHERE TOWN_NAME LIKE 'Erlinsbach%';
-- OUTPUT : 2 rows updated.

UPDATE SWITZERLAND 
SET CANTON_NAME = 'Solothurn' 
WHERE TOWN_NAME LIKE 'Erlinsbach';
-- OUTPUT : 2 rows updated.

UPDATE SWITZERLAND 
SET TOWN_NAME = 'Eschlikon' 
WHERE TOWN_NAME LIKE 'Eschlikon%';
-- OUTPUT : 1 rows updated.

UPDATE SWITZERLAND 
SET CANTON_NAME = 'Thurgau' 
WHERE TOWN_NAME LIKE 'Eschlikon';
-- OUTPUT : 1 rows updated.

UPDATE SWITZERLAND 
SET TOWN_NAME = 'Gilly' 
WHERE TOWN_NAME LIKE 'Gilly%';
-- OUTPUT : 1 rows updated.

UPDATE SWITZERLAND 
SET CANTON_NAME = 'Vaud' 
WHERE TOWN_NAME LIKE 'Gilly';
-- OUTPUT : 1 rows updated.


UPDATE SWITZERLAND 
SET CANTON_NAME = 'Zürich' 
WHERE TOWN_NAME LIKE 'Gossau (ZH)';
-- OUTPUT : 2 rows updated.

UPDATE SWITZERLAND 
SET TOWN_NAME = 'Gossau' 
WHERE TOWN_NAME LIKE 'Gossau (ZH)';
-- OUTPUT : 2 rows updated.


UPDATE SWITZERLAND 
SET CANTON_NAME = 'St. Gallen' 
WHERE TOWN_NAME LIKE 'Gossau SG';
-- OUTPUT : 1 rows updated.

UPDATE SWITZERLAND 
SET TOWN_NAME = 'Gossau' 
WHERE TOWN_NAME LIKE 'Gossau SG';
-- OUTPUT : 1 rows updated.


UPDATE SWITZERLAND 
SET CANTON_NAME = 'Geneva' 
WHERE TOWN_NAME LIKE 'Grand-Lancy%';
-- OUTPUT : 2 rows updated.

UPDATE SWITZERLAND 
SET TOWN_NAME = 'Grand-Lancy' 
WHERE TOWN_NAME LIKE 'Grand-Lancy%';
-- OUTPUT : 2 rows updated.

UPDATE SWITZERLAND 
SET CANTON_NAME = 'Chamoson' 
WHERE TOWN_NAME LIKE 'Grugnay%';
-- OUTPUT : 1 rows updated.

UPDATE SWITZERLAND 
SET TOWN_NAME = 'Grugnay' 
WHERE TOWN_NAME LIKE 'Grugnay%';
-- OUTPUT : 1 rows updated.

UPDATE SWITZERLAND 
SET CANTON_NAME = 'Rheintal' 
WHERE TOWN_NAME LIKE 'Haag (%';
-- OUTPUT : 1 rows updated.

UPDATE SWITZERLAND 
SET TOWN_NAME = 'Haag' 
WHERE TOWN_NAME LIKE 'Haag (%';
-- OUTPUT : 1 rows updated.

UPDATE SWITZERLAND 
SET CANTON_NAME = 'Nidwalden' 
WHERE TOWN_NAME LIKE 'Hergiswil%';
-- OUTPUT : 4 rows updated.

UPDATE SWITZERLAND 
SET TOWN_NAME = 'Hergiswil' 
WHERE TOWN_NAME LIKE 'Hergiswil%';
-- OUTPUT : 4 rows updated.


UPDATE SWITZERLAND 
SET CANTON_NAME = 'Zürich' 
WHERE TOWN_NAME LIKE 'Kilchberg%';
-- OUTPUT : 6 rows updated.

UPDATE SWITZERLAND 
SET TOWN_NAME = 'Kilchberg' 
WHERE TOWN_NAME LIKE 'Kilchberg%';
-- OUTPUT : 6 rows updated.

UPDATE SWITZERLAND 
SET CANTON_NAME = 'Schwyz' 
WHERE TOWN_NAME LIKE 'Lachen%';
-- OUTPUT : 18 rows updated.

UPDATE SWITZERLAND 
SET TOWN_NAME = 'Lachen' 
WHERE TOWN_NAME LIKE 'Lachen%';
-- OUTPUT : 18 rows updated.


UPDATE SWITZERLAND 
SET TOWN_NAME = 'Langnau' 
WHERE TOWN_NAME LIKE 'Langnau%';
-- OUTPUT : 7 rows updated.


UPDATE SWITZERLAND 
SET CANTON_NAME = 'Baden' 
WHERE TOWN_NAME LIKE 'Laufenburg%';
-- OUTPUT : 29 rows updated.

UPDATE SWITZERLAND 
SET TOWN_NAME = 'Laufenburg' 
WHERE TOWN_NAME LIKE 'Laufenburg%';
-- OUTPUT : 29 rows updated.


UPDATE SWITZERLAND 
SET CANTON_NAME = 'Geneva' 
WHERE TOWN_NAME LIKE 'Le Lignon%';
-- OUTPUT : 1 rows updated.

UPDATE SWITZERLAND 
SET TOWN_NAME = 'Le Lignon' 
WHERE TOWN_NAME LIKE 'Le Lignon%';
-- OUTPUT : 1 rows updated.

UPDATE SWITZERLAND 
SET TOWN_NAME = 'Les Ponts-de-Martel' 
WHERE TOWN_NAME LIKE 'Les Po%';
-- OUTPUT : 2 rows updated.

UPDATE SWITZERLAND 
SET TOWN_NAME = 'Lugano' 
WHERE TOWN_NAME LIKE 'Lugano%';
-- OUTPUT : 19 rows updated.

UPDATE SWITZERLAND 
SET TOWN_NAME = 'Marin-Epagnier' 
WHERE TOWN_NAME LIKE 'Marin-Epagnier%';
-- OUTPUT : 2 rows updated.

UPDATE SWITZERLAND 
SET CANTON_NAME = 'Zürich' 
WHERE TOWN_NAME LIKE 'Mettmenstetten%';
-- OUTPUT : 2 rows updated.

UPDATE SWITZERLAND 
SET TOWN_NAME = 'Mettmenstetten' 
WHERE TOWN_NAME LIKE 'Mettmenstetten%';
-- OUTPUT : 2 rows updated.

UPDATE SWITZERLAND 
SET CANTON_NAME = 'Geneva' 
WHERE TOWN_NAME LIKE 'Meyrin%';
-- OUTPUT : 10 rows updated.

UPDATE SWITZERLAND 
SET TOWN_NAME = 'Meyrin' 
WHERE TOWN_NAME LIKE 'Meyrin%';
-- OUTPUT : 10 rows updated.

UPDATE SWITZERLAND 
SET CANTON_NAME = 'Lugano' 
WHERE TOWN_NAME LIKE 'Molino Nuovo%';
-- OUTPUT : 1 rows updated.

UPDATE SWITZERLAND 
SET TOWN_NAME = 'Molino Nuovo' 
WHERE TOWN_NAME LIKE 'Molino Nuovo%';
-- OUTPUT : 1 rows updated.


UPDATE SWITZERLAND 
SET TOWN_NAME = 'Morbio-Inferiore' 
WHERE TOWN_NAME LIKE 'Morbio Inferiore';
-- OUTPUT : 18 rows updated.

UPDATE SWITZERLAND 
SET TOWN_NAME = 'Morbio-Superiore' 
WHERE TOWN_NAME LIKE 'Morbio Superiore';
-- OUTPUT : 2 rows updated.

UPDATE SWITZERLAND 
SET TOWN_NAME = 'Muri bei Bern' 
WHERE TOWN_NAME LIKE 'Muri b%';
-- OUTPUT : 795 rows updated.


UPDATE SWITZERLAND 
SET CANTON_NAME = 'Aargau' 
WHERE TOWN_NAME LIKE 'Muri (%';
-- OUTPUT : 3 rows updated.

UPDATE SWITZERLAND 
SET CANTON_NAME = 'Aargau' 
WHERE TOWN_NAME LIKE 'Muri%';
-- OUTPUT : 798 rows updated.

UPDATE SWITZERLAND 
SET TOWN_NAME = 'Muri' 
WHERE TOWN_NAME LIKE 'Muri (AG)';
-- OUTPUT : 3 rows updated.

UPDATE SWITZERLAND 
SET CANTON_NAME = 'Bern' 
WHERE TOWN_NAME LIKE 'Oberwangen b%';
-- OUTPUT : 2 rows updated.

UPDATE SWITZERLAND 
SET TOWN_NAME = 'Oberwangen bei Bern' 
WHERE TOWN_NAME LIKE 'Oberwangen%';
-- OUTPUT : 2 rows updated.

UPDATE SWITZERLAND 
SET CANTON_NAME = 'St. Gallen' 
WHERE TOWN_NAME LIKE 'Rapperswil (SG)';
-- OUTPUT : 27 rows updated.

UPDATE SWITZERLAND 
SET CANTON_NAME = 'Bern' 
WHERE TOWN_NAME LIKE 'Rapperswil BE';
-- OUTPUT : 6 rows updated.

UPDATE SWITZERLAND 
SET CANTON_NAME = 'St. Gallen' 
WHERE TOWN_NAME LIKE 'Rapperswil SG';
-- OUTPUT : 68 rows updated.

UPDATE SWITZERLAND 
SET TOWN_NAME = 'Rapperswil' 
WHERE TOWN_NAME LIKE 'Rapperswil%';
-- OUTPUT : 128 rows updated.

UPDATE SWITZERLAND 
SET TOWN_NAME = 'Oberwangen bei Bern' 
WHERE TOWN_NAME LIKE 'Oberwangen%';
-- OUTPUT : 2 rows updated.

UPDATE SWITZERLAND 
SET TOWN_NAME = 'Reinach' 
WHERE TOWN_NAME LIKE 'Reinach%';
-- OUTPUT : 32 rows updated.


UPDATE SWITZERLAND 
SET CANTON_NAME = 'Vaud' 
WHERE TOWN_NAME LIKE  'Renens%';
-- OUTPUT : 23 rows updated.

UPDATE SWITZERLAND 
SET TOWN_NAME = 'Renens' 
WHERE TOWN_NAME LIKE 'Renens%';
-- OUTPUT : 23 rows updated.

UPDATE SWITZERLAND 
SET CANTON_NAME = 'Luzern' 
WHERE TOWN_NAME LIKE  'Rickenbach%';
-- OUTPUT : 1 rows updated.

UPDATE SWITZERLAND 
SET TOWN_NAME = 'Rickenbach' 
WHERE TOWN_NAME LIKE 'Rickenbach%';
-- OUTPUT : 1 rows updated.

UPDATE SWITZERLAND 
SET CANTON_NAME = 'Bern' 
WHERE TOWN_NAME LIKE  'Roggwil (BE)%';
-- OUTPUT : 3 rows updated.

UPDATE SWITZERLAND 
SET TOWN_NAME = 'Roggwil' 
WHERE TOWN_NAME LIKE 'Roggwil (BE)%';
-- OUTPUT : 3 rows updated.

UPDATE SWITZERLAND 
SET CANTON_NAME = 'Thurgau' 
WHERE TOWN_NAME LIKE  'Roggwil TG%';
-- OUTPUT : 1 rows updated.

UPDATE SWITZERLAND 
SET TOWN_NAME = 'Roggwil' 
WHERE TOWN_NAME LIKE 'Roggwil TG%';
-- OUTPUT : 3 rows updated.

UPDATE SWITZERLAND 
SET CANTON_NAME = 'Fribourg' 
WHERE TOWN_NAME LIKE  'Romont%';
-- OUTPUT : 2 rows updated.

UPDATE SWITZERLAND 
SET TOWN_NAME = 'Romont' 
WHERE TOWN_NAME LIKE 'Romont%';
-- OUTPUT : 2 rows updated.


UPDATE SWITZERLAND 
SET TOWN_NAME = 'Reggisburg-Oberitschel' 
WHERE TOWN_NAME LIKE 'Reggisburg/%';
-- OUTPUT : 2 rows updated.



UPDATE SWITZERLAND 
SET CANTON_NAME = 'Zürich' 
WHERE TOWN_NAME LIKE 'Rooti%';
-- OUTPUT : 2 rows updated.

UPDATE SWITZERLAND 
SET TOWN_NAME = 'Rooti' 
WHERE TOWN_NAME LIKE 'Rooti%';
-- OUTPUT : 2 rows updated.

UPDATE SWITZERLAND 
SET TOWN_NAME = 'Sankt-Gellen' 
WHERE TOWN_NAME LIKE 'Sankt G%';
-- OUTPUT : 2 rows updated.

UPDATE SWITZERLAND 
SET TOWN_NAME = 'Sankt-Urser' 
WHERE TOWN_NAME LIKE 'Sankt U%';
-- OUTPUT : 1 rows updated.

UPDATE SWITZERLAND 
SET TOWN_NAME = 'Seedorf' 
WHERE TOWN_NAME LIKE 'Sedorf%';
-- OUTPUT : 4 rows updated.

UPDATE SWITZERLAND 
SET TOWN_NAME = 'Seewis-Dorf' 
WHERE TOWN_NAME LIKE 'Seewis D%';
-- OUTPUT : 15 rows updated.


UPDATE SWITZERLAND 
SET TOWN_NAME = 'Sempach-Station' 
WHERE TOWN_NAME LIKE 'Sempach S%';
-- OUTPUT : 1 rows updated.


UPDATE SWITZERLAND 
SET TOWN_NAME = 'Sierre-Siders' 
WHERE TOWN_NAME LIKE 'Sierre/%';
-- OUTPUT : 2 rows updated.


UPDATE SWITZERLAND 
SET TOWN_NAME = 'Solothurn' 
WHERE TOWN_NAME LIKE 'Solothun';
-- OUTPUT : 1 rows updated.


UPDATE SWITZERLAND 
SET TOWN_NAME = 'Spiegel bei Bern' 
WHERE TOWN_NAME LIKE 'Spiegel b%';
-- OUTPUT : 2 rows updated.


UPDATE SWITZERLAND 
SET TOWN_NAME = 'Saint-Maurice' 
WHERE TOWN_NAME LIKE 'St-Maur%';
-- OUTPUT : 1 rows updated.


UPDATE SWITZERLAND 
SET TOWN_NAME = 'Saint-Aubin-Sauges' 
WHERE TOWN_NAME LIKE 'St-Aubin-Sauges%';
-- OUTPUT : 1 rows updated.


UPDATE SWITZERLAND 
SET TOWN_NAME = 'Saint-Cergue' 
WHERE TOWN_NAME LIKE 'St-Cergue%';
-- OUTPUT : 1 rows updated.


UPDATE SWITZERLAND 
SET TOWN_NAME = 'Saint-Pierre-de-Clages' 
WHERE TOWN_NAME LIKE 'St-Pierre-de-Clages%';
-- OUTPUT : 1 rows updated.

UPDATE SWITZERLAND 
SET TOWN_NAME = 'Seewis-Dorf' 
WHERE TOWN_NAME LIKE 'Seewis Dorf%';
-- OUTPUT : 1 rows updated.


UPDATE SWITZERLAND 
SET CANTON_NAME = 'Schwyz' 
WHERE TOWN_NAME LIKE 'Studen%';
-- OUTPUT : 9 rows updated.


UPDATE SWITZERLAND 
SET TOWN_NAME = 'Studen' 
WHERE TOWN_NAME LIKE 'Studen%';
-- OUTPUT : 9 rows updated.

UPDATE SWITZERLAND 
SET CANTON_NAME = 'Geneva' 
WHERE TOWN_NAME LIKE 'Versoix%';
-- OUTPUT : 4 rows updated.

UPDATE SWITZERLAND 
SET TOWN_NAME = 'Versoix' 
WHERE TOWN_NAME LIKE 'Versoix%';
-- OUTPUT : 4 rows updated.

UPDATE SWITZERLAND 
SET CANTON_NAME = 'Valais' 
WHERE TOWN_NAME LIKE 'Vilette%';
-- OUTPUT : 83 rows updated.

UPDATE SWITZERLAND 
SET TOWN_NAME = 'Vilette' 
WHERE TOWN_NAME LIKE 'Vilette%';
-- OUTPUT : 83 rows updated.

UPDATE SWITZERLAND 
SET CANTON_NAME = 'Solothurn' 
WHERE TOWN_NAME LIKE 'Walterswil%';
-- OUTPUT : 15 rows updated.

UPDATE SWITZERLAND 
SET TOWN_NAME = 'Walterwil' 
WHERE TOWN_NAME LIKE 'Walterswil%';
-- OUTPUT : 15 rows updated.

UPDATE SWITZERLAND 
SET TOWN_NAME = 'Weil am Rhein' 
WHERE TOWN_NAME LIKE 'Weil am Rh%';
-- OUTPUT : 8 rows updated.

UPDATE SWITZERLAND 
SET CANTON_NAME = 'Zürich' 
WHERE TOWN_NAME LIKE 'Weni%';
-- OUTPUT : 2 rows updated.

UPDATE SWITZERLAND 
SET TOWN_NAME = 'Wemige' 
WHERE TOWN_NAME LIKE 'Weni%';
-- OUTPUT : 2 rows updated.

UPDATE SWITZERLAND 
SET CANTON_NAME = 'Zürich' 
WHERE TOWN_NAME LIKE 'Wetzikon%';
-- OUTPUT : 87 rows updated.

UPDATE SWITZERLAND 
SET TOWN_NAME = 'Wetzikon' 
WHERE TOWN_NAME LIKE 'Wetzikon%';
-- OUTPUT : 87 rows updated.

UPDATE SWITZERLAND 
SET CANTON_NAME = 'Bern' 
WHERE TOWN_NAME LIKE 'Wiezikon%';
-- OUTPUT : 4 rows updated.

UPDATE SWITZERLAND 
SET TOWN_NAME = 'Wiezikon bei Sirnach' 
WHERE TOWN_NAME LIKE 'Wetzikon%';
-- OUTPUT : 4 rows updated.

UPDATE SWITZERLAND 
SET TOWN_NAME = 'Wil' 
WHERE TOWN_NAME LIKE 'Wil (ZH)';
-- OUTPUT : 2 rows updated.

UPDATE SWITZERLAND 
SET CANTON_NAME = 'Zürich' 
WHERE TOWN_NAME LIKE 'Wil';
-- OUTPUT : 4 rows updated.

UPDATE SWITZERLAND 
SET TOWN_NAME = 'Wohlen' 
WHERE TOWN_NAME LIKE 'Wohlen (AG)';
-- OUTPUT : 4 rows updated.

UPDATE SWITZERLAND 
SET CANTON_NAME = 'Aargau' 
WHERE TOWN_NAME LIKE 'Wohlen (AG)';
-- OUTPUT : 4 rows updated.

UPDATE SWITZERLAND 
SET TOWN_NAME = 'Wohlen bei Bern' 
WHERE TOWN_NAME LIKE 'Wohlen b%';
-- OUTPUT : 66 rows updated.

UPDATE SWITZERLAND 
SET CANTON_NAME = 'Bern' 
WHERE TOWN_NAME LIKE 'Wohlen b%';
-- OUTPUT : 66 rows updated.

------- Update To capitalize first letter.
UPDATE SWITZERLAND 
SET TOWN_NAME = 'Adelboden' 
WHERE TOWN_NAME LIKE 'adelboden';
-- OUTPUT : 4 rows updated.

UPDATE SWITZERLAND 
SET TOWN_NAME = 'Bern' 
WHERE TOWN_NAME LIKE 'bern';
-- OUTPUT : 1 rows updated.

UPDATE SWITZERLAND 
SET TOWN_NAME = 'Geneva' 
WHERE TOWN_NAME LIKE 'geneva';
-- OUTPUT : 1 rows updated.

UPDATE SWITZERLAND 
SET TOWN_NAME = 'Meggen' 
WHERE TOWN_NAME LIKE 'meggen';
-- OUTPUT : 1 rows updated.

UPDATE SWITZERLAND 
SET TOWN_NAME = 'Oberwil' 
WHERE TOWN_NAME LIKE 'oberwil';
-- OUTPUT : 1 rows updated.

UPDATE SWITZERLAND 
SET TOWN_NAME = 'Vernier' 
WHERE TOWN_NAME LIKE 'vernier';
-- OUTPUT : 4 rows updated.

UPDATE SWITZERLAND 
SET TOWN_NAME = 'Versoix' 
WHERE TOWN_NAME LIKE 'versoix';
-- OUTPUT : 1 rows updated.

UPDATE SWITZERLAND 
SET TOWN_NAME = 'Wald' 
WHERE TOWN_NAME LIKE 'wald';
-- OUTPUT : 1 rows updated.

UPDATE SWITZERLAND 
SET TOWN_NAME = 'Woodenswil' 
WHERE TOWN_NAME LIKE 'woodenswil';
-- OUTPUT : 1 rows updated.

UPDATE SWITZERLAND 
SET TOWN_NAME = 'Zug' 
WHERE TOWN_NAME LIKE 'zug';
-- OUTPUT : 1 rows updated.

UPDATE SWITZERLAND 
SET TOWN_NAME = 'Zürich' 
WHERE TOWN_NAME LIKE 'zürich';
-- OUTPUT : 1 rows updated.



