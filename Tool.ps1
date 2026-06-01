# Load required Windows Forms assemblies
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# --- DEFINE ALL TOOLS ---
# Type: "Web" (Opens browser) or "Cmd" (Runs PowerShell command)
 $ToolData = @(
    # --- ORBDIFF ---
    @{ Name="PrefetchView"; Category="Orbdiff"; Type="Web"; URL="https://github.com/Orbdiff/PrefetchView/releases/tag/v1.6.7" },
    @{ Name="BAMReveal"; Category="Orbdiff"; Type="Web"; URL="https://github.com/Orbdiff/BAMReveal/releases/tag/v1.3.1" },
    @{ Name="StringsParser"; Category="Orbdiff"; Type="Web"; URL="https://github.com/Orbdiff/StringsParser/releases/tag/v1.0" },
    @{ Name="Fileless"; Category="Orbdiff"; Type="Web"; URL="https://github.com/Orbdiff/Fileless/releases/tag/v1.3" },
    @{ Name="DPS-Analyzer"; Category="Orbdiff"; Type="Web"; URL="https://github.com/Orbdiff/DPS-Analyzer/releases/tag/v1.1" },
    @{ Name="UserAssistView"; Category="Orbdiff"; Type="Web"; URL="https://github.com/Orbdiff/UserAssistView/releases/tag/v1.0" },
    @{ Name="JournalParser"; Category="Orbdiff"; Type="Web"; URL="https://github.com/Orbdiff/JournalParser/releases/tag/v1.2" },
    @{ Name="InjGen"; Category="Orbdiff"; Type="Web"; URL="https://github.com/Orbdiff/InjGen/releases/tag/fork" },
    @{ Name="USBDetector"; Category="Orbdiff"; Type="Web"; URL="https://github.com/Orbdiff/USBDetector/releases/tag/v1.1" },
    @{ Name="PFTrace"; Category="Orbdiff"; Type="Web"; URL="https://github.com/Orbdiff/PFTrace/releases/tag/v1.0.1" },
    @{ Name="CheckDeletedUSN"; Category="Orbdiff"; Type="Web"; URL="https://github.com/Orbdiff/CheckDeletedUSN/releases/tag/v0.2.1" },
    @{ Name="JARParser"; Category="Orbdiff"; Type="Web"; URL="https://github.com/Orbdiff/JARParser/releases/tag/v1.2" },

    # --- SPOKWN ---
    @{ Name="BAM-parser"; Category="Spokwn"; Type="Web"; URL="https://github.com/spokwn/BAM-parser/releases/tag/v1.2.9" },
    @{ Name="PathsParser"; Category="Spokwn"; Type="Web"; URL="https://github.com/spokwn/PathsParser/releases/tag/v1.2" },
    @{ Name="JournalTrace"; Category="Spokwn"; Type="Web"; URL="https://github.com/spokwn/JournalTrace/releases/tag/1.2" },
    @{ Name="KernelLiveDumpTool"; Category="Spokwn"; Type="Web"; URL="https://github.com/spokwn/KernelLiveDumpTool/releases/tag/v1.1" },
    @{ Name="BamDeletedKeys"; Category="Spokwn"; Type="Web"; URL="https://github.com/spokwn/BamDeletedKeys/releases/tag/v1.0" },
    @{ Name="Tool"; Category="Spokwn"; Type="Web"; URL="https://github.com/spokwn/Tool/releases/tag/v1.1.3" },
    @{ Name="pcasvc-executed"; Category="Spokwn"; Type="Web"; URL="https://github.com/spokwn/pcasvc-executed/releases/tag/v0.8.7" },
    @{ Name="process-parser"; Category="Spokwn"; Type="Web"; URL="https://github.com/spokwn/process-parser/releases/tag/v0.5.5" },
    @{ Name="prefetch-parser"; Category="Spokwn"; Type="Web"; URL="https://github.com/spokwn/prefetch-parser/releases/tag/v1.5.5" },
    @{ Name="ActivitiesCache"; Category="Spokwn"; Type="Web"; URL="https://github.com/spokwn/ActivitiesCache-execution/releases/tag/v0.6.5" },

    # --- TONYNOH ---
    @{ Name="MeowDoomsdayFucker"; Category="Tonynoh"; Type="Web"; URL="https://github.com/MeowTonynoh/MeowDoomsdayFucker/releases/tag/V.1.2" },
    @{ Name="MeowModAnalyzer"; Category="Tonynoh"; Type="Cmd"; Command="Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/MeowTonynoh/MeowModAnalyzer/main/MeowModAnalyzer.ps1')" },
    @{ Name="MeowResolver"; Category="Tonynoh"; Type="Web"; URL="https://github.com/MeowTonynoh/MeowResolver/releases/tag/MeowResolver" },
    @{ Name="MeowNovowareFucker"; Category="Tonynoh"; Type="Web"; URL="https://github.com/MeowTonynoh/MeowNovowareFucker/releases/tag/V1" },
    @{ Name="MeowImportsChecker"; Category="Tonynoh"; Type="Web"; URL="https://github.com/MeowTonynoh/MeowImportsChecker/releases/tag/MeowImportsChecker" },

    # --- PRAISELILY ---
    @{ Name="PSHunter"; Category="Praiselily"; Type="Web"; URL="https://github.com/praiselily/PSHunter/releases/tag/Built" },
    @{ Name="AltDetector"; Category="Praiselily"; Type="Web"; URL="https://github.com/praiselily/AltDetector/releases/tag/Detector" },
    @{ Name="HotspotLogs"; Category="Praiselily"; Type="Cmd"; Command="iwr https://raw.githubusercontent.com/praiselily/WeHateFakers/refs/heads/main/HotspotLogs.ps1 | iex" },
    @{ Name="CommonDirectories"; Category="Praiselily"; Type="Cmd"; Command="Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/praiselily/lilith-ps/refs/heads/main/CommonDirectories.ps1')" },
    @{ Name="HarddiskConverter"; Category="Praiselily"; Type="Cmd"; Command="Invoke-Expression (Invoke-RestMethod https://raw.githubusercontent.com/praiselily/lilith-ps/refs/heads/main/HarddiskConverter.ps1)" },
    @{ Name="Services"; Category="Praiselily"; Type="Cmd"; Command="Invoke-Expression (Invoke-RestMethod https://raw.githubusercontent.com/praiselily/lilith-ps/refs/heads/main/Services.ps1)" },
    @{ Name="Signed-Scheduled-Tasks"; Category="Praiselily"; Type="Cmd"; Command="Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/praiselily/lilith-ps/refs/heads/main/Signed-Scheduled-Tasks')" },

    # --- REDLOTUS ---
    @{ Name="RedLotus Mod Analyzer"; Category="RedLotus"; Type="Web"; URL="https://github.com/ItzIceHere/RedLotus-Mod-Analyzer/releases/tag/RL" },
    @{ Name="RedLotus Task Sentinel"; Category="RedLotus"; Type="Web"; URL="https://github.com/ItzIceHere/RedLotus-Task-Sentinel/releases/tag/RL" },
    @{ Name="RedLotus Alt Checker"; Category="RedLotus"; Type="Web"; URL="https://github.com/ItzIceHere/RedLotusAltChecker/releases/tag/RL" },

    # --- OTHERS ---
    @{ Name="WinPrefetchView"; Category="Others"; Type="Web"; URL="https://www.nirsoft.net/utils/win_prefetch_view.html" },
    @{ Name="ComputerActivityView"; Category="Others"; Type="Web"; URL="https://www.nirsoft.net/utils/computer_activity_view.html" },
    @{ Name="AmcacheParser"; Category="Others"; Type="Web"; URL="https://download.ericzimmermanstools.com/net9/AmcacheParser.zip" },
    @{ Name="JumpListExplorer"; Category="Others"; Type="Web"; URL="https://download.ericzimmermanstools.com/net9/JumpListExplorer.zip" },
    @{ Name="System Informer"; Category="Others"; Type="Web"; URL="https://www.systeminformer.com/canary" },
    @{ Name="DIE-engine"; Category="Others"; Type="Web"; URL="https://github.com/horsicq/DIE-engine/releases" },
    @{ Name="DQRKIS-FUCKER"; Category="Others"; Type="Cmd"; Command="Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/cheesecatlol/DQRKIS-FUCKER/refs/heads/main/DqrkisFucker.ps1')" },
    @{ Name="MacroDetector"; Category="Others"; Type="Cmd"; Command="Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/Nickk196/MacroDetector/refs/heads/main/MacroDetector.ps1')" }
)

