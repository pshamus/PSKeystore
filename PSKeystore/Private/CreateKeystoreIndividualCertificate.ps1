function CreateKeystoreIndividualCertificate {
	[CmdletBinding()]
	[OutputType([System.Security.Cryptography.X509Certificates.X509Certificate2])]
	param ()

	Get-CallerPreference -Cmdlet $PSCmdlet -SessionState $ExecutionContext.SessionState

	try {
		$ErrorActionPreference = 'Stop'

		$currentUser = Get-LoggedOnUserName -Format UserPrincipalName
		if (GetKeystoreIndividualCertificate) {
			Write-Verbose "A keystore individual certificate already exists for $currentUser"
			return
		}

		Write-Verbose "Keystore individual certificate was not found for $currentUser, creating"
		$selfSignedParams = @{
			Subject            = "CN=$currentUser"
			NotBefore          = [datetime]::Now.AddYears(10)
			EnhancedKeyUsage   = '1.3.6.1.4.1.311.80.1'
			KeyUsage           = @('DataEncipherment', 'KeyEncipherment')
			SignatureAlgorithm = 'SHA256'
			FriendlyName       = $Script:IndividualCertificateName
			PassThru           = $true
		}
		$null = New-SelfSignedCertificateEx @selfSignedParams
		GetKeystoreIndividualCertificate
	}
	catch {
		$PSCmdlet.ThrowTerminatingError($_)
	}
	finally {
		$ErrorActionPreference = 'Continue'
	}
}