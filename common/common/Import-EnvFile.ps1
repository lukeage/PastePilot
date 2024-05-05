function Import-EnvFile {
    param ($filePath)

    if (Test-Path $filePath) {
        $lines = Get-Content $filePath
        foreach ($line in $lines) {
            if ($line -match '^([^=]+)=(.*)$') {
                $name, $value = $matches[1], $matches[2]
                [Environment]::SetEnvironmentVariable($name, $value)
            }
        }
    } else {
        Write-Warning "File not found: $filePath"
    }

    Update-Environment
}