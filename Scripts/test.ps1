$strUserName = "neilchil"
$strUser = get-qaduser -SamAccountName $strUserName
$strUser.memberof
