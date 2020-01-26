: Penguin Random House:- User data (HomeShare) consolidation and migration.

@ echo off
SET dest=\\lo1upvdifil001\users\PRH
SET source1=\\ukedxfilsrv04\users1
SET source2=\\ukedgnas01.pearson.com\useradmin$
SET source3=\\ukstrnas02.pearson.com\useradmin2$
SET log1=c:\robocopy\logs\edexcel\edexcel-robocopy-log-file
SET log2=c:\robocopy\logs\harlow\edgnas01-robocopy-log-file
SET log3=c:\robocopy\logs\strand\strnas02-robocopy-log-file

ECHO UK IBM F1 Citrix:- User data (HomeShare) consolidation and migration.
ECHO
ECHO
:START

ECHO DO YOU WANT TO COPY USERS IN \\ukedxfilsrv04\users1\ THEN PRESS 1
ECHO DO YOU WANT TO COPY USERS IN \\ukedgnas01.pearson.com\useradmin$\ THEN PRESS 2
ECHO DO YOU WANT TO COPY USERS IN \\ukstrnas02.pearson.com\useradmin2$\ THEN PRESS 3
SET /P UserInput=Please Enter a Numer:

SET /A UserInputVal="%UserInput%"*1
IF %UserInputVal% EQU 1 GOTO EDEXCELCOPY
IF %UserInputVal% EQU 2 GOTO EDGCOPY
IF %UserInputVal% EQU 3 GOTO STRCOPY

IF %UserInputVal% EQU 0 GOTO INVALIDINPUT
IF %UserInputVal% GTR 3 GOTO INVALIDINPUT

:EDEXCELCOPY
 for /f "tokens=1,2 delims=," %%i in (C:\robocopy\edexcelusers.txt) do (

          ECHO ...Copying %%i user from %source1% to  %dest%. Please wait.....
          robocopy %source1%\%%i %dest%\%%i /SEC /S /COPY:DAT /lOG:%log1%-%%i.log
           
    )
 GOTO END 

:EDGCOPY
 for /f "tokens=1,2 delims=," %%i in (C:\robocopy\edgusers.txt) do (

          ECHO ...Copying %%i user from %source2% to  %dest%. Please wait.....
          robocopy %source2%\%%i %dest%\%%i /SEC /S /COPY:DAT /lOG:%log2%-%%i.log
               
    ) 
 GOTO END

:STRCOPY
 for /f "tokens=1,2 delims=," %%i in (C:\robocopy\penguinusers.txt) do (

          ECHO ...Copying %%i user from %source1% to  %dest%. Please wait.....	
          robocopy %source3%\%%i %dest%\%%i /SEC /S /COPY:DAT /lOG:%log3%-%%i.log
             
    )
 GOTO END

:INVALIDINPUT
ECHO Invalid user input. Please enter 1, 2 or 3
GOTO START

: END
ECHO Copy completed. Please check C:\robocopy\logs\ for log files
 