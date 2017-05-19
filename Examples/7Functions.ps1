##### Functions #############################################

# syntax
#function <name> {
#stuff
#}


# example 1
function Hidden {

Get-ChildItem C:\Windows -Attributes hidden

}

# example 2
function AllJPGItems {

dir C:\ | Get-ChildItem  -Recurse| Where-Object {$_.Extension -eq  ".jpg"}

}

# example 3 with parameters

function HelloWorld([string]$Name) {

$Msg = "Hello " + $Name

Write-Host $Msg

}

$UserName = whoami


##### END OF Functions ######################################