function New-KeystoreAccessGroup {
	#.ExternalHelp Keystore.psm1-Help.xml
	[CmdletBinding(SupportsShouldProcess)]
	[OutputType([KeystoreAccessGroup])]
	param (
		[Parameter(Mandatory, ValueFromPipelineByPropertyName)]
		[ValidateNotNullOrEmpty()]
		[string]$Name,

		[Parameter(Mandatory, ValueFromPipelineByPropertyName)]
		[ValidateNotNullOrEmpty()]
		[string]$CertificateThumbprint
	)

	begin {
		Get-CallerPreference -Cmdlet $PSCmdlet -SessionState $ExecutionContext.SessionState
		$ErrorActionPreference = 'Stop'

		$Script:Settings = Import-Configuration
	}

	process {
		try {
			if ($Name -eq 'Self') {
				throw "The access group 'Self' is built-in and cannot be altered."
			}

			if ($null -ne (Get-KeystoreAccessGroup -Name $Name)) {
				throw "An access group with the name '$Name' already exists. To modify an existing access group, use Set-KeystoreAccessGroup."
			}
			$accessGroup = [KeystoreAccessGroup]::new($Name, $CertificateThumbprint.ToUpper(), 'Custom', $false)
			$target = "Keystore access group '$Name' ($($accessGroup.CertificateThumbprint))"
			if ($PSCmdlet.ShouldProcess($target, 'Create')) {
				$accessGroup.ValidateCertificate()
				$Script:Settings.AccessGroups[$Name] = $accessGroup.CertificateThumbprint
				$Script:Settings | Export-Configuration
				$accessGroup
			}
		} catch {
			$PSCmdlet.ThrowTerminatingError($_)
		}
	}

	end {
		$ErrorActionPreference = 'Continue'
	}
}