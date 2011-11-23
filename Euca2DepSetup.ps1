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


function tryUrl($url){
	try
	{
		$request = [System.Net.WebRequest]::Create($url)
		$request.Method = 'HEAD'
		$response = $request.GetResponse()
		$httpStatus = $response.StatusCode
		$urlIsValid = ($httpStatus -eq 'OK')
		$response.Close()
        return true
	}
	catch [System.Exception] {
		$httpStatus = $null
        write-host "There is unexpected error: "  
        write-host $_.Exception.ToString()  
	}
    return false
}

function downloadApp($downloadUrl,$installDest){
     try {
           # Download file using the .NET WebClient object
           $webclient = New-Object System.Net.WebClient
           $webclient.DownloadFile($downloadUrl, $installDest)
     }
     catch [System.Web.Exception] {
            write-host "There is error downloading from $downloadUrl with trace: " 
            write-host $_.Exception.ToString()       
     }
     catch [System.Exception] {
            write-host "There is unexpected error: "  
            write-host $_.Exception.ToString()  
	 }
}

function downloadAndInstall($downloadUrl) {
   if( tryUrl($downloadUrl) ) 
   {
      $installerDest = "$env:temp\"+$downloadUrl.Split('/')[-1]   
      $logName = $downloadUrl.Split('/')[-1] 
      try{
             downloadApp($downloadUrl)
             # Execute the silent installer
             Invoke-Expression "msiexec /i $installerDest /qn $installerDest/$logName "
             # Remove the original installation file from the file system
             Remove-Item $installerDest -recurse
      }  
      catch [System.Web.Exception] {
            write-host "There is error downloading from $downloadurl with trace: " 
            write-host $_.Exception.ToString() 
      
      }
      catch [System.Exception] {
            write-host "There is unexpected error: "  
            write-host $_.Exception.ToString()  
	  }
   
    }
}


function setupDependencyTool{
    $download_url = "http://downloads.sourceforge.net/project/sevenzip/7-Zip/9.20/7z920.exe"
    downloadAndInstall($download_url)
    #http://downloads.sourceforge.net/project/sevenzip/7-Zip/9.20/7z920-x64.msi
}

function installPython{
    $download_url = "http://www.python.org/ftp/python/2.7.2/python-2.7.2.msi"
    downloadAndInstall($download_url)
}

function isPythonInstalled{
    

}

function installPutty{
    $download_url = "http://the.earth.li/~sgtatham/putty/latest/x86/putty-0.61-installer.exe"
    downloadAndInstall($download_url)
}

function isPuttyInstalled{


}

function installBoto{
    $download_url = "http://eucalyptussoftware.com/downloads/releases/euca2ools-1.3.1-src-deps.tar.gz"
    download($download_url)
    # Extract the name of the installer from the URL
    $installer_dest = "$env:temp\"+$download_url.Split('/')[-1]
    download($download_url,$installer_dest)
    Invole-Expression ""
    
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