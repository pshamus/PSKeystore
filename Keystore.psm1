<#
	===========================================================================
	Organization:	Dusk Consulting
	Filename:		Keystore.psm1
	-------------------------------------------------------------------------
	Module Name:	Keystore
	===========================================================================
#>

Set-StrictMode -Version Latest

# Check if the Json.NET and Json.NET Schema libraries are loaded.
$isJsonLoaded = $null -ne ([System.Management.Automation.PSTypeName]'Newtonsoft.Json.Linq.JObject').Type
$isJsonSchemaLoaded = $null -ne ([System.Management.Automation.PSTypeName]'Newtonsoft.Json.Schema.JSchema').Type

$jsonVersion = $null
if ($isJsonLoaded -and !$isJsonSchemaLoaded) {
	# Determine the version of Json.NET loaded so we can find the correct Json.NET Schema version to load.
	$jsonVersion = ([version]([Newtonsoft.Json.Linq.JObject].Assembly.FullName.Split(',')[1].Split('=')[1])).ToString(2)
}

# Get public and private function definition files.
$Public = @(Get-ChildItem -Path $PSScriptRoot\Public\*.ps1 -ErrorAction Ignore)
$Private = @(Get-ChildItem -Path $PSScriptRoot\Private\*.ps1 -ErrorAction Ignore)

# Dot source the files.
foreach ($import in @($Public + $Private)) {
	try {
		Write-Verbose "Importing $($import.FullName)"
		. $import.FullName
	} catch {
		Write-Error "Failed to import function $($import.FullName): $_"
		return
	}
}

# Export all public functions as module members.
Export-ModuleMember -Function $Public.BaseName

$Script:IndividualCertificateName = 'Keystore Individual Certificate'
$Script:SelfKeystorePath = "$Env:USERPROFILE\Documents\Keystore"

try {
	# Ensure the module configuration path is accessible.
	if (!(Test-Path -Path (Get-ConfigurationPath))) {
		$null = New-Item -Path (Get-ConfigurationPath) -ItemType Directory -Force
	}

	$Script:Settings = Get-KeystoreConfiguration

	if ($null -eq (GetKeystoreIndividualCertificate)) {
		NewKeystoreIndividualCertificate
	}

	# Create the Self keystore if it doesn't exist.
	if (!(Test-Path -Path $Script:SelfKeystorePath -PathType Container)) {
		$null = New-Item -Path $Script:SelfKeystorePath -ItemType Directory -Force
	}

	$Script:KeystoreItemSchema = [Newtonsoft.Json.Schema.JSchema]::Parse((Get-Content -Path "$PSScriptRoot\keystore_item.schema.json"))
} catch {
	Write-Error "Unable to load Keystore item schema: $($_.Exception.ToString())"
	return
}