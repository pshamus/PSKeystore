---
external help file: Keystore-help.xml
Module Name: Keystore
online version:
schema: 2.0.0
---

# Set-KeystoreStore

## SYNOPSIS
Modifies a store.

## SYNTAX

```
Set-KeystoreStore [-Store] <KeystoreStore> [-Path] <String> [-PassThru] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
The **Set-KeystoreStore** function modifies an existing store.

## EXAMPLES

### Example 1 Modify store path
```powershell
PS C:\> Get-KeystoreStore -Name Shared | Set-KeystoreStore -Path C:\keystore
```

This command sets the store file path for the specified store.

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

### -PassThru
Returns an object representing the item with which you are working. By default, this function does not generate any output.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Path
Specifies the file path of the store.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
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

### System.String

### KeystoreStore

## OUTPUTS

### KeystoreStore

## NOTES

## RELATED LINKS

[Get-KeystoreStore](./Get-KeystoreStore.md)

[Get-KeystoreDefaultStore](./Get-KeystoreDefaultStore.md)

[New-KeystoreStore](./New-KeystoreStore.md)

[Remove-KeystoreStore](./Remove-KeystoreStore.md)

[Set-KeystoreDefaultStore](./Set-KeystoreDefaultStore.md)