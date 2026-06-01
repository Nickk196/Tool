# Load required assemblies
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
Add-Type -Name User32 -Namespace Win32 -MemberDefinition @"
[DllImport("user32.dll")] public static extern bool ReleaseCapture();
[DllImport("user32.dll")] public static extern int SendMessage(IntPtr hWnd, int Msg, int wParam, int lParam);
"@

# --- COLORS (DISCORD / DARK THEME) ---
 $ColorWindowBg     = [System.Drawing.Color]::FromArgb(54, 57, 63)    
 $ColorTabBg        = [System.Drawing.Color]::FromArgb(47, 49, 54)    
 $ColorBtn          = [System.Drawing.Color]::FromArgb(71, 74, 80)    
 $ColorBtnHover     = [System.Drawing.Color]::FromArgb(88, 101, 242)  
 $ColorText         = [System.Drawing.Color]::White
 $ColorLogBg        = [System.Drawing.Color]::Black
 $ColorLogText      = [System.Drawing.Color]::LimeGreen

# --- DEFINE ALL TOOLS ---
 $ToolData = @(
    # --- ORBDIFF ---
    @{ Name="PrefetchView"; Category="Orbdiff"; Type="GitHub"; URL="https://github.com/Orbdiff/PrefetchView/releases/tag/v1.6.7" },
    @{ Name="BAMReveal"; Category="Orbdiff"; Type="GitHub"; URL="https://github.com/Orbdiff/BAMReveal/releases/tag/v1.3.1" },
    @{ Name="StringsParser"; Category="Orbdiff"; Type="GitHub"; URL="https://github.com/Orbdiff/StringsParser/releases/tag/v1.0" },
    @{ Name="Fileless"; Category="Orbdiff"; Type="GitHub"; URL="https://github.com/Orbdiff/Fileless/releases/tag/v1.3" },
    @{ Name="DPS-Analyzer"; Category="Orbdiff"; Type="GitHub"; URL="https://github.com/Orbdiff/DPS-Analyzer/releases/tag/v1.1" },
    @{ Name="UserAssistView"; Category="Orbdiff"; Type="GitHub"; URL="https://github.com/Orbdiff/UserAssistView/releases/tag/v1.0" },
    @{ Name="JournalParser"; Category="Orbdiff"; Type="GitHub"; URL="https://github.com/Orbdiff/JournalParser/releases/tag/v1.2" },
    @{ Name="InjGen"; Category="Orbdiff"; Type="GitHub"; URL="https://github.com/Orbdiff/InjGen/releases/tag/fork" },
    @{ Name="USBDetector"; Category="Orbdiff"; Type="GitHub"; URL="https://github.com/Orbdiff/USBDetector/releases/tag/v1.1" },
    @{ Name="PFTrace"; Category="Orbdiff"; Type="GitHub"; URL="https://github.com/Orbdiff/PFTrace/releases/tag/v1.0.1" },
    @{ Name="CheckDeletedUSN"; Category="Orbdiff"; Type="GitHub"; URL="https://github.com/Orbdiff/CheckDeletedUSN/releases/tag/v0.2.1" },
    @{ Name="JARParser"; Category="Orbdiff"; Type="GitHub"; URL="https://github.com/Orbdiff/JARParser/releases/tag/v1.2" },

    # --- SPOKWN ---
    @{ Name="BAM-parser"; Category="Spokwn"; Type="GitHub"; URL="https://github.com/spokwn/BAM-parser/releases/tag/v1.2.9" },
    @{ Name="PathsParser"; Category="Spokwn"; Type="GitHub"; URL="https://github.com/spokwn/PathsParser/releases/tag/v1.2" },
    @{ Name="JournalTrace"; Category="Spokwn"; Type="GitHub"; URL="https://github.com/spokwn/JournalTrace/releases/tag/1.2" },
    @{ Name="KernelLiveDumpTool"; Category="Spokwn"; Type="GitHub"; URL="https://github.com/spokwn/KernelLiveDumpTool/releases/tag/v1.1" },
    @{ Name="BamDeletedKeys"; Category="Spokwn"; Type="GitHub"; URL="https://github.com/spokwn/BamDeletedKeys/releases/tag/v1.0" },
    @{ Name="Tool"; Category="Spokwn"; Type="GitHub"; URL="https://github.com/spokwn/Tool/releases/tag/v1.1.3" },
    @{ Name="pcasvc-executed"; Category="Spokwn"; Type="GitHub"; URL="https://github.com/spokwn/pcasvc-executed/releases/tag/v0.8.7" },
    @{ Name="process-parser"; Category="Spokwn"; Type="GitHub"; URL="https://github.com/spokwn/process-parser/releases/tag/v0.5.5" },
    @{ Name="prefetch-parser"; Category="Spokwn"; Type="GitHub"; URL="https://github.com/spokwn/prefetch-parser/releases/tag/v1.5.5" },
    @{ Name="ActivitiesCache"; Category="Spokwn"; Type="GitHub"; URL="https://github.com/spokwn/ActivitiesCache-execution/releases/tag/v0.6.5" },

    # --- TONYNOH ---
    @{ Name="MeowDoomsdayFucker"; Category="Tonynoh"; Type="GitHub"; URL="https://github.com/MeowTonynoh/MeowDoomsdayFucker/releases/tag/V.1.2" },
    @{ Name="MeowModAnalyzer"; Category="Tonynoh"; Type="Cmd"; Command="Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/MeowTonynoh/MeowModAnalyzer/main/MeowModAnalyzer.ps1')" },
    @{ Name="MeowResolver"; Category="Tonynoh"; Type="GitHub"; URL="https://github.com/MeowTonynoh/MeowResolver/releases/tag/MeowResolver" },
    @{ Name="MeowNovowareFucker"; Category="Tonynoh"; Type="GitHub"; URL="https://github.com/MeowTonynoh/MeowNovowareFucker/releases/tag/V1" },
    @{ Name="MeowImportsChecker"; Category="Tonynoh"; Type="GitHub"; URL="https://github.com/MeowTonynoh/MeowImportsChecker/releases/tag/MeowImportsChecker" },

    # --- PRAISELILY ---
    @{ Name="PSHunter"; Category="Praiselily"; Type="GitHub"; URL="https://github.com/praiselily/PSHunter/releases/tag/Built" },
    @{ Name="AltDetector"; Category="Praiselily"; Type="GitHub"; URL="https://github.com/praiselily/AltDetector/releases/tag/Detector" },
    @{ Name="HotspotLogs"; Category="Praiselily"; Type="Cmd"; Command="iwr https://raw.githubusercontent.com/praiselily/WeHateFakers/refs/heads/main/HotspotLogs.ps1 | iex" },
    @{ Name="CommonDirectories"; Category="Praiselily"; Type="Cmd"; Command="Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/praiselily/lilith-ps/refs/heads/main/CommonDirectories.ps1')" },
    @{ Name="HarddiskConverter"; Category="Praiselily"; Type="Cmd"; Command="Invoke-Expression (Invoke-RestMethod https://raw.githubusercontent.com/praiselily/lilith-ps/refs/heads/main/HarddiskConverter.ps1)" },
    @{ Name="Services"; Category="Praiselily"; Type="Cmd"; Command="Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/praiselily/lilith-ps/refs/heads/main/Services.ps1')" },
    @{ Name="Signed-Scheduled-Tasks"; Category="Praiselily"; Type="Cmd"; Command="Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/praiselily/lilith-ps/refs/heads/main/Signed-Scheduled-Tasks.ps1')" },

    # --- REDLOTUS ---
    @{ Name="RedLotus-Mod-Analyzer"; Category="RedLotus"; Type="GitHub"; URL="https://github.com/ItzIceHere/RedLotus-Mod-Analyzer/releases/tag/RL" },
    @{ Name="RedLotus-Task-Sentinel"; Category="RedLotus"; Type="GitHub"; URL="https://github.com/ItzIceHere/RedLotus-Task-Sentinel/releases/tag/RL" },
    @{ Name="RedLotusAltChecker"; Category="RedLotus"; Type="GitHub"; URL="https://github.com/ItzIceHere/RedLotusAltChecker/releases/tag/RL" },

    # --- OTHERS ---
    @{ Name="WinPrefetchView (NirSoft)"; Category="Others"; Type="Web"; URL="https://www.nirsoft.net/utils/win_prefetch_view.html" },
    @{ Name="CompActivityView (NirSoft)"; Category="Others"; Type="Web"; URL="https://www.nirsoft.net/utils/computer_activity_view.html" },
    @{ Name="AmcacheParser (EZ Tools)"; Category="Others"; Type="Web"; URL="https://download.ericzimmermanstools.com/net9/AmcacheParser.zip" },
    @{ Name="SystemInformer"; Category="Others"; Type="Web"; URL="https://www.systeminformer.com/canary" },
    @{ Name="DIE-engine"; Category="Others"; Type="Web"; URL="https://github.com/horsicq/DIE-engine/releases" },
    @{ Name="DQRKIS-FUCKER"; Category="Others"; Type="Cmd"; Command="Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/cheesecatlol/DQRKIS-FUCKER/refs/heads/main/DqrkisFucker.ps1')" },
    @{ Name="MacroDetector"; Category="Others"; Type="Cmd"; Command="Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/Nickk196/MacroDetector/refs/heads/main/MacroDetector.ps1')" }
)

