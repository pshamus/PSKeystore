@{
	PSDependOptions = @{
		AddToPath  = $true
		Target     = 'BuildOutput\Modules'
		Parameters = @{}
	}
	BuildHelpers    = 'latest'
	InvokeBuild     = 'latest'
	Pester          = 'latest'
	platyPS         = 'latest'
}