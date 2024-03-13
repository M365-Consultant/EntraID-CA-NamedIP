<#
.SYNOPSIS
Retrieves IP addresses associated with named locations in Conditional Access.

.DESCRIPTION
The `Get-ConditionalAccessNamedIP` function retrieves IP addresses from named locations in Conditional Access policies. You can filter the results based on whether the location is trusted or untrusted.

.PARAMETER IsTrusted
Specifies that only trusted named locations should be considered. If this switch is used, the function will return IP addresses associated with trusted locations.

.PARAMETER IsUntrusted
Specifies that only untrusted named locations should be considered. If this switch is used, the function will return IP addresses associated with untrusted locations.

.EXAMPLE
Get-ConditionalAccessNamedIP -IsTrusted
# Retrieves IP addresses from trusted named locations.

.EXAMPLE
Get-ConditionalAccessNamedIP -IsUntrusted
# Retrieves IP addresses from untrusted named locations.

.NOTES
- Requires connection to Microsoft Graph using `Connect-MgGraph`.
- The function uses the `Get-MgIdentityConditionalAccessNamedLocation` cmdlet.
- IP addresses are returned as an array of strings.
#>

function Get-ConditionalAccessNamedIP {
    [CmdletBinding(DefaultParameterSetName = 'All')]
    param (
        [Parameter(ParameterSetName = 'Trusted')]
        [switch]$IsTrusted,

        [Parameter(ParameterSetName = 'Untrusted')]
        [switch]$IsUntrusted
    )

    # Connect to Graph
    if (-not (Get-MgContext)) {
        # Connect to Graph
        Connect-MgGraph -Scopes "Policy.Read.All"
    }

    # Get all named locations from conditional access
    [array]$CAKnownLocations = Get-MgIdentityConditionalAccessNamedLocation -All

    # Filter by trusted or untrusted
    if ($IsTrusted -eq $true) {
        $CAKnownLocations = $CAKnownLocations | Where-Object { $_.AdditionalProperties.isTrusted -eq $true }
    }
    elseif ($IsUntrusted -eq $true) {
        $CAKnownLocations = $CAKnownLocations | Where-Object { $_.AdditionalProperties.isTrusted -eq $false }
    }

    #Prepare the arrays
    [array]$CAIPAddressRanges = $Null
    [array]$CAIPAddresses = $Null

    # Iterate through each named location and get the IP ranges
    ForEach ($Location in $CAKnownLocations) {
    $IPRanges = $Null
    $IPRanges = $Location.AdditionalProperties['ipRanges']
    If ($IPRanges) {
        ForEach ($Address in $IPRanges) {
            $CAIPAddressRanges += $Address['cidrAddress']

        }
    }
    }

    # Iterate through each IP range and get the IP addresses by Get-Subnet
    foreach ($range in $CAIPAddressRanges) {
        $subnet = Get-Subnet $range
        $CAIPAddresses += $subnet.NetworkAddress.IPAddressToSTring
        $CAIPAddresses += $subnet.BroadcastAddress.IPAddressToSTring
        $CAIPAddresses += $subnet.HostAddresses
    }

    # Return the IP addresses
    Write-Output $IsTrusted
    Write-Output $IsUntrusted
    $CAIPAddresses
}

Export-ModuleMember -Function Get-ConditionalAccessNamedIP