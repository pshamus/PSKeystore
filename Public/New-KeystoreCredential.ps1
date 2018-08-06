function New-KeystoreCredential {
	#.ExternalHelp Keystore.psm1-Help.xml
	[CmdletBinding()]
	[OutputType([System.Management.Automation.PSCredential])]
	param(
		[Parameter(Mandatory)]
		[ValidateNotNullOrEmpty()]
		[string]$Name,

		[Parameter(Mandatory, ParameterSetName = 'CredentialAndStore')]
		[Parameter(Mandatory, ParameterSetName = 'CredentialAndPath')]
		[pscredential]$Credential,

		[Parameter(ParameterSetName = 'CredentialAndStore')]
		[ValidateNotNullOrEmpty()]
		[string]$StoreName,

		[Parameter(Mandatory, ParameterSetName = 'CredentialAndPath')]
		[ValidateNotNullOrEmpty()]
		[string]$Path,

		[Parameter()]
		[ValidateNotNullOrEmpty()]
		[string]$AccessGroup,

		[Parameter()]
		[switch]$Disable,

		[Parameter()]
		[hashtable]$Tag = @{}
	)

	begin {
		$ErrorActionPreference = 'Stop'
	}

	process {
		try {
			New-KeystoreItem @PSBoundParameters | Get-KeystoreCredential
		} catch {
			$PSCmdlet.WriteError($_)
		}
	}

	end {
		$ErrorActionPreference = 'Continue'
	}
}