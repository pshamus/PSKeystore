function Set-KeystoreDefaultAccessGroup {
	#.ExternalHelp Keystore.psm1-Help.xml
	[CmdletBinding(SupportsShouldProcess, DefaultParameterSetName = 'ByName')]
	param (
		[Parameter(Mandatory, ParameterSetName = 'ByName')]
		[ValidateNotNullOrEmpty()]
		[string]$Name,

		[Parameter(Mandatory, ValueFromPipeline, ParameterSetName = 'ByObject')]
		[KeystoreAccessGroup]$AccessGroup
	)

	begin {
		Get-CallerPreference -Cmdlet $PSCmdlet -SessionState $ExecutionContext.SessionState
		$ErrorActionPreference = 'Stop'
	}

	process {
		try {
			if ($PSCmdlet.ParameterSetName -eq 'ByObject') {
				$Name = $AccessGroup.Name
			} else {
				if ($null -eq ($AccessGroup = Get-KeystoreAccessGroup -Name $Name)) {
					throw "The access group '$Name' does not exist."
				}
			}

			if ($Script:Settings.DefaultAccessGroup -eq $AccessGroup.Name) {
				Write-Verbose "The access group '$Name' is already set as the default."
			} else {
				$target = "Keystore access group '$($AccessGroup.Name)' ($($AccessGroup.CertificateThumbprint))"
				if ($PSCmdlet.ShouldProcess($target, 'Set as default')) {
					$Script:Settings = Import-Configuration
					$Script:Settings.DefaultAccessGroup = $AccessGroup.Name
					$Script:Settings | Export-Configuration
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