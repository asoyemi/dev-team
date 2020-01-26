: Hellaby Quality Data Migration.

@ echo off
SET dest=\\ukedxfilsrv04\Operations\Hellaby Operations\Hellaby Quality
SET source1=V:\Hellaby Quality

SET log1=c:\robocopy\hellaby


ECHO Hellaby Quality Data Migration.
ECHO
ECHO
:START

ECHO DO YOU WANT TO COPY Hellaby Quality folder IN \\ukedxfilsrv04\ THEN PRESS 1
ECHO DO YOU WANT TO EXIT COPY THEN PRESS 2

SET /P UserInput=Please Enter a Numer:

SET /A UserInputVal="%UserInput%"*1
IF %UserInputVal% EQU 1 GOTO HELCOPY
IF %UserInputVal% EQU 2 GOTO END
IF %UserInputVal% EQU 0 GOTO INVALIDINPUT
IF %UserInputVal% GTR 2 GOTO INVALIDINPUT

:HELCOPY
          ECHO ...Copying data from %source1% to %dest%. Please wait.....
          robocopy %source1% %dest% /SEC /S /COPY:DAT /lOG:%log1%.log
           
GOTO END 

:INVALIDINPUT
ECHO Invalid user input. Please enter 1, 2 or 3
GOTO START

:END
ECHO Copy completed. Please check C:\robocopy\ for log files
 