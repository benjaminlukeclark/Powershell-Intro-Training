##### VARIABLES #############################################

##### How to assign a variable ##############################

$AssignedVar = "Dionysus"

"Steve" | New-variable -Name SteveVar

## How to set a variable

Set-Variable -Name SteveVar -Value "Bob"

$SteveVar = "David"

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

## typecast

[string]$IntExampleAsString = 10






