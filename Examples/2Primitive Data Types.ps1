### Primitive Data Types ###

### Types we'll cover: ###
###
### boolean 
### string
### int
### long


##### BOOLEAN ##############################################

# $TRUE = 1, and usually any non-zero interger 
# $FALSE = 0

# TRUE
2 -eq 2

# FALSE
2 -eq 3

# TRUE VARIABLE
$TrueBoolean = 2 -eq 2
Write-Host $TrueBoolean

# TRUE INT
[int]$TrueInt = $TrueBoolean
Write-Host $TrueInt

[boolean]$TrueNum = 1
Write-Host $TrueNum

# FALSE VARIABLE
$FalseBoolean = 2 -eq 3
Write-Host $FalseBoolean

[boolean]$FalseNum = 0
Write-Host $FalseNum

# FALSE INT
[int]$FalseInt = $FalseBoolean
Write-Host $FalseInt


##### END OF BOOLEAN ##############################################

##### START OF STRING #############################################

$Blink = "This is my Timey-Wimey detector. Goes ding when there's stuff."
Write-Host $Blink

[string]$MeaningOfLife = 42
write-host $MeaningOfLife

##### END OF STRING ################################################

##### START OF INTERGER ############################################

[int]$Int1 = 3
Write-Host $Int1

[int]$Int2 = 5
Write-Host $Int2

$Int1 * $Int2


#####################################################################
