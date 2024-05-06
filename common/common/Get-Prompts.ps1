function Get-Prompts {
    param (
      [string]$text,
      [string]$TriggerSequence,
      [string]$SplitSequence,
      [ValidateScript({Test-Path $_})]
      [string]$PathToSystemPrompts,
      [ValidateScript({Test-Path $_})]
      [string]$PathToUserPrompts
    )
    
    $SystemPromptIds = (Get-ChildItem -Path $PathToSystemPrompts -Filter *.md).BaseName
    $UserPromptIds = (Get-ChildItem -Path $PathToUserPrompts -Filter *.md).BaseName

    # split ||| 
    $TextToProcess = $text.split("$TriggerSequence",2)[1].trim()

    # split and get last:
    $splittedText =  $TextToProcess.split("$SplitSequence",3)
    $Prompt = $splittedText[-1].Trim()
    if ($splittedText.Count -gt 2) {
        $SystemPromptId = $splittedText[0].Trim()
        $UserPromptId = $splittedText[-2].Trim()
    } elseif ($splittedText.Count -gt 1 ) {
        $SystemPromptId = $splittedText[0].Trim()
        $UserPromptId = "default"
    } else {
        $SystemPromptId = "default"
        $UserPromptId = "default"
    }
    
    if ($SystemPromptId -in $SystemPromptIds) {
        Write-Verbose "Using '$SystemPromptId' System Prompt"
        $SystemPrompt = Get-Content -Path (Join-Path $PathToSystemPrompts "$SystemPromptId.md")
    } else {
        Write-Verbose "Using default System Prompt ... "
        $SystemPrompt = Get-Content -Path (Join-Path $PathToSystemPrompts "default.md")
    }

    if ($UserPromptId -in $UserPromptIds) {
        Write-Verbose "Using '$UserPromptId' User Prompt"
        $UserPrompt = Get-Content -Path (Join-Path $PathToUserPrompts "$UserPromptId.md")
    } else {
        Write-Verbose "Using default User Prompt ... "
        $UserPrompt = Get-Content -Path (Join-Path $PathToUserPrompts "default.md")
    }

    return $SystemPrompt, $UserPrompt, $Prompt
}