# --- HELPER FUNCTION ---
function Get-GitHubExeUrl {
    param([string]$ReleaseUrl)
    if ($ReleaseUrl -match "github\.com/([^/]+)/([^/]+)/releases/tag/([^/]+)") {
        $User = $matches[1]; $Repo = $matches[2]; $Tag = $matches[3]
        $ApiUrl = "https://api.github.com/repos/$User/$Repo/releases/tags/$Tag"
        try {
            $ProgressPreference = 'SilentlyContinue'
            $Response = Invoke-RestMethod -Uri $ApiUrl -ErrorAction Stop
            $ProgressPreference = 'Continue'
            $Asset = $Response.assets | Where-Object { $_.name -like "*.exe" } | Select-Object -First 1
            if ($Asset) { return $Asset.browser_download_url }
        } catch { }
    }
    return $null
}

# --- CREATE FORM ---
 $Form = New-Object System.Windows.Forms.Form
 $Form.Text = "ScreenShare Tool"
 $Form.Size = New-Object System.Drawing.Size(1100, 750)
 $Form.StartPosition = "CenterScreen"
 $Form.BackColor = $ColorWindowBg
 $Form.FormBorderStyle = "None"
 $Form.TopLevel = $true

# Draggable
 $Form.Add_MouseDown({
    if ($_.Button -eq [System.Windows.Forms.MouseButtons]::Left) {
        [Win32.User32]::ReleaseCapture()
        [Win32.User32]::SendMessage($Form.Handle, 0x0112, 0xF012, 0)
    }
})

