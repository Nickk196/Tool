# Load required assemblies
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# --- DEFINE COLORS (THEME) ---
 $ColorBg        = [System.Drawing.Color]::FromArgb(43, 43, 43)   
 $ColorPanel     = [System.Drawing.Color]::FromArgb(43, 43, 43)   
 $ColorBtn       = [System.Drawing.Color]::FromArgb(60, 60, 60)   
 $ColorBtnHover  = [System.Drawing.Color]::FromArgb(80, 80, 80)   
 $ColorText      = [System.Drawing.Color]::White                  
 $ColorLogBg     = [System.Drawing.Color]::Black                  
 $ColorLogText   = [System.Drawing.Color]::LimeGreen              

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
    @{ Name="Services"; Category="Praiselily"; Type="Cmd"; Command="Invoke-Expression (Invoke-RestMethod https://raw.githubusercontent.com/praiselily/lilith-ps/refs/heads/main/Services.ps1)" },
    @{ Name="Signed-Scheduled-Tasks"; Category="Praiselily"; Type="Cmd"; Command="Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/praiselily/lilith-ps/refs/heads/main/Signed-Scheduled-Tasks')" },

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

# --- HELPER FUNCTION TO FIND EXE VIA GITHUB API ---
function Get-GitHubExeUrl {
    param([string]$ReleaseUrl)
    
    if ($ReleaseUrl -match "github\.com/([^/]+)/([^/]+)/releases/tag/([^/]+)") {
        $User = $matches[1]
        $Repo = $matches[2]
        $Tag = $matches[3]
        
        $ApiUrl = "https://api.github.com/repos/$User/$Repo/releases/tags/$Tag"
        
        try {
            $ProgressPreference = 'SilentlyContinue'
            $Response = Invoke-RestMethod -Uri $ApiUrl -ErrorAction Stop
            $ProgressPreference = 'Continue'
            
            $Asset = $Response.assets | Where-Object { $_.name -like "*.exe" } | Select-Object -First 1
            
            if ($Asset) {
                return $Asset.browser_download_url
            }
            else {
                return $null
            }
        }
        catch {
            return $null
        }
    }
    return $null
}

# --- CREATE FORM ---
 $Form = New-Object System.Windows.Forms.Form
 $Form.Text = "Tool Launcher v4 (Centered)"
 $Form.Size = New-Object System.Drawing.Size(600, 500)
 $Form.StartPosition = "CenterScreen"
 $Form.BackColor = $ColorBg

# --- SPLIT CONTAINER ---
 $SplitContainer = New-Object System.Windows.Forms.SplitContainer
 $SplitContainer.Dock = "Fill"
 $SplitContainer.SplitterDistance = 400
 $SplitContainer.Panel2MinSize = 50
 $SplitContainer.BackColor = $ColorBg
 $Form.Controls.Add($SplitContainer)

# --- TAB CONTROL ---
 $TabControl = New-Object System.Windows.Forms.TabControl
 $TabControl.Dock = "Fill"
 $TabControl.BackColor = $ColorBg
 $SplitContainer.Panel1.Controls.Add($TabControl)

# --- OUTPUT LOG ---
 $OutputLog = New-Object System.Windows.Forms.TextBox
 $OutputLog.Multiline = $true
 $OutputLog.ScrollBars = "Vertical"
 $OutputLog.ReadOnly = $true
 $OutputLog.BackColor = $ColorLogBg
 $OutputLog.ForeColor = $ColorLogText
 $OutputLog.Font = New-Object System.Drawing.Font("Consolas", 9)
 $OutputLog.Dock = "Fill"
 $OutputLog.Text = "System Ready..."
 $OutputLog.BorderStyle = "None"
 $SplitContainer.Panel2.Controls.Add($OutputLog)

function Write-Log {
    param([string]$message)
    $timestamp = Get-Date -Format "HH:mm:ss"
    $OutputLog.AppendText("`n[$timestamp] $message")
    $OutputLog.ScrollToCaret()
}

# --- SETUP TABS ---
 $TabPanels = @{}
 $Categories = @("Orbdiff", "Spokwn", "RedLotus", "Tonynoh", "Praiselily", "Others", "Webs")

