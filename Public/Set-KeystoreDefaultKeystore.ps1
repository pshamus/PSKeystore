function Set-KeystoreDefaultKeystore {
	#.ExternalHelp Keystore.psm1-Help.xml
	[CmdletBinding(SupportsShouldProcess, DefaultParameterSetName = 'ByName')]
	param (
		[Parameter(Mandatory, ParameterSetName = 'ByName')]
		[ValidateNotNullOrEmpty()]
		[string]$Name,

		[Parameter(Mandatory, ValueFromPipeline, ParameterSetName = 'ByObject')]
		[Keystore]$Keystore
	)

	begin {
		Get-CallerPreference -Cmdlet $PSCmdlet -SessionState $ExecutionContext.SessionState
		$ErrorActionPreference = 'Stop'
	}

	process {
		try {
			if ($PSCmdlet.ParameterSetName -eq 'ByObject') {
				$Name = $Keystore.Name
			} else {
				if ($null -eq ($Keystore = Get-Keystore -Name $Name)) {
					throw "The keystore '$Name' does not exist."
				}
			}

			if ($Script:Settings.DefaultKeystore -eq $Keystore.Name) {
				Write-Verbose "The keystore '$Name' is already set as the default."
			} else {
				$target = "Keystore '$($Keystore.Name)' ($($Keystore.Path))"
				if ($PSCmdlet.ShouldProcess($target, 'Set as default')) {
					$Script:Settings = Get-KeystoreConfiguration
					$Script:Settings.DefaultKeystore = $Keystore.Name
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