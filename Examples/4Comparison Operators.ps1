##### COMPARISON OPERATORS ################################################

# syntax
# <input> <operator> <value>

# When the input to the operator is singular it returns a Boolean value
# When the input to the operator is a collection, the operator returns any matching values.
# If there are no matches in a collection the operator returns nothing.


## Gt ###########################################################

# True
8 -gt 2

# Returns True value in the collection
1,2,3,4,5 -gt 4

# Counts True values in the collection
$Collection1 = 1,2,3,4,5 -gt 4
$Collection1.Count

# False
2 -gt 3

# Returns nothing as there are no true values
2,3,4 -gt 5

## END OF Gt #####################################################

## Lt ############################################################

# True
2 -lt 3

# Returns True value in the collection
1,2,3,4,5 -lt 3

# False
2 -lt 1

# Returns nothing as there are no true values
2,3,4,5 -lt 1

## END OF Lt ######################################################


## Like ############################################################

# True
"Agent Smith: Never send a human to do a machine's job" -like "*job"

# Returns true value in the collection
"Welcome to the Black Parade", "I don't love you", "Na Na Na" -like "*na"

# False
"I don't want to set the world on fire..." -like "*The Ink Spots"

# Returns nothing as there are no true values
"Sam Wise Baggins", "Beer Smasher", "Ed Sheran" -like "*Smithers"

## END OF like #######################################################

##### Equality Operators #############################################

# syntax
# <input> <operator> <value>

# Returns a value of TRUE when the input operator is singular
# Returns matches when one of more of the input values in a collection is identical to the specified pattern
# If there are no matches in a collection then the operator returns nothing

#######################################################################

## Eq #################################################################

# True
42 -eq 42
"Captain Adama" -eq "Captain Adama"

# Returns true value in the collection
10,42,64 -eq 10
"Cylon","Galactica","Apollo" -eq "Apollo"

# False
100 -eq 50
"Cylon" -eq "Human"

# Returns nothing as there are no true values in the collection
69,21,35 -eq 18
"Apollo","Cylons","Starbuck","Laura Roslin" -eq "Husker"

######################################################################

