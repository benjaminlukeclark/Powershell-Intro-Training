##### APIs #####################################################

###### OFFICE 365 (EXCHANGE) ##################################

##### How to connect #################

$UserCredOfficeExchange = Get-Credential

$SessionOfficeExchange = New-PSSession -ConfigurationName Microsoft.Exchange `
-ConnectionUri https://outlook.office365.com/powershell/liveid/ -Credential $UserCredOfficeExchange -Authentication Basic -AllowRedirection

Import-PSSession $SessionOfficeExchange


######################################

##### What can you do? ###############
$INSTALL_DIRECTORY = "CURRENT DIRECTORY PATH"
$MailboxFileLocation = $INSTALL_DIRECTORY + "\Examples\New Files\Mailboxes.txt"

$MailboxHeaders = "PrimarySMTP,DisplayName,RecipientType"

New-Item -Path $MailboxFileLocation -ItemType file

Add-Content -Path $MailboxFileLocation -Value $MailboxHeaders

$Mailboxes = Get-Mailbox

Foreach ($Mailbox in $Mailboxes) {

    $MailboxEmail = $Mailbox.PrimarySmtpAddress
    $MailboxDisplayName = $Mailbox.DisplayName
    $MailboxRecipientType = $Mailbox.RecipientType
    $MailboxContent = $MailboxEmail + "," + $MailboxDisplayName + "," + $MailboxRecipientType

Add-Content -Path $MailboxFileLocation -Value $MailboxContent

}


##### End of what can you do ##########

#######################################

##### How to disconnect ################

Remove-PSSession

# OR

Remove-PSSession $SessionOfficeExchange

# TO REMOVE ALL

Get-PSSession | Remove-PSSession


#########################################

###### END OF OFFICE 365 (EXCHANGE) ############################

################################################################

##### AZURE AD ########################################

##### How to connect #################

$UserCredMsol = Get-Credential

Connect-MsolService -Credential $UserCredMsol


#######################################

##### What can you do? ################

$LicensedMsolUsersLocation = $INSTALL_DIRECTORY + "\Examples\New Files\LicensedMsolUsers.txt"

$LicensedMsolUsersHeaders = "PrimarySMTP,DisplayName,"

New-Item -Path $LicensedMsolUsersLocation -ItemType file

Add-Content -Path $LicensedMsolUsersLocation -Value $LicensedMsolUsersHeaders


$LicensedMsolUsers = Get-MsolUser -All | Where-Object { $_.isLicensed -eq "TRUE" } 

Foreach ($LicensedMsolUser in $LicensedMsolUsers) {

    $LicensedMsolUserFirstName = $LicensedMsolUser.FirstName
    $LicensedMsolUserLastName = $LicensedMsolUser.LastName
    $LicensedMsolUserUPN = $LicensedMsolUser.UserPrincipalName
    $LicensedMsolUserLicense = (Get-MsolUser -UserPrincipalName $LicensedMsolUser.UserPrincipalName | Select-Object -ExpandProperty Licenses).AccountSkuId
    $LicensedMsolUserContent = $LicensedMsolUserFirstName + "," + $LicensedMsolUserLastName + "," + $LicensedMsolUserUPN + "," + $LicensedMsolUserLicense

    Add-Content -Path $LicensedMsolUsersLocation -Value $LicensedMsolUserContent

}

##### End of what can you do #############

#########################################

##### How to disconnect ################

Remove-PSSession

# OR

Remove-PSSession $SessionOfficeExchange

# TO REMOVE ALL

Get-PSSession | Remove-PSSession


#########################################

###### END OF AZURE AD #############################

##############################################################

##### END OF APIs ###########################################
