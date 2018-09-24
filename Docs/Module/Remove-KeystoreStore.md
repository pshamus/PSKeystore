---
external help file: PSKeystore-help.xml
Module Name: Keystore
online version:
schema: 2.0.0
---

# Remove-KeystoreStore

## SYNOPSIS
Removes a store.

## SYNTAX

```
Remove-KeystoreStore [-Store] <KeystoreStore> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
The **Remove-KeystoreStore** function removes an existing store. Note that the actual file path itself is _not_ deleted.

## EXAMPLES

### Example 1 Remove an existing store
```powershell
PS C:\> Get-KeystoreStore -Name Shared | Remove-KeystoreStore
```

This command removes the store with the specified name.

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

### -Store
Specifies a **KeystoreStore** object.

```yaml
Type: KeystoreStore
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
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

[Get-KeystoreDefaultStore](./Get-KeystoreDefaultStore.md)

[Get-KeystoreStore](./Get-KeystoreStore.md)

[New-KeystoreStore](./New-KeystoreStore.md)

[Set-KeystoreDefaultStore](./Set-KeystoreDefaultStore.md)

[Set-KeystoreStore](./Set-KeystoreStore.md)