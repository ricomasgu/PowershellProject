function Set-DhcpServerv4Reservationv2
{
  param (
    [String]$ClientId,
    [String]$NewClientId,
    [IPAddress]$IPAddress,
    [IPAddress]$NewIPAddress,
    [String]$NewDescription,
    [String]$NewName,
    [AsJob]$AsJob,
    [CimSession]$CimSession,
    [PassThru]$PassThru,
    [Int32]$ThrottleLimit,
    [String]$Type,
    [Boolean]$Confirm,
    [WhatIf]$WhatIf,
    [CommonParameters]$CommonParameters
    )
    Get-DhcpServerv4Reservation 
}