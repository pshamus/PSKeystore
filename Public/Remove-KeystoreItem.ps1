function Remove-KeystoreItem {
	#.ExternalHelp Keystore.psm1-Help.xml
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
	[OutputType('KeystoreItem')]
	param(
		[Parameter(ValueFromPipeline)]
		[KeystoreItem]$InputObject,

		[Parameter()]
		[switch]$PassThru
	)

	begin {
		Get-CallerPreference -Cmdlet $PSCmdlet -SessionState $ExecutionContext.SessionState
		$ErrorActionPreference = 'Stop'
	}

	process {
		try {
			$itemPath = $InputObject.Path.FullName
			if (!(Test-Path -Path $itemPath)) {
				throw "The expected file for keystore item '$itemPath' does not exist."
			}

			$shouldProcessCaption = 'Keystore item: {0} ({1})' -f $InputObject.Name, $itemPath
			if ($PSCmdlet.ShouldProcess($shouldProcessCaption, 'Remove')) {
				Remove-Item -Path $itemPath
				if ($PassThru.IsPresent) {
					$InputObject
				}
			}
		} catch {
			$PSCmdlet.WriteError($_)
		}
	}

	end {
		$ErrorActionPreference = 'Continue'
	}
}