: Penguin Random House:- PRH NAS Drive migration.

c:
cd\
echo off

 for /f "tokens=1,2 delims=," %%i in (C:\Scripts\nas02shares.txt) do (

          ECHO ...Removing everyone group share permission from %%i. Please wait..... >>C:\scripts\nas02sharelog.txt
          rmtshare %%i /remove everyone >>C:\scripts\nas02sharelog.txt
         
    )
 >