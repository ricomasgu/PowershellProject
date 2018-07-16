function Test-ConnectionIPRange
{
  param (
    [parameter(Mandatory=$true)][IPAddress]$firstIP,
    [parameter(Mandatory=$true)][IPAddress]$lastIP
  )
  
  $first=$firstIP.IPAddressToString.split(".")
  $last=$lastIP.IPAddressToString.split(".")

  for($i=[int]$first[3];$i -le [int]$last[3]; $i++)
  {
    $ip=$first[0]+"."+$first[1]+"."+$first[2]+"."+$i
    $test=(Test-Connection -ComputerName $ip  -Quiet)
    write $ip"       "$test
  }
}