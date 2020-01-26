import-module activedirectory

$targetFile = "C:\users.csv"
rm $targetFile
Add-Content $targetFile "User;Group"

$SourceFile = “c:\user.txt”

$UserList = Get-Content $SourceFile

foreach($user in $UserList)

{
    $groups = Get-ADPrincipalGroupMembership $user

    foreach ($group in $groups)
    {
        $username = $user.samaccountname
        $groupname = $group.name
        $line = "$username;$groupname"
        Add-Content $targetFile $line
    }
}



