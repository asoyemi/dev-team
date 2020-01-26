On Error Resume Next

Const FOR_WRITING = 2

Dim arrNames()
intSize = 0

REM - AD group and path being queried

strAnswer = InputBox("Please Enter Group Name:", _
    "Create File")
strGrpQueried = strAnswer

REM - strGrpQueried = EMEA PUK Appr DKTeam

strAnswer1 = InputBox("Please Enter CN of OU, i.e. OU=Accounts,OU=UK:", _
    "Create File")

strOUQueried = strAnswer1

REM - strOUQueried = "OU=Groups,OU=UK,OU=Europe-Middle East-Africa,OU=Penguin Group"

strAnswer2 = InputBox("Please Enter Domain of OU, i.e DC=primary,DC=com:", _
    "Create File")

strOUPath = strAnswer2

REM - strOUPath = "DC=PGROOT,DC=Com"

strObjQuery = "LDAP://CN=" & strGrpQueried & "," & strOUQueried & "," & strOUPath


REM - path to output file, file name based on AD group queried

strWriteFile = "C:\Scripts\" & strGrpQueried & "Members.txt"


REM - Check output file exists and reuse or create

Set objFSO = CreateObject("Scripting.FileSystemObject")
If objFSO.FileExists(strWriteFile) Then
    Set objTextFile = objFSO.OpenTextFile(strWriteFile, FOR_WRITING)
Else
    Set objTextFile = objFSO.CreateTextFile(strWriteFile)
End If


REM - Get group members

Set objGroup = GetObject(strObjQuery)

For Each strUser in objGroup.Member
    Set objUser =  GetObject("LDAP://" & strUser)
    If objUser.AccountDisabled = FALSE Then
       ReDim Preserve arrNames(intSize)
       arrNames(intSize) = "Email: " & objUser.EmailAddress & "   " & vbTab & "USERNAME: " & objUser.displayName & "Account ID: " & objuser.sAMAccountName
       intSize = intSize + 1
    Else
       ReDim Preserve arrNames(intSize)
       arrNames(intSize) = "Email: " & objUser.EmailAddress & "   " & vbTab & "USERNAME: " & objUser.displayName & vbTab & " ACCOUNT DISABLED"
       intSize = intSize + 1
    End If
Next

REM - Create output file

objTextFile.WriteLine("Group Membership for: " & vbTab & strGrpQueried)
objTextFile.WriteLine(" ")

For Each strName in arrNames
    objTextFile.WriteLine(strName)
Next


REM - Cleanup

objTextFile.Close






