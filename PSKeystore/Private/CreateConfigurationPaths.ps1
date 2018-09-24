function CreateConfigurationPaths {
	[CmdletBinding()]
	[OutputType([void])]
	param ()

	Get-CallerPreference -Cmdlet $PSCmdlet -SessionState $ExecutionContext.SessionState

	@('Enterprise', 'Machine').ForEach({
		$configFolder = Get-ConfigurationPath -Scope $_ -CallStack $MyInvocation.CommandOrigin
		if (!(Test-Path -Path $configFolder)) {
			$null = New-Item -Path $configFolder -ItemType Directory -Force
		} else {
			Write-Verbose "Keystore $($_.ToLower()) configuration folder '$configFolder' already exists"
		}
	})
}