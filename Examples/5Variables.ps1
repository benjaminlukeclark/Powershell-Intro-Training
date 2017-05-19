##### VARIABLES #############################################

##### How to assign a variable ##############################

$AssignedVar = "Dionysus"

##### End of how to assign a variable #######################

# Example number varaible 1
$NumVariable1 = 3
Write-Host $NumVariable1

# Example number variable 2
$NumVariable2 = 10
Write-Host $NumVariable2

# Example of using variables
$NumVariable1 * $NumVariable2 # Just like Excel! A1*B1

$Var5 = $NumVariable1 * $NumVariable2 #Just like Excel! =sum(A1*B1)

# Example of getting variables
Get-Variable * 

# How to clear and remove a variable
Clear-Variable "NumVariable1"
Remove-Variable "NumVariable1"

Write-Host $NumVariable1


##### End of how to assign a variable ########################


##### Variables scopes #######################################

$Services = Get-Service *
$Services


foreach ($Service in $Services) {

$Name = $Service.Name
$Status = $Service.Status
$SrvMsg = $Name + " is " + $Status

Write-Host $SrvMsg


}


##### End of Variable Scopes ##################################
