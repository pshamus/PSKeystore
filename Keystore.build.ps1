[CmdletBinding()]
param ()

task InitializeBuildEnvironment {
	Set-BuildEnvironment -Force
	Get-BuildEnvironment
}

task CleanBuildOutputFolder {
	$Script:moduleOutputPath = Join-Path -Path $Env:BHBuildOutput -ChildPath $Env:BHProjectName
	$Script:moduleOutputManifest = "$moduleOutputPath\$Env:BHProjectName.psd1"
	#if (Test-Path -Path $moduleOutputPath) {
		Write-Verbose 'Clearing build output folder' -Verbose
		Get-ChildItem -Path $Env:BHBuildOutput -Exclude Modules | Remove-Item -Recurse -Force
	#}
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

task CreateArtifact -if ($Configuration -eq 'Release') {
	Write-Verbose "Creating $Env:BHProjectName module artifact" -Verbose
	$repoName = 'LocalGallery'
	$repoPath = "$Env:BHBuildOutput\$repoName"
	if (!(Test-Path -Path $repoPath)) {
		$null = New-Item -Path $repoPath -ItemType Directory -Force
	}
	Register-PSRepository -Name $repoName -SourceLocation $repoPath -InstallationPolicy Trusted
	Write-Verbose 'Publishing required modules to a temporary local repository' -Verbose
	foreach ($requiredModule in (Get-Module -Name $Env:BHProjectName).RequiredModules) {
		Publish-Module -Name $requiredModule.Name -RequiredVersion $requiredModule.Version -Repository $repoName
	}
	if (!($Env:PSModulePath.Split(';').Contains((Get-Module -Name $Env:BHProjectName).ModuleBase))) {
		$Env:PSModulePath = (Get-Module -Name $Env:BHProjectName).ModuleBase + ";$Env:PSModulePath"
	}
	Write-Verbose 'Publishing module to temporary local repository' -Verbose
	Publish-Module -Name $Env:BHProjectName -Repository $repoName

	Write-Verbose 'Removing required modules from temporary local repository' -Verbose
	Get-ChildItem -Path $repoPath -Exclude $Env:BHProjectName* | Remove-Item

	Unregister-PSRepository -Name $repoName
}