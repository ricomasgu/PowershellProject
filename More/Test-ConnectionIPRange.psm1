function Test-ConnectionIPRange
{
  param (
    [parameter(Mandatory=$true)][IPAddress]$firstIP,
    [parameter(Mandatory=$true)][IPAddress]$lastIP
  )
  
  $lastIndex = [Convert]::ToString($firstIP.IPAddressToString,2)
  write $lastIndex
  for($i = $firstIP;$i -le $lastIP;$i++)
  {
    if(!(Test-Connection -ComputerName $i -Quiet)){
      
    }
  }
}