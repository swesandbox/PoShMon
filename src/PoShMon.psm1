$scriptFiles  = @( Get-ChildItem -Path $PSScriptRoot\Functions\*\*.ps1 -ErrorAction SilentlyContinue )

Foreach($import in $scriptFiles)
{
    Try
    {
        . $import.fullname

        #if ($import.FullName.Contains("PoShMon.Configuration") -or $scriptFiles.Basename.StartsWith("Invoke-") )
        #    { Export-ModuleMember -Function $import.BaseName }
    }
    Catch
    {
        Write-Error -Message "Failed to import function $($import.fullname): $_"
    }
}

New-Alias -Name "General" -Value "New-GeneralConfig"
New-Alias -Name "OperatingSystem" -Value "New-OSConfig"
New-Alias -Name "Notifications" -Value "New-NotificationsConfig"
New-Alias -Name "Email" -Value "New-EmailConfig"
New-Alias -Name "Extensibility" -Value "New-ExtensibilityConfig"
New-Alias -Name "O365Teams" -Value "New-O365TeamsConfig"
New-Alias -Name "OperationValidationFramework" -Value "New-OperationValidationFrameworkConfig"
New-Alias -Name "Pushbullet" -Value "New-PushbulletConfig"
New-Alias -Name "SharePoint" -Value "New-SharePointConfig"
New-Alias -Name "WebSite" -Value "New-WebSiteConfig"
New-Alias -Name "Twilio" -Value "New-TwilioConfig"

#Export-ModuleMember -Function $scriptFiles.Basename
#. $PSScriptRoot\Functions\PoShMon.Shared\Get-EmailFooter.ps1
