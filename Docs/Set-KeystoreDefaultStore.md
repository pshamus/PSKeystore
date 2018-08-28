---
external help file: Keystore-help.xml
Module Name: Keystore
online version:
schema: 2.0.0
---

# Set-KeystoreDefaultStore

## SYNOPSIS
Sets the default store.

## SYNTAX

### ByName (Default)
```
Set-KeystoreDefaultStore -Name <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

### ByObject
```
Set-KeystoreDefaultStore -Store <KeystoreStore> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
The **Set-KeystoreDefaultStore** function marks a store as the default, making it simpler to create Keystore items.

## EXAMPLES

### Example 1 Set default store by pipeline
```powershell
PS C:\> Get-KeystoreStore -Name Shared | Set-KeystoreDefaultStore
```

This command gets the specified store and passes it to the function via the pipeline, making it the default.

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
Specifies the name of a store.

```yaml
Type: String
Parameter Sets: ByName
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Store
Specifies a **KeystoreStore** object.

```yaml
Type: KeystoreStore
Parameter Sets: ByObject
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
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

### KeystoreStore

## OUTPUTS

### None

## NOTES

## RELATED LINKS

[Get-KeystoreStore](./Get-KeystoreStore.md)

[Get-KeystoreDefaultStore](./Get-KeystoreDefaultStore.md)

[New-KeystoreStore](./New-KeystoreStore.md)

[Remove-KeystoreStore](./Remove-KeystoreStore.md)

[Set-KeystoreStore](./Set-KeystoreStore.md)