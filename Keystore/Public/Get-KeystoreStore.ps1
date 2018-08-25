function Get-KeystoreStore {
	#.ExternalHelp Keystore.psm1-Help.xml
	[CmdletBinding()]
	[OutputType([KeystoreStore])]
	param (
		[Parameter()]
		[ValidateNotNullOrEmpty()]
		[string]$Name
	)

	Get-CallerPreference -Cmdlet $PSCmdlet -SessionState $ExecutionContext.SessionState

	try {
		$Script:Settings = Import-Configuration

		$stores = New-Object -TypeName 'System.Collections.ArrayList'
		$storeArgs = @('CurrentDirectory', (Get-Location).Path, 'BuiltIn', ($Script:Settings.DefaultStore -eq 'CurrentDirectory'))
		$null = $stores.Add((New-Object -TypeName 'KeystoreStore' -ArgumentList $storeArgs))
		if (Test-Path -Path $Script:SelfKeystorePath) {
			$storeArgs = @('Self', $Script:SelfKeystorePath, 'BuiltIn', ($Script:Settings.DefaultStore -eq 'Self'))
			$null = $stores.Add((New-Object -TypeName 'KeystoreStore' -ArgumentList $storeArgs))
		}
		foreach ($store in $Script:Settings.Stores.GetEnumerator()) {
			$storeArgs = @($store.Name, $store.Value, 'Custom', ($store.Name -eq $Script:Settings.DefaultStore))
			$null = $stores.Add((New-Object -TypeName 'KeystoreStore' -ArgumentList $storeArgs))
		}

		$filterClause = '$true'
		if ($PSBoundParameters.ContainsKey('Name')) {
			$filterClause = '$_.Name -eq $Name'
		}
		$filter = [scriptblock]::Create($filterClause)
		$stores.Where($filter) | Sort-Object Name
	} catch {
		$PSCmdlet.ThrowTerminatingError($_)
	} finally {
		$ErrorActionPreference = 'Continue'
	}
}