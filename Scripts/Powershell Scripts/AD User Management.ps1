import-module activedirectory
#Powershell code to manage user account in test-labs
# Writen by : Adedeji Soyemi
# Version 1.0.0

# Menu function to disable and enable AD user account

function Show-EnabledMenu
{
     param (
           [string]$Title = 'Enable or Disable User Account'
     )
     cls
     Write-Host "================ $Title ================"
    
     Write-Host "1: Press '1' To Disable User Account."
     Write-Host "2: Press '2' To Enable User Account."
     Write-Host "3: Press '3' To Return To Main Menu."
}

# Menu function to manage AD user account
function Show-Menu
{
     param (
           [string]$Title = 'EE AD User Management'
     )
     cls
     Write-Host "================ $Title ================"
    
     Write-Host "1: Press '1' Check User JumpBox Account Details."
     Write-Host "2: Press '2' Reset User JumpBox Password."
     Write-Host "3: Press '3' Extend User Account Expiry Date."
     Write-Host "4: Press '4' Check Users Access to Jump Servers."
     Write-Host "5: Press '5' Unlock User Jumpbox Account."
     Write-Host "5: Press '5' Enable or Disable User Account."
     Write-Host "Q: Press 'Q' to quit."
}

do
{
     Show-Menu
     $input = Read-Host "Please make a selection"
     switch ($input)
     {
          # Input AD account and check if account exist and if it does display AD account attributes
            '1' {
               
               $UserName=Read-Host -Prompt 'Enter the AD username name'
                  
                  if (@(Get-ADUser -Filter { SamAccountName -eq $UserName }).Count -eq 0) { Write-Warning -Message "User $UserName does not exist, please try again."}
                          Else{Write-Host "Find below the AD account details for user '$UserName'"
                          Get-ADUser -server wpftp01 $UserName -Properties * | Select AccountExpirationDate, Created, LockedOut, SamAccountName, LastLogonDate, whenCreated, whenChanged, Enabled}
               
           } '2' {
           # Input AD account and if account exisit reset password to a new one typed in by user
                $UserName=Read-Host -Prompt 'Enter the AD username name' 

                  if (@(Get-ADUser -Filter { SamAccountName -eq $UserName }).Count -eq 0) { Write-Warning -Message "User $UserName does not exist, please try again."}
                          Else{                              
                          $newPass=Read-Host "Enter the new user password" -AsSecureString
                          Set-ADAccountPassword -server wpftp01 $UserName -NewPassword $newPass 
                          Set-ADUser -Server wpftp01 $UserName -ChangePasswordAtLogon $False
                          Write-Host "The jumpaccount password for user '$UserName' has now been changed" 
                          }
           } '3' {
            # Input AD account and if account exist change the account expiry date
                 $UserName=Read-Host -Prompt 'Enter the AD username name' 

                  if (@(Get-ADUser -Filter { SamAccountName -eq $UserName }).Count -eq 0) { Write-Warning -Message "User $UserName does not exist, please try again."} 
                          Else{
                          $AccExpDate=Read-Host -Prompt 'Enter new account expiry date Format MM/DD/YYYY'
                          Set-ADAccountExpiration -Server wpftp01 -Identity $UserName -DateTime $AccExpDate
                          Write-Host "The new account expiry date for user '$UserName' is now '$AccExpDate' "}

           } '4' {
           # Check which group AD user belongs to, to determine which jump server the user can access
                 $UserName=Read-Host -Prompt 'Enter the AD username name' 

                    if (@(Get-ADUser -Filter { SamAccountName -eq $UserName }).Count -eq 0) { Write-Warning -Message "User $UserName does not exist, please try again."} 
                      Else{
                      Get-ADPrincipalGroupMembership $UserName | select name
                     } 
           
            } '5' {
           # unlock user jumpbox user account
                 $UserName=Read-Host -Prompt 'Enter the AD username name' 

                    if (@(Get-ADUser -Filter { SamAccountName -eq $UserName }).Count -eq 0) { Write-Warning -Message "User $UserName does not exist, please try again."} 
                      Else{
                      Unlock-ADAccount -Identity $UserName
                      Write-Host "The user '$UserName' jumpbox account is now unlocked' "}
                     } 

            '6' {
            #  Input AD account and if account exist enable or disable user account   
               $UserName=Read-Host -Prompt 'Enter the AD username name' 

                  if (@(Get-ADUser -Filter { SamAccountName -eq $UserName }).Count -eq 0) { Write-Warning -Message "User $UserName does not exist, please try again."} 
                   Else{ 
                    do
                        {
                            Show-EnabledMenu
                            $input1 = Read-Host "Please make a selection"
                            switch ($input1) 
                                    
                                   {
          
                                        '1' {

                                               
                                                Disable-ADAccount -server wpftp01 $UserName 
                                                Write-Host "User Account '$UserName' has now been disabled"
                                                Pause                                                  
                                       } '2' {

                                                Enable-ADAccount -server wpftp01 $UserName 
                                                Write-Host "User Account '$UserName' has now been enabled"
                                                Pause  
                                       } '3' {
                                               
                                               break :DoLoop 
                                   }
                                }
                           
                               } until ($input1 -eq '3') 
                                  
                     
                    }                              
           } 'q' {
                return
           }
     }
     pause
}
until ($input -eq 'q')