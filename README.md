# EntraID-CA-NamedIP
This module helps you getting all possible IP-adresses from the IP-ranges in your Conditional Access Named Locations.

The `Get-ConditionalAccessNamedIP` function retrieves IP addresses from named locations in Conditional Access policies. You can filter the results based on whether the location is trusted or untrusted.

_This module is currently in development and will receive additional features and functions in the future._

_Feel free to share any feature requests with me!_

# Installation
The module is published on [PowerShell Gallery](https://www.powershellgallery.com/packages/M365cde.ConditionalAccessNamedIP/) and can be installed with this command within a powershell console:

    Install-Module -Name M365cde.ConditionalAccessNamedIP -AllowPrerelease -Scope CurrentUser

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
- v0.0.1 First release
  - First release of this script
