:PRH EXCHANGE RESTORES FROM 2010

@ echo off

ECHO PRH EXCHANGE RESTORES FROM 2010.
ECHO
ECHO
:START

for /f "tokens=1,2 delims=," %%i in (L:\PUKOUTS3.txt) do (

L:
cd\Restores\vs02
md %%i

ECHO Restoring exchange data from TSM. Please wait.....
C:
cd\
cd\tsm\tdpexchange\
tdpexcc restorefiles "SG1" FULL /partial="PUK (Surname H-L)" /OBJECT=%%i /INTO=M:\Restores\vs02\%%i\ /fromexcserver=ukstrexvs02 /tsmoptfile=vs02_monthly.opt /tsmpassword=wizard
           
)


for /f "tokens=1,2 delims=," %%i in (L:\PUKOUTS4.txt) do (

M:
cd\Restores\vs02
md %%i

ECHO Restoring exchange data from TSM. Please wait.....
C:
cd\
cd\tsm\tdpexchange\
tdpexcc restorefiles "SG2" FULL /partial="PUK (Surname M-O)" /OBJECT=%%i /INTO=M:\Restores\vs02\%%i\ /fromexcserver=ukstrexvs02 /tsmoptfile=vs02_monthly.opt /tsmpassword=wizard
           
)

for /f "tokens=1,2 delims=," %%i in (L:\PUKOUTS4b.txt) do (

M:
cd\Restores\vs02
md %%i

ECHO Restoring exchange data from TSM. Please wait.....
C:
cd\
cd\tsm\tdpexchange\
tdpexcc restorefiles "SG2" FULL /partial="PUK (Surname P-Z)" /OBJECT=%%i /INTO=M:\Restores\vs02\%%i\ /fromexcserver=ukstrexvs02 /tsmoptfile=vs02_monthly.opt /tsmpassword=wizard
           
)


ECHO Exchange restore of Completed. Thanks you>>>>
 