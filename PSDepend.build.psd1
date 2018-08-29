@{
	PSDependOptions = @{
		AddToPath  = $true
		Target     = 'BuildOutput\Modules'
		Parameters = @{}
	}
	BuildHelpers    = 'latest'
	Configuration   = @{
		Name    = 'Configuration'
		Version = '1.3.0'
	}
	InvokeBuild     = 'latest'
	Pester          = 'latest'
	platyPS         = 'latest'
}