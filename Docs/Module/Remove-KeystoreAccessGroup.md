---
external help file: PSKeystore-help.xml
Module Name: Keystore
online version:
schema: 2.0.0
---

# Remove-KeystoreAccessGroup

## SYNOPSIS
Removes an access group.

## SYNTAX

```
Remove-KeystoreAccessGroup [-AccessGroup] <KeystoreAccessGroup> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
The **Remove-KeystoreAccessGroup** function removes an existing access group. Note that the actual certificate itself is _not_ deleted.

## EXAMPLES

### Example 1 Remove an existing access group
```powershell
PS C:\> Get-KeystoreAccessGroup -Name Shared | Remove-KeystoreAccessGroup
```

This command removes the access group with the specified name.

## PARAMETERS

### -AccessGroup
Specifies a **KeystoreAccessGroup** object.

```yaml
Type: KeystoreAccessGroup
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
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

[Set-KeystoreAccessGroup](./Set-KeystoreAccessGroup.md)

[Set-KeystoreDefaultAccessGroup](./Set-KeystoreDefaultAccessGroup.md)