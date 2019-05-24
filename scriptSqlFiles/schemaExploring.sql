-- EXPLORING SWITZERLAND SCHEMA TO IDENFITY ENTITIESTO TRANSFORM

-- STEP 1: BASIC ANALYSIS OF TABLE PROPERTIES

-- 1A: Finding Count of Records in Table
SELECT COUNT(*) FROM SWITZERLAND;
-- OUTPUT: 56337 ROWS

-- 1B: Finding Unique Row Count for All Records
-- Now we will count the **distinct** rows to compare against the previous
-- And if necessary, subtract from the original count to look for Duplicates.
SELECT DISTINCT COUNT(*) FROM SWITZERLAND;
-- OUTPUT: 56337 ROWS
-- GREAT! NO DUPLICATES


-- STEP 2: FINDING COUNTS OF NAME'S AND LOOK FOR DUPLICATES/ERRORS W/ DISTINCT

-- To Reiterate, we have (5) columns in our SWITZERLAND TABLE
-- LATITUDE : shows latitude coordinates
-- LONGITUDE : shows longitude coordinates
-- TOWN_NAME : displays name of location (town/city) with first letter capitalized.
-- STREET_NUM : number datatype displays number component of address.
-- STREET_NAME : displays name of street corresponding to street_num to makeup street address.


-- 2A: Displaying the Distinct Town Names In Switzerland Table
SELECT DISTINCT TOWN_NAME
FROM SWITZERLAND
-- Order Column to Display Alphabetically (Default: Ascending)
ORDER BY 1;

-- OUTPUT : RIGHT CLICK THE TABLE IN BELOW 'QUERY RESULT' > COUNT ROWS TO FIND COUNT 
-- OUTPUT (COUNT ROWS) =  1,124

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


