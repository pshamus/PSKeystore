---
external help file: PSKeystore-help.xml
Module Name: Keystore
online version:
schema: 2.0.0
---

# Set-KeystoreDefaultAccessGroup

## SYNOPSIS
Sets the default access group.

## SYNTAX

### ByName (Default)
```
Set-KeystoreDefaultAccessGroup -Name <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

### ByObject
```
Set-KeystoreDefaultAccessGroup -AccessGroup <KeystoreAccessGroup> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
The **Set-KeystoreDefaultAccessGroup** function marks an access group as the default, making it simpler to create Keystore items.

## EXAMPLES

### Example 1 Set default access group by pipeline
```powershell
PS C:\> Get-KeystoreAccessGroup -Name Shared | Set-KeystoreDefaultAccessGroup
```

This command gets the specified access group and passes it to the function via the pipeline, making it the default.

## PARAMETERS

### -AccessGroup
Specifies a **KeystoreAccessGroup** object.

```yaml
Type: KeystoreAccessGroup
Parameter Sets: ByObject
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

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
Specifies the name of an access group.

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

### KeystoreAccessGroup

## OUTPUTS

### None

## NOTES

## RELATED LINKS

[Get-KeystoreAccessGroup](./Get-KeystoreAccessGroup.md)

[Get-KeystoreDefaultAccessGroup](./Get-KeystoreDefaultAccessGroup.md)

[New-KeystoreAccessGroup](./New-KeystoreAccessGroup.md)

[Remove-KeystoreAccessGroup](./Remove-KeystoreAccessGroup.md)

[Set-KeystoreAccessGroup](./Set-KeystoreAccessGroup.md)