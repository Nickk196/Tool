# Load required assemblies
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
Add-Type -Name User32 -Namespace Win32 -MemberDefinition @"
[DllImport("user32.dll")] public static extern bool ReleaseCapture();
[DllImport("user32.dll")] public static extern int SendMessage(IntPtr hWnd, int Msg, int wParam, int lParam);
"@

# --- DEFINE COLORS (TESLA THEME) ---
 $ColorWindowBg     = [System.Drawing.Color]::FromArgb(12, 16, 22)    
 $ColorSidebar      = [System.Drawing.Color]::FromArgb(22, 27, 34)    
 $ColorHeader       = [System.Drawing.Color]::FromArgb(16, 20, 26)    
 $ColorBtn          = [System.Drawing.Color]::FromArgb(33, 38, 46)    
 $ColorBtnHover     = [System.Drawing.Color]::FromArgb(56, 163, 255)  
 $ColorText         = [System.Drawing.Color]::White
 $ColorLogBg        = [System.Drawing.Color]::Black
 $ColorLogText      = [System.Drawing.Color]::FromArgb(50, 255, 50)   

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
 $Form.Text = "Tesla Launcher"
 $Form.Size = New-Object System.Drawing.Size(1000, 650)
 $Form.StartPosition = "CenterScreen"
 $Form.BackColor = $ColorWindowBg
 $Form.FormBorderStyle = "None"
 $Form.TopLevel = $true

# Make window draggable
 $Form.Add_MouseDown({
    if ($_.Button -eq [System.Windows.Forms.MouseButtons]::Left) {
        [Win32.User32]::ReleaseCapture()
        [Win32.User32]::SendMessage($Form.Handle, 0x0112, 0xF012, 0)
    }
})

# --- HEADER (TOP BAR) ---
 $HeaderPanel = New-Object System.Windows.Forms.Panel
 $HeaderPanel.Height = 60
 $HeaderPanel.Dock = "Top"
 $HeaderPanel.BackColor = $ColorHeader
 $Form.Controls.Add($HeaderPanel)

 $TitleLabel = New-Object System.Windows.Forms.Label
 $TitleLabel.Text = "Tesla Launcher"
 $TitleLabel.Font = New-Object System.Drawing.Font("Segoe UI", 16, [System.Drawing.FontStyle]::Bold)
 $TitleLabel.ForeColor = [System.Drawing.Color]::White
 $TitleLabel.Location = New-Object System.Drawing.Point(20, 15)
 $TitleLabel.AutoSize = $true
 $HeaderPanel.Controls.Add($TitleLabel)

 $CloseBtn = New-Object System.Windows.Forms.Button
 $CloseBtn.Text = "✕"
 $CloseBtn.Size = New-Object System.Drawing.Size(40, 40)
# FIXED: Hardcoded X position to avoid calculation error
 $CloseBtn.Location = New-Object System.Drawing.Point(950, 10) 
 $CloseBtn.BackColor = [System.Drawing.Color]::FromArgb(40, 40, 40)
 $CloseBtn.ForeColor = [System.Drawing.Color]::White
 $CloseBtn.FlatStyle = "Flat"
 $CloseBtn.Font = New-Object System.Drawing.Font("Segoe UI", 12)
 $CloseBtn.Cursor = [System.Windows.Forms.Cursors]::Hand
 $CloseBtn.Add_Click({ $Form.Close() })
 $HeaderPanel.Controls.Add($CloseBtn)

# --- SIDEBAR (LEFT) ---
 $SidebarPanel = New-Object System.Windows.Forms.Panel
 $SidebarPanel.Width = 220
 $SidebarPanel.Dock = "Left"
 $SidebarPanel.BackColor = $ColorSidebar
 $SidebarPanel.Padding = New-Object System.Windows.Forms.Padding(10, 10, 10, 10)
 $Form.Controls.Add($SidebarPanel)

# --- MAIN CONTENT (RIGHT) ---
 $MainPanel = New-Object System.Windows.Forms.Panel
 $MainPanel.Dock = "Fill"
 $MainPanel.BackColor = $ColorWindowBg
 $MainPanel.Padding = New-Object System.Windows.Forms.Padding(20)
 $Form.Controls.Add($MainPanel)

