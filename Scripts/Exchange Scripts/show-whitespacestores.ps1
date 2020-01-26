Function GetWhiteSpace($Server)
 {
  $logfile="Application"
  $eventcode="1221"
  $recent=[System.Management.ManagementDateTimeConverter]::ToDMTFDateTime((Get-Date).AddDays(-1)) # Gets yesterdays date.
  $Events = get-wmiobject -computer $server -class Win32_NTLogEvent `
  -filter "logfile = '$logfile' AND (TimeGenerated >='$recent') AND EventCode = '$eventcode'"
  
  #This section formats the results from $Events
   Foreach ($item in $Events)
  { 
   $iDay= ($item.TimeGenerated.SubString( 6, 2))
   $iMonth= ($item.TimeGenerated.SubString( 4, 2))
   $iYear= ($item.TimeGenerated.SubString( 0, 4))
   $iHour= ($item.TimeGenerated.SubString( 8, 2))
   $iMinute= ($item.TimeGenerated.SubString(10, 2))
   $iSecond= ($item.TimeGenerated.SubString(12, 2))
   If ($iDay.length -eq 1) {"0"+$iday}
   If ($iMonth.length -eq 1) {"0"+$iMonth}
   $strDate=$iDay+"/"+$iMonth+"/"+$iYear
   $StrTime=$iHour+":"+$iMinute+":"+$iSecond
   
   $iServer = $item.message | % {($_.Split("""")[1])}
   $iSize = $item.message | % {($_.Split("") | ?{$_ -match "\d"})[1]}
   
   $myobj = "" | Select-Object Date,"Server","MailStore","Size MB"
   $myobj."Date" = $strDate
   $myobj."Server" = $Server
   $myobj."MailStore" = $iServer
   $myobj."Size MB" = $iSize
   $myobj
  }
 }


 $i=0
 $Server = "ukstrexvs01","ukstrexvs02","ukstrexvs03","ukstrexvs04","ukedgexvs01","ukedgexvs02","ukedgexvs03","ukedgexvs04"
 Foreach($Serv in $Server) 
 {
 $i++
 Write-Progress -id 10 -Activity "Exchange White Space Check" -Status "Progress" -PercentComplete (($i/$Server.length)*100)
 Write-Progress -id $i -parentId 10 -Activity "Extracting Information" -Status $Serv
 GetWhiteSpace($Serv)
 }

