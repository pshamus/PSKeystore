function Set-KeystoreStore {
	#.ExternalHelp Keystore.psm1-Help.xml
	[CmdletBinding(SupportsShouldProcess, DefaultParameterSetName = 'ByName')]
	[OutputType([KeystoreStore])]
	param (
		[Parameter(Mandatory, ValueFromPipelineByPropertyName, ParameterSetName = 'ByName')]
		[ValidateNotNullOrEmpty()]
		[string]$Name,

		[Parameter(Mandatory, ValueFromPipeline, ParameterSetName = 'ByObject')]
		[KeystoreStore]$InputObject,

		[Parameter()]
		[ValidateNotNullOrEmpty()]
		[string]$Path = (Get-Location),

		[Parameter()]
		[switch]$PassThru
	)

	process {
		try {
			$ErrorActionPreference = 'Stop'

			if ($PSCmdlet.ParameterSetName -eq 'ByObject') {
				$keystore = $InputObject
				$Name = $keystore.Name
			}

			# If Path is specified, verify none of the built-in keystore names are being used.
			if ($PSBoundParameters.ContainsKey('Path')) {
				@('CurrentDirectory', 'Self') | ForEach-Object {
					if ($Name -eq $_) {
						throw "The access group '$_' is built-in and cannot be altered."
					}
				}
			}

			$newItem = $false
			if ($PSCmdlet.ParameterSetName -eq 'ByName') {
				if ($null -eq ($keystore = Get-KeystoreStore -Name $Name)) {
					$newItem = $true
					# Create a brand new keystore.
					$keystore = [KeystoreStore]::new($Name, $Path, 'Custom', $false)
				}
			}

			$updateNeeded = $false
			if ($newItem -eq $false) {
				if ($PSBoundParameters.ContainsKey('Path')) {
					$updateNeeded = $true
					$keystore.Path = $Path
				}
			}

			$keystore.Validate()

			if ($newItem -or $updateNeeded) {
				$target = "Keystore '$Name' ($($keystore.Path))"
				if ($PSCmdlet.ShouldProcess($target, 'Set')) {
					if ($keystore.Type -ne 'BuiltIn' -and $PSBoundParameters.ContainsKey('Path')) {
						$Settings.Stores[$Name] = $Path
					}
					$Settings | Export-Configuration
					if ($PassThru.IsPresent) {
						$keystore
					}
				}
			}
		}
		catch {
			$PSCmdlet.ThrowTerminatingError($_)
		}
		finally {
			$ErrorActionPreference = 'Continue'
		}
	}
}