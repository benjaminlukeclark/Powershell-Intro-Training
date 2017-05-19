# New User Script

# Download these if you are having some trouble running the script:
# http://go.microsoft.com/fwlink/?LinkID=286152
# http://go.microsoft.com/fwlink/p/?linkid=236297

# Import Modules
Import-Module ActiveDirectory

# Connect to Exchange 2013 
$UserCredential = Get-Credential `
-UserName "Sudoadmin" `
-Message "Please enter the Sudoadmin password."

$Session = New-PSSession -ConfigurationName `
Microsoft.Exchange `
-ConnectionUri http://SERVERNAME.DOMAIN.local/PowerShelll `
-Authentication Kerberos -Credential $UserCredential

Import-PSSession $Session



# Import CSV file with usernames
(Get-Date).ToString() + " - "  + "Attempting Import of Users CSV"
$CsvLocation = "\\SERVERNAME\C$\Sudoblark\NewUsers\NewUsers.csv"
$Users = Import-Csv $CsvLocation

#Measure Number of Users in Excel file
(Get-Date).ToString() + " - "  + "Counting number of users in Excel file"
$MeasureUsers = $Users | Measure-Object

# Loop through CSV file and add users.
Foreach ($User in $Users) {

    try 

        {
            # Set user details from Excel file.
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

            # Create new user with the details.
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


            # Creates the user's user profile folder and assigns permissions
            (Get-Date).ToString() + " - "  + "Creating user's DFS profile folder..."
            New-Item -Path $ProfilePath -Name $ProfileFolderName -ItemType "directory"
            $Acl = Get-Acl $FullProfilePath
            $Ar = New-Object `
            System.Security.AccessControl.FileSystemAccessRule ($SAM,"FullControl","ContainerInherit,ObjectInherit","None","Allow")
            $Acl.SetAccessRule($Ar)
            $Acl.SetOwner([System.Security.Principal.NTAccount]$SAM)
            Set-Acl $FullProfilePath $Acl
            (Get-Date).ToString() + " - "  + "DFS Profile created and permissions assigned"

            # Enables the mailbox on Exchange 2013

            Enable-Mailbox -identity $SAM


            # Sets the Office field for the AD object if it's not set to NA

            if ($Office -ne "NA") { 
                Set-ADUser $SAM `
                -Office $Office `
                -Department $Office
                }

            # Sets the Manager field for the AD object if it's not set to NA

            if ($Manager -ne "NA") {
                Set-ADUser $SAM `
                -Manager $Manager
                }

            # Sets the Description field for the AD object if it's not set to NA

                if ($Description -ne "NA") {
                Set-ADUser $SAM `
                -Description $Description -Title $Description
                }

            # Sets the OfficePhone field for the AD object if it's not set to NA

            if ($TeleExtension -ne "NA") {
                Set-ADUser $SAM `
                -OfficePhone $TeleNumber
                }

            # Sets the user's HomePage field for the AD object

            Set-ADUser $SAM -HomePage $HomePage

            # Copies a pre-existenting user's group membership to the new user if this field is
            # not set to NA

            if ($UserToCopy -ne "NA") {

                Get-ADUser -Identity $UserToCopy -Properties memberof |
                Select-Object -ExpandProperty memberof |
                Add-ADGroupMember -Members $SAM -PassThru |
                Select-Object -Property SamAccountName
                }

        }

    catch 

    {
        # Catch any account creation errors
        $ErrorMessage = $_.Exception.Message
        "Failed to create user " + $User.UserFirstName
        "Failed completing the following step: " + $ErrorMessage
    }

    # End of ForEach loop

}

Remove-PSSession $Session
