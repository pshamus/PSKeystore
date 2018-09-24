---
external help file: PSKeystore-help.xml
Module Name: Keystore
online version:
schema: 2.0.0
---

# New-KeystoreItem

## SYNOPSIS
{{Fill in the Synopsis}}

## SYNTAX

### GenericSecretAndStore (Default)
```
New-KeystoreItem -Name <String> -SecretValue <SecureString> [-StoreName <String>] [-AccessGroup <String>]
 [-Disable] [-Tag <Hashtable>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### GenericSecretAndPath
```
New-KeystoreItem -Name <String> -SecretValue <SecureString> -Path <String> [-AccessGroup <String>] [-Disable]
 [-Tag <Hashtable>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### CredentialAndPath
```
New-KeystoreItem -Name <String> -Credential <PSCredential> -Path <String> [-AccessGroup <String>] [-Disable]
 [-Tag <Hashtable>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### CredentialAndStore
```
New-KeystoreItem -Name <String> -Credential <PSCredential> [-StoreName <String>] [-AccessGroup <String>]
 [-Disable] [-Tag <Hashtable>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
{{Fill in the Description}}

## EXAMPLES

### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

### -AccessGroup
{{Fill AccessGroup Description}}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
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

### -Credential
{{Fill Credential Description}}

```yaml
Type: PSCredential
Parameter Sets: CredentialAndPath, CredentialAndStore
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Disable
{{Fill Disable Description}}

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

### -Name
{{Fill Name Description}}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Path
{{Fill Path Description}}

```yaml
Type: String
Parameter Sets: GenericSecretAndPath, CredentialAndPath
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SecretValue
{{Fill SecretValue Description}}

```yaml
Type: SecureString
Parameter Sets: GenericSecretAndStore, GenericSecretAndPath
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -StoreName
{{Fill StoreName Description}}

```yaml
Type: String
Parameter Sets: GenericSecretAndStore, CredentialAndStore
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Tag
{{Fill Tag Description}}

```yaml
Type: Hashtable
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

### None

## OUTPUTS

### KeystoreItem

## NOTES

## RELATED LINKS
