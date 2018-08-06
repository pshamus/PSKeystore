function Get-KeystoreAccessGroup {
	#.ExternalHelp Keystore.psm1-Help.xml
	[CmdletBinding()]
	[OutputType('KeystoreAccessGroup')]
	param (
		[Parameter()]
		[ValidateNotNullOrEmpty()]
		[string]$Name
	)

	Get-CallerPreference -Cmdlet $PSCmdlet -SessionState $ExecutionContext.SessionState

	try {
		$ErrorActionPreference = 'Stop'

		$Script:Settings = Get-KeystoreConfiguration

		$accessGroups = [System.Collections.ArrayList]::new()
		if ($null -ne ($selfCert = GetKeystoreIndividualCertificate)) {
			$null = $accessGroups.Add([KeystoreAccessGroup]::new('Self', $selfCert.Thumbprint, 'BuiltIn', ('Self' -eq $Script:Settings.DefaultAccessGroup)))
		}
		$Script:Settings.AccessGroups.GetEnumerator().ForEach({
			$null = $accessGroups.Add([KeystoreAccessGroup]::new($_.Name, $_.Value, 'Custom', ($_.Name -eq $Script:Settings.DefaultAccessGroup)))
		})

		$filterClause = '$true'
		if ($PSBoundParameters.ContainsKey('Name')) {
			$filterClause = '$_.Name -eq $Name'
		}
		$filter = [scriptblock]::Create($filterClause)
		$accessGroups.Where($filter)
	} catch {
		$PSCmdlet.ThrowTerminatingError($_)
	} finally {
		$ErrorActionPreference = 'Continue'
	}
}