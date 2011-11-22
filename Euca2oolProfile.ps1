########### Euca2ools powershell wrapper ##############

updateExecutionPolicy


if($env:EUCA_HOME){
$EUCA_HOME = $env:EUCA_HOME #Get-item -path env:EUCA_HOME
}else{
write-warning "EUCA_HOME variable is not set"
$EUCA_HOME = "C:\Eucalyptus"
}

write-warning "EUCA_HOME is set to $EUCA_HOME"

$EUCA_RC="$EUCA_HOME\\eucarc"

[string]$ec2url=""
[string]$access_key=""
[string]$secret_key=""
[string]$walrusurl=""
[string]$ec2privatekey=""
[string]$ec2cert=""
[string]$eucalyptuscert=""
[string]$ec2userid=""
setEnvVariableFromNovaRC

setEnvironmentVariable(env:EC2_URL,"$ec2url")
setEnvironmentVariable(env:EC2_ACCESS_KEYL,"$$access_key")
setEnvironmentVariable(env:EC2_SECRET_KEY,"$secret_key")
setEnvironmentVariable(env:WALRUS_URL,"$walrusurl")
setEnvironmentVariable(env:S3_URL,"$walrusurl")

#Set-Item -path env:EC2_URL -value "$ec2url"
#Set-Item -path env:EC2_ACCESS_KEY -value "$access_key"
#Set-Item -path env:EC2_SECRET_KEY -value "$secret_key"
#Set-Item -path env:WALRUS_URL -value "$walrusurl"
#Set-Item -path env:S3_URL -value "$walrusurl"

if($ec2cert -ne ""){
Set-Item -path env:EC2_CERT -value "$ec2cert";
}
if($ec2privatekey -ne ""){
Set-Item -path env:EC2_PRIVATE_KEY -value "$ec2privatekey";
}
if($eucalyptuscert -ne ""){
Set-Item -path env:EUCALYPTUS_CERT -value "$eucalyptuscert";
}
if($ec2userid -ne ""){
Set-Item -path env:EC2_USER_ID -value "$ec2userid";
}

#write-output "$env:EC2_URL"
#write-output "$env:EC2_ACCESS_KEY"
#write-output "$env:EC2_SECRET_KEY"
#write-output "$env:WALRUS_URL"

function euca-add-group{
    euca_wrapper("euca-add-group")
}

function euca-add-keypair{
    euca_wrapper("euca-add-keypair")
}

function euca-allocate-address{
    euca_wrapper("euca-allocate-address")
}

function euca-associate-address{
    euca_wrapper("euca-associate-address")
}

function euca-attach-volume{
    euca_wrapper("euca-attach-volume")
}

function euca-authorize{
    write-output "$args"
    euca_wrapper("euca-authorize")
}

function euca-bundle-image{
    euca_wrapper("euca-bundle-image")
}

function euca-bundle-instance{
    euca_wrapper("euca-bundle-instance")
}

function euca-bundle-upload{
    euca_wrapper("euca-bundle-upload")
}

function euca-bundle-vol{
    euca_wrapper("euca-bundle-vol")
}

function euca-cancel-bundle-task{
    euca_wrapper("euca-cancel-bundle-task")
}

function euca-check-bucket{
    euca_wrapper("euca-check-bucket")
}

function euca-confirm-product-instance{
    euca_wrapper("euca-confirm-product-instance")
}

function euca-create-snapshot{
    euca_wrapper("euca-create-snapshot")
}

function euca-create-volume{
    euca_wrapper("euca-create-volume")
}

function euca-delete-bundle{
    euca_wrapper("euca-delete-bundle")
}

function euca-delete-group{
   euca_wrapper("euca-delete-group")
}

function euca-delete-keypair{
    euca_wrapper("euca-delete-keypair")
}

function euca-delete-snapshot{
    euca_wrapper("euca-delete-snapshot")
}

function euca-delete-volume{
    euca_wrapper("euca-delete-volume")
}

function euca-deregister{
    euca_wrapper("euca-deregister")
}

function euca-describe-addresses{
    euca_wrapper("euca-describe-addresses")
}

function euca-describe-availability-zones{
    euca_wrapper("euca-describe-availability-zones")
}

function euca-describe-bundle-tasks{
    euca_wrapper("euca-describe-bundle-tasks")
}

function euca-describe-groups{
    euca_wrapper("euca-describe-groups")
}

function euca-describe-image-attribute{
    euca_wrapper("euca-describe-image-attribute")
}

function euca-describe-images{
#write-output "PARAM: $args"
    euca_wrapper("euca-describe-images")
}

function euca-describe-instances{
    euca_wrapper("euca-describe-instances")
}

function euca-describe-keypairs{
    euca_wrapper("euca-describe-keypairs")
}

function euca-describe-regions{
    euca_wrapper("euca-describe-regions")
}

function euca-describe-snapshots{
    euca_wrapper("euca-describe-snapshots")
}

function euca-describe-volumes{
    euca_wrapper("euca-describe-volumes")
}

function euca-detach-volume{
    euca_wrapper("euca-detach-volume")
}

