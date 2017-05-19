### BACKGROUND ###

### Scripting language ######################################################
### example = new user scripts
### real world execution is the new user scripts


##############################################################################

##### Execution Runtime Policy ###############################################

Set-ExecutionPolicy -ExecutionPolicy Unrestricted

##############################################################################

##### Get-Help ###############################################################

Get-Help *

Get-Help Add-Content 

Get-Help Add-Content -Examples

##############################################################################

##### WhatIf #################################################################

Add-Content -Path "C:\Sudoblark\Hello.txt" -Value "Boo" -WhatIf

Stop-Process -Name SystemTrayApp -WhatIf

Write-Host "Hello"

###############################################################################

### START BASED ON .NET ############################################################


# Create a GUI ############################################################################################

### global variables ####
$INSTALL_DIRECTORY = "CURRENT DIRECTORY PATH"
$BackgroundImagePath = $INSTALL_DIRECTORY + "Examples\Source Files\GROOT.jpg"

# Import Assemblies 
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing")
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")


# Create a new form object and assign it to the variable GUIExample
$GUIExample = New-Object System.Windows.Forms.Form

# Define the background image and then set the form to be the same height/width as the image
$BackgroundImage = [System.Drawing.Image]::FromFile($BackgroundImagePath)
$GUIExample.BackgroundImage = $BackgroundImage
$GUIExample.Width = $BackgroundImage.Width
$GUIExample.Height = $BackgroundImage.Height

# Make the GUI the topmost window and give it focus (make it the selected window)
$GUIExample.TopMost = $True
$GUIExample.Add_Shown({$GUIExample.Activate()})

# Show the GUI
[void]$GUIExample.ShowDialog()

# End of GUI ############################################################################################

##### Invoke Excel ######################################################################################


$excel = New-Object -ComObject Excel.Application
$excel.Visible = $true
$workbook = $excel.Workbooks.Add()
$sheet = $workbook.ActiveSheet
$Sheet.Cells.Item(1,1) = "I"
$Sheet.Cells.Item(1,2) = "AM"
$Sheet.Cells.Item(1,3) = "GROOT"

##### end of invoke Excel ###############################################################################


#### END OF BASED ON .NET ################################################################################


##### START OF NAMING STRUCTURE AND ADD-CONTENT ##########################################################

$ItemPath = $INSTALL_DIRECTORY + "Examples\New Files\Robot Wars.txt"

Get-Service

Get-Service | fl

Get-Service | fl -GroupBy Name

New-Item -Path $ItemPath -ItemType file

Add-Content -Path $ItemPath -Value "Sgt. Bash is the best house robot because... fire."

Set-Content -Path $ItemPath -Value "Sir Kill-A-Lot is the best house robot because of reasons."

Remove-Item -Path $ItemPath

##### END OF NAMING STRUCTURE ############################################################################