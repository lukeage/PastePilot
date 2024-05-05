function Invoke-OpenAIChat {
  [CmdletBinding()]
  param (
    [Parameter(Mandatory=$true)]
    [string]$Prompt,

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
              "content" = "You are an AI trained to engage in natural and coherent conversations with users. Your role is to understand user queries and respond in a helpful and accurate manner, tailored to the simplicity or complexity of the user's input. When responding to basic greetings or straightforward questions, keep your replies concise and direct. Expand your responses appropriately when the conversation demands more detailed information or when the user seeks in-depth discussion. Prioritize clarity and avoid over-elaboration unless prompted by the user. Your ultimate goal is to adapt your conversational style to fit the user's needs, ensuring a satisfying and human-like interaction."
          },
          @{
            "role" = "user"
            "content" = $Prompt
        }
      )
      "max_tokens" = $MaxTokens
      "model" = $Model
  } | ConvertTo-Json -Compress

  $response = Invoke-RestMethod -Uri $uri -Method Post -Headers $headers -Body $body

  return ($response.choices)[0].message.content.Trim()
}