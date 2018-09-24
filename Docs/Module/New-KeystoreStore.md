---
external help file: PSKeystore-help.xml
Module Name: Keystore
online version:
schema: 2.0.0
---

# New-KeystoreStore

## SYNOPSIS
Creates a new store.

## SYNTAX

```
New-KeystoreStore [-Name] <String> [[-Path] <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
The **New-KeystoreStore** function creates a new store. Stores are file paths that have been given friendly names so they can be more easily referenced.

There are two built-in stores which cannot be altered: CurrentDirectory and Self. CurrentDirectory is as it sounds, changing as your current location changes. Self is per-user and is set to $Env:USERPROFILE\Documents\Keystore. The Self store is not created by default; you must run **Initialize-Keystore** first.

## EXAMPLES

### Example 1
```powershell
PS C:\> New-KeystoreStore -Name Shared -Path C:\keystore

Name   Path          Type IsDefault
----   ----          ---- ---------
Shared C:\keystore Custom     False
```

This command creates a store with the specified name and path.

## PARAMETERS

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name
Specifies the name of the store.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Path
Specifies the file path of the store.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

## OUTPUTS

### KeystoreStore

## NOTES

## RELATED LINKS

[Get-KeystoreDefaultStore](./Get-KeystoreDefaultStore.md)

[Get-KeystoreStore](./Get-KeystoreStore.md)

[Remove-KeystoreStore](./Remove-KeystoreStore.md)

[Set-KeystoreDefaultStore](./Set-KeystoreDefaultStore.md)

[Set-KeystoreStore](./Set-KeystoreStore.md)