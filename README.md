# EntraID-CA-NamedIP
This module helps you getting all possible IP-adresses from the IP-ranges in your Conditional Access Named Locations.

The `Get-ConditionalAccessNamedIP` function retrieves IP addresses from named locations in Conditional Access policies. You can filter the results based on whether the location is trusted or untrusted.

_This module is currently in development and will receive additional features and functions in the future._

_Feel free to share any feature requests with me!_

# Installation
The module is published on [PowerShell Gallery](https://www.powershellgallery.com/packages/M365cde.ConditionalAccessNamedIP/) and can be installed with this command within a powershell console:

    Install-Module -Name M365cde.ConditionalAccessNamedIP -AllowPrerelease -Scope CurrentUser

# Pre-Requirements
The required modules are:
- [Subnet](https://www.powershellgallery.com/packages/Subnet/)
- [Microsoft.Graph.Identity.SignIns](https://www.powershellgallery.com/packages/Microsoft.Graph.Identity.SignIns/)

It also requires a Microsoft Graph Connection.

# Usage

Retrieves IP addresses from trusted named locations
```
Get-ConditionalAccessNamedIP -IsTrusted
```

Retrieves IP addresses from untrusted named locations
```
Get-ConditionalAccessNamedIP -IsUntrusted
```

Retrieves IP addresses from all named locations
```
Get-ConditionalAccessNamedIP
```

# Changelog
- v0.0.3 Bugfix
  - Bugfix on the output and supressed the welcome message for Connect-MgGraph.
- v0.0.2 Bugfix / Changed Output
  - Output bugfix for Get-ConditionalAccessNamedIP.
  - Changed the output to return two properties: NamedLocation and IP.
- v0.0.1 First release
  - First release of this script
