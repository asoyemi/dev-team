: PRH EXCHANGE RESTORES FROM 2010

@ echo off

ECHO PRH EXCHANGE RESTORES FROM 2010.
ECHO
ECHO
:START

ECHO DO YOU WANT TO START EXCHANGE RESTORES FROM UKSTREXVS01, THEN PRESS 1
ECHO DO YOU WANT TO START EXCHANGE RESTORES FROM UKSTREXVS02, THEN PRESS 2

SET /P UserInput=Please Enter a Numer:

SET /A UserInputVal="%UserInput%"*1
IF %UserInputVal% EQU 1 GOTO STREXVS01
IF %UserInputVal% EQU 2 GOTO STREXVS02
IF %UserInputVal% EQU 0 GOTO INVALIDINPUT
IF %UserInputVal% GTR 2 GOTO INVALIDINPUT

:STREXVS01
SET /P UserInput1=PLEASE INPUT DATABASE TO RESTORE:
SET /P UserInput2=PLEASE DATABASE OBJECT NUMBER:
SET /P UserInput3=PLEASE INPUT STORAGE GROUP I.E SG1:
SET /A UserInputVal1="%UserInput1%"
SET /A UserInputVal2="%UserInput2%"
SET /A UserInputVal3="%UserInput3%"

L:
cd\restores\vs01
md %UserInput2%

ECHO Restoring exchange data from TSM. Please wait..... 
C:
cd\
cd\tsm\tdpexchange\
tdpexcc restorefiles "%UserInput3%" FULL /partial="%UserInput1%" /OBJECT=%UserInput2% /INTO=M:\Restores\vs01\%UserInput2%\ /fromexcserver=ukstrexvs01 /tsmoptfile=vs01_monthly.opt /tsmpassword=password

ECHO DO YOU WANT TO RESTORE ANOTHER DATABASE FROM UKSTREXVS01, THEN PRESS 1
ECHO DO YOU WANT TO QUIT, THEN PRESS 2

SET /P UserInput4=Please Enter a Numer:

SET /A UserInputVal4="%UserInput4%"*1
IF %UserInputVal4% EQU 1 GOTO STREXVS01
IF %UserInputVal4% EQU 2 GOTO END
           
:STREXVS02
SET /P UserInput1=PLEASE INPUT DATABASE TO RESTORE:
SET /P UserInput2=PLEASE DATABASE OBJECT NUMBER:
SET /P UserInput3=PLEASE INPUT STORAGE GROUP I.E SG1:
SET /A UserInputVal1="%UserInput1%"
SET /A UserInputVal2="%UserInput2%"
SET /A UserInputVal3="%UserInput3%"

L:
cd\Restores\vs02
md %UserInput2%

ECHO Restoring exchange data from TSM. Please wait.....
C:
cd\
cd\tsm\tdpexchange\
tdpexcc restorefiles "%UserInput3%" FULL /partial="%UserInput1%" /OBJECT=%UserInput2% /INTO=M:\Restores\vs02\%UserInput2%\ /fromexcserver=ukstrexvs02 /tsmoptfile=vs02_monthly.opt /tsmpassword=wizard
           
ECHO DO YOU WANT TO RESTORE ANOTHER DATABASE FROM UKSTREXVS02, THEN PRESS 1
ECHO DO YOU WANT TO QUIT, THEN PRESS 2

SET /P UserInput4=Please Enter a Numer:

SET /A UserInputVal4="%UserInput4%"*1
IF %UserInputVal4% EQU 1 GOTO STREXVS02
IF %UserInputVal4% EQU 2 GOTO END

:INVALIDINPUT
ECHO Invalid user input. Please enter 1 or 2
GOTO START

:END
ECHO Exchange restore of %UserInput1% Completed. Thanks you>>>>
 