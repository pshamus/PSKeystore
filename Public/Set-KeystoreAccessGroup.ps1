function Set-KeystoreAccessGroup {
	#.ExternalHelp Keystore.psm1-Help.xml
	[CmdletBinding(SupportsShouldProcess, DefaultParameterSetName = 'ByName')]
	[OutputType('KeystoreAccessGroup')]
	param (
		[Parameter(Mandatory, ValueFromPipelineByPropertyName, ParameterSetName = 'ByName')]
		[ValidateNotNullOrEmpty()]
		[string]$Name,

		[Parameter(Mandatory, ValueFromPipeline, ParameterSetName = 'ByObject')]
		[KeystoreAccessGroup]$InputObject,

		[Parameter()]
		[ValidateNotNullOrEmpty()]
		[string]$CertificateThumbprint,

		[Parameter()]
		[switch]$PassThru
	)

	begin {
		Get-CallerPreference -Cmdlet $PSCmdlet -SessionState $ExecutionContext.SessionState
		$ErrorActionPreference = 'Stop'
	}

	process {
		try {
			if ($PSCmdlet.ParameterSetName -eq 'ByObject') {
				$accessGroup = $InputObject
				$accessGroup.CertificateThumbprint = $CertificateThumbprint
				$Name = $accessGroup.Name
			}

			if ($PSBoundParameters.ContainsKey('CertificateThumbprint')) {
				if ($Name -eq 'Self') {
					throw "The access group 'Self' is built-in and cannot be altered."
				}
			}

			$newItem = $false
			if ($PSCmdlet.ParameterSetName -eq 'ByName') {
				if ($null -eq ($accessGroup = Get-KeystoreAccessGroup -Name $Name)) {
					$newItem = $true
					if (!$PSBoundParameters.ContainsKey('CertificateThumbprint')) {
						throw 'A certificate thumbprint is required when creating a new keystore access group.'
					}
					$accessGroup = [KeystoreAccessGroup]::new($Name, $CertificateThumbprint, 'Custom', $false)
				}
			}

			$updateNeeded = $false
			if ($newItem -eq $false) {
				if ($PSBoundParameters.ContainsKey('CertificateThumbprint')) {
					$updateNeeded = $true
					$accessGroup.CertificateThumbprint = $CertificateThumbprint
				}
			}

			if ($newItem -or $updateNeeded) {
				$accessGroup.ValidateCertificate()
				$target = "Keystore access group '$Name' ($($accessGroup.CertificateThumbprint))"
				if ($PSCmdlet.ShouldProcess($target, 'Set')) {
					if ($accessGroup.Type -ne 'BuiltIn' -and $PSBoundParameters.ContainsKey('CertificateThumbprint')) {
						$Script:Settings.AccessGroups[$Name] = $CertificateThumbprint
					}
					$Script:Settings | Export-Configuration
					if ($PassThru.IsPresent) {
						$accessGroup
					}
				}
			} else {
				Write-Verbose 'No parameters were specified that required updating'
			}
		} catch {
			$PSCmdlet.ThrowTerminatingError($_)
		}
	}

	end {
		$ErrorActionPreference = 'Continue'
	}
}