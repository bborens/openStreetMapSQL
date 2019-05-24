## README.txt
## BY BRYAN BORENSTEIN
## DATE : 20MAY2019 

### Project Title: Optimizing OpenStreetMap Data with Oracle 12c

### Description: This folder contains all files and scripts necessary
to complete the project. 

### Directory 
	
	> /README.txt (this file)
	> /scriptSqlFiles (location of .sql scripts to clean data)
	> /schemaCreation/csvFiles (location of exported CSV files and sqlldr
	   CTL/LOG files)
	> /openMapsProj/address-extraction-openstreet-master (sourced github for
	  conv. osm > csv)
	> /steps.txt (steps to connecting to 12c and loading data).
	> /SOURCES.txt (list of all sources used in this Project)


### INTRODUCTION : 

	Here, we are going to be taking the original Switzerland Geodata (osm data)
	and converting it to CSV files (1) using python. Once we have created the
	schema (table) within SQL Developer. Then, we will create a 'control' CTL file for
	use in loading the CSV file with the sqlldr Oracle terminal line tool.
	The CTL file has the necessary schema code written in it (much like the 
	table creation script in 'schemaCreation.sql,' less the data types.

	Once we've succesffuly loaded the newly exported CSV file (out-all.csv) 
	into our new Oracle 12c Schema, and confirmed it is there (in the SWITZERLAND
	table), we will move on to assess the quality of our data and make subsequent
	transformations.

### MANIPULATING (CLEANING) DATA WITHIN ORACLE 12C

#####################################################################################
		

 	##### STEP 1: ASSESS QUALITY OF DATA FOR:

		1) Validity

		2) Accuracy

		3) Completeness

		4) Consistency
	
		5) Uniformity

	These 5 points are addressed by Andy Kirk, the author of "Data Visualisation,
	A Handbook for Data Driven Design." (2) 

	"I love data that is neatly structured, clean and complete. This rarely
	exists. Location data will have inconsistent place-name spellings, there
	will be dates that have a mixture of US and UK formats..." (pg. 98)

	"CONDITION: This is the best moment to identify any data quality and comple-
	teness issues. Naturally, unidentified and unresolved issues around data 
	quality will come to bite later, undermining the scope and, crucially, 
	trust in the accuracy of your work. You will address these issues.... 
	look out for [the following]:

		* MISSING VALUES

		* ERRONEOUS VALUES

		* INCONSISTENCIES

		* DUPLICATE RECORDS

		* OUT OF DATE

		* UNCOMMON SYSTEM CHARACTERS OR LINE BREAKS

		* LEADING OR TRAILING SPACES

		* DATE ISSUES AROUND FORMAT" (pg 111)

#################################################################################

	#### STEP 2:  INTENTIONS TO CLEAN DATA

	We will begin by trying to adhere to Mr. Kirk's methodology, and examine
	our newly imported schema with these points in mind. To follow along with 
	our analysis, please examine '/scriptSqlFiles/schemaExploring.sql'

	
	FINDINGS (also found in comments of .sql file)


		INITIAL STATISTICS
		---------------------------------------------
		> NUMBER OF RECORDS (rows): 56337
		> NUMBER OF DISTINCT (unique) records: 56337
		> NUMBER OF DISTINCT TOWN NAMES: 1,224

		----------------------------------------------
		THINGS TO FIX 
		# 85+ points to fix for TOWN_NAME column.
		# i.e misspellings, overlappings, creating uniformity w/ abbv.
		# see comments in schemaExploring.sql

####################################################################################

		
	#### STEP 3: UPDATING TOWN_NAME COLUMN ERRORS
		
		We will now begin by cleaning up our issues found in schemaExploring.sql
		And begin out updates by executing /scriptSqlFiles/townNameUpdating.sql

		Notes for Updating: Many of our updates have to do with the country's
		'canton name,' or municipality being abbreviated several different
		ways... i.e town_name (ZH) or town_name ZH etc. Initially, I thought
		about simply adding a comma with the canton name, but since there
		are so many, I will simply add a new column called CANTON_NAME
		and then insert any distinctions there. After, I will trim all the
		Canton Name Abbreviations off the TOWN_NAME. Note that there will 
		be many entites with a NULL CANTON_NAME value, because of time 
		constraints with having to look up every municipality for every town
		(1,224); but overall this should be a positive start point in the
		evolution of this map data.

###################################################################################

	#### STEP 4: VIEWING OUR CHANGES

		Now that we have successfully examined, cleaned, and updated our
		database, we are ready to view it. To do this, we're going to 
		project our addresses with a query to show the ADDRESS which 
		will be a concatination of the STREET_NUM | STREET_NAME | TOWN_NAME
		| CANTON_NAME (if applicable). To see our final query, please
		visit addressView.sql
