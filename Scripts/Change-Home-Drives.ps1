import-module activedirectory

$Users = gc "C:\scripts\PRHusers.txt"


foreach ($AccountName in $Users) {

$HomeDrive=’H:’

$UserRoot=’\\UKSTRNAS02\Useradmin$\’

$HomeDirectory=$UserRoot+$AccountName

Set-ADUser $AccountName -Homedrive $HomeDrive -HomeDirectory $HomeDirectory 

}




