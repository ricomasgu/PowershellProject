function Set-DhcpServerv4Reservationv2
{
  param (
    [String]$ClientId,
    [String]$NewClientId,
    [IPAddress]$IPAddress,
    [IPAddress]$NewIPAddress #,
    #[string]$NewDescription,
    #[string]$NewName,
    #[AsJob]$AsJob,
    #[CimSession]$CimSession,
    #[PassThru]$PassThru,
    #[Int32]$ThrottleLimit,
    #[string]$Type,
    #[boolean]$Confirm,
    #[WhatIf]$WhatIf,
    #[CommonParameters]$CommonParameters
    )

    
    #Case 3: Want to change IPAddress and MacAddress
    if($NewClientId -and $ClientId -and $IPAddress -and $NewIPAddress){
        Write-Host Case 3!
    }
    #Case 2: Only want to change MacAddress
    elseif ($NewClientId -and $ClientId) {
        Write-Host Case 2!
    }
    #Case 1: Only want to change IPAddress
    elseif($NewIpAddress -and $IPAddress)
    {
        Write-Host Case 1!
    }
    

#    $reservation = Get-DhcpServerv4Reservation -IPAddress $IPAddress
#    Remove-DhcpServerv4Reservation -IPAddress $IPAddress
#    Add-DhcpServerv4Reservation 
}