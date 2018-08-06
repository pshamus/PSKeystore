enum KeystoreSettingType {
	BuiltIn
	Custom
}

class Keystore {
	[ValidateNotNullOrEmpty()]
	[string]$Name

	[ValidateNotNullOrEmpty()]
	[string]$Path

	[KeystoreSettingType]$Type

	[bool]$IsDefault

	Keystore([string]$name, [string]$path, [KeystoreSettingType]$type, [bool]$isDefault) {
		$this.Name = $name
		$this.Path = $path
		$this.Type = $type
		$this.IsDefault = $isDefault
	}

	[void]Validate() {
		if (Test-Path -Path $this.Path) {
			if (!(Test-Path -Path $this.Path -PathType Container)) {
				throw "Invalid keystore path '$($this.Path)'. A keystore path must be a directory."
			}
		} else {
			throw "The keystore path '$($this.Path)' does not exist or is not accessible."
		}
	}
}

class KeystoreAccessGroup {
	[ValidateNotNullOrEmpty()]
	[string]$Name

	[ValidateNotNullOrEmpty()]
	[string]$CertificateThumbprint

	[KeystoreSettingType]$Type

	[bool]$IsDefault

	KeystoreAccessGroup([string]$name, [string]$certThumbprint, [KeystoreSettingType]$type, [bool]$isDefault) {
		$this.Name = $name
		$this.CertificateThumbprint = $certThumbprint
		$this.Type = $type
		$this.IsDefault = $isDefault
	}

	[bool]IsValidCertificate() {
		$isValid = $false
		$validCertPaths = @('Cert:\CurrentUser\My', 'Cert:\LocalMachine\My')
		foreach ($cert in (Get-ChildItem -Path $validCertPaths -DocumentEncryptionCert -Recurse | Where-Object { $_.Thumbprint -eq $this.CertificateThumbprint })) {
			if ($cert.EnhancedKeyUsageList | Where-Object { $_.ObjectId -eq '1.3.6.1.4.1.311.80.1' }) {
				$isValid = $true
				break
			}
		}
		return $isValid
	}

	[string]ProtectString([securestring]$value) {
		$this.ValidateCertificate()
		Write-Verbose "Encrypting secret value with access group '$($this.Name) ($($this.CertificateThumbprint))'"
		$secretValueText = Unprotect-SecureString -SecureString $value
		$protectedMessage = Protect-CmsMessage -To $this.CertificateThumbprint -Content $secretValueText
		return [System.Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($protectedMessage))
	}

	[void]ValidateCertificate() {
		if (!$this.IsValidCertificate()) {
			throw "The certificate for access group '$($this.Name)' is not valid. Ensure the certificate exists and has the Document Encryption extended key usage."
		}
	}
}

class KeystoreItem {
	[ValidateNotNullOrEmpty()]
	[string]$Name

	[System.IO.FileInfo]$Path

	[ValidateNotNullOrEmpty()]
	[string]$SecretValue

	[KeystoreItemAttributes]$Attributes

	KeystoreItem([string]$name, [string]$secretValue, [KeystoreItemAttributes]$attributes) {
		$this.Name = $name
		$this.SecretValue = $secretValue
		$this.Attributes = $attributes
	}

	[securestring]GetSecretValue() {
		return (ConvertTo-SecureString -String $this.GetSecretValueText() -AsPlainText -Force)
	}

	[string]GetSecretValueText() {
		return (Unprotect-KeystoreSecretValue -Value $this.SecretValue)
	}
}

class KeystoreItemAttributes {
	[bool]$Enabled

	[datetime]$Created

	[datetime]$Updated

	[ValidateSet('Credential', 'GenericSecret')]
	[string]$ContentType

	[ValidateNotNullOrEmpty()]
	[string]$UserName

	[hashtable]$Tags

	KeystoreItemAttributes([bool]$enabled, [datetime]$created, [datetime]$updated, [hashtable]$tags) {
		$this.Enabled = $enabled
		$this.Created = $created
		$this.Updated = $updated
		$this.ContentType = 'GenericSecret'
		$this.Tags = $tags
	}

	KeystoreItemAttributes([bool]$enabled, [datetime]$created, [datetime]$updated, [string]$userName, [hashtable]$tags) {
		$this.Enabled = $enabled
		$this.Created = $created
		$this.Updated = $updated
		$this.ContentType = 'Credential'
		$this.UserName = $userName
		$this.Tags = $tags
	}
}