# --- HEADER (TOP) ---
 $HeaderPanel = New-Object System.Windows.Forms.Panel
 $HeaderPanel.Height = 40
 $HeaderPanel.Dock = "Top"
 $HeaderPanel.BackColor = $ColorTabBg
 $Form.Controls.Add($HeaderPanel)

 $TitleLabel = New-Object System.Windows.Forms.Label
 $TitleLabel.Text = "ScreenShare Tool (discord.gg/cfnmHrqP3K)"
 $TitleLabel.Font = New-Object System.Drawing.Font("Segoe UI", 11, [System.Drawing.FontStyle]::Bold)
 $TitleLabel.ForeColor = [System.Drawing.Color]::White
 $TitleLabel.Location = New-Object System.Drawing.Point(10, 10)
 $TitleLabel.AutoSize = $true
 $HeaderPanel.Controls.Add($TitleLabel)

 $CloseBtn = New-Object System.Windows.Forms.Button
 $CloseBtn.Text = "✕"
 $CloseBtn.Size = New-Object System.Drawing.Size(30, 30)
 $CloseBtn.Location = New-Object System.Drawing.Point(1055, 5)
 $CloseBtn.BackColor = [System.Drawing.Color]::Transparent
 $CloseBtn.ForeColor = [System.Drawing.Color]::White
 $CloseBtn.FlatStyle = "Flat"
 $CloseBtn.Font = New-Object System.Drawing.Font("Segoe UI", 12)
 $CloseBtn.Cursor = [System.Windows.Forms.Cursors]::Hand
 $CloseBtn.Add_Click({ $Form.Close() })
 $HeaderPanel.Controls.Add($CloseBtn)

 $MinBtn = New-Object System.Windows.Forms.Button
 $MinBtn.Text = "—"
 $MinBtn.Size = New-Object System.Drawing.Size(30, 30)
 $MinBtn.Location = New-Object System.Drawing.Point(1020, 5)
 $MinBtn.BackColor = [System.Drawing.Color]::Transparent
 $MinBtn.ForeColor = [System.Drawing.Color]::White
 $MinBtn.FlatStyle = "Flat"
 $MinBtn.Font = New-Object System.Drawing.Font("Segoe UI", 16)
 $MinBtn.Cursor = [System.Windows.Forms.Cursors]::Hand
 $MinBtn.Add_Click({ $Form.WindowState = "Minimized" })
 $HeaderPanel.Controls.Add($MinBtn)

# --- SPLIT CONTAINER (Main Layout) ---
# Panel 1: Tab Content (Top/Right). Panel 2: Log (Bottom).
 $SplitContainer = New-Object System.Windows.Forms.SplitContainer
 $SplitContainer.Dock = "Fill"
 $SplitContainer.SplitterDistance = 550 # 550px for tabs, rest for log
 $SplitContainer.Panel2MinSize = 100
 $Form.Controls.Add($SplitContainer)

# --- PANEL 1: TAB CONTENT ---
 $TabPanel = $SplitContainer.Panel1
 $TabPanel.BackColor = $ColorWindowBg

 $TabControl = New-Object System.Windows.Forms.TabControl
 $TabControl.Dock = "Fill"
 $TabControl.BackColor = $ColorWindowBg
 $TabPanel.Controls.Add($TabControl)

