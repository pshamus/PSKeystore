function IsAssemblyFileNameLoaded {
	param (
		[string]$Name
	)

	[System.Reflection.Assembly[]]$loadedAssemblies = [System.AppDomain]::CurrentDomain.GetAssemblies().Where({ $_.ManifestModule.ScopeName -eq $Name })
	$loadedAssemblies.Where({ [string]::IsNullOrEmpty($_.Location) }).Count -eq 1
}