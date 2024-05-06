function Watch-Clipboard {
  param (
    [string]$TriggerSequence,
    [string]$SplitSequence,
    [ValidateScript({Test-Path $_})]
    [string]$PathToSystemPrompts,
    [ValidateScript({Test-Path $_})]
    [string]$PathToUserPrompts
  )

  Add-Type -AssemblyName System.Windows.Forms

  while ($true) {
    Start-Sleep -Milliseconds 500
    $clipText = [System.Windows.Forms.Clipboard]::GetText()
    if ($clipText -like "*$TriggerSequence*") {
      $SystemPrompt, $UserPrompt, $Prompt = Get-Prompts `
        -text $clipText `
        -TriggerSequence $TriggerSequence `
        -SplitSequence $SplitSequence `
        -PathToSystemPrompts $PathToSystemPrompts `
        -PathToUserPrompts $PathToUserPrompts
      
      # ACTION ON TRIGGER ===============
      $response = Invoke-OpenAiChat `
        -Prompt $Prompt `
        -UserPrompt $UserPrompt `
        -SystemPrompt $SystemPrompt `
        -ApiKey $($env:AI_API_KEY) `
        -Uri $($env:AI_API_ENDPOINT) `
        -MaxTokens $($env:AI_MAX_TOKENS) `
        -Model $($env:AI_MODEL)

      [System.Windows.Forms.Clipboard]::SetText("$response".Replace("$TriggerSequence", "<trigger>"))
      Write-Host "Clipboard updated!"

      Show-Notification -Message "$response" -Title "AI Response (already in clipboard)"
      # # =============== ACTION ON TRIGGER

      
    }
  }
}
