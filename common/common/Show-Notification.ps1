function Show-Notification {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$Message,
        [Parameter(Mandatory=$false)]
        [string]$Title="Notification"
    )

    Add-Type -AssemblyName System.Windows.Forms

    $notification = New-Object System.Windows.Forms.Form
    $notification.Text = $Title
    $notification.Width = 600
    $notification.Height = 400
    $notification.StartPosition = "CenterScreen"
    $notification.TopMost = $true

    $label = New-Object System.Windows.Forms.Label
    $label.Location = New-Object System.Drawing.Point(20, 40)
    $label.Size = New-Object System.Drawing.Size(560, 240)
    $label.Text = $Message
    $notification.Controls.Add($label)

    $okButton = New-Object System.Windows.Forms.Button
    $okButton.Location = New-Object System.Drawing.Point(260, 320)
    $okButton.Size = New-Object System.Drawing.Size(80, 30)
    $okButton.Text = "OK"
    $okButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
    $notification.AcceptButton = $okButton
    $notification.Controls.Add($okButton)

    $notification.ShowDialog() | Out-Null
}