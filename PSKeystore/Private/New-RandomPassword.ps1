function New-RandomPassword {
	#.ExternalHelp Keystore.psm1-Help.xml
	[CmdletBinding()]
	[OutputType([System.Security.SecureString])]
	param(
		[Parameter()]
		[ValidateRange(8, 64)]
		[uint32]$Length = (Get-Random -Minimum 20 -Maximum 32),

		[Parameter()]
		[ValidateRange(0, 8)]
		[uint32]$Complexity = 3
	)

	try {
		$ErrorActionPreference = 'Stop'

		# Generate a password with the specified length and complexity.
		Write-Verbose "Generating password $Length characters in length and with a complexity of $Complexity."
		$password = [System.Web.Security.Membership]::GeneratePassword($Length, $Complexity)

		# Remove any restricted characters that makes the password unfriendly to XML.
		@('"', "'", '<', '>', '&', '/', '!', ';') | ForEach-Object {
			$password = $password.Replace($_, '')
		}

		# Convert the password to a secure string so we don't put plain text passwords on the pipeline.
		ConvertTo-SecureString -String $password -AsPlainText -Force
	} catch {
		$PSCmdlet.ThrowTerminatingError($_)
	} finally {
		$ErrorActionPreference = 'Continue'
	}
}