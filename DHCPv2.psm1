function Set-DhcpServerv4Reservationv2
{
  param (
    [String]$ClientId,
    [String]$NewClientId,
    [parameter(Mandatory=$true)][IPAddress]$IPAddress,
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

    

    #Case 1
    if(-not [IPAddress]::IsNullOrEmpty($NewIpAddress))
    {
        Write-Host Hello!
    }

    #Case 2


    #Case 3

    $reservation = Get-DhcpServerv4Reservation -IPAddress $IPAddress
    Remove-DhcpServerv4Reservation -IPAddress $IPAddress
    Add-DhcpServerv4Reservation 
}