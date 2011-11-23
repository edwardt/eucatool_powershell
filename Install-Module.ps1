function Install-Module {
[CmdletBinding()]
Param(
    [Parameter(ValueFromPipeline=$true,ValueFromPipelineByPropertyName=$true,Mandatory=$true)]
    [Alias("PSPath")]
    [String]$ModuleFilePath
,   [Switch]$Global
)
    ## Get the Full Path of the module file
    $ModuleFilePath = Resolve-Path $ModuleFilePath
    
    ## Deduce the Module Name from the file name
    $ModuleName = (ls $ModuleFilePath).BaseName
    
    ## Note: This assumes that your PSModulePath is unaltered
    ## Or at least, that it has the LOCAL path first and GLOBAL path second
    $PSModulePath = $Env:PSModulePath -split ";" | Select -Index ([int][bool]$Global)

    ## Make a folder for the module
    $ModuleFolder = MkDir $PSModulePath\$ModuleName -EA 0 -EV FailMkDir
    ## Handle the error if they asked for -Global and don't have permissions
    if($FailMkDir -and @($FailMkDir)[0].CategoryInfo.Category -eq "PermissionDenied") {
        if($Global) {
            throw "You must be elevated to install a global module."
        } else { throw @($FailMkDir)[0] }
    }

    ## Move the script module (and make sure it ends in .psm1)
    Move-Item $ModuleFilePath $ModuleFolder

    ## Output A ModuleInfo object
    Get-Module $ModuleName -List
<#
.Synopsis
    Installs a single-file (psm1 or dll) module to the ModulePath
.Description 
    Supports installing modules for the current user or all users (if elevated)
.Parameter ModuleFilePath
    The path to the module file to be installed
.Parameter Global
    If set, attempts to install the module to the all users location in Windows\System32...
.Example
    Install-Module .\Authenticode.psm1 -Global

    Description
    -----------
    Installs the Authenticode module to the System32\WindowsPowerShell\v1.0\Modules for all users to use.
.Example
    

    Description
    -----------
    Uses Get-PoshCode (from the PoshCode module) to download the Impersonation module and then fixes it's file name, and finally installs the Impersonation module for the current user.
#>
}