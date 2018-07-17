function Test-ConnectionIPRange
{
  param (
    [parameter(Mandatory=$true)][IPAddress]$firstIP,
    [IPAddress]$lastIP,
    [IPAddress]$mask
  )

  if($lastIP)
  {
    $first=$firstIP.IPAddressToString.split(".")
    $last=$lastIP.IPAddressToString.split(".")

    for($i=[int]$first[3];$i -le [int]$last[3]; $i++)
    {
      $ip=$first[0]+"."+$first[1]+"."+$first[2]+"."+$i
      $test=(Test-Connection -ComputerName $ip  -Quiet)
      write $ip"       "$test
    }
  }
  elseif($mask)
  {
    if(Test-IPv4MaskString $mask)
    {
      //Complete
    }
    else
    {
      write "Mask incorrect!"
    }
  }
}

function Test-IPv4MaskString {
  <#
  I am not the author of this function. I extract it of next link:

  http://www.itprotoday.com/management-mobility/working-ipv4-addresses-powershell

  .SYNOPSIS
  Tests whether an IPv4 network mask string (e.g., "255.255.255.0") is valid.

  .DESCRIPTION
  Tests whether an IPv4 network mask string (e.g., "255.255.255.0") is valid.

  .PARAMETER MaskString
  Specifies the IPv4 network mask string (e.g., "255.255.255.0").
  #>
  param(
    [parameter(Mandatory=$true)]
    [String] $MaskString
  )
  $validBytes = '0|128|192|224|240|248|252|254|255'
  $maskPattern = ('^((({0})\.0\.0\.0)|'      -f $validBytes) +
         ('(255\.({0})\.0\.0)|'      -f $validBytes) +
         ('(255\.255\.({0})\.0)|'    -f $validBytes) +
         ('(255\.255\.255\.({0})))$' -f $validBytes)
  $MaskString -match $maskPattern
}