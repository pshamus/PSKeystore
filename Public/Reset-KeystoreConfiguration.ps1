function Reset-KeystoreConfiguration {
	#.ExternalHelp Keystore.psm1-Help.xml
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
	param ()

	Get-CallerPreference -Cmdlet $PSCmdlet -SessionState $ExecutionContext.SessionState

	try {
		$ErrorActionPreference = 'Stop'

		if ($PSCmdlet.ShouldProcess('Keystore configuration', 'Reset')) {
			@{
				AccessGroups       = @{}
				CurrentJsonVersion = '11.0'
				DefaultAccessGroup = 'Self'
				DefaultKeystore    = 'Self'
				Keystores          = @{}
			} | Export-Configuration
		}
	} catch {
		$PSCmdlet.ThrowTerminatingError($_)
	} finally {
		$ErrorActionPreference = 'Continue'
	}
}