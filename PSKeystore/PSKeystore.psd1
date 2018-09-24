@{
	RootModule        = 'PSKeystore.psm1'
	ModuleVersion     = '0.0.1'
	GUID              = 'db8cdab0-3635-4a04-bd5d-e8439e34c153'
	Author            = 'Paul Shamus'
	CompanyName       = 'Dusk Consulting'
	Copyright         = '(c) Dusk Consulting. All rights reserved.'
	Description       = 'A simple, file-based secret/credential storage solution to assist in the automation of PowerShell scripts/modules'
	PowerShellVersion = '5.0'
	CLRVersion        = '4.0'
	RequiredModules   = @(
		@{ ModuleName = 'Configuration'; ModuleVersion = '1.3.0' }
	)
	ScriptsToProcess  = @('.\Classes\KeystoreClasses.ps1')
	FormatsToProcess  = @('PSKeystore.Format.ps1xml')
	FunctionsToExport = @('*')
	PrivateData       = @{
		PSData = @{
			Tags                       = @('Certificates', 'Security', 'Credentials')
			IconUri                    = ''
			ProjectUri                 = 'https://github.com/pshamus/PSKeystore'
			LicenseUri                 = ''
			ReleaseNotes               = ''
			RequireLicenseAcceptance   = ''
			Prerelease                 = 'true'
		}
	}
}