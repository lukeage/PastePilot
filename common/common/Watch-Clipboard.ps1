function Watch-Clipboard {
  param (
    [string]$Sequence
  )

  Add-Type -AssemblyName System.Windows.Forms

  while ($true) {
    Start-Sleep -Milliseconds 500
    $clipText = [System.Windows.Forms.Clipboard]::GetText()
    if ($clipText -like "*$Sequence*") {

      # ACTION ON TRIGGER =============== 
      $Prompt = $clipText
      $response = Invoke-OpenAiChat `
        -Prompt $Prompt `
        -ApiKey $($env:AI_API_KEY) `
        -Uri $($env:AI_API_ENDPOINT) `
        -MaxTokens $($env:AI_MAX_TOKENS) `
        -Model $($env:AI_MODEL)

      [System.Windows.Forms.Clipboard]::SetText("$response".Replace("|||", "| | |"))
      # # =============== ACTION ON TRIGGER
      Write-Host "Clipboard updated!"

      Show-Notification -Message "$response" -Title "AI Response (already in clipboard)"
      
    }
  }
}
