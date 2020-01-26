: Windows Batch File
SET dest=\\lo1upvdifil001\users
SET log="c:\path-to-robocopy-log-file.log"

REM for /f %%t in (C:\makehomedir.txt) do (
REM      mkdir %dest%\%%t
      
REM   )

 for /f %%i in (C:\sourcelocation.txt) do (
       xcopy %%i %dest% /E 
     
   )  