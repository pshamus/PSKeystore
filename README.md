# Keystore
A simple, file-based secret/credential storage solution to assist in the automation of PowerShell scripts/modules

# Access Groups
Keystore secrets are encrypted using a certificate with Document Encryption extended key usage attribute. The thumbprint of the certificate is referenced when performing the encryption. To make this easier to use, you can use an Access Group, which is an association of a certificate thumbprint to a friendly name.

A special access group called Self is created automatically and uses a locally-generated self-signed certificate.

# Keystores
A keystore is a pre-defined location (path) with a friendly name. This allows for easy access with Get/New-KeystoreItem.

Self store is fixed to $Env:USERPROFILE\Documents\Keystore

# To-Do
- Dynamically download/load JSON .NET libraries
- Upon loading, verify Self store exists and create if necessary
- Add ability to move keystore items between stores and optionally re-encrypt with a different access group
- Create self keystore folder upon module loading?
- Pester tests
- Documentation