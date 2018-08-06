function Get-KeystoreItem {
	#.ExternalHelp Keystore.psm1-Help.xml
	[CmdletBinding(DefaultParameterSetName = 'ByStore')]
	[OutputType('KeystoreItem')]
	param (
		[Parameter(ParameterSetName = 'ByStore', Position = 1)]
		[Parameter(ParameterSetName = 'ByPath', Position = 1)]
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

	Get-CallerPreference -Cmdlet $PSCmdlet -SessionState $ExecutionContext.SessionState

	try {
		$ErrorActionPreference = 'Stop'

		if ($PSCmdlet.ParameterSetName -eq 'ByStore') {
			if ($PSBoundParameters.ContainsKey('StoreName')) {
				if ($null -eq ($keystore = Get-Keystore -Name $StoreName)) {
					throw "The keystore '$StoreName' does not exist."
				}
			} else {
				$keystore = Get-KeystoreDefaultKeystore
			}
			$keystore.Validate()
			$Path = $keystore.Path
		}

		$resolvedPath = Resolve-Path -Path $Path
		$gciParams = @{
			Path = $resolvedPath.Path
		}
		if ($PSBoundParameters.ContainsKey('Name')) {
			$Name = [string]::Format('{0}.ksi', $Name.Replace('\', '-'))
			$gciParams.Filter = $Name
		} else {
			$gciParams.Filter = '*.ksi'
		}
		if (Test-Path -Path $resolvedPath.Path -PathType Container) {
			$gciParams.File	= $true
		}
		foreach ($item in (Get-ChildItem @gciParams)) {
			$currentItemPath = $item.FullName
			Write-Verbose "Processing file '$currentItemPath'"
			$keystoreItemContent = Get-Content -Path $currentItemPath -Encoding UTF8
			$tags = @{}
			try {
				$keystoreItemJson = [Newtonsoft.Json.Linq.JToken]::Parse((Get-Content -Path $currentItemPath -Raw -Encoding UTF8))
				$validationErrors = New-Object System.Collections.Generic.List[string]
				$isValid = [Newtonsoft.Json.Schema.SchemaExtensions]::IsValid($keystoreItemJson, $Script:KeystoreItemSchema, [ref]$validationErrors)
				if ($isValid -eq $false) {
					$warningMessage = "Unable to process item '{0}': The file has one or more validation errors:`r`n{1}" -f $item.Name, ($validationErrors -join "`r`n")
					Write-Warning $warningMessage
					continue
				}
				$validationErrors = $null
				$keystoreItemFromJson = $keystoreItemContent | ConvertFrom-Json
				if ($keystoreItemFromJson.Name -ne $item.BaseName) {
					Write-Warning "Unable to process item '$($item.Name)': The file has been altered from its original state."
					continue
				}
				$itemName = $keystoreItemFromJson.Name
				$protectedString = $keystoreItemFromJson.SecretValue
				$enabledState = $keystoreItemFromJson.Attributes.Enabled
				$createdDate = $keystoreItemFromJson.Attributes.Created
				$modifiedDate = $keystoreItemFromJson.Attributes.Updated
				$tags = $keystoreItemFromJson.Attributes.Tags.PSObject.Properties | ForEach-Object { @{$_.Name = $_.Value } }
				if ($null -eq $tags) {
					$tags = @{}
				}
				$contentType = $keystoreItemFromJson.Attributes.ContentType
				if ($contentType -eq 'Credential') {
					$userName = $keystoreItemFromJson.Attributes.UserName
				}
			} catch {
				$PSCmdlet.WriteError($_)
			}

			$attributeList = @($enabledState, $createdDate, $modifiedDate)
			if ($contentType -eq 'Credential') {
				$attributeList += $userName
			}
			$attributeList += $tags
			$attributes = New-Object -TypeName KeystoreItemAttributes -ArgumentList $attributeList

			$keystoreItem = New-Object -TypeName KeystoreItem -ArgumentList @($itemName, $protectedString, $attributes)
			$keystoreItem.Path = Get-Item -Path $currentItemPath
			$keystoreItem
		}
	} catch {
		$PSCmdlet.WriteError($_)
	} finally {
		$ErrorActionPreference = 'Continue'
	}
}