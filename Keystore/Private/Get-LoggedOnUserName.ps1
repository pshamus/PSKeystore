function Get-LoggedOnUserName {
	#.ExternalHelp Keystore.psm1-Help.xml
	[CmdletBinding()]
	[OutputType([string])]
	param (
		[Parameter()]
		[ValidateNotNullOrEmpty()]
		[ValidateSet('UserPrincipalName', 'DownLevelLogonName', 'ShortUserName')]
		[string]$Format
	)

	$ErrorActionPreference = 'Stop'

	try {
		$username = $Env:USERNAME
		$domainName = $Env:USERDOMAIN
		$dnsDomainName = $Env:USERDNSDOMAIN.ToLower()
		switch ($Format) {
			'UserPrincipalName' {
				'{0}@{1}' -f $username.ToLower(), $dnsDomainName
			}
			'ShortUserName' {
				$username
			}
			default {
				'{0}\{1}' -f $domainName, $username
			}
		}
	} catch {
		$PSCmdlet.ThrowTerminatingError($_)
	}
}