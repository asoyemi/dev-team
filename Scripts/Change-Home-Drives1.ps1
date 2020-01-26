import-module activedirectory

$users = Import-Csv -Path C:\Scripts\PRHUsers.csv 


foreach ($AccountName in $Users) {

$HomeDrive=’H:’

$UserRoot=’\\UKSTRNAS02\Useradmin$\’

$HomeDirectory=$UserRoot+$AccountName

Set-ADUser $AccountName -Homedrive $HomeDrive -HomeDirectory $HomeDirectory 

}




