Import-Module ActiveDirectory
$UserCredential = Get-Credential `
-UserName "Sudoadmin" `
-Message "Please enter the sudoadmin password."
$Session = New-PSSession -ConfigurationName `
Microsoft.Exchange `
-ConnectionUri http://SERVERNAME.DOMAIN.local/PowerShell `
-Authentication Kerberos -Credential $UserCredential
Import-PSSession $Session
(Get-Date).ToString() + " - "  + "Attempting Import of Users CSV"
$CsvLocation = "\\SERVERNAME\C$\Sudoblark\NewUsers\NewUsers.csv"
$Users = Import-Csv $CsvLocation
(Get-Date).ToString() + " - "  + "Counting number of users in Excel file"
$MeasureUsers = $Users | Measure-Object
Foreach ($User in $Users) {
try 
{
(Get-Date).ToString() + " - "  + "Gather first users details from Excel file"
$UserFirstName = $User.FirstName            
$UserLastName = $User.LastName   
$DisplayName = $User.LastName + ", " + $User.FirstName 
$OU = "OU=NewUsers,OU=Sudoblark Users,DC=Sudoblark,DC=local"
$SAM = $User.LogonName
$UPN = $User.LogonName + "@sudoblark.local"
$Description = $User.Description
$Password = "Password123"
$EmailAddress = $User.FirstName + "." + $User.LastName + "@" + "sudoblark.com"
$UserToCopy = $User.UserToCopy
$HomeDirectory = "\\sudoblark.local\UserData\HomeDirs\" + $SAM
$Office = $User.Department
$ProfilePath = "\\sudoblark.local\DFS\profiles$\"
$ProfileFolderName = $SAM + ".V2"
$FullProfilePath = $ProfilePath + $ProfileFolderName
$FullProfilePathAD = $ProfilePath + $SAM
$TeleExtension = $User.Extension
$TeleNumber = "+44 20 7111 " + $TeleExtension
$MailboxIdentity = "sudoblark.local\" + $SAM
$HomePage = "http://sudoblark.com/"
$Company = "Sudoblark"
$Manager = $User.Manager
(Get-Date).ToString() + " - "  + "User details gathered from Excel file"
(Get-Date).ToString() + " - "  + "Create AD account for user"
New-ADUser -Name $DisplayName `
 -GivenName $UserFirstName `
 -Surname $UserLastName `
 -DisplayName $DisplayName `
 -EmailAddress $EmailAddress `
 -SamAccountName  $SAM `
 -UserPrincipalName  $UPN `
 -Path $OU `
 -company $Company `
 -HomeDrive "H" `
 -HomeDirectory $HomeDirectory `
 -ProfilePath $FullProfilePathAD `
 -AccountPassword (ConvertTo-SecureString $Password -AsPlainText -Force) `
 -ChangePasswordAtLogon $true  `
 -Enabled $true
(Get-Date).ToString() + " - "  + "AD Account created for User"
(Get-Date).ToString() + " - "  + "Creating user's DFS profile folder..."
New-Item -Path $ProfilePath -Name $ProfileFolderName -ItemType "directory"
$Acl = Get-Acl $FullProfilePath
$Ar = New-Object `
System.Security.AccessControl.FileSystemAccessRule ($SAM,"FullControl","ContainerInherit,ObjectInherit","None","Allow")
$Acl.SetAccessRule($Ar)
$Acl.SetOwner([System.Security.Principal.NTAccount]$SAM)
Set-Acl $FullProfilePath $Acl
(Get-Date).ToString() + " - "  + "DFS Profile created and permissions assigned"
Enable-Mailbox -identity $SAM
if ($Office -ne "NA") { 
 Set-ADUser $SAM `
 -Office $Office `
 -Department $Office
 }
if ($Manager -ne "NA") {
Set-ADUser $SAM `
-Manager $Manager
}
if ($Description -ne "NA") {
Set-ADUser $SAM `
 -Description $Description -Title $Description
}

if ($TeleExtension -ne "NA") {
Set-ADUser $SAM `
-OfficePhone $TeleNumber
}
Set-ADUser $SAM -HomePage $HomePage
if ($UserToCopy -ne "NA") {
Get-ADUser -Identity $UserToCopy -Properties memberof |
Select-Object -ExpandProperty memberof |
Add-ADGroupMember -Members $SAM -PassThru |
Select-Object -Property SamAccountName
}
}
catch 
{
$ErrorMessage = $_.Exception.Message
"Failed to create user " + $User.UserFirstName
"Failed completing the following step: " + $ErrorMessage
}
}
Remove-PSSession $Session
