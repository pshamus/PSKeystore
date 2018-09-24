function Get-KeystoreAccessGroup {
	#.ExternalHelp Keystore.psm1-Help.xml
	[CmdletBinding()]
	[OutputType([KeystoreAccessGroup])]
	param (
		[Parameter()]
		[ValidateNotNullOrEmpty()]
		[string]$Name
	)

	Get-CallerPreference -Cmdlet $PSCmdlet -SessionState $ExecutionContext.SessionState

	try {
		$ErrorActionPreference = 'Stop'

		$Script:Settings = Import-Configuration

		$accessGroups = New-Object 'System.Collections.ArrayList'
		if ($null -ne ($selfCert = GetKeystoreIndividualCertificate)) {
			$accessGroupArgs = @('Self', $selfCert.Thumbprint, 'BuiltIn', ('Self' -eq $Script:Settings.DefaultAccessGroup))
			$null = $accessGroups.Add((New-Object -TypeName 'KeystoreAccessGroup' -ArgumentList $accessGroupArgs))
		}
		foreach ($accessGroup in $Script:Settings.AccessGroups.GetEnumerator()) {
			$accessGroupArgs = @($accessGroup.Name, $accessGroup.Value, 'Custom', ($accessGroup.Name -eq $Script:Settings.DefaultAccessGroup))
			$null = $accessGroups.Add((New-Object -TypeName 'KeystoreAccessGroup' -ArgumentList $accessGroupArgs))
		}

		$filterClause = '$true'
		if ($PSBoundParameters.ContainsKey('Name')) {
			$filterClause = '$_.Name -eq $Name'
		}
		$filter = [scriptblock]::Create($filterClause)
		$accessGroups.Where($filter) | Sort-Object Name
	} catch {
		$PSCmdlet.ThrowTerminatingError($_)
	} finally {
		$ErrorActionPreference = 'Continue'
	}
}