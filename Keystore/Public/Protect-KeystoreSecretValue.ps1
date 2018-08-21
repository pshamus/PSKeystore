function Protect-KeystoreSecretValue {
	#.ExternalHelp Keystore.psm1-Help.xml
	[CmdletBinding()]
	[OutputType([string])]
	param (
		[Parameter(Mandatory)]
		[ValidateNotNullOrEmpty()]
		[string]$Value,

		[Parameter(Mandatory)]
		[ValidateNotNullOrEmpty()]
		[string]$AccessGroup
	)

	Get-CallerPreference -Cmdlet $PSCmdlet -SessionState $ExecutionContext.SessionState

	try {
		$ErrorActionPreference = 'Stop'

		if ($null -eq ($keystoreAccessGroup = Get-KeystoreAccessGroup -Name $AccessGroup)) {
			throw "The access group '$AccessGroup' does not exist."
		}
		$keystoreAccessGroup.ValidateCertificate()

		$thumbprint = $keystoreAccessGroup.CertificateThumbprint
		Write-Verbose "Encrypting secret value with access group '$AccessGroup ($thumbprint)'"
		[System.Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes((Protect-CmsMessage -To $thumbprint -Content $Value)))
	}
	catch {
		$PSCmdlet.ThrowTerminatingError($_)
	} finally {
		$ErrorActionPreference = 'Continue'
	}
}