foreach ($Cat in $Categories) {
    $TabPage = New-Object System.Windows.Forms.TabPage
    $TabPage.Text = $Cat
    $TabPage.BackColor = $ColorPanel 
    $TabPage.ForeColor = $ColorText   
    
    $FlowPanel = New-Object System.Windows.Forms.FlowLayoutPanel
    $FlowPanel.Dock = "Fill"
    $FlowPanel.FlowDirection = "TopDown"
    $FlowPanel.AutoScroll = $true
    $FlowPanel.WrapContents = $false 
    $FlowPanel.Padding = New-Object System.Windows.Forms.Padding(15)
    $FlowPanel.BackColor = $ColorPanel
    
    $TabPage.Controls.Add($FlowPanel)
    $TabControl.TabPages.Add($TabPage)
    $TabPanels[$Cat] = $FlowPanel
}

# --- GENERATE BUTTONS ---
foreach ($Tool in $ToolData) {
    $Panel = $TabPanels[$Tool.Category]
    
    if ($Panel) {
        $Btn = New-Object System.Windows.Forms.Button
        $Btn.Text = $Tool.Name
        $Btn.Width = 480
        $Btn.Height = 50 # Increased height slightly
        
        # --- DESIGN UPDATE ---
        $Btn.BackColor = $ColorBtn
        $Btn.ForeColor = $ColorText
        $Btn.Font = New-Object System.Drawing.Font("Segoe UI", 11, [System.Drawing.FontStyle]::Bold) # Bigger and Bold
        $Btn.TextAlign = "MiddleCenter" # CENTERED TEXT
        $Btn.FlatStyle = "Flat"
        $Btn.FlatAppearance.BorderSize = 0
        $Btn.Cursor = [System.Windows.Forms.Cursors]::Hand
        $Btn.Margin = New-Object System.Windows.Forms.Padding(0, 0, 0, 8)

        # Hover Effect
        $Btn.Add_MouseEnter({ $This.BackColor = $ColorBtnHover })
        $Btn.Add_MouseLeave({ $This.BackColor = $ColorBtn })

        # Click Logic
        $Btn.Add_Click({
            $ToolName = $This.Text
            $ToolDataItem = $ToolData | Where-Object { $_.Name -eq $ToolName }
            
            Write-Log "Checking: $ToolName..."

            if ($ToolDataItem.Type -eq "Cmd") {
                Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -Command `"$($ToolDataItem.Command)`""
            }
            elseif ($ToolDataItem.Type -eq "Web") {
                Start-Process $ToolDataItem.URL
            }
            elseif ($ToolDataItem.Type -eq "GitHub") {
                $PageUrl = $ToolDataItem.URL
                $TempPath = "$env:TEMP\$ToolName.exe"
                
                if (Test-Path $TempPath) {
                    Write-Log "Found in cache."
                    Start-Process $TempPath
                }
                else {
                    Write-Log "Finding download link..."
                    $DirectLink = Get-GitHubExeUrl -ReleaseUrl $PageUrl
                    
                    if ($DirectLink) {
                        Write-Log "Downloading..."
                        try {
                            $ProgressPreference = 'SilentlyContinue'
                            Invoke-WebRequest -Uri $DirectLink -OutFile $TempPath -UseBasicParsing -ErrorAction Stop
                            $ProgressPreference = 'Continue'
                            
                            Write-Log "Running..."
                            Start-Process $TempPath
                        }
                        catch {
                            $ProgressPreference = 'Continue'
                            Write-Log "Download failed. Opening page..."
                            Start-Process $PageUrl
                        }
                    }
                    else {
                        Write-Log "Could not find .exe file."
                        Start-Process $PageUrl
                    }
                }
            }
        })

        $Panel.Controls.Add($Btn)
    }
}

# --- WEBS TAB ---
 $WebsPanel = $TabPanels["Webs"]
 $Label = New-Object System.Windows.Forms.Label
 $Label.Text = "No web tools added."
 $Label.ForeColor = [System.Drawing.Color]::Gray
 $WebsPanel.Controls.Add($Label)

# --- SHOW GUI ---
[void]$Form.ShowDialog()
