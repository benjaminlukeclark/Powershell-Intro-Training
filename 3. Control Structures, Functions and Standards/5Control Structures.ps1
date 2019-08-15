##### Control Structures #####################################################


##### IMPORTANT!!!!! ########################################################

##### If #####################################################################

$Doctor10 = "David Tennant"
$Doctor11 = "Matt Smith"

# Example of an If statement
If ($Doctor10 -eq "David Tennant") {

Write-Host "The Doctor: [disappointed] Aw, I wanted to be ginger!"

}



# Example of an elseif statement
If ($Doctor11 -eq "David Tennant") {

Write-Host "The Doctor: [disappointed] Aw, I wanted to be ginger!"

} 
else {

write-host "Apple's rubbish. I hate apples."


}


##### END OF If ################################################################

##### While ####################################################################


# sets a variable to be used for later
$1 = 1


# example of a while statement which ends
while ( $1 -lt 5 ) {

Write-Host $1
$1++


}


# example of a bad while statement
while (1 -eq 1) {


Write-Host "Hey. Who turned off the lights?"

}

##### End of while ##############################################################

##### Foreach ###################################################################

$Array = 1,2,3,4,5

Foreach ($Object in $Array) {

Write-Host $Object

}

$Processes = Get-Process

foreach ($Process in $Processes) {

$Name = $Process.Name
$Company = $Process.Company

$OutputMsg = $Name + " , " + $Company

Write-Host $OutputMsg


}


##### END OF Foreach ############################################################


