function Initialize-Keystore {
	[CmdletBinding()]
	param ()

	try {
		$ErrorActionPreference = 'Stop'

		$null = CreateKeystoreIndividualCertificate

		# Create the Self keystore if it doesn't exist.
		if (!(Test-Path -Path $Script:SelfKeystorePath -PathType Container)) {
			Write-Verbose "Creating Self store path at $Script:SelfKeystorePath"
			$null = New-Item -Path $Script:SelfKeystorePath -ItemType Directory -Force
		} else {
			Write-Verbose "Self store path $Script:SelfKeystorePath already exists"
		}

		$Script:Settings.DefaultStore = 'Self'
	}
	catch {
		$PSCmdlet.ThrowTerminatingError($_)
	}
	finally {
		$ErrorActionPreference = 'Continue'
	}
}