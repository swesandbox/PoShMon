Function Confirm-SendMonitoringEmail
{
    [CmdletBinding()]
    param(
        $TestOutputValues,
        $SkippedTests,
        $SendEmailOnlyOnFailure,
        $SendEmail,
        $EnvironmentName,
        $EmailBody,
        $MailToList,
        $MailFrom,
        $SMTPAddress,
        [TimeSpan]$TotalElapsedTime
    )

    $noIssuesFound = Confirm-NoIssuesFound $TestOutputValues

    if ($NoIssuesFound -and $SendEmailOnlyOnFailure -eq $true)
    {
        Write-Verbose "No major issues encountered, skipping email"
    } else {
        if ($SendEmail)
        {
            $emailBody = ''
            
            $emailBody += Get-EmailHeader "$EnvironmentName Monitoring Report"

            $emailBody += New-MonitoringEmailOutput -SendEmailOnlyOnFailure $SendEmailOnlyOnFailure -TestOutputValues $TestOutputValues

            $emailBody += Get-EmailFooter $SkippedTests $TotalElapsedTime

            Write-Verbose $EmailBody
 
            Send-MailMessage -Subject "[PoshMon Monitoring] $EnvironmentName Monitoring Results" -Body $emailBody -BodyAsHtml -To $MailToList -From $MailFrom -SmtpServer $SMTPAddress
        }
    }
}