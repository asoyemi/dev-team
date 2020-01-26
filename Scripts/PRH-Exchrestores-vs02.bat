:PRH EXCHANGE RESTORES FROM 2010

@ echo off

ECHO PRH EXCHANGE RESTORES FROM 2010.
ECHO
ECHO
:START

for /f "tokens=1,2 delims=," %%i in (L:\PUKH-L.txt) do (

L:
cd\Restores\vs02
md %%i

ECHO Restoring exchange data from TSM. Please wait.....
C:
cd\
cd\tsm\tdpexchange\
tdpexcc restorefiles "SG1" FULL /partial="PUK (Surname H-L)" /OBJECT=%%i /INTO=M:\Restores\vs02\%%i\ /fromexcserver=ukstrexvs02 /tsmoptfile=vs02_monthly.opt /tsmpassword=wizard
           
)

for /f "tokens=1,2 delims=," %%i in (L:\PUKS.txt) do (

M:
cd\Restores\vs02
md %%i

ECHO Restoring exchange data from TSM. Please wait.....
C:
cd\
cd\tsm\tdpexchange\
tdpexcc restorefiles "SG1" FULL /partial="PUK (Surname S)" /OBJECT=%%i /INTO=M:\Restores\vs02\%%i\ /fromexcserver=ukstrexvs02 /tsmoptfile=vs02_monthly.opt /tsmpassword=wizard
           
)

for /f "tokens=1,2 delims=," %%i in (L:\PUKM-O.txt) do (

M:
cd\Restores\vs02
md %%i

ECHO Restoring exchange data from TSM. Please wait.....
C:
cd\
cd\tsm\tdpexchange\
tdpexcc restorefiles "SG2" FULL /partial="PUK (Surname M-O)" /OBJECT=%%i /INTO=M:\Restores\vs02\%%i\ /fromexcserver=ukstrexvs02 /tsmoptfile=vs02_monthly.opt /tsmpassword=wizard
           
)

for /f "tokens=1,2 delims=," %%i in (L:\PUKP-Z.txt) do (

M:
cd\Restores\vs02
md %%i

ECHO Restoring exchange data from TSM. Please wait.....
C:
cd\
cd\tsm\tdpexchange\
tdpexcc restorefiles "SG2" FULL /partial="PUK (Surname P-Z)" /OBJECT=%%i /INTO=M:\Restores\vs02\%%i\ /fromexcserver=ukstrexvs02 /tsmoptfile=vs02_monthly.opt /tsmpassword=wizard
           
)

for /f "tokens=1,2 delims=," %%i in (L:\PUKP-R.txt) do (

M:
cd\Restores\vs02
md %%i

ECHO Restoring exchange data from TSM. Please wait.....
C:
cd\
cd\tsm\tdpexchange\
tdpexcc restorefiles "SG3" FULL /partial="PUK (Surname P-R)" /OBJECT=%%i /INTO=M:\Restores\vs02\%%i\ /fromexcserver=ukstrexvs02 /tsmoptfile=vs02_monthly.opt /tsmpassword=wizard
           
)

for /f "tokens=1,2 delims=," %%i in (L:\PUKM-Oa.txt) do (

M:
cd\Restores\vs02
md %%i

ECHO Restoring exchange data from TSM. Please wait.....
C:
cd\
cd\tsm\tdpexchange\
tdpexcc restorefiles "SG4" FULL /partial="PUK (Surname M-O)" /OBJECT=%%i /INTO=M:\Restores\vs02\%%i\ /fromexcserver=ukstrexvs02 /tsmoptfile=vs02_monthly.opt /tsmpassword=wizard
           
)


ECHO Exchange restore of Completed. Thanks you>>>>
 