# Environmental Variables

[Official Documentation](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_environment_variables?view=powershell-7.5)

### System Level Variables (stored in HKLM and accessible by all users on a machine)

```powershell
[Environment]::SetEnvironmentVariable('Foo','Bar')
[Environment]::GetEnvironmentVariable('Foo')
```

### User Level Variables (stored in HKCU and only for one user)

Warning: Keys stored in HKCU ARE NOT encrypted at rest. Consider obfuscating or encypting passwords before storing here.

```powershell
Copy-Item -Path Env:\Foo -Destination Env:\Foo2 -PassThru
Set-Item -Path Env:\Foo2 -Value 'BAR'
Get-Item -Path Env:\Foo*
Remove-Item -Path Env:\Foo* -Verbose
```