# --- CREATE THE MAIN FORM ---
 $Form = New-Object System.Windows.Forms.Form
 $Form.Text = "Master Tool Launcher"
 $Form.Size = New-Object System.Drawing.Size(550, 500)
 $Form.StartPosition = "CenterScreen"
 $Form.FormBorderStyle = "FixedDialog"
 $Form.MaximizeBox = $false

# --- CREATE THE OUTPUT LOG ---
 $OutputLog = New-Object System.Windows.Forms.TextBox
 $OutputLog.Multiline = $true
 $OutputLog.ScrollBars = "Vertical"
 $OutputLog.ReadOnly = $true
 $OutputLog.BackColor = [System.Drawing.Color]::Black
 $OutputLog.ForeColor = [System.Drawing.Color]::LimeGreen
 $OutputLog.Font = New-Object System.Drawing.Font("Consolas", 8)
 $OutputLog.Location = New-Object System.Drawing.Point(10, 400)
 $OutputLog.Size = New-Object System.Drawing.Size(510, 50)
 $OutputLog.Text = "Ready..."
 $Form.Controls.Add($OutputLog)

function Write-Log {
    param([string]$message)
    $timestamp = Get-Date -Format "HH:mm:ss"
    $OutputLog.AppendText("`n[$timestamp] $message")
    $OutputLog.ScrollToCaret()
}

