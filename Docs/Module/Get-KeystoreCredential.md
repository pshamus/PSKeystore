---
external help file: Keystore-help.xml
Module Name: Keystore
online version:
schema: 2.0.0
---

# Get-KeystoreCredential

## SYNOPSIS
Gets a Keystore item and returns a PSCredential object.

## SYNTAX

### ByObject
```
Get-KeystoreCredential -KeystoreItem <KeystoreItem> [<CommonParameters>]
```

### ByPath
```
Get-KeystoreCredential [-Name <String>] -Path <String> [<CommonParameters>]
```

### ByStore
```
Get-KeystoreCredential [-Name <String>] [-StoreName <String>] [<CommonParameters>]
```

## DESCRIPTION
The Get-KeystoreCredential function gets one or more Keystore items and returns them as a PSCredential object. This is only applicable to Credential Keystore items; GenericSecret items will be skipped.

## EXAMPLES

### Example 1
```powershell
PS C:\> Get-KeystoreCredential -Name myCred
```

Gets the Keystore item myCred and returns it as a PSCredential object.

## PARAMETERS

### -KeystoreItem
Specifies a **KeystoreItem** object. May be passed via the pipeline.

```yaml
Type: KeystoreItem
Parameter Sets: ByObject
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Name
Specifies the name of the Keystore item.

```yaml
Type: String
Parameter Sets: ByPath, ByStore
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Path
Specifies a file path to look for the Keystore item.

```yaml
Type: String
Parameter Sets: ByPath
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -StoreName
Specifies the name of the Keystore store to use. A store has a pre-defined path associated with it.

```yaml
Type: String
Parameter Sets: ByStore
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### KeystoreItem

## OUTPUTS

### System.Management.Automation.PSCredential

## NOTES

## RELATED LINKS

[New-KeystoreCredential](./New-KeystoreCredential.md)
