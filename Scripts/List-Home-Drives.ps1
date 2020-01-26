import-module activedirectory

$Users = gc "C:\scripts\PRHNewusers.txt"

foreach ($User in $Users) {
Get-ADUser $User  -properties scriptpath, homedrive, homedirectory | ft Name, scriptpath, homedrive, homedirectory 


}




