[CmdletBinding()]
param ()

task InitializeBuildEnvironment {
	Set-BuildEnvironment -Force
	Get-BuildEnvironment
}

task CleanBuildOutputFolder {
	$Script:moduleOutputPath = Join-Path -Path $Env:BHBuildOutput -ChildPath $Env:BHProjectName
	$Script:moduleOutputManifest = "$moduleOutputPath\$Env:BHProjectName.psd1"
	if (Test-Path -Path $moduleOutputPath) {
		Write-Verbose 'Clearing build output folder' -Verbose
		Remove-Item -Path $moduleOutputPath -Recurse -Force
	}
}

task StageModuleFiles {
	Copy-Item -Path $Env:BHModulePath -Destination $Env:BHBuildOutput -Recurse -Force
}

task UpdateModuleVersion -if { $null -ne $Env:APPVEYOR_BUILD_VERSION } {
	Write-Verbose "Updating module version to $Env:APPVEYOR_BUILD_VERSION" -Verbose
	$manifest = Get-Content -Path $moduleOutputManifest -Raw
	$manifest = $manifest -replace "'0.0.1'", "'$($Env:APPVEYOR_BUILD_VERSION)'"
	Set-Content -Path $moduleOutputManifest -Value $manifest -Encoding Ascii
}

task GenerateModuleHelp -if ($Configuration -eq 'Release') {
	Write-Verbose "Generating module external help" -Verbose
	Remove-Module $Env:BHProjectName -ErrorAction Ignore
	Import-Module $moduleOutputPath

	$null = New-ExternalHelp -Path "$Env:BHProjectPath\Docs\Module" -OutputPath "$moduleOutputPath\en-US" -ShowProgress -Force
	Write-Verbose "Module external help saved to: $moduleOutputPath\en-US" -Verbose
}