: Penguin Random House:- User data (HomeShare) consolidation and migration.

@ echo off
SET dest=\\lo1upvdifil001\users\PRH
SET source1=\\ukstrvs02\userspukntoz
SET source2=\\ukstrnas01.pearson.com\useradmin$
SET source3=\\ukstrnas02.pearson.com\useradmin2$

ECHO Penguin Random House:- User data (HomeShare) consolidation and migration.
ECHO
ECHO
:START

ECHO LIST HOME FOLDER SIZE OF PRH USERS IN \\ukstrvs02\userspukntoz THEN PRESS 1
ECHO LIST HOME FOLDER SIZE OF PRH USERS IN \\ukstrnas01.pearson.com\useradmin$\ THEN PRESS 2
ECHO LIST HOME FOLDER SIZE OF PRH USERS IN \\ukstrnas02.pearson.com\useradmin2$\ THEN PRESS 3
SET /P UserInput=Please Enter a Number:

SET /A UserInputVal="%UserInput%"*1
IF %UserInputVal% EQU 1 GOTO VS02USERS
IF %UserInputVal% EQU 2 GOTO NAS01USERS
IF %UserInputVal% EQU 3 GOTO NAS02USERS

IF %UserInputVal% EQU 0 GOTO INVALIDINPUT
IF %UserInputVal% GTR 3 GOTO INVALIDINPUT

:VS02USERS
 for /f "tokens=1,2 delims=," %%i in (C:\Scripts\prhnewusers.txt) do (

          Echo.....Evaluating folder size...please wait
          echo Home drive size for %%i >>C:\scripts\PRH\prhhomevs02.txt 
	  net use L: %source1%\%%i
          C:\SysInternals\du -c L:\ >>C:\scripts\PRH\prhhomevs02.txt
          net use L: /delete /YES
    )
 GOTO END 

:NAS01USERS
 for /f "tokens=1,2 delims=," %%i in (C:\Scripts\prhnewusers.txt) do (

          Echo.....Evaluating folder size...please wait
          echo Home drive size for %%i >>C:\scripts\PRH\prhhomenas01.txt 
	  net use M: %source2%\%%i
          C:\SysInternals\du -c M:\ >>C:\scripts\PRH\prhhomenas01.txt
          net use M: /delete /YES
    ) 
 GOTO END

:NAS02USERS
 for /f "tokens=1,2 delims=," %%i in (C:\Scripts\prhnewusers.txt) do (

          Echo.....Evaluating folder size...please wait
          echo Home drive size for %%i >>C:\scripts\PRH\prhhomenas02.txt 
	  net use Q: %source3%\%%i
          C:\SysInternals\du -c Q:\ >>C:\scripts\PRH\prhhomenas02.txt
          net use Q: /delete /YES
    
                       
    )
 GOTO END

:INVALIDINPUT
ECHO Invalid user input. Please enter 1, 2 or 3
GOTO START

: END
ECHO Copy completed. Please check C:\Scripta\PRH\
 