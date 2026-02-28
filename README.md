# Madara's Judgment: "What a Failure" 👺

Hear Uchiha Madara's iconic "Ahh... What a failure" every time a command fails in your terminal. This is a high-quality, cross-platform Antigravity Skill.

## 🚀 Features
- **Cross-Platform Support**: Works on macOS, Linux, and Windows.
- **Background Playback**: Sound plays silently in the background without blocking your terminal.
- **Auto-Repair**: Automatically detects and fixes shell configurations for the best experience.
- **Antigravity Integrated**: Designed to work perfectly with the Antigravity AI IDE.

## 🛠 Installation

### As an Antigravity Skill
Clone this repository into your Antigravity skills directory:

```bash
git clone https://github.com/pragneshkoli/madaras-judgment-fail-sound.git ~/.gemini/antigravity/skills/fail_sound
```

### For Global Terminal Use
To hear Madara's judgment in **every** terminal window, add the following hook to your shell config file.

#### macOS (Zsh) - `~/.zshrc`
```zsh
precmd() {
    local exit_status=$?
    if [ $exit_status -ne 0 ]; then
        bash ~/.gemini/antigravity/skills/fail_sound/scripts/play_fail.sh
    fi
}
```

#### Linux (Bash) - `~/.bashrc`
```bash
export PROMPT_COMMAND='EXIT_STATUS=$?; if [ $EXIT_STATUS -ne 0 ]; then bash ~/.gemini/antigravity/skills/fail_sound/scripts/play_fail.sh; fi'
```

#### Windows (PowerShell) - `$PROFILE`
```powershell
function Prompt {
    $exitStatus = $?
    if (-not $exitStatus) {
        powershell.exe -File "$HOME\.gemini\antigravity\skills\fail_sound\scripts\play_fail.ps1"
    }
    "PS $($ExecutionContext.SessionState.Path.CurrentLocation)> "
}
```

## 📜 Usage
The script is designed to run automatically on command failure once installed. You can also trigger it manually:

- **macOS/Linux**: `bash scripts/play_fail.sh`
- **Windows**: `powershell scripts/play_fail.ps1`

---
Developed by [@pragneshkoli](https://github.com/pragneshkoli)
