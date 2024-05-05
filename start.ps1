$PastePilotDir = Split-Path ($MyInvocation.MyCommand.Path) -Parent
Import-Module (Join-Path $PastePilotDir "\common\common.psm1") -Force
Import-EnvFile -FilePath (Join-Path $PastePilotDir ".env.prod")


Write-Host @"
=============================================
 ____           _       ____  _ _       _  
|  _ \ ___  ___| |_ ___|  _ \(_) | ___ | |_ 
| |_) / _  / __| __/ _ \ |_) | | |/ _ \| __|
|  __/ (_| \__ \ ||  __/  __/| | | (_) | |_ 
|_|   \__,_|___/\__\___|_|   |_|_|\___/ \__|

================  Settings  =================

AI_API_ENDPOINT = '$($env:AI_API_ENDPOINT)
AI_MODEL = '$($env:AI_MODEL)'
AI_MAX_TOKENS = '$($env:AI_MAX_TOKENS)'
CLIPBOARD_TRIGGER_SEQUENCE = '$($env:CLIPBOARD_TRIGGER_SEQUENCE)'

=================  How To?  =================
1) Copy any text. 
   If the text contains '$($env:CLIPBOARD_TRIGGER_SEQUENCE)' 
    - The clipboard will be send to '$($env:AI_API_ENDPOINT)'
      and a popup with the <response> will show up.
    - The clipboard will also be replaced with the response.

2) To check whether everything works copy the following text:
    -----------------------------------------
    $($env:CLIPBOARD_TRIGGER_SEQUENCE) Hi, tell me a funny joke :-).
    -----------------------------------------

==================  Start  ==================
Waiting for trigger '$($env:CLIPBOARD_TRIGGER_SEQUENCE) <your-text>' ...
"@

Watch-Clipboard -Sequence "$($env:CLIPBOARD_TRIGGER_SEQUENCE)"