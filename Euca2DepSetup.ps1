function Start-Logging(){

	## Create Directory
	if (Test-Path $env:temp){
	}else{
	   New-Item -path $env:temp -name log -type directory | Out-Null
	}
	
	## Create Directory based on Date
	$dateformat = get-date -format "yyyy-MM-dd"
	if (Test-Path "$env:temp\log\$dateformat"){
	}else{
	   New-Item -path $env:temp\log -name $dateformat -type directory | Out-Null
	}
	
	## Start Logging
	$hourmin = ""
	$hourmin = get-date -format "yyyy-MM-dd-hhmm"
	Start-Transcript -Path "$env:temp\log\$dateformat\$env:computername-$hourmin-pre.txt"
}

function Stop-Logging(){
	
	Stop-Transcript
}


function testUrl($url){
	try
	{
		$request = [System.Net.WebRequest]::Create($url)
		$request.Method = 'HEAD'
		$response = $request.GetResponse()
		$httpStatus = $response.StatusCode
		$urlIsValid = ($httpStatus -eq 'OK')
		$tryError = $null
		$response.Close()
        return true
	}
	catch [System.Exception] {
		$httpStatus = $null
		$tryError = $_.Exception
		$urlIsValid = $false;
	}
    return false
}


function downloadAndInstall($downloadUrl,$targetDir){
   if(tryUrl($downloadUrl){
      $installer_dest = "$env:temp\"+$download_url.Split('/')[-1]   
      try{
             # Download file using the .NET WebClient object
             $webclient = New-Object System.Net.WebClient
             $webclient.DownloadFile($download_url, $installer_dest)
             
             # Execute the silent installer
             Invoke-Expression "msiexec /i $installer_dest /qn $installer_dest/pythonsetup.log "
             # Remove the original installation file from the file system
             Remove-Item $installer_dest -recurse
      }  
      catch [System.Exception] {
            write
	 }
   
   }

}


function setupDependencyTool{
    http://downloads.sourceforge.net/project/sevenzip/7-Zip/9.20/7z920.exe
    
    http://downloads.sourceforge.net/project/sevenzip/7-Zip/9.20/7z920-x64.msi
}

function installPython{
    $download_url = "http://www.python.org/ftp/python/2.7.2/python-2.7.2.msi"
    # Extract the name of the installer from the URL
    $installer_dest = "$env:temp\"+$download_url.Split('/')[-1]

    # Download file using the .NET WebClient object
    $webclient = New-Object System.Net.WebClient
    $webclient.DownloadFile($download_url, $installer_dest)

    # Execute the silent installer
    Invoke-Expression "msiexec /i $installer_dest /qn $installer_dest/pythonsetup.log "

    # Remove the original installation file from the file system
    Remove-Item $installer_dest -recurse
    
}

function isPythonInstalled{


}

function installPutty{
    $download_url = "http://the.earth.li/~sgtatham/putty/latest/x86/putty-0.61-installer.exe"
    # Extract the name of the installer from the URL
    $installer_dest = "$env:temp\"+$download_url.Split('/')[-1]

    # Download file using the .NET WebClient object
    $webclient = New-Object System.Net.WebClient
    $webclient.DownloadFile($download_url, $installer_dest)

    # Execute the silent installer
    Invoke-Expression "msiexec /i $installer_dest /qn /l*v $installer_dest/puttysetup.log "

    # Remove the original installation file from the file system
    Remove-Item $installer_dest -recurse

}

function isPuttyInstalled{


}

function installBoto{
    $download_url = "http://eucalyptussoftware.com/downloads/releases/euca2ools-1.3.1-src-deps.tar.gz"
    # Extract the name of the installer from the URL
    $installer_dest = "$env:temp\"+$download_url.Split('/')[-1]

    # Download file using the .NET WebClient object
    $webclient = New-Object System.Net.WebClient
    $webclient.DownloadFile($download_url, $installer_dest)

    # Uncompress and Untar the archive
    
    # Execute the silent installer
    Invoke-Expression "msiexec /i $installer_dest /qn /l*v $installer_dest/puttysetup.log "

    # Remove the original installation file from the file system
    Remove-Item $installer_dest -recurse

}

function installOpenssl{

}

function isOpensslInstalled{


}

function installM2Crypto{



}

function isM2CryptoInstalled{


}

function installEuca2ool{
    $download_url = "http://the.earth.li/~sgtatham/putty/latest/x86/putty-0.61-installer.exe"
    # Extract the name of the installer from the URL
    $installer_dest = "$env:temp\"+$download_url.Split('/')[-1]

    # Download file using the .NET WebClient object
    $webclient = New-Object System.Net.WebClient
    $webclient.DownloadFile($download_url, $installer_dest)

    # Execute the silent installer
    Invoke-Expression "msiexec /i $installer_dest /qn /l*v $installer_dest/puttysetup.log "

    # Remove the original installation file from the file system
    Remove-Item $installer_dest -recurse

}

function isEuca2oolInstalled{


}


#REGION 


#ENDREGION