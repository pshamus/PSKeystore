function Import-Assembly {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory, Position = 1, ValueFromPipeline, ValueFromPipelineByPropertyName)]
		[ValidateNotNullOrEmpty()]
		[string[]]$Path
	)

	begin {
		Get-CallerPreference -Cmdlet $PSCmdlet -SessionState $ExecutionContext.SessionState
		$ErrorActionPreference = 'Stop'
	}

	process {
		foreach ($pathItem in $Path) {
			try {
				$resolvedItem = Resolve-Path -Path $pathItem
				$item = Get-Item -Path $resolvedItem
				if (!(IsAssemblyFileNameLoaded -Name $item.Name)) {
					Write-Verbose ("Importing assembly '{0}'" -f $item.Name)
					[byte[]]$assemblyBuffer = [System.IO.File]::ReadAllBytes($item.FullName)
					$null = [System.Reflection.Assembly]::Load($assemblyBuffer)
					$assemblyBuffer = $null
				} else {
					Write-Verbose ("Assembly '{0}' is already loaded" -f $item.Name)
				}
			} catch {
				$PSCmdlet.ThrowTerminatingError($_)
			}
		}
	}

	end {
		$ErrorActionPreference = 'Continue'
	}
}