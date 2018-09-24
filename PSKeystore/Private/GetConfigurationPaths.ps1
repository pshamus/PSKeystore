function GetConfigurationPaths {
	[CmdletBinding()]
	[OutputType([string])]
	param ()

	@('Enterprise', 'Machine').ForEach({
		Get-ConfigurationPath -Scope $_
	})
}