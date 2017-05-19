# Powershell_Intro_Training

OVERVIEW:
This repository contains the contents and source material for my self-made "Introduction to PowerShell" course.

SUMMARY:
The word document is intended as a speaking guide for the presenter; it is to be used as an outline for the speaker to ensure that
essential points are covered.

The PowerPoint presentation to intended to be presented to the class. However, whenever I've run through the course myself
i find that i only really use the presentation up to side 5.

All of the PS1 files under the "examples" folder are to be used whilst teaching the course. These PS1 files offer
a practical example to students of the concepts being covered by the course. Importantly, the functional "9Standard-Good"
script at the end may be used as a working example. It is basic - so does not cover functions or self-made modules etc - but
is a useful starting point for students. Whenever I have run through the course I have always presented this script to the class
and asked them to talk me through it line by line.

KEYNOTES:
The $INSTALL_DIRECTORY variable is used in several scripts to determine where the contents of this course have
been downloaded to. Please amend this variable otherwise examples which including reading and writing data to files
will not work.

All content in this course is self made. The only content in this course not made by me is the cheat sheet under "Documentation/PowerShell Cheat SheetV2.00.pdf"


GUIDE:
Print off the cheat sheet under the "Documentation" folder and provide this to students before beginning the course.

Begin the course by running through the PowerPoint, up to slide 5, with the class. 
Once the aims and background sections have been covered then open all of the PS1 files and continue the course in ISE.

Set the value of the $INSTALL_DIRECTORY variable to the base path of where you have downloaded all of the source material.

1) Background

Covers the following:

- ExecutionPolicy
- Get-Help cmdlets
- -whatif
- Example GUI using .NET methods
- Example com application (Excel) invocation
- Basic naming structure: Get, New, Add, Set, Remove

2) Primitive Data Types

Covers the following data types:

- Booleans
- Strings
- Integers

3) Idioms

THIS IS NOT YET COMPLETE AND SO FAR I HAVE NOT HAD THE REQUIRED TIME TO EVEN SCOPE THIS OUT

4) Comparison Operators

Covers the following comparison operators:

- Greater Than (gt)
- Less Than (lt)
- Like 
- Equals (eq)

- Examples are given for both singular and array comparisons.


5) Variables

Covers the following:

- How to assign a variable
- How to get variables
- How to manipulate variables
- How to clear and remove variables without deleting the name space
- Local and global variable scopes

6) Control Structures

Covers the following control structures:

- ElseIf
- While
- Foreach

PLEASE NOTE: This is usual the part of the course where students have the most questions. Examples are included in order
to provide working good (and bad) examples of control structures. These examples use basic data as the goal here is to understand
the conceptual logic behind control structures, rather than practicing manipulating large amounts of data.

7) Functions

This section only covers extremely basic variables. The decision to not include complex functions was taken as this
was deemed too advanced for a beginners course. For clarification, an advanced function in this context includes the following:

- Params
- Verbose
- Help files
- Param validation
- Param aliases
- Workflows
- Custom objects

So, for example:

```
function Get-CompDisk
{
    <#
    .Synopsis
    This Command gets disk info from computers.
    .DESCRIPTION
    This does many cool things
    .PARAMETER ComputerNames
    The name(s) of the computer(s) to look at.
    .EXAMPLE
    Get-CompDisk -ComputerNames LON-CL1,LON-DC1
    This example gets disk info for computers LON-CL1 and LON-DC1
    .EXAMPLE
    Get-CompDisk -HostName LON-CL1,LON-DC1
    This example also gets disk info for computers LON-CL1 and LON-DC1 using an alias for the ComputerNames parameter.
    #>
[cmdletBinding(SupportsShouldProcess=$true,ConfirmImpact='medium')]
param 
(
[parameter(Mandatory=$True,
HelpMessage="Provide a computer to scan",
ValueFromPipeline=$true)]
[ValidatePattern('LON-\w{2,3}\d{1,2}')]
[Alias("HostName")][string[]]$ComputerNames 
　
)
Begin 
    {
　
    }
　
Process {
    Foreach ($ComputerName in $ComputerNames) {

        if ($PSCmdlet.ShouldProcess($ComputerName)) {

            # Write Verbose
            Write-Verbose "Now disk info from $ComputerName "
            # Gather drive info
            $Drives = Get-CimInstance -ClassName Win32_LogicalDisk -ComputerName $ComputerName | where {$_.DriveType -eq "3"}
            # Loop through all drives on the machine
            Foreach ($Drive in $Drives) {
                # Assign various properties to a hash table
                $Properties = [Ordered]@{'ComputerName'=$ComputerName;
                'DriveLetter'=$Drive.DeviceID;
                'FreeSpace MB'=[Math]::Round(($Drive.FreeSpace / 1MB),2);
                'Size MB'=[Math]::Round(($Drive.Size / 1MB),2)

                }
            # Create a custom object using the hash table as the properties
            $DiskObject = New-Object -TypeName PSObject -Property $Properties
            # Write Output
            Write-Output $DiskObject
        } # END OF FOREACH DRIVE IN DRIVES
    } # END OF IF
    } # END OF FOREACH COMPUTER
    } # END OF PROCESS
    End 
    {
　
　
    } # END OF END
} # END OF FUNCTION
```


8) APIs

Covers the following:

- Connecting to Office 365 (Exchange).
- Example data gathering exercises in Office 365
- Disconnected from PSSessions
- Connect to Azure AD
- Example data gathering exercises in Azure AD


9) Standard-Bad

This PS1 file is merely to show a bad example of using PowerShell. The code may be perfectly functionality but it 
is extremely difficult to read for a human eye.

9) Standard-Good

This PS1 file is used to show a good example of using PowerShell. The code is both functionality and has an easy to read
layout. Directly comparisons should be drawn between the good and bad examples, with emphasis placed on whitespace and 
comments. These are, after all, for our own benefit! 

CLOSING NOTES:

A lot of effort was put into producing this course. You're free to use the material for your own means, but please credit 
the source. 

I plan on making more advanced courses. Covering things such as module creation, advanced functions, desired state configuration,
encrypted credential caching etc. It's just finding the time!

If you have any course ideas, or feedback regarding this course, please email me directly at bclark@sudoblark.com.

Happy automating!
