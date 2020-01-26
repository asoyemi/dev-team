net use t: \\uk.testfacility.t-mobile.net\testfacility-shares

@echo OFF

reg Query "HKLM\Hardware\Description\System\CentralProcessor\0" | find /i "x86" > NUL && set OS=32BIT || set OS=64BIT

if %OS%==32BIT C:\windows\system32\bginfo\bginfo /ic:\windows\system32\BGInfo\logon.bgi /timer:0 /NOLICPROMPT
if %OS%==64BIT C:\windows\system32\bginfo\bginfo64 /ic:\windows\system32\BGInfo\logon.bgi /timer:0 /NOLICPROMPT

