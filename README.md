# Keystore
A simple, file-based secret/credential storage solution to assist with automation when using PowerShell scripts/modules.

## Dependencies
The Keystore module is dependent on the [Configuration module by Joel Bennett](https://github.com/PoshCode/Configuration). It can be installed from the PowerShell Gallery by running `Install-Module -Name Configuration -RequiredVersion 1.3.0 -Force`.

# Getting Started
The basic components of the Keystore module are Access Groups, Stores, and Items.

## Access Groups
Keystore secrets are encrypted using a certificate with Document Encryption extended key usage attribute. The thumbprint of the certificate is referenced when performing the encryption. To make this easier to use, you can use an Access Group, which is an association of a certificate thumbprint to a friendly name.

Once a certificate available, it can be added as an Access Group:

`Set-KeystoreAccessGroup -Name 'foo' -CertificateThumbprint 92B8E1A4169853B165F1B0E8F647075A678175F3`

You can list the existing Access Groups with `Get-KeystoreAccessGroup`:

```
PS C:\> Get-KeystoreAccessGroup

Name CertificateThumbprint                      Type IsDefault
---- ---------------------                      ---- ---------
foo  92B8E1A4169853B165F1B0E8F647075A678175F3 Custom      True
```

Changing the default Access Group can be done with `Get-KeystoreAccessGroup -Name 'bar' | Set-KeystoreDefaultAccessGroup`.

## Stores
A Keystore store is a pre-defined location (path) with a friendly name. This allows for easy access with Get/New-KeystoreItem. A built-in store named CurrentDirectory references whatever location you are currently in.

Stores can be created like this:

`Set-KeystoreStore -Name 'foo' -Path 'C:\keystore'`

You can list the available stores with `Get-KeystoreStore`:

```
PS C:\> Get-KeystoreStore

Name             Path           Type IsDefault
----             ----           ---- ---------
CurrentDirectory C:\         BuiltIn      True
foo              C:\keystore  Custom     False
```

Changing the default store can be done with `Get-KeystoreStore -Name 'foo' | Set-KeystoreDefaultStore`.

## Self Access Group/Store
A special built-in access group and store called "Self" is available and uses a locally-generated self-signed certificate. The Self store is fixed to $Env:USERPROFILE\Documents\Keystore. To take advantage of this Access Group, you need to run `Initialize-Keystore`.

## Items
Keystore items are objects that represent what you have protected. There are two types of items, Generic Secret (simple string of text) and Credential (username/password paring). For credential items, the item (file) name can be different than username.

You can create both type of items with the same command, `New-KeystoreItem`. The default Access Group and Store will be used.

To create a generic secret item:

```
PS C:\> New-KeystoreItem -Name mysecret -SecretValue (Read-Host -AsSecureString)
***********


Name        : mysecret
Path        : C:\keystore
Enabled     : True
Created     : 8/22/2018 1:05:02 AM
Updated     : 8/22/2018 1:05:02 AM
ContentType : GenericSecret
Tags        : {}
```

To create a credential item:

```
PS C:\> New-KeystoreItem -Name 'mycred' -Credential (Get-Credential)


Name        : mycred
Path        : C:\keystore
Enabled     : True
Created     : 8/22/2018 1:06:05 AM
Updated     : 8/22/2018 1:06:05 AM
ContentType : Credential
Tags        : {}
```

Keystore items can be retrieved using `Get-KeystoreItem`. The default Store will be used unless otherwise specified with the StoreName parameter.

To decrypt your secret value, retrieve the Keystore item and use the GetSecretValueText() method:

```
PS C:\> (Get-KeystoreItem -Name mysecret).GetSecretValueText()
supersecret
```


# To-Do
- Dynamically download/load JSON .NET libraries
- Add ability to move keystore items between stores and optionally re-encrypt with a different access group
- Pester tests
- Documentation