---
external help file: Keystore-help.xml
Module Name: Keystore
online version:
schema: 2.0.0
---

# Get-KeystoreAccessGroup

## SYNOPSIS
Gets an access group.

## SYNTAX

```
Get-KeystoreAccessGroup [[-Name] <String>] [<CommonParameters>]
```

## DESCRIPTION
The **Get-KeystoreAccessGroup** function gets one or more access groups. Access groups are certificate thumbprints that have been given friendly names so they can be more easily referenced.

## EXAMPLES

### Example 1 Get all available access groups
```powershell
PS C:\> Get-KeystoreAccessGroup

Name   CertificateThumbprint                       Type IsDefault
----   ---------------------                       ---- ---------
Self   B8EF8F52D5806FDC13B5C10D8859AE0D76953F22 BuiltIn      True
Shared 92B8E1A4169853B165F1B0E8F647075A678175F3  Custom     False
```

This command gets all available access groups.

### Example 2 Get an access group by name
```powershell
PS C:\> Get-KeystoreAccessGroup -Name Shared

Name   CertificateThumbprint                      Type IsDefault
----   ---------------------                      ---- ---------
Shared 92B8E1A4169853B165F1B0E8F647075A678175F3 Custom     False
```

This command gets the access group with the specified name.

## PARAMETERS

### -Name
Specifies the name of the access group.

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

### KeystoreAccessGroup

## NOTES

## RELATED LINKS

[Get-KeystoreDefaultAccessGroup](./Get-KeystoreDefaultAccessGroup.md)

[New-KeystoreAccessGroup](./New-KeystoreAccessGroup.md)

[Remove-KeystoreAccessGroup](./Remove-KeystoreAccessGroup.md)

[Set-KeystoreAccessGroup](./Set-KeystoreAccessGroup.md)

[Set-KeystoreDefaultAccessGroup](./Set-KeystoreDefaultAccessGroup.md)