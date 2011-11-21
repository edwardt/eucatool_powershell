function checkIfInstalled{



}


function checkPuttyInstalled{


}

function checkOpenSSLInstalled{


}


function checkEuca2oolInstalled{


}

function checkPythonInstalled{
$download_url = "http://www.python.org/ftp/python/2.7.2/python-2.7.2.msi"
# Set up the download URL for python

# Extract the name of the installer from the URL
$installer_dest = "$env:temp\"+$download_url.Split('/')[-1]

# Download file using the .NET WebClient object
$webclient = New-Object System.Net.WebClient
$webclient.DownloadFile($download_url, $installer_dest)

# Execute the silent installer
Invoke-Expression "msiexec /i /qn $installer_dest"


# Remove the original installation file from the file system
Remove-Item $installer_dest -recurse
    
}

function is32bit{
    if ($env:PROCESSOR_IDENTIFIER.Contains("Intel64"))
    { 
        if ($env:ProgramW6432 -neq "" ){
            return false
        }
        else{
            return true
        }
    }
    return true
}

function setEnvironmentVar{
    
 [Environment]::SetEnvironmentVariable( "INCLUDE", $env:INCLUDE, [System.EnvironmentVariableTarget]::User 

}