function Set-KeystoreStore {
	#.ExternalHelp Keystore.psm1-Help.xml
	[CmdletBinding(SupportsShouldProcess)]
	[OutputType([KeystoreStore])]
	param (
		[Parameter(Mandatory, ValueFromPipeline)]
		[KeystoreStore]$Store,

		[Parameter(Mandatory)]
		[ValidateNotNullOrEmpty()]
		[string]$Path,

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
			$storeName = $Store.Name
			@('CurrentDirectory', 'Self') | ForEach-Object {
				if ($storeName -eq $_) {
					throw "The access group '$_' is built-in and cannot be altered."
				}
			}

			$resolvedPath = Resolve-Path -Path $Path
			$Store.Path = $resolvedPath
			$target = "Keystore store '$storeName' ($resolvedPath)"
			if ($PSCmdlet.ShouldProcess($target, 'Set')) {
				$Store.Validate()
				$Settings.Stores[$storeName] = $resolvedPath
				$Settings | Export-Configuration
				if ($PassThru.IsPresent) {
					$Store
				}
			}
		}
		catch {
			$PSCmdlet.ThrowTerminatingError($_)
		}
	}

	end {
		$ErrorActionPreference = 'Continue'
	}
}