function euca-disassociate-address{
    euca_wrapper("euca-disassociate-address")
}

function euca-download-bundle{
    euca_wrapper("euca-download-bundle")
}

function euca-get-console-output{
    euca_wrapper("euca-get-console-output")
}

function euca-get-password{
    euca_wrapper("euca-get-password")
}

function euca-get-password-data{
    euca_wrapper("euca-get-password-data")
}

function euca-modify-image-attribute{
    euca_wrapper("euca-modify-image-attribute")
}

function euca-reboot-instances{
    euca_wrapper("euca-reboot-instances")
}

function euca-register{
    euca_wrapper("euca-register")
}

function euca-release-address{
    euca_wrapper("euca-release-address")
}

function euca-reset-image-attribute{
    euca_wrapper("euca-reset-image-attribute")
}

function euca-revoke{
    euca_wrapper("euca-revoke")
}

function euca-run-instances{
    euca_wrapper("euca-run-instances")
}

function euca-terminate-instances{
    euca_wrapper("euca-terminate-instances")
}

function euca-unbundle{
    euca_wrapper("euca-unbundle")
}

function euca-upload-bundle{
    euca_wrapper("euca-upload-bundle")
}

function euca-version{
    euca_wrapper("euca-version")
}

function euca_wrapper($executable)
{
    python "$EUCA_HOME\Script\$executable" $args
}

########### Euca2ools powershell Dependency  ##############
function setEnvVariableFromNovaRC{

    if(![System.IO.Directory]::Exists("$EUCA_HOME")){
        throw "The directory '$EUCA_HOME' doesn't exist"
    }
    if(![System.IO.File]::Exists($EUCA_RC)){
        throw "File '$EUCA_RC' doesn't exist"
    }

    #parse eucarc file and set environment variable properly
    $rcfile = get-content "$EUCA_RC"
    foreach ($line in $rcfile)
    {
         if($line.contains("EC2_URL="))
         {
            $ec2url = $line.Substring($line.IndexOf("EC2_URL=")+8);
         }
         elseif($line.contains("EC2_ACCESS_KEY="))
         {
            $access_key = $line.Substring($line.IndexOf("EC2_ACCESS_KEY=")+15);
            $access_key = $access_key.Replace("'","")
         }
         elseif($line.contains("EC2_SECRET_KEY="))
         {
            $secret_key = $line.substring($line.IndexOf("EC2_SECRET_KEY=")+15);
            $secret_key = $secret_key.Replace("'","")
         }
         elseif($line.contains("S3_URL="))
         {
            $walrusurl=$line.substring($line.IndexOf("S3_URL=")+7);
         }
         elseif($line.contains("EC2_CERT="))
         {
            $ec2cert=$line.substring($line.IndexOf("EC2_CERT=")+9);
            $ec2cert=$ec2cert.replace("`${EUCA_KEY_DIR}/","$EUCA_HOME\");
         }
         elseif($line.contains("EC2_PRIVATE_KEY="))
        {
            $ec2privatekey=$line.substring($line.IndexOf("EC2_PRIVATE_KEY=")+16);
            $ec2privatekey=$ec2privatekey.replace("`${EUCA_KEY_DIR}/","$EUCA_HOME\");
        }
        elseif($line.contains("EUCALYPTUS_CERT="))
        {
            $eucalyptuscert=$line.substring($line.IndexOf("EUCALYPTUS_CERT=")+16);
            $eucalyptuscert=$eucalyptuscert.replace("`${EUCA_KEY_DIR}/","$EUCA_HOME\");
        }
        elseif($line.contains("EC2_USER_ID="))
        {
            $ec2userid=$line.substring($line.IndexOf("EC2_USER_ID=")+12);
            $ec2userid=$ec2userid.Replace("'","")
        }
    }
    verifyCoreEnvVariable()  
}

function verifyCoreEnvVariableSet(){
    verifyEnvVariableisSet($ec2url,"EC2_URL")
    verifyEnvVariableisSet($access_key,"EC2_ACCESS_KEY")
    verifyEnvVariableisSet($secret_key,"EC2_SECRET_KEY")
    verifyEnvVariableisSet($walrusurl,"WALRUS_URL")
}



function verifyEnvVariableisSet($variable, $varName){
  if($variable -eq ""){
    throw "$varName variable is not set"
    }
}



function updateExecutionPolicy{
if (Get-ExecutionPolicy -ne "Unrestricted")
    {
        write-warning "Execution policy must be set as unrestricted"
        write-warning "Bring up Windows Powershell and execute Set-executionpolicy unrestricted "
    }
}

function setEnvironmentVariable($varName, $value){
    if($env:$varName eq "") {
        Set-Item -path env:$varName -value ($value)
    }
    
    write-host "Envirable variable $varName is set to $value"   
}

function overwriteEnvironmentVariable($varName, $newValue){
    if($varName -ne ""){
        Set-Item -path env:EC2_CERT -value "$newValue";
    }
     write-host "Envirable variable $varName is set to $newvalue" 
}
