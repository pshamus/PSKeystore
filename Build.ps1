[CmdletBinding()]
param (
	[Parameter()]
	[ValidateSet('Debug', 'Release')]
	[string]$Configuration = 'Debug'
)

$ErrorActionPreference = 'Stop'

# Ensure the NuGet package provider is installed and the PSGallery repository is trusted.
if (!(Get-PackageProvider -Name 'NuGet' -ForceBootstrap)) {
	Write-Verbose 'Installing NuGet package provider' -Verbose
	$packageProviderParams = @{
		Name           = 'NuGet'
		Force          = $true
		ForceBootstrap = $true
	}
	$null = Install-PackageProvider @packageProviderParams
}
Write-Verbose 'Setting PowerShell Gallery as a trusted PSRepository' -Verbose
Set-PSRepository -Name 'PSGallery' -InstallationPolicy 'Trusted'

# Bootstrap PSDepend module which will be used to download other dependent modules.
if (!(Get-Module -Name 'PSDepend' -ListAvailable)) {
	Write-Verbose 'Bootstrapping PSDepend module from PowerShell Gallery' -Verbose
	$installPSDependParams = @{
		Name         = 'PSDepend'
		Scope        = 'CurrentUser'
		AllowClobber = $true
		Force        = $true
		Confirm      = $false
	}
	Install-Module @installPSDependParams
}

Write-Verbose 'Resolving dependencies and installing any required modules' -Verbose
$psDependParams = @{
	Path  = "$PSScriptRoot\PSDepend.build.psd1"
	Force = $true
}
Invoke-PSDepend @psDependParams

Invoke-Build -Task *
