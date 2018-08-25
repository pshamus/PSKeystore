---
external help file: Keystore-help.xml
Module Name: Keystore
online version:
schema: 2.0.0
---

# New-KeystoreAccessGroup

## SYNOPSIS
Creates a new access group.

## SYNTAX

```
New-KeystoreAccessGroup [-Name] <String> [-CertificateThumbprint] <String> [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
The **New-KeystoreAccessGroup** function creates a new access group.

## EXAMPLES

### Example 1
```powershell
PS C:\> New-KeystoreAccessGroup -Name 'Shared' -CertificateThumbprint 92B8E1A4169853B165F1B0E8F647075A678175F3
```

This command creates a new access group using the specified name and certificate thumbprint.

## PARAMETERS

### -CertificateThumbprint
Specifies the thumbprint of the certificate. The certificate must have the Document Encryption enhanced key usage (OID 1.3.6.1.4.1.311.80.1).

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
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
Specifies the name of the access group.

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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

## OUTPUTS

### KeystoreAccessGroup

## NOTES

## RELATED LINKS

[Get-KeystoreAccessGroup](./Get-KeystoreAccessGroup.md)

[Remove-KeystoreAccessGroup](./Remove-KeystoreAccessGroup.md)

[Set-KeystoreAccessGroup](./Set-KeystoreAccessGroup.md)
