<#
	===========================================================================
	Organization:	Dusk Consulting
	Filename:		Keystore.psd1
	-------------------------------------------------------------------------
	Module Manifest
	-------------------------------------------------------------------------
	Module Name:	Keystore
	===========================================================================
#>

@{
	RootModule         = 'Keystore.psm1'
	ModuleVersion      = '2.0.0'
	GUID               = 'db8cdab0-3635-4a04-bd5d-e8439e34c153'
	Author             = 'Paul Shamus'
	CompanyName        = 'Dusk Consulting'
	Copyright          = '(c) Dusk Consulting. All rights reserved.'
	PowerShellVersion  = '5.0'
	CLRVersion         = '4.0'
	RequiredModules    = @(
		@{ ModuleName = 'Configuration'; ModuleVersion = '1.3.0' }
	)
	RequiredAssemblies = @('Newtonsoft.Json.dll', 'Newtonsoft.Json.Schema.dll')
	FormatsToProcess   = @('Keystore.Format.ps1xml')
	ScriptsToProcess   = @('.\Classes\KeystoreClasses.ps1')
	FunctionsToExport  = @('*')
	FileList           = @()
	PrivateData        = @{
		PSData = @{
			Category                 = 'Automation'
			Tags                     = @('PowerShell')
			IconUri                  = ''
			ProjectUri               = ''
			LicenseUri               = ''
			ReleaseNotes             = ''
			RequireLicenseAcceptance = ''
			IsPrerelease             = 'false'
		}
	}
}