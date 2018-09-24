function New-KeystoreStore {
	#.ExternalHelp Keystore.psm1-Help.xml
	[CmdletBinding(SupportsShouldProcess)]
	[OutputType([KeystoreStore])]
	param (
		[Parameter(Mandatory, ValueFromPipelineByPropertyName)]
		[ValidateNotNullOrEmpty()]
		[string]$Name,

		[Parameter()]
		[ValidateNotNullOrEmpty()]
		[string]$Path = (Get-Location)
	)

	process {
		try {
			$ErrorActionPreference = 'Stop'

			# Verify none of the built-in store names are being used.
			@('CurrentDirectory', 'Self') | ForEach-Object {
				if ($Name -eq $_) {
					throw "The access group '$_' is built-in and cannot be altered."
				}
			}

			$resolvedPath = Resolve-Path -Path $Path
			if ($null -ne (Get-KeystoreStore -Name $Name)) {
				throw "A store with the name '$Name' already exists. To modify an existing store, use Set-KeystoreStore."
			}
			$store = [KeystoreStore]::new($Name, $resolvedPath, 'Custom', $false)
			$target = "Keystore store '$Name' ($($store.Path))"
			if ($PSCmdlet.ShouldProcess($target, 'Create')) {
				$store.Validate()
				$Settings.Stores[$Name] = $store.Path
				$Settings | Export-Configuration
				$store
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