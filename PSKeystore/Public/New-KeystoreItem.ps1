function New-KeystoreItem {
	#.ExternalHelp Keystore.psm1-Help.xml
	[CmdletBinding(SupportsShouldProcess, DefaultParameterSetName = 'GenericSecretAndStore')]
	[OutputType([KeystoreItem])]
	param(
		[Parameter(Mandatory)]
		[ValidateNotNullOrEmpty()]
		[string]$Name,

		[Parameter(Mandatory, ParameterSetName = 'GenericSecretAndStore')]
		[Parameter(Mandatory, ParameterSetName = 'GenericSecretAndPath')]
		[securestring]$SecretValue,

		[Parameter(Mandatory, ParameterSetName = 'CredentialAndStore')]
		[Parameter(Mandatory, ParameterSetName = 'CredentialAndPath')]
		[pscredential]$Credential,

		[Parameter(ParameterSetName = 'GenericSecretAndStore')]
		[Parameter(ParameterSetName = 'CredentialAndStore')]
		[ValidateNotNullOrEmpty()]
		[string]$StoreName,

		[Parameter(Mandatory, ParameterSetName = 'GenericSecretAndPath')]
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

	Get-CallerPreference -Cmdlet $PSCmdlet -SessionState $ExecutionContext.SessionState

	try {
		$ErrorActionPreference = 'Stop'

		ValidateKeystoreItemName -Name $Name

		if ($PSCmdlet.ParameterSetName -like '*Store') {
			if ($PSBoundParameters.ContainsKey('StoreName')) {
				if ($null -eq ($keystore = Get-KeystoreStore -Name $StoreName)) {
					throw "The store '$StoreName' does not exist."
				}
			} else {
				$keystore = Get-KeystoreDefaultStore
			}
			$keystore.Validate()
			$Path = $keystore.Path
		}
		Write-Verbose "Using store: $($keystore.Name)"

		if ($PSBoundParameters.ContainsKey('AccessGroup')) {
			if ($null -eq ($keystoreAccessGroup = Get-KeystoreAccessGroup -Name $AccessGroup)) {
				throw "The access group '$AccessGroup' does not exist."
			}
		} else {
			$keystoreAccessGroup = Get-KeystoreDefaultAccessGroup
		}
		Write-Verbose "Using access group: $($keystoreAccessGroup.Name)"

		$resolvedPath = Convert-Path -Path $Path

		# Since the name of the keystore item is a file, replace any backslashes (\) with dashes (-).
		$Name = $Name.Replace('\', '-').Trim()
		$keystoreItemPath = Join-Path -Path $resolvedPath -ChildPath "$Name.ksi"
		if (Test-Path -Path $keystoreItemPath -PathType Leaf) {
			throw "A keystore item with the name '$Name' already exists."
		}

		$target = "Keystore item '$Name' ($keystoreItemPath)"
		if ($PSCmdlet.ShouldProcess($target, 'Create')) {
			$timestamp = [datetime]::UtcNow.ToUniversalTime()
			$enabledState = !$Disable.IsPresent
			$attributeList = @($enabledState, $timestamp, $timestamp)

			# Extract the username and password if a PSCredential is specified.
			if ($PSCmdlet.ParameterSetName -like 'Credential*') {
				[System.Net.NetworkCredential]$networkCredential = $Credential.GetNetworkCredential()
				$userName = $Credential.UserName
				if ([string]::IsNullOrEmpty($networkCredential.Domain)) {
					$userName = $networkCredential.UserName
				}
				$SecretValue = $Credential.Password
				$attributeList += $userName.Trim()
			}
			$attributeList += $Tag

			$attributes = New-Object -TypeName KeystoreItemAttributes -ArgumentList $attributeList

			$protectedString = $keystoreAccessGroup.ProtectString($SecretValue)
			$keystoreItem = New-Object -TypeName KeystoreItem -ArgumentList @($Name, $protectedString, $attributes)

			# Output the keystore item to a JSON file but exclude the Path property, since it is dynamic.
			$keystoreItem | Select-Object -Property * -ExcludeProperty Path | ConvertTo-Json | Set-Content -Path $keystoreItemPath -Encoding UTF8
			Get-KeystoreItem -Path $keystoreItemPath
		}
	} catch {
		$PSCmdlet.WriteError($_)
	} finally {
		$ErrorActionPreference = 'Continue'
	}
}