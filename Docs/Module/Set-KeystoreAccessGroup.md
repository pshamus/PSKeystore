---
external help file: PSKeystore-help.xml
Module Name: Keystore
online version:
schema: 2.0.0
---

# Set-KeystoreAccessGroup

## SYNOPSIS
Modifies an access group.

## SYNTAX

```
Set-KeystoreAccessGroup [-AccessGroup] <KeystoreAccessGroup> [-CertificateThumbprint] <String> [-PassThru]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
The **Set-KeystoreAccessGroup** function modifies an existing access group.

## EXAMPLES

### Example 1 Modify certificate thumbprint
```powershell
PS C:\> Get-KeystoreAccessGroup -Name Shared | Set-KeystoreAccessGroup -CertificateThumbprint 26B2A36D6BFB71B88503C5F78BEC25985DDB9702
```

This command sets the certificate thumbprint for the specified access group.

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

### -CertificateThumbprint
Specifies the thumbprint of the certificate. The certificate must have the Document Encryption enhanced key usage (OID 1.3.6.1.4.1.311.80.1).


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

### KeystoreAccessGroup

## OUTPUTS

### KeystoreAccessGroup

## NOTES

## RELATED LINKS

[Get-KeystoreAccessGroup](./Get-KeystoreAccessGroup.md)

[Get-KeystoreDefaultAccessGroup](./Get-KeystoreDefaultAccessGroup.md)

[New-KeystoreAccessGroup](./New-KeystoreAccessGroup.md)

[Remove-KeystoreAccessGroup](./Remove-KeystoreAccessGroup.md)

[Set-KeystoreDefaultAccessGroup](./Set-KeystoreDefaultAccessGroup.md)