# --- LOG OUTPUT (BOTTOM OF MAIN PANEL) ---
 $OutputLog = New-Object System.Windows.Forms.TextBox
 $OutputLog.Height = 120
 $OutputLog.Dock = "Bottom"
 $OutputLog.Multiline = $true
 $OutputLog.ScrollBars = "Vertical"
 $OutputLog.ReadOnly = $true
 $OutputLog.BackColor = $ColorLogBg
 $OutputLog.ForeColor = $ColorLogText
 $OutputLog.Font = New-Object System.Drawing.Font("Consolas", 9)
 $OutputLog.BorderStyle = "None"
 $OutputLog.Text = "System Ready..."
 $MainPanel.Controls.Add($OutputLog)

function Write-Log {
    param([string]$message)
    $timestamp = Get-Date -Format "HH:mm:ss"
    $OutputLog.AppendText("`n[$timestamp] $message")
    $OutputLog.ScrollToCaret()
}

# --- TOOLS FLOW PANEL (FILLS REST OF MAIN PANEL) ---
 $ToolsFlowPanel = New-Object System.Windows.Forms.FlowLayoutPanel
 $ToolsFlowPanel.Dock = "Fill"
 $ToolsFlowPanel.FlowDirection = "TopDown"
 $ToolsFlowPanel.AutoScroll = $true
 $ToolsFlowPanel.WrapContents = $false
 $ToolsFlowPanel.BackColor = $ColorWindowBg
 $MainPanel.Controls.Add($ToolsFlowPanel)

# --- SETUP SIDEBAR BUTTONS ---
 $Categories = @("Orbdiff", "Spokwn", "RedLotus", "Tonynoh", "Praiselily", "Others")
 $SidebarButtons = @{}

 $yPos = 10
foreach ($Cat in $Categories) {
    $Btn = New-Object System.Windows.Forms.Button
    $Btn.Text = $Cat
    $Btn.Width = 200
    $Btn.Height = 40
    $Btn.Top = $yPos
    $Btn.Left = 0
    $Btn.FlatStyle = "Flat"
    $Btn.BackColor = $ColorBtn
    $Btn.ForeColor = $ColorText
    $Btn.Font = New-Object System.Drawing.Font("Segoe UI", 11)
    $Btn.TextAlign = "MiddleLeft"
    $Btn.Padding = New-Object System.Windows.Forms.Padding(15, 0, 0, 0)
    $Btn.Cursor = [System.Windows.Forms.Cursors]::Hand
    
    $SidebarButtons[$Cat] = $Btn

    $Btn.Add_Click({
        # Reset colors
        foreach ($b in $SidebarButtons.Values) { 
            $b.BackColor = $ColorBtn 
            $b.ForeColor = $ColorText
        }
        # Highlight current
        $This.BackColor = $ColorBtnHover
        $This.ForeColor = [System.Drawing.Color]::Black
        
        # Load Tools
        $ToolsFlowPanel.Controls.Clear()
        $CatName = $This.Text
        $Tools = $ToolData | Where-Object { $_.Category -eq $CatName }
        
        foreach ($Tool in $Tools) {
            $ToolBtn = New-Object System.Windows.Forms.Button
            $ToolBtn.Text = $Tool.Name
            $ToolBtn.Width = 700
            $ToolBtn.Height = 50
            $ToolBtn.BackColor = $ColorBtn
            $ToolBtn.ForeColor = $ColorText
            $ToolBtn.Font = New-Object System.Drawing.Font("Segoe UI", 11)
            $ToolBtn.FlatStyle = "Flat"
            $ToolBtn.TextAlign = "MiddleCenter"
            $ToolBtn.Cursor = [System.Windows.Forms.Cursors]::Hand
            $ToolBtn.Margin = New-Object System.Windows.Forms.Padding(0, 0, 0, 10)
            
            # Hover
            $ToolBtn.Add_MouseEnter({ $This.BackColor = $ColorBtnHover; $This.ForeColor = [System.Drawing.Color]::Black })
            $ToolBtn.Add_MouseLeave({ $This.BackColor = $ColorBtn; $This.ForeColor = $ColorText })

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
    })
    $SidebarPanel.Controls.Add($Btn)
    $yPos += 50
}

# Load first category safely
if ($SidebarButtons["Orbdiff"]) {
    $SidebarButtons["Orbdiff"].PerformClick()
}

[void]$Form.ShowDialog()
