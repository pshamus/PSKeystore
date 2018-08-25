function Reset-KeystoreConfiguration {
	#.ExternalHelp Keystore.psm1-Help.xml
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
	param ()

	Get-CallerPreference -Cmdlet $PSCmdlet -SessionState $ExecutionContext.SessionState

	try {
		$ErrorActionPreference = 'Stop'

		if ((Test-Path -Path $Script:ConfigurationPath) -and (Get-ChildItem -Path $Script:ConfigurationPath -Filter 'Configuration.psd1')) {
			if ($PSCmdlet.ShouldProcess('Keystore configuration', 'Reset')) {
				Write-Verbose 'Removing configuration file for current user'
				Get-ChildItem -Path $Script:ConfigurationPath -Filter 'Configuration.psd1' | Remove-Item -Confirm:$false

				Write-Verbose 'Applying keystore default configuration values'
				Import-Configuration | Export-Configuration
			}
		} else {
			Write-Verbose 'Keystore configuration already uses the default values'
		}
	} catch {
		$PSCmdlet.ThrowTerminatingError($_)
	} finally {
		$ErrorActionPreference = 'Continue'
	}
}