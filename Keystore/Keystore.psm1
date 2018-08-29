<#
	===========================================================================
	Organization:	Dusk Consulting
	Filename:		Keystore.psm1
	-------------------------------------------------------------------------
	Module Name:	Keystore
	===========================================================================
#>

Set-StrictMode -Version Latest

$Script:ConfigurationPath = Get-ConfigurationPath
$Script:CurrentJsonVersion = '11.0'
$Script:IndividualCertificateName = 'Keystore Individual Certificate'
$Script:SelfKeystorePath = "$Env:USERPROFILE\Documents\Keystore"
$Script:Settings = Import-Configuration

try {
	# Get public and private function definition files.
	$Public = @(Get-ChildItem -Path $PSScriptRoot\Public\*.ps1 -ErrorAction Ignore)
	$Private = @(Get-ChildItem -Path $PSScriptRoot\Private\*.ps1 -ErrorAction Ignore)

	# Dot source the files.
	foreach ($import in @($Public + $Private)) {
		try {
			. $import.FullName
		} catch {
			Write-Error "Failed to import function $($import.FullName): $_"
			return
		}
	}

	# Export all public functions as module members.
	Export-ModuleMember -Function $Public.BaseName

	# Check if the Json.NET and Json.NET Schema libraries are loaded.
	$isJsonLoaded = $null -ne ([System.Management.Automation.PSTypeName]'Newtonsoft.Json.Linq.JObject').Type
	$isJsonSchemaLoaded = $null -ne ([System.Management.Automation.PSTypeName]'Newtonsoft.Json.Schema.JSchema').Type

	$assembliesToLoad = [System.Collections.ArrayList]::new()
	if (!$isJsonLoaded -and !$isJsonSchemaLoaded) {
		# No Json.NET libraries are loaded, so load the latest Json.NET library version deployed with EO.
		$null = $assembliesToLoad.Add("$PSScriptRoot\Assemblies\$CurrentJsonVersion\Newtonsoft.Json.dll")
		$null = $assembliesToLoad.Add("$PSScriptRoot\Assemblies\$CurrentJsonVersion\Newtonsoft.Json.Schema.dll")
	} elseif ($isJsonLoaded -and !$isJsonSchemaLoaded) {
		# The Json.NET library is loaded but the Json.NET Schema library isn't, so extract the version of the loaded
		# Newtonsoft.Json.dll assembly in order to determine the correct version of Json.NET Schema to load.
		$jsonVersion = ([version]([Newtonsoft.Json.Linq.JObject].Assembly.FullName.Split(',')[1].Split('=')[1])).ToString(2)
		$null = $assembliesToLoad.Add("$PSScriptRoot\Assemblies\$jsonVersion\Newtonsoft.Json.Schema.dll")
	}

	foreach ($assembly in $assembliesToLoad) {
		Import-Assembly -Path $assembly
	}

	$Script:KeystoreItemSchema = [Newtonsoft.Json.Schema.JSchema]::Parse((Get-Content -Path "$PSScriptRoot\keystore_item.schema.json"))
} catch {
	Write-Error "Failed to load Keystore module: $($_.Exception.ToString())"
	return
}