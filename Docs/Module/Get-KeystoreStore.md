---
external help file: PSKeystore-help.xml
Module Name: Keystore
online version:
schema: 2.0.0
---

# Get-KeystoreStore

## SYNOPSIS
Gets a store.

## SYNTAX

```
Get-KeystoreStore [[-Name] <String>] [<CommonParameters>]
```

## DESCRIPTION
The **Get-KeystoreStore** function gets one or more Keystore stores. Stores are file paths that have been given friendly names so they can be more easily referenced.

There are two built-in stores: CurrentDirectory and Self. CurrentDirectory is as it sounds, changing as your current location changes. Self is per-user and is set to $Env:USERPROFILE\Documents\Keystore. The Self store is not created by default; you must run **Initialize-Keystore** first.

## EXAMPLES

### Example 1 Get all available stores
```powershell
PS C:\> Get-KeystoreStore

Name             Path           Type IsDefault
----             ----           ---- ---------
CurrentDirectory C:\         BuiltIn      True
Shared           C:\keystore  Custom     False
```

This command gets all available stores.

### Example 2 Get a store by name
```powershell
PS C:\> Get-KeystoreStore -Name Shared

Name   Path          Type IsDefault
----   ----          ---- ---------
Shared C:\keystore Custom     False
```

This command gets the store with the specified name.

## PARAMETERS

### -Name
Specifies the name of the store.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### KeystoreStore

## NOTES

## RELATED LINKS

[Get-KeystoreDefaultStore](./Get-KeystoreDefaultStore.md)

[New-KeystoreStore](./New-KeystoreStore.md)

[Remove-KeystoreStore](./Remove-KeystoreStore.md)

[Set-KeystoreDefaultStore](./Set-KeystoreDefaultStore.md)

[Set-KeystoreStore](./Set-KeystoreStore.md)