# --- CREATE THE TAB CONTROL ---
 $TabControl = New-Object System.Windows.Forms.TabControl
 $TabControl.Location = New-Object System.Drawing.Point(10, 10)
 $TabControl.Size = New-Object System.Drawing.Size(510, 380)
 $Form.Controls.Add($TabControl)

# Helper to find or create a tab
 $Tabs = @{}
 $Categories = @("Orbdiff", "Spokwn", "RedLotus", "Tonynoh", "Praiselily", "Others", "Webs")

foreach ($Cat in $Categories) {
    $Tab = New-Object System.Windows.Forms.TabPage
    $Tab.Text = $Cat
    $Tab.BackColor = [System.Drawing.Color]::White
    $Tab.AutoScroll = $true # Enable scrolling for long lists
    $TabControl.TabPages.Add($Tab)
    $Tabs[$Cat] = $Tab
}

# --- GENERATE BUTTONS ---
 $yPos = 10

foreach ($Tool in $ToolData) {
    $CatTab = $Tabs[$Tool.Category]
    if (-not $CatTab) { continue }

    # Create Button
    $Btn = New-Object System.Windows.Forms.Button
    $Btn.Text = $Tool.Name
    $Btn.Width = 460
    $Btn.Height = 35
    $Btn.Top = $yPos
    $Btn.Left = 10
    $Btn.FlatStyle = "Flat"
    $Btn.BackColor = [System.Drawing.Color]::FromArgb(240, 240, 240)
    $Btn.Cursor = [System.Windows.Forms.Cursors]::Hand

    # Add Click Logic
    $Btn.Add_Click({
        $ToolName = $This.Text
        $ToolDataItem = $ToolData | Where-Object { $_.Name -eq $ToolName }
        
        Write-Log "Launching: $ToolName..."

        if ($ToolDataItem.Type -eq "Cmd") {
            # Run PowerShell Command
            $Cmd = $ToolDataItem.Command
            Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -Command `"$Cmd`""
        }
        elseif ($ToolDataItem.Type -eq "Web") {
            $Link = $ToolDataItem.URL
            
            # Check if it looks like a direct file download (ends in .exe, .zip, .msi)
            if ($Link -match "\.(exe|zip|msi)$") {
                # Download to Temp and Run
                try {
                    $FileName = Split-Path $Link -Leaf
                    $TempPath = "$env:TEMP\$FileName"
                    
                    Write-Log "Downloading $FileName..."
                    Invoke-WebRequest -Uri $Link -OutFile $TempPath -UseBasicParsing
                    
                    Write-Log "Running..."
                    Start-Process $TempPath
                }
                catch {
                    Write-Log "Error: $_"
                    # Fallback to browser if download fails
                    Start-Process $Link
                }
            }
            else {
                # Just open the browser
                Start-Process $Link
            }
        }
    })

    $CatTab.Controls.Add($Btn)
    $yPos += 40 # Move down for next button
}

# --- WEBS CATEGORY (Since user left it blank, adding a placeholder) ---
 $WebsTab = $Tabs["Webs"]
 $Placeholder = New-Object System.Windows.Forms.Label
 $Placeholder.Text = "No web tools added yet."
 $Placeholder.Location = New-Object System.Drawing.Point(20, 20)
 $Placeholder.ForeColor = [System.Drawing.Color]::Gray
 $WebsTab.Controls.Add($Placeholder)

# --- SHOW GUI ---
[void]$Form.ShowDialog()
