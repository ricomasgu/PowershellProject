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