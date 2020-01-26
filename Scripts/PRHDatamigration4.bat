: Penguin Random House:- User data (HomeShare) consolidation and migration.

@ echo off

ECHO Penguin Random House:- User data (HomeShare) consolidation and migration.
ECHO
ECHO
:START


 for /f "tokens=1,2 delims=," %%i in (C:\testusers.txt) do (

          ECHO ...removing %%i user hidden share. Please wait.....

          net share V:\userspukntoz\%%i /delete

                     
    )
 

: END
ECHO Share delete completed. Please check 
 