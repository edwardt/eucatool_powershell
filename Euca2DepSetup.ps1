function get-webFile {
  param( 
     [string] $url,
     [string] $fileName = $null,
     [switch]$Passthru,
     [switch]$quiet
   )
   
   $req = [System.Net.HttpWebRequest]::Create($url);
   $res = $req.GetResponse();
 
   if($fileName -and !(Split-Path $fileName)) {
      $fileName = Join-Path (Get-Location -PSProvider "FileSystem") $fileName
   } 
   elseif((!$Passthru -and ($fileName -eq $null)) -or (($fileName -ne $null) -and (Test-Path -PathType "Container" $fileName)))
   {
      [string]$fileName = ([regex]'(?i)filename=(.*)$').Match( $res.Headers["Content-Disposition"] ).Groups[1].Value
      $fileName = $fileName.trim("\/""'")
      if(!$fileName) {
         $fileName = $res.ResponseUri.Segments[-1]
         $fileName = $fileName.trim("\/")
         if(!$fileName) { 
            $fileName = Read-Host "Please provide a file name"
         }
         $fileName = $fileName.trim("\/")
         if(!([IO.FileInfo]$fileName).Extension) {
            $fileName = $fileName + "." + $res.ContentType.Split(";")[0].Split("/")[1]
         }
      }
      $fileName = Join-Path (Get-Location -PSProvider "FileSystem") $fileName
   }
   if($Passthru) {
      $encoding = [System.Text.Encoding]::GetEncoding( $res.CharacterSet )
      [string]$output = ""
   }
 
   if($res.StatusCode -eq 200) {
      [int]$goal = $res.ContentLength
      $reader = $res.GetResponseStream()
      if($fileName) {
         $writer = new-object System.IO.FileStream $fileName, "Create"
      }
      [byte[]]$buffer = new-object byte[] 4096
      [int]$total = [int]$count = 0
      do
      {
         $count = $reader.Read($buffer, 0, $buffer.Length);
         if($fileName) {
            $writer.Write($buffer, 0, $count);
         } 
         if($Passthru){
            $output += $encoding.GetString($buffer,0,$count)
         } elseif(!$quiet) {
            $total += $count
            if($goal -gt 0) {
               Write-Progress "Downloading $url" "Saving $total of $goal" -id 0 -percentComplete (($total/$goal)*100)
            } else {
               Write-Progress "Downloading $url" "Saving $total bytes..." -id 0
            }
         }
      } while ($count -gt 0)
      
      $reader.Close()
      if($fileName) {
         $writer.Flush()
         $writer.Close()
      }
      if($Passthru){
         $output
      }
   }
   $res.Close(); 
   if($fileName) {
      ls $fileName
   }
}



function Start-Logging(){

	## Create Directory
	if (Test-Path $env:temp){
	}else{
	   New-Item -path $env:temp -name log -type directory | Out-Null
	}
	
	## Create Directory based on Date
	$dateformat = get-date -format "yyyy-MM-dd"
	if (Test-Path "$env:temp\log\$dateformat"){
		Write-Verbose "Logging to $env:temp\log\$dateformat"
	}
	else{
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
		Write-Host "Url $url is valid"
        return $true
	}
	catch [System.Exception] {
		$httpStatus = $null
        write-host "There is unexpected error: "  
        write-host $_.Exception.ToString()  
	}
    return $false
}

function downloadApp($downloadUrl, $fileName, $installDest){
     try {
           # Download file using the .NET WebClient object
           #$webclient = New-Object System.Net.WebClient
           #$webclient.DownloadFile($downloadUrl, $installDest)
		   Get-WebFile ($downloadUrl,$fileName)
     }
     catch [System.Web.HttpException] {
            write-host "There is error downloading from $downloadUrl with trace: " 
            write-host $_.Exception.ToString()       
     }
     catch [System.Exception] {
            write-host "There is unexpected error: "  
            write-host $_.Exception.ToString()  
	 }
}
function downloadAndInstall{
    param( 
     [string] $downloadUrl = $null,
     [string] $saveAsFileName = $null
    )
	&downloadAndInstall($downloadUrl, $saveAsFileName, $true)
}

function downloadAndInstall{
	param( 
     [string] $downloadUrl = $null,
     [string] $saveAsFileName = $null,
	 [switch] $dontInstall = $false
    )
   #if( tryUrl($downloadUrl) ) 
   if( $downloadUrl -ne $null -and ($saveAsFileName -ne $null) )
   {
      #$installerDest = "$env:temp\"+$downloadUrl.Split('/')[-1]   
	  $installDest = Join-Path (Get-Location -PSProvider "FileSystem") $fileName
	  $passthru = $true
	  $notShowProgress = $false
	  $installlog = $installDest + ".log"

      try{
             #downloadApp($downloadUrl)
			 Get-WebFile $downloadUrl $saveAsFileName $passthru $notShowProgress
             # Execute the silent installer
			 if ($dontInstall) {
             	Invoke-Expression "msiexec /i $installerDest /l*v $installlog "
             	# Remove the original installation file from the file system
             	Remove-Item $installerDest -recurse
			 }
      }  
      catch [System.Exception] {
            write-host "There is unexpected error: "  
            write-host $_.Exception.ToString()  
	  }
   
    }
}




function installZipTool{
    $downloadUrl = "http://downloads.sourceforge.net/project/sevenzip/7-Zip/9.20/"
	$saveAsfileName = "7z920.exe"
    downloadAndInstall($downloadUrl,$saveAsfileName)
    #http://downloads.sourceforge.net/project/sevenzip/7-Zip/9.20/7z920-x64.msi
}

function installPython{
    $downloadUrl = "http://www.python.org/ftp/python/2.7.2/"
	$saveAsfileName = "python-2.7.2.msi"
    downloadAndInstall ($downloadUrl, $saveAsfileName)
}


function installPutty{
    $downloadUrl = "http://the.earth.li/~sgtatham/putty/latest/x86/"
    $saveAsFileName = "putty-0.61-installer.exe"
	downloadAndInstall($download_url)
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
installZipTool
installPython

#ENDREGION