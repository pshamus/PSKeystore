function ValidateKeystoreItemName {
	[CmdletBinding()]
	param(
		[Parameter(Mandatory)]
		[string]$Name
	)

	if ($Name.IndexOfAny([System.IO.Path]::GetInvalidFileNameChars()) -ge 0 -and !$Name.Contains('\')) {
		throw (New-Object System.ArgumentException("Keystore item name '{0}' contains invalid characters. Only valid filename characters are allowed." -f $Name));
	}
}