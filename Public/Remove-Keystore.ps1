function Remove-Keystore {
	#.ExternalHelp Keystore.psm1-Help.xml
	[CmdletBinding(SupportsShouldProcess)]
	param (
		[Parameter(Mandatory, ValueFromPipeline)]
		[Keystore]$InputObject
	)

	process {
		try {
			$ErrorActionPreference = 'Stop'

			$keystoreName = $InputObject.Name
			@('CurrentDirectory', 'Self') | ForEach-Object {
				if ($keystoreName -eq $_) {
					throw "The access group '$_' is built-in and cannot be altered."
				}
			}

			$target = "Keystore '$keystoreName' ($($InputObject.Path))"
			if ($PSCmdlet.ShouldProcess($target, 'Remove')) {
				$Settings = Get-KeystoreConfiguration
				$Settings.Keystores.Remove($keystoreName)
				if ($InputObject.IsDefault) {
					$Settings.DefaultKeystore = 'Self'
				}
				$Settings | Export-Configuration
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