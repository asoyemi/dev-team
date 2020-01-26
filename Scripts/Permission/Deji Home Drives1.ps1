<#	
	.NOTES
	===========================================================================
	 Created with: 	SAPIEN Technologies, Inc., PowerShell Studio 2015 v4.2.82
	 Created on:   	22/06/2015 16:29
	 Created by:   	jdibley
	 Organization: 	PRH
	 Filename:     	Deji Home Drives
	===========================================================================
	.DESCRIPTION
		Script for Deji to look at what user folders PUK Home Drive Deny Access wont work for.

		This will make 2 CSV files:
		1 which has any of the "PUK HomeDrive DenyAccess" Groups as the first ACL Permission
		1 which has any other ACL name as the first ACL listing - You will use this to fix permissions
#>

#Type in your home drive admin share
#$HomeDriveAdminFolder = "\\ukstrnas02\useradmin2$"

$SourceFolder = “c:\prhusers.txt”

$FolderPath = Get-Content $SourceFolder

#Getting root folder listing
#$GCIHomeDriveAdminFolder = GCI $HomeDriveAdminFolder

#Looping through each folder
foreach ($Folder in $FolderPath)
{
	#Getting folder name in variable (should be username too)
	#$FolderName = $Folder.Name
	
	#Getting folder full path
	#$FolderPath = $Folder.FullName
	
	#Getting ACL Permissions of the user folder
	$FolderACL = Get-ACL $Folder
	
	#Getting the username/groupname of the first ACL Value
	$FolderACLTopPermissionsUsername = $FolderACL.access[0].identityreference.value
	
	#Making the value for the add content. Path,Name,Permission Name
	$Value = """$FolderPath""" + "," """$FolderACLTopPermissionsUsername"""
	
	#If it is one of the PUK HomeDrive DenyAccess then add $value variable to "U:\Deji - PUKHomeDriveDenyAccess.csv" if not add to "U:\Deji - Not PUKHomeDriveDenyAccess.csv"
	If ($FolderACLTopPermissionsUsername -eq "UK\PUK HomeDrive DenyAccess" -or $FolderACLTopPermissionsUsername -eq "PEROOT\PUK HomeDrive DenyAccess" -or $FolderACLTopPermissionsUsername -eq "UK\PUK HomeDrive DenyAccess - UK")
	{
		Add-Content -Path "C:\Deji - PUKHomeDriveDenyAccess1.csv" -Value $Value
	}
	else
	{
		Add-Content -Path "C:\Deji - Not PUKHomeDriveDenyAccess1.csv" -Value $Value
	}
	
	#If ($FolderName -eq $FolderACLTopPermissionsUsername)
	#{
	#	$FolderACL	
	#}
	
}
