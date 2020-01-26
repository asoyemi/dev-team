' Pearson OU Pwd.vbs
' VBScript to change a group of user password in a given OU 
' Written by - Deji Soyemi
' ---------------------------------------------------------' 
Option Explicit
Dim objOU, objUser, objRootDSE
Dim strContainer, strDNSDomain, strPassword 
Dim intCounter, intAccValue, intPwdValue
Dim strAnswer, strAnswer1

' --------------------------------------------------------'
' Note: Please change OU=nowhere, to reflect your domain
' --------------------------------------------------------'
' ---------------------
' IntAccValue Options'
' ---------------------
' 512 - Enable Account
' 514 - Disable account
' 544 - Account Enabled - Require user to change password at first logon 
' 66048 - Password never expires
' 262656 - Smart Card Logon Required
' strAnswer = InputBox("Please Enter CN of OU, i.e. OU=Accounts,OU=UK: WARNING ALL PASSWORD IN THESE OU WILL BE CHANGED!!", _
'    "Create File")
' strContainer = strAnswer

' strAnswer1 = InputBox("Please Enter The New Password For All Users in The OU:", _
'    "Create File")
' strPassword = strAnswer1

strContainer = "OU=Test OU,OU=EMEA, "
strPassword = "Passw0rd12"
intAccValue = 66048
intPwdValue = 0
intCounter = 0
' -------------------------------------------------------'
' Users Password is set never to expire 
' -------------------------------------------------------'

Set objRootDSE = GetObject("LDAP://RootDSE") 
strDNSDomain = objRootDSE.Get("DefaultNamingContext")
strContainer = strContainer & strDNSDomain
set objOU =GetObject("LDAP://" & strContainer )

For each objUser in objOU
If objUser.class="user" then
objUser.SetPassword strPassword
objUser.SetInfo
objUser.Put "pwdLastSet", intPwdValue
objUser.SetInfo

objUser.Put "userAccountControl", intAccValue
objUser.SetInfo
intCounter = intCounter +1
End if
next

WScript.Echo strPassword & " is Password. UserAccountValue = " _
& intAccValue & vbCr & intCounter & " accounts changed"


WScript.Quit

' End of change Pearson password change VBScript
