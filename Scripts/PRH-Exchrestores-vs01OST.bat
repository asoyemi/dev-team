:PRH EXCHANGE RESTORES FROM 2010

@ echo off

ECHO PRH EXCHANGE RESTORES FROM 2010.
ECHO
ECHO
:START

for /f "tokens=1,2 delims=," %%i in (L:\PUKOUTS1.txt) do (

M:
cd\restores\vs01
md %%i

ECHO Restoring exchange data from TSM. Please wait..... 
C:
cd\
cd\tsm\tdpexchange\

tdpexcc restorefiles "SG1" FULL /partial="PUK (Surname A-C)" /OBJECT=%%i /INTO=M:\Restores\vs01\%%i\ /fromexcserver=ukstrexvs01 /tsmoptfile=vs01_monthly.opt /tsmpassword=password

)

for /f "tokens=1,2 delims=," %%i in (L:\PUKOUTS2.txt) do (

M:
cd\restores\vs01
md %%i

ECHO Restoring exchange data from TSM. Please wait..... 
C:
cd\
cd\tsm\tdpexchange\

tdpexcc restorefiles "SG2" FULL /partial="PUK (Surname D-G)" /OBJECT=%%i /INTO=M:\Restores\vs01\%%i\ /fromexcserver=ukstrexvs01 /tsmoptfile=vs01_monthly.opt /tsmpassword=password

)


:END
ECHO Exchange restore of Completed. Thanks you>>>>
 