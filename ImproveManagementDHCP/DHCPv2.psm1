##This module contains several functions that provide better administration of the DHCP server.

## Allows IPAddress and ClientId (MacAddress) change of reservation.
function Set-DhcpServerv4Reservationv2
{
    param (
        [String]$ClientId,
        [String]$NewClientId,
        [IPAddress]$IPAddress,
        [IPAddress]$NewIPAddress,
        [IPAddress]$Scope, 
        [String]$ComputerName
    )
    
    $ErrorActionPreference = "Stop" #The errors stop the script.
    
    switch ($psCmdlet.ParameterSetName) {
        #Case 3: Want to change IPAddress and MacAddress.
        "$NewClientId -and $ClientId -and $IPAddress -and $NewIPAddress" {
            if($ComputerName){
                $oldReservation=Get-DhcpServerv4Reservation -ComputerName $ComputerName -IPAddress $IPAddress
                Remove-DhcpServerv4Reservation -ComputerName $ComputerName -IPAddress $IPAddress
                if ($NewClientId -and $ClientId) {
                    Add-DhcpServerv4Reservation -ComputerName $ComputerName -IPAddress $NewIPAddress -ClientId $NewClientId `
                    -ScopeId $oldReservation.ScopeId -Description $oldReservation.Description -Type $oldReservation.Type -Name $oldReservation.Name
                }

                #Case 1: Only want to change IPAddress.
                else {
                    Add-DhcpServerv4Reservation -ComputerName $ComputerName -IPAddress $NewIPAddress -ClientId $oldReservation.ClientId `
                    -ScopeId $oldReservation.ScopeId -Description $oldReservation.Description -Type $oldReservation.Type -Name $oldReservation.Name
                }
            }
            else {
                $oldReservation=Get-DhcpServerv4Reservation -IPAddress $IPAddress
                Remove-DhcpServerv4Reservation -IPAddress $IPAddress
                if ($NewClientId -and $ClientId) {
                    Add-DhcpServerv4Reservation -IPAddress $NewIPAddress -ClientId $NewClientId `
                    -ScopeId $oldReservation.ScopeId -Description $oldReservation.Description -Type $oldReservation.Type -Name $oldReservation.Name
                }

                #Case 1: Only want to change IPAddress.
                else {
                    Add-DhcpServerv4Reservation -IPAddress $NewIPAddress -ClientId $oldReservation.ClientId `
                    -ScopeId $oldReservation.ScopeId -Description $oldReservation.Description -Type $oldReservation.Type -Name $oldReservation.Name
                }
            }
        }
        #Case 2: Only want to change MacAddress. The change applies ALL SCOPES!!!
        "$NewClientId -and $ClientId" {
            if($ComputerName){
                $oldReservation=Get-DhcpServerv4Scope -ComputerName $ComputerName | 
                ForEach-Object {Get-DhcpServerv4Reservation -ComputerName $ComputerName -ClientId $ClientId -ScopeId $_.ScopeId.IPAddressToString}
                Get-DhcpServerv4Scope -ComputerName $ComputerName | 
                ForEach-Object {Remove-DhcpServerv4Reservation -ComputerName $ComputerName -ClientId $ClientId -ScopeId $_.ScopeId.IPAddressToString}
                Get-DhcpServerv4Scope -ComputerName $ComputerName | 
                ForEach-Object {Add-DhcpServerv4Reservation -ComputerName $ComputerName -IPAddress $NewIPAddress -ClientId $NewClientId `
                -ScopeId $_.ScopeId.IPAddressToString -Description $oldReservation.Description -Type $oldReservation.Type -Name $oldReservation.Name}
            }
            else {
                $oldReservation=Get-DhcpServerv4Scope -ComputerName $ComputerName | 
                ForEach-Object {Get-DhcpServerv4Reservation -ClientId $ClientId -ScopeId $_.ScopeId.IPAddressToString}
                Get-DhcpServerv4Scope -ComputerName $ComputerName | 
                ForEach-Object {Remove-DhcpServerv4Reservation -ClientId $ClientId -ScopeId $_.ScopeId.IPAddressToString}
                Get-DhcpServerv4Scope -ComputerName $ComputerName | 
                ForEach-Object {Add-DhcpServerv4Reservation -IPAddress $NewIPAddress -ClientId $NewClientId `
                -ScopeId $_.ScopeId.IPAddressToString -Description $oldReservation.Description -Type $oldReservation.Type -Name $oldReservation.Name}
            }
        }
    }
}

## Lets you get an object by description or MacAddress. Support of regular expressions in the "Value" parameter.
function Get-DhcpServerv4Filterv2
{
    param (
        [String]$MacAddress,
        [String]$List,
        [String]$Description,
        [ValidateSet("CContains","CEQ","CGE","CGT","CIn","CLE","CLT","CLike","CMatch","CNE","CNotContains",
        "CNotIn","CNotLike","CNotMatch","Contains","EQ","GE","GT","In","Is","IsNot","LE","LT","Like","Match",
        "NE","NotContains","NotIn","NotLike","NotMatch")][String]$Operator,
        [String]$ComputerName
    )

    $ErrorActionPreference = "Stop"

    Get-DhcpServerv4Filter -ComputerName $ComputerName

    #Get-DhcpServerv4Filter -ComputerName $ComputerName | Where-Object -Property MacAddress -Value $MacAddress -$Operator
    #Get-DhcpServerv4Filter -ComputerName $ComputerName | Where-Object -Property Description -Value *00* -$Operator
}