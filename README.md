# Keystore
A simple, file-based secret/credential storage solution to assist in the automation of PowerShell scripts/modules

# Access Groups
Keystore secrets are encrypted using a certificate with Document Encryption extended key usage attribute. The thumbprint of the certificate is referenced when performing the encryption. To make this easier to use, you can use an Access Group, which is an association of a certificate thumbprint to a friendly name.

A special access group called Self is created automatically and uses a locally-generated self-signed certificate.

# Stores
A keystore store is a pre-defined location (path) with a friendly name. This allows for easy access with Get/New-KeystoreItem.

Self store is fixed to <ConfigurationPath>\Keystore

# To-Do
- Dynamically download/load JSON .NET libraries
- Function to initialize keystore (e.g. create Self keystore folder/certificate/configuration folder)
- Add ability to move keystore items between stores and optionally re-encrypt with a different access group
- Pester tests
- Documentation