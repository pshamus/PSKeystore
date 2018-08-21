function Get-KeystoreCredential {
	#.ExternalHelp Keystore.psm1-Help.xml
	[CmdletBinding()]
	[OutputType([System.Management.Automation.PSCredential])]
	param(
		[Parameter(Mandatory, ParameterSetName = 'ByObject', ValueFromPipeline)]
		[KeystoreItem]$KeystoreItem,

		[Parameter(ParameterSetName = 'ByStore')]
		[Parameter(ParameterSetName = 'ByPath')]
		[ValidateNotNullOrEmpty()]
		[SupportsWildcards()]
		[string]$Name,

		[Parameter(ParameterSetName = 'ByStore')]
		[ValidateNotNullOrEmpty()]
		[string]$StoreName,

		[Parameter(Mandatory, ParameterSetName = 'ByPath')]
		[ValidateNotNullOrEmpty()]
		[string]$Path
	)

	begin {
		Get-CallerPreference -Cmdlet $PSCmdlet -SessionState $ExecutionContext.SessionState
		$ErrorActionPreference = 'Stop'
	}

	process {
		try {
			$keystoreItems = [System.Collections.ArrayList]::new()
			if ($PSCmdlet.ParameterSetName -eq 'ByObject') {
				$null = $keystoreItems.Add($KeystoreItem)
			} else {
				Get-KeystoreItem @PSBoundParameters | ForEach-Object {
					$null = $keystoreItems.Add($_)
				}
			}

			foreach ($item in $keystoreItems) {
				if ($item.Attributes.ContentType -eq 'Credential') {
					New-Object System.Management.Automation.PSCredential -ArgumentList @($item.Attributes.UserName, $item.GetSecretValue())
				} else {
					Write-Verbose "Keystore item '$($item.Name)' does not have a content type of Credential, skipping"
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