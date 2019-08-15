### BACKGROUND ###

### Scripting language ######################################################
### example = new user scripts
### real world execution is the new user scripts and CommVault monitors


### Examples to get people excited

# Query a database of cat facts then read them out using a speech synthesizer
function CatFactsGalore{

    Add-Type -AssemblyName System.Speech
    $SpeechSynth = New-Object System.Speech.Synthesis.SpeechSynthesizer
    $Random = Get-Random -Maximum 200
    $CatFact = (ConvertFrom-Json (Invoke-WebRequest -Uri http://www.catfact.info/api/v1/facts.json?per_page=200)).Facts[$Random]
    $SpeechSynth.Speak("did you know?")
    $SpeechSynth.Speak($CatFact.details)
} 

CatFactsGalore


# ASCI rickroll

iex (New-Object Net.WebClient).DownloadString("http://bit.ly/e0Mw9w")


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

##############

# JIT compliation rather than static


###########

### START BASED ON .NET ############################################################
# Explain common language runtime by speaking in German then using the example of a translator
# Means you can directly manipulate and use .NET libraries

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
# .NET also means you can manipulate other objects based on it like .COM objects (e.g. Excel)

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

## Above are most common starts for cmdlets
## explain what each one will do/does

# Get gets things
# New makes new things
# Add adds something to an existing object
# Set overwrites something in an object
# Remove removes an object


## explain that powershell is object-orientated but not in the same way as c# for example
## explain the pipe and how it lets you pass things through