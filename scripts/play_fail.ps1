# play_fail.ps1 for Windows

if ($args[0] -ne "--child") {
    # Self-backgrounding for Windows PowerShell
    Start-Process powershell.exe -ArgumentList "-File `"$PSCommandPath`" --child" -WindowStyle Hidden
    exit
}

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$CustomSoundPath = Join-Path $ScriptDir "..\assets\madara_saying_what_a_failure.mp3"

if (Test-Path $CustomSoundPath) {
    $Player = New-Object System.Media.SoundPlayer
    $Player.SoundLocation = $CustomSoundPath
    $Player.PlaySync()
}
else {
    # Beep if custom sound is missing
    [System.Console]::Beep(440, 500)
}
