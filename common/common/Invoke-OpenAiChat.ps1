function Invoke-OpenAIChat {
  [CmdletBinding()]
  param (
    [Parameter(Mandatory=$true)]
    [string]$Prompt,

    [Parameter(Mandatory=$true)]
    [string]$UserPrompt,

    [Parameter(Mandatory=$true)]
    [string]$SystemPrompt,

    [Parameter(Mandatory=$true)]
    [string]$ApiKey,

    [Parameter(Mandatory=$true)]
    [string]$Uri,

    [Parameter(Mandatory=$false)]
    [int]$MaxTokens = 1024,

    [Parameter(Mandatory=$false)]
    [string]$Model = "text-davinci-003"
  )

  $headers = @{
    "Authorization" = "Bearer $ApiKey"
    "Content-Type" = "application/json"
  }

  $body = @{
      "messages" = @(
          @{
              "role" = "system"
              "content" = $SystemPrompt
          },
          @{
            "role" = "user"
            "content" = $UserPrompt + $Prompt
        }
      )
      "max_tokens" = $MaxTokens
      "model" = $Model
  } | ConvertTo-Json -Compress

  $response = Invoke-RestMethod -Uri $uri -Method Post -Headers $headers -Body $body

  return ($response.choices)[0].message.content.Trim()
}