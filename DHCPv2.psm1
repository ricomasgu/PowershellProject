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

    
    #Case 3: Want to change IPAddress and MacAddress.
    if($NewClientId -and $ClientId -and $IPAddress -and $NewIPAddress){
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
    elseif ($NewClientId -and $ClientId) {
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