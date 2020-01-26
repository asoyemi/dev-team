: Penguin Random House:- User data (HomeShare) consolidation and migration.

@ echo off

SET Dest=\\ukstrnas02\useradmin2$\PRHusers
SET Source=\\ukstrnas02\useradmin2$

ECHO Penguin Random House:- User data (HomeShare) consolidation and migration.
ECHO
ECHO
:START


 for /f "tokens=1,2 delims=," %%i in (C:\Scripts\testusers.txt) do (

          ECHO ...moving %%i user from %source% to  %dest%. Please wait.....

          move %Source%\"%%i" %Dest%

          ECHO....user %%i moved suceessfully

           
    )
 

: END
ECHO Move completed. Please check \\ukstrnas02\useradmin2$\Prhusers\ folder
 