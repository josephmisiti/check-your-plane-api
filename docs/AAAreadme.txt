This directory contains aviation data and documentation 
from the new NTSB accident database system (eADMS), which 
was implemented September 2008.


***DATA:

• In the folder "Access95" are self-extracting ZIP files of datasets 
in Microsoft Access (MDB) format, covering accident information from 
1982 to present.* Full datasets are recreated the 1st of every month; 
update datasets are created weekly. Although the files have zip extensions, 
they are self-extracting and will (should) be recognized as such by
uncompressing tools. Alternately, changing a file's extension to exe and
executing it will activate the self-extraction as well.

Note: The creation of single-year update files (i.e. "avxxxx.zip", where xxxx is 1982 - 2012) was suspended in February 2013.

Multi-Year Databases

   "avall.zip"   self-extracting ZIP file containing all data from 1982
                 to present*; it is created on the 1st of each month.


Weekly Update Databases

   "up_____.zip" self-extracting ZIP file containing data that was 
                 added or modified for the range indicated by the 
                 cut-off date. Data is for all years 1982-present.* 
                 Updates must be applied to pre-loaded data as 
                 appropriate in order to ensure the most current 
                 information.  4 update files are created each 
                 month; they remain available online for 3 months.

     Examples:

   "up08APR.zip" - updates between the 1st and 7th of April, inclusive.
   "up15APR.zip" - updates between April 8th and 14th
   "up22APR.zip" - updates between April 15th and 21st
   "up01MAY.zip" - updates between April 22nd and last day of April



***DOCUMENTATION:

• Contained in each dataset MDB file is
-   data dictionary
-   sample queries
-   code tables (ct_iaids, ct_seqevt and MultipleResponse) 
-   translation table (correlating old and new database elements)


• "eadmspub.pdf" contains a complete diagram of the tables and relationships 
                for the downloadable version of ADMS2000.

• "admsrel.pdf" contains a diagram of the logical relationships among data 
                elements for the downloadable version of ADMS2000.

• "codeman.pdf" is the Aviation Coding Manual (rev. 12/98) which contains
                instructions and codes for storage and retrieval of infor-
                mation concerning aviation accidents in the NTSB database.

• "mult_response.pdf" contains a description of treatment for data 
		      elements with multiple responses.


***OTHER:

• "eADMSpub.sql" is a script file which will create the aviation database in
    SQLserver


***NEW:

Pre1982.zip is a self-extracting zip file of Pre1982.mdb, an Access2000 
database containing accidents that occurred between 1/1/1961 and 12/31/1981, 
inclusively. They are stored separately from the post-1981 accidents because 
their data, codes and resulting schema are considerably different. The data 
is not routinely updated.

The database contains five tables with relationships described both in the 
database itself and below, as follows:

tblFirstHalf	the first of two top-level tables containing one record per 
                event. It has a one-to-one relationship with the tblSecondHalf 
                table below, both of which were divided from a single large 
                table for convenience.

tblSecondHalf	the second of two top-level tables as described above.

tblOccurrences	a sub-level table having a one-to-many relationship with the 
                tblFirstHalf and tblSecondHalf tables above. Each event can 
                have several occurrence records associated with it.

tblSeqOfEvents	a sub-level table having a one-to-many relationship with the 
                tblOccurrences table above. Each occurrence can have several 
                sequence-of-events records associated with it.

ct_Pre1982:	the look-up table used to code many of the fields in the four 
                database tables above.


For assistance with any aviation database questions, please
contact the the Office of Research and Engineering: 
avdata@ntsb.gov or (202)314-6541.


-----
updated 1 April 2013

