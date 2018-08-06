function Get-KeystoreConfiguration {
	#.ExternalHelp Keystore.psm1-Help.xml
	[CmdletBinding()]
	param ()

	Get-CallerPreference -Cmdlet $PSCmdlet -SessionState $ExecutionContext.SessionState

	try {
		$ErrorActionPreference = 'Stop'

		Import-Configuration
	} catch {
		$PSCmdlet.ThrowTerminatingError($_)
	} finally {
		$ErrorActionPreference = 'Continue'
	}
}