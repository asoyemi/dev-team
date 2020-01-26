On Error Resume Next

Const FOR_WRITING = 2

Dim arrNames()
intSize = 0

REM - AD group and path being queried

strAnswer = InputBox("Please Enter Group Name:", _
    "Create File")
strGrpQueried = strAnswer

REM - path to output file, file name based on AD group queried

strWriteFile = "C:\Scripts\Query AD.txt"

REM - Check output file exists and reuse or create

Set objFSO = CreateObject("Scripting.FileSystemObject")
If objFSO.FileExists(strWriteFile) Then
    Set objTextFile = objFSO.OpenTextFile(strWriteFile, FOR_WRITING)
Else
    Set objTextFile = objFSO.CreateTextFile(strWriteFile)
End If

REM - Get group details

Set objConnection = CreateObject("ADODB.Connection")
Set objCommand =   CreateObject("ADODB.Command")
objConnection.Provider = "ADsDSOObject"
objConnection.Open "Active Directory Provider"
Set objCommand.ActiveConnection = objConnection

objCommand.Properties("Page Size") = 1000
objCommand.Properties("Searchscope") = ADS_SCOPE_SUBTREE 

objCommand.CommandText = _
    "SELECT Name FROM 'LDAP://DC=peroot,DC=com' WHERE objectCategory='group' " & _
        "AND Name='DK*'"

Set objRecordSet = objCommand.Execute

For Each strUser in objRecordSet.MoveFirst
        ReDim Preserve arrNames(intSize)
       arrNames(intSize) = "Group Name: " & objRecordSet.Fields("Name").Value 
       intSize = intSize + 1
    Next

REM - Create output file

objTextFile.WriteLine("Group List for: " & strGrpQueried)
objTextFile.WriteLine(" ")

For Each strName in arrNames
    objTextFile.WriteLine(strName)
Next


REM - Cleanup

objTextFile.Close






