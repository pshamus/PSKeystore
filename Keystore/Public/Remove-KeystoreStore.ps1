function Remove-KeystoreStore {
	#.ExternalHelp Keystore.psm1-Help.xml
	[CmdletBinding(SupportsShouldProcess)]
	param (
		[Parameter(Mandatory, ValueFromPipeline)]
		[KeystoreStore]$Store
	)

	process {
		try {
			$ErrorActionPreference = 'Stop'

			$keystoreName = $Store.Name
			@('CurrentDirectory', 'Self').ForEach({
				if ($keystoreName -eq $_) {
					throw "The store '$_' is built-in and cannot be altered."
				}
			})

			$target = "Keystore '$keystoreName' ($($Store.Path))"
			if ($PSCmdlet.ShouldProcess($target, 'Remove')) {
				$Settings = Get-KeystoreConfiguration
				$Settings.Stores.Remove($keystoreName)
				if ($Store.IsDefault) {
					$Settings.DefaultStore = 'Self'
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