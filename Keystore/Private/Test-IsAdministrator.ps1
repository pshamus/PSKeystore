function Test-IsAdministrator {
	[CmdletBinding()]
	[OutputType([bool])]
	param ()

	$currentUser = [Security.Principal.WindowsIdentity]::GetCurrent()
	(New-Object Security.Principal.WindowsPrincipal $currentUser).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}