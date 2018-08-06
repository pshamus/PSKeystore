function Unprotect-SecureString {
	#.ExternalHelp Keystore.psm1-Help.xml
	[CmdletBinding()]
	[OutputType([System.String])]
	param(
		[Parameter(Mandatory)]
		[ValidateNotNullOrEmpty()]
		[System.Security.SecureString]$SecureString
	)

	try {
		$ErrorActionPreference = 'Stop'

		# Create a credential object with a fake username.
		$credential = New-Object System.Management.Automation.PSCredential -ArgumentList @('N/A', $SecureString)

		# Converts the credential data into a NetworkCredential object, which exposes a method to decrypt the password
		# from a secure string.
		$credential.GetNetworkCredential().Password
	} catch {
		$PSCmdlet.ThrowTerminatingError($_)
	} finally {
		$ErrorActionPreference = 'Continue'
	}
}