# --- PANEL 2: LOG OUTPUT ---
 $LogPanel = $SplitContainer.Panel2
 $LogPanel.BackColor = $ColorLogBg

 $OutputLog = New-Object System.Windows.Forms.TextBox
 $OutputLog.Dock = "Fill"
 $OutputLog.Multiline = $true
 $OutputLog.ScrollBars = "Vertical"
 $OutputLog.ReadOnly = $true
 $OutputLog.BackColor = $ColorLogBg
 $OutputLog.ForeColor = $ColorLogText
 $OutputLog.Font = New-Object System.Drawing.Font("Consolas", 9)
 $OutputLog.BorderStyle = "None"
 $OutputLog.Text = "Ready..."
 $LogPanel.Controls.Add($OutputLog)

function Write-Log {
    param([string]$message)
    $timestamp = Get-Date -Format "HH:mm:ss"
    $OutputLog.AppendText("`n[$timestamp] $message")
    $OutputLog.ScrollToCaret()
}

# --- GENERATE TABS ---
 $Categories = @("Orbdiff", "Spokwn", "RedLotus", "Tonynoh", "Praiselily", "Others")

foreach ($Cat in $Categories) {
    $TabPage = New-Object System.Windows.Forms.TabPage
    $TabPage.Text = $Cat
    $TabPage.BackColor = $ColorWindowBg
    $TabPage.BorderStyle = "None"
    $TabPage.Padding = New-Object System.Windows.Forms.Padding(20)
    $TabControl.TabPages.Add($TabPage)

    # 1. Description Label
    $DescLabel = New-Object System.Windows.Forms.Label
    $DescLabel.Text = "Forensic Analysis Tools - Click a button to download."
    $DescLabel.Font = New-Object System.Drawing.Font("Segoe UI", 11, [System.Drawing.FontStyle]::Bold)
    $DescLabel.ForeColor = [System.Drawing.Color]::White
    $DescLabel.Dock = "Top"
    $DescLabel.Height = 40
    $DescLabel.Padding = New-Object System.Windows.Forms.Padding(0, 10, 0, 20)
    $TabPage.Controls.Add($DescLabel)

    # 2. Flow Panel (Grid)
    $ToolsFlowPanel = New-Object System.Windows.Forms.FlowLayoutPanel
    $ToolsFlowPanel.Dock = "Fill"
    $ToolsFlowPanel.FlowDirection = "LeftToRight"
    $ToolsFlowPanel.WrapContents = $true
    $ToolsFlowPanel.AutoScroll = $true
    $ToolsFlowPanel.BackColor = $ColorWindowBg # Ensure visibility
    $TabPage.Controls.Add($ToolsFlowPanel)

    # Add Buttons
    $Tools = $ToolData | Where-Object { $_.Category -eq $Cat }
    foreach ($Tool in $Tools) {
        $ToolBtn = New-Object System.Windows.Forms.Button
        $ToolBtn.Text = $Tool.Name
        # Larger buttons for Grid Look
        $ToolBtn.Width = 180
        $ToolBtn.Height = 90
        $ToolBtn.BackColor = $ColorBtn
        $ToolBtn.ForeColor = $ColorText
        $ToolBtn.Font = New-Object System.Drawing.Font("Segoe UI", 9.5)
        $ToolBtn.FlatStyle = "Flat"
        $ToolBtn.TextAlign = "MiddleCenter"
        $ToolBtn.Cursor = [System.Windows.Forms.Cursors]::Hand
        $ToolBtn.Margin = New-Object System.Windows.Forms.Padding(15)

        $ToolBtn.Add_MouseEnter({ $This.BackColor = $ColorBtnHover })
        $ToolBtn.Add_MouseLeave({ $This.BackColor = $ColorBtn })

        $ToolBtn.Add_Click({
            $TName = $This.Text
            $TData = $ToolData | Where-Object { $_.Name -eq $TName }
            Write-Log "Launching: $TName..."
            if ($TData.Type -eq "Cmd") {
                Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -Command `"$($TData.Command)`""
            }
            elseif ($TData.Type -eq "Web") {
                Start-Process $TData.URL
            }
            elseif ($TData.Type -eq "GitHub") {
                $TempPath = "$env:TEMP\$TName.exe"
                if (Test-Path $TempPath) {
                    Start-Process $TempPath
                } else {
                    Write-Log "Downloading..."
                    $Link = Get-GitHubExeUrl -ReleaseUrl $TData.URL
                    if ($Link) {
                        try {
                            $ProgressPreference = 'SilentlyContinue'
                            Invoke-WebRequest -Uri $Link -OutFile $TempPath -UseBasicParsing
                            $ProgressPreference = 'Continue'
                            Start-Process $TempPath
                        } catch { Start-Process $TData.URL }
                    } else { Start-Process $TData.URL }
                }
            }
        })
        $ToolsFlowPanel.Controls.Add($ToolBtn)
    }
}

[void]$Form.ShowDialog()
