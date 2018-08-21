function Unprotect-KeystoreSecretValue {
	#.ExternalHelp Keystore.psm1-Help.xml
	[CmdletBinding()]
	param (
		[Parameter(Mandatory, Position = 1)]
		[ValidateNotNullOrEmpty()]
		[string]$Value
	)

	Get-CallerPreference -Cmdlet $PSCmdlet -SessionState $ExecutionContext.SessionState

	try {
		$ErrorActionPreference = 'Stop'
		[System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($Value)) | Unprotect-CmsMessage
	} catch {
		if ($_.Exception.Message -match 'The enveloped-data message does not contain the specified recipient') {
			throw 'Access denied: Unable to decrypt the keystore secret value.'
			return
		}
		Write-Error -Exception $_.Exception
	} finally {
		$ErrorActionPreference = 'Continue'
	}
}