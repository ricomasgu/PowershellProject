function Set-DhcpServerv4Reservationv2
{
  param (
    #[parameter(Mandatory=$true,ParameterSetName="ClientId")][String]$ClientId,
    #[parameter(ParameterSetName="NewClientId")][String]$NewClientId
    $IPAddress,
    $NewIPAddress
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

    Write-Host Hello $IPAddress
}