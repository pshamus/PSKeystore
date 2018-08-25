function Set-KeystoreAccessGroup {
	#.ExternalHelp Keystore.psm1-Help.xml
	[CmdletBinding(SupportsShouldProcess)]
	[OutputType([KeystoreAccessGroup])]
	param (
		[Parameter(Mandatory, ValueFromPipeline)]
		[KeystoreAccessGroup]$AccessGroup,

		[Parameter(Mandatory)]
		[ValidateNotNullOrEmpty()]
		[string]$CertificateThumbprint,

		[Parameter()]
		[switch]$PassThru
	)

	begin {
		Get-CallerPreference -Cmdlet $PSCmdlet -SessionState $ExecutionContext.SessionState
		$ErrorActionPreference = 'Stop'

		$Script:Settings = Import-Configuration
	}

	process {
		try {
			$accessGroupName = $AccessGroup.Name
			if ($accessGroupName -eq 'Self') {
				throw "The access group 'Self' is built-in and cannot be altered."
			}
			$AccessGroup.CertificateThumbprint = $CertificateThumbprint.ToUpper()

			$target = "Keystore access group '$accessGroupName' ($($AccessGroup.CertificateThumbprint))"
			if ($PSCmdlet.ShouldProcess($target, 'Set')) {
				$AccessGroup.ValidateCertificate()
				$Script:Settings.AccessGroups[$accessGroupName] = $AccessGroup.CertificateThumbprint
				$Script:Settings | Export-Configuration
				if ($PassThru.IsPresent) {
					$AccessGroup
				}
			}
		} catch {
			$PSCmdlet.ThrowTerminatingError($_)
		}
	}

	end {
		$ErrorActionPreference = 'Continue'
	}
}