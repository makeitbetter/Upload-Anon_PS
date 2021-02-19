<#PSScriptInfo

.VERSION 1.1

.GUID cabe1358-d9ac-43fc-9b8e-4917152718a1

.AUTHOR simeononsecurity.ch

.COMPANYNAME SimeonOnSecurity

.COPYRIGHT 2020 SimeonOnSecurity. All rights reserved.

.TAGS AnonFiles Upload File Share FileShare

.PROJECTURI https://github.com/simeononsecurity/Upload-Anon_PS

.DESCRIPTION "Upload to AnonFiles.com easily Ex. 'Upload-Anon -File 'C:\temp\test.txt'"

.RELEASENOTES
Init

#>

function Upload-Anon {
    #Requires -Version 6.0
    param(
        [string]$File 
    )
    If (!$File) {
        Write-Host "Please provide the a file. Ex: Upload-Anon -File 'C:\temp\test.txt'"
    }
    Else {
        Write-Host "Please wait wile the file is uploaded"
        (Invoke-WebRequest -Method "Post" -Uri "https://api.anonfiles.com/upload" -Form @{file = (Get-Item $File) }).content -Split { $_ -eq '"' -or $_ -eq "{" -or $_ -eq "}" -or $_ -eq ',' -or $_ -eq ' ' } | Select-String -NoEmphasis -Pattern 'https' | Out-String | Set-Variable -Name links
        Write-Host "`n"
        Write-Host "Share your files with either of the following links:"
        Write-Host "$links"
    }
}
