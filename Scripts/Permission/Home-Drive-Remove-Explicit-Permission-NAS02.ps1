Function Remove-ExplicitUserPermission
{
    <#
        .SYNOPSIS
            Removes explicit permissions on user folders

        .DESCRIPTION
            Removes explicit permissions on user folders

        .PARAMETER Path
            The folder or file that will have the permission removed from.

        .PARAMETER Account
            Optional parameter to remove explicit user permissions from the folder

            Default value is 'Builtin\Administrators'

        .PARAMETER Recurse
            Not used
	
       
    #>
	[cmdletbinding(
				   SupportsShouldProcess = $True
				   )]
	Param (
		[parameter(ValueFromPipeline = $True, ValueFromPipelineByPropertyName = $True)]
		[Alias('FullName')]
		[string[]]$Path,
		[parameter()]
		[string]$Account = 'BUILTIN\Administrators',
		[parameter()]
		[switch]$Recurse
	)
	Begin
	{
		#Prevent Confirmation on each Write-Debug command when using -Debug
		If ($PSBoundParameters['Debug'])
		{
			$DebugPreference = 'Continue'
		}
		Try
		{
			[void][TokenAdjuster]
		}
		Catch
		{
			$AdjustTokenPrivileges = @"
            using System;
            using System.Runtime.InteropServices;

             public class TokenAdjuster
             {
              [DllImport("advapi32.dll", ExactSpelling = true, SetLastError = true)]
              internal static extern bool AdjustTokenPrivileges(IntPtr htok, bool disall,
              ref TokPriv1Luid newst, int len, IntPtr prev, IntPtr relen);
              [DllImport("kernel32.dll", ExactSpelling = true)]
              internal static extern IntPtr GetCurrentProcess();
              [DllImport("advapi32.dll", ExactSpelling = true, SetLastError = true)]
              internal static extern bool OpenProcessToken(IntPtr h, int acc, ref IntPtr
              phtok);
              [DllImport("advapi32.dll", SetLastError = true)]
              internal static extern bool LookupPrivilegeValue(string host, string name,
              ref long pluid);
              [StructLayout(LayoutKind.Sequential, Pack = 1)]
              internal struct TokPriv1Luid
              {
               public int Count;
               public long Luid;
               public int Attr;
              }
              internal const int SE_PRIVILEGE_DISABLED = 0x00000000;
              internal const int SE_PRIVILEGE_ENABLED = 0x00000002;
              internal const int TOKEN_QUERY = 0x00000008;
              internal const int TOKEN_ADJUST_PRIVILEGES = 0x00000020;
              public static bool AddPrivilege(string privilege)
              {
               try
               {
                bool retVal;
                TokPriv1Luid tp;
                IntPtr hproc = GetCurrentProcess();
                IntPtr htok = IntPtr.Zero;
                retVal = OpenProcessToken(hproc, TOKEN_ADJUST_PRIVILEGES | TOKEN_QUERY, ref htok);
                tp.Count = 1;
                tp.Luid = 0;
                tp.Attr = SE_PRIVILEGE_ENABLED;
                retVal = LookupPrivilegeValue(null, privilege, ref tp.Luid);
                retVal = AdjustTokenPrivileges(htok, false, ref tp, 0, IntPtr.Zero, IntPtr.Zero);
                return retVal;
               }
               catch (Exception ex)
               {
                throw ex;
               }
              }
              public static bool RemovePrivilege(string privilege)
              {
               try
               {
                bool retVal;
                TokPriv1Luid tp;
                IntPtr hproc = GetCurrentProcess();
                IntPtr htok = IntPtr.Zero;
                retVal = OpenProcessToken(hproc, TOKEN_ADJUST_PRIVILEGES | TOKEN_QUERY, ref htok);
                tp.Count = 1;
                tp.Luid = 0;
                tp.Attr = SE_PRIVILEGE_DISABLED;
                retVal = LookupPrivilegeValue(null, privilege, ref tp.Luid);
                retVal = AdjustTokenPrivileges(htok, false, ref tp, 0, IntPtr.Zero, IntPtr.Zero);
                return retVal;
               }
               catch (Exception ex)
               {
                throw ex;
               }
              }
             }
"@
			Add-Type $AdjustTokenPrivileges
		}
		
		#Activate necessary admin privileges to make changes without NTFS perms
		[void][TokenAdjuster]::AddPrivilege("SeRestorePrivilege") #Necessary to set Owner Permissions
		[void][TokenAdjuster]::AddPrivilege("SeBackupPrivilege") #Necessary to bypass Traverse Checking
		[void][TokenAdjuster]::AddPrivilege("SeTakeOwnershipPrivilege") #Necessary to override FilePermissions
		
	}
	Process
	{
		ForEach ($Item in $Path)
		{
			Write-Verbose "FullName: $Item"
			$DirUserAcl = New-Object System.Security.AccessControl.DirectorySecurity
			$UserACL = New-Object System.Security.AccessControl.FileSystemAccessRule($Account, 'FullControl', 'ContainerInherit,ObjectInherit', 'None', 'Allow')
			$DirUserAcl.RemoveAccessRule($UserACL)
			
			
			try
			{
				$ItemOld = $Item
				$Item = Get-Item -LiteralPath $Item -Force -ErrorAction Stop
			}
			catch
			{
				Write-Warning "Folder Not Present"
				continue
			}
			If ($PSCmdlet.ShouldProcess($Item, 'Set Directory Owner'))
			{
				try
				{
					Write-Verbose "Removing User ACL Permissions"
					$Item.SetAccessControl($DirUserAcl)
				}
				catch
				{
					Write-Warning "Setting access failed"
				}
			}
			
		}
		
	}
	End
		{
			#Remove priviledges that had been granted
			[void][TokenAdjuster]::RemovePrivilege("SeRestorePrivilege")
			[void][TokenAdjuster]::RemovePrivilege("SeBackupPrivilege")
			[void][TokenAdjuster]::RemovePrivilege("SeTakeOwnershipPrivilege")
		}
}

$SourceFolder = "C:\PRHUserpath3.txt"

$FolderPrh = Get-Content $SourceFolder

foreach ($PrhUser in $FolderPrh)

  {

   write-host “Setting permissions on: $Prhuser..Please wait”
   Remove-ExplicitUserPermission -Path $PrhUser
   
   }
   
   