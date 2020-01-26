# 1. Login into destination Exchange 2007 Server

# 2. Set the database name in line $TargetDatabase = “Mailbox Database” where you want to move the mailboxes

# 3. Put the list of all user’s alias into c:\users.txt file
# 4. Copy this file at C:\Program Files\Microsoft\Exchange Server\scripts with name Move-Mailboxes.ps1
# 5. Run the cmdlet from Exchange Power Shell
# 6. Once all mailboxes moves check the file c:\MoveLog.txt file for any error during movement


$TargetDatabase = "ukedgvs02\SG1\PSS Tech 2 (M-Z)”

$SourceFile = “c:\Mailbox Moves\testmove.txt”

$a = remove-item c:\Movelog.txt -ea SilentlyContinue

$error.Clear()

$UserList = Get-Content $SourceFile

foreach($user in $UserList)
{

$message = “Moving User -> ” + $user

write-output $message out-file -filePath “c:\MoveLog.txt” -append -noClobber

move-mailbox -Identity $user -TargetDatabase $TargetDatabase -BadItemLimit 5 -PreserveMailboxSizeLimit:$true -Confirm: $false
if($error.Count -ne 0)
{

$message = “User ” + $user + ” failed to move ???????????”
write-output $message out-file -filePath “c:\MoveLog.txt” -append -noClobber

$message = “Error:::: ” + $error[0].ToString()

write-output $message out-file -filePath “c:\MoveLog.txt” -append -noClobber

$error.Clear()
}
}


