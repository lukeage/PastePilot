function Update-Environment {
    $env:PATH = [System.Environment]::GetEnvironmentVariable("PATH", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("PATH", "User")
    foreach ($key in [System.Environment]::GetEnvironmentVariables().Keys) {
        Set-Variable -Name "env:$key" -Value ([System.Environment]::GetEnvironmentVariable($key))
    }
}