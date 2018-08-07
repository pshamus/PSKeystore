function Get-Keystore {
	#.ExternalHelp Keystore.psm1-Help.xml
	[CmdletBinding()]
	[OutputType('Keystore')]
	param (
		[Parameter()]
		[ValidateNotNullOrEmpty()]
		[string]$Name
	)

	Get-CallerPreference -Cmdlet $PSCmdlet -SessionState $ExecutionContext.SessionState

	try {
		$Script:Settings = Get-KeystoreConfiguration

		$keystores = [System.Collections.ArrayList]::new()
		$null = $keystores.Add([Keystore]::new('CurrentDirectory', (Get-Location).Path, 'BuiltIn', ($Script:Settings.DefaultKeystore -eq 'CurrentDirectory')))
		$null = $keystores.Add([Keystore]::new('Self', $Script:SelfKeystorePath, 'BuiltIn', ($Script:Settings.DefaultKeystore -eq 'Self')))
		$Script:Settings.Keystores.GetEnumerator().ForEach({
			$null = $keystores.Add([Keystore]::new($_.Name, $_.Value, 'Custom', ($_.Name -eq $Script:Settings.DefaultKeystore)))
		})

		$filterClause = '$true'
		if ($PSBoundParameters.ContainsKey('Name')) {
			$filterClause = '$_.Name -eq $Name'
		}
		$filter = [scriptblock]::Create($filterClause)
		$keystores.Where($filter)
	} catch {
		$PSCmdlet.ThrowTerminatingError($_)
	} finally {
		$ErrorActionPreference = 'Continue'
	}
}