function GetKeystoreIndividualCertificate {
	[CmdletBinding()]
	[OutputType([System.Security.Cryptography.X509Certificates.X509Certificate2])]
	param ()

	Get-CallerPreference -Cmdlet $PSCmdlet -SessionState $ExecutionContext.SessionState

	try {
		$ErrorActionPreference = 'Stop'

		Get-ChildItem -Path Cert:\CurrentUser\My | Where-Object { $_.FriendlyName -eq $Script:IndividualCertificateName }
	}
	catch {
		$PSCmdlet.ThrowTerminatingError($_)
	}
	finally {
		$ErrorActionPreference = 'Continue'
	}
}