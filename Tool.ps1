# Load required Windows Forms assemblies
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# --- DEFINE ALL TOOLS ---
# Type: "SmartDL" (Tries to download .exe from GitHub), "Web" (Opens Browser), "Cmd" (Runs PS Script)
 $ToolData = @(
    # --- ORBDIFF ---
    @{ Name="PrefetchView"; Category="Orbdiff"; Type="SmartDL"; URL="https://github.com/Orbdiff/PrefetchView/releases/tag/v1.6.7" },
    @{ Name="BAMReveal"; Category="Orbdiff"; Type="SmartDL"; URL="https://github.com/Orbdiff/BAMReveal/releases/tag/v1.3.1" },
    @{ Name="StringsParser"; Category="Orbdiff"; Type="SmartDL"; URL="https://github.com/Orbdiff/StringsParser/releases/tag/v1.0" },
    @{ Name="Fileless"; Category="Orbdiff"; Type="SmartDL"; URL="https://github.com/Orbdiff/Fileless/releases/tag/v1.3" },
    @{ Name="DPS-Analyzer"; Category="Orbdiff"; Type="SmartDL"; URL="https://github.com/Orbdiff/DPS-Analyzer/releases/tag/v1.1" },
    @{ Name="UserAssistView"; Category="Orbdiff"; Type="SmartDL"; URL="https://github.com/Orbdiff/UserAssistView/releases/tag/v1.0" },
    @{ Name="JournalParser"; Category="Orbdiff"; Type="SmartDL"; URL="https://github.com/Orbdiff/JournalParser/releases/tag/v1.2" },
    @{ Name="InjGen"; Category="Orbdiff"; Type="SmartDL"; URL="https://github.com/Orbdiff/InjGen/releases/tag/fork" },
    @{ Name="USBDetector"; Category="Orbdiff"; Type="SmartDL"; URL="https://github.com/Orbdiff/USBDetector/releases/tag/v1.1" },
    @{ Name="PFTrace"; Category="Orbdiff"; Type="SmartDL"; URL="https://github.com/Orbdiff/PFTrace/releases/tag/v1.0.1" },
    @{ Name="CheckDeletedUSN"; Category="Orbdiff"; Type="SmartDL"; URL="https://github.com/Orbdiff/CheckDeletedUSN/releases/tag/v0.2.1" },
    @{ Name="JARParser"; Category="Orbdiff"; Type="SmartDL"; URL="https://github.com/Orbdiff/JARParser/releases/tag/v1.2" },

    # --- SPOKWN ---
    @{ Name="BAM-parser"; Category="Spokwn"; Type="SmartDL"; URL="https://github.com/spokwn/BAM-parser/releases/tag/v1.2.9" },
    @{ Name="PathsParser"; Category="Spokwn"; Type="SmartDL"; URL="https://github.com/spokwn/PathsParser/releases/tag/v1.2" },
    @{ Name="JournalTrace"; Category="Spokwn"; Type="SmartDL"; URL="https://github.com/spokwn/JournalTrace/releases/tag/1.2" },
    @{ Name="KernelLiveDumpTool"; Category="Spokwn"; Type="SmartDL"; URL="https://github.com/spokwn/KernelLiveDumpTool/releases/tag/v1.1" },
    @{ Name="BamDeletedKeys"; Category="Spokwn"; Type="SmartDL"; URL="https://github.com/spokwn/BamDeletedKeys/releases/tag/v1.0" },
    @{ Name="Tool"; Category="Spokwn"; Type="SmartDL"; URL="https://github.com/spokwn/Tool/releases/tag/v1.1.3" },
    @{ Name="pcasvc-executed"; Category="Spokwn"; Type="SmartDL"; URL="https://github.com/spokwn/pcasvc-executed/releases/tag/v0.8.7" },
    @{ Name="process-parser"; Category="Spokwn"; Type="SmartDL"; URL="https://github.com/spokwn/process-parser/releases/tag/v0.5.5" },
    @{ Name="prefetch-parser"; Category="Spokwn"; Type="SmartDL"; URL="https://github.com/spokwn/prefetch-parser/releases/tag/v1.5.5" },
    @{ Name="ActivitiesCache"; Category="Spokwn"; Type="SmartDL"; URL="https://github.com/spokwn/ActivitiesCache-execution/releases/tag/v0.6.5" },

    # --- TONYNOH ---
    @{ Name="MeowDoomsdayFucker"; Category="Tonynoh"; Type="SmartDL"; URL="https://github.com/MeowTonynoh/MeowDoomsdayFucker/releases/tag/V.1.2" },
    @{ Name="MeowModAnalyzer"; Category="Tonynoh"; Type="Cmd"; Command="Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/MeowTonynoh/MeowModAnalyzer/main/MeowModAnalyzer.ps1')" },
    @{ Name="MeowResolver"; Category="Tonynoh"; Type="SmartDL"; URL="https://github.com/MeowTonynoh/MeowResolver/releases/tag/MeowResolver" },
    @{ Name="MeowNovowareFucker"; Category="Tonynoh"; Type="SmartDL"; URL="https://github.com/MeowTonynoh/MeowNovowareFucker/releases/tag/V1" },
    @{ Name="MeowImportsChecker"; Category="Tonynoh"; Type="SmartDL"; URL="https://github.com/MeowTonynoh/MeowImportsChecker/releases/tag/MeowImportsChecker" },

    # --- PRAISELILY ---
    @{ Name="PSHunter"; Category="Praiselily"; Type="SmartDL"; URL="https://github.com/praiselily/PSHunter/releases/tag/Built" },
    @{ Name="AltDetector"; Category="Praiselily"; Type="SmartDL"; URL="https://github.com/praiselily/AltDetector/releases/tag/Detector" },
    @{ Name="HotspotLogs"; Category="Praiselily"; Type="Cmd"; Command="iwr https://raw.githubusercontent.com/praiselily/WeHateFakers/refs/heads/main/HotspotLogs.ps1 | iex" },
    @{ Name="CommonDirectories"; Category="Praiselily"; Type="Cmd"; Command="Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/praiselily/lilith-ps/refs/heads/main/CommonDirectories.ps1')" },
    @{ Name="HarddiskConverter"; Category="Praiselily"; Type="Cmd"; Command="Invoke-Expression (Invoke-RestMethod https://raw.githubusercontent.com/praiselily/lilith-ps/refs/heads/main/HarddiskConverter.ps1)" },
    @{ Name="Services"; Category="Praiselily"; Type="Cmd"; Command="Invoke-Expression (Invoke-RestMethod https://raw.githubusercontent.com/praiselily/lilith-ps/refs/heads/main/Services.ps1)" },
    @{ Name="Signed-Scheduled-Tasks"; Category="Praiselily"; Type="Cmd"; Command="Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/praiselily/lilith-ps/refs/heads/main/Signed-Scheduled-Tasks')" },

    # --- REDLOTUS ---
    @{ Name="RedLotus-Mod-Analyzer"; Category="RedLotus"; Type="SmartDL"; URL="https://github.com/ItzIceHere/RedLotus-Mod-Analyzer/releases/tag/RL" },
    @{ Name="RedLotus-Task-Sentinel"; Category="RedLotus"; Type="SmartDL"; URL="https://github.com/ItzIceHere/RedLotus-Task-Sentinel/releases/tag/RL" },
    @{ Name="RedLotusAltChecker"; Category="RedLotus"; Type="SmartDL"; URL="https://github.com/ItzIceHere/RedLotusAltChecker/releases/tag/RL" },

    # --- OTHERS ---
    # NirSoft and EZ Tools are left as Web because they require complex zip extraction or specific handling
    @{ Name="WinPrefetchView (NirSoft)"; Category="Others"; Type="Web"; URL="https://www.nirsoft.net/utils/win_prefetch_view.html" },
    @{ Name="CompActivityView (NirSoft)"; Category="Others"; Type="Web"; URL="https://www.nirsoft.net/utils/computer_activity_view.html" },
    @{ Name="AmcacheParser (EZ Tools)"; Category="Others"; Type="Web"; URL="https://download.ericzimmermanstools.com/net9/AmcacheParser.zip" },
    @{ Name="SystemInformer"; Category="Others"; Type="Web"; URL="https://www.systeminformer.com/canary" },
    @{ Name="DIE-engine"; Category="Others"; Type="Web"; URL="https://github.com/horsicq/DIE-engine/releases" },
    
    # These are PS scripts, handled by Type="Cmd"
    @{ Name="DQRKIS-FUCKER"; Category="Others"; Type="Cmd"; Command="Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/cheesecatlol/DQRKIS-FUCKER/refs/heads/main/DqrkisFucker.ps1')" },
    @{ Name="MacroDetector"; Category="Others"; Type="Cmd"; Command="Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/Nickk196/MacroDetector/refs/heads/main/MacroDetector.ps1')" }
)

# --- CREATE THE MAIN FORM ---
 $Form = New-Object System.Windows.Forms.Form
 $Form.Text = "Auto Tool Launcher"
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
    $Tab.AutoScroll = $true 
    $TabControl.TabPages.Add($Tab)
    $Tabs[$Cat] = $Tab
}

# --- GENERATE BUTTONS ---
 $yPos = 10

foreach ($Tool in $ToolData) {
    $CatTab = $Tabs[$Tool.Category]
    if (-not $CatTab) { continue }

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
        # Find the tool data in the array by name
        $ToolDataItem = $ToolData | Where-Object { $_.Name -eq $ToolName }
        
        Write-Log "Checking: $ToolName..."

        if ($ToolDataItem.Type -eq "Cmd") {
            # Run PowerShell Command
            Write-Log "Running script..."
            Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -Command `"$($ToolDataItem.Command)`""
        }
        elseif ($ToolDataItem.Type -eq "Web") {
            # Just open the browser (for NirSoft/EZ Tools)
            Write-Log "Opening website..."
            Start-Process $ToolDataItem.URL
        }
        elseif ($ToolDataItem.Type -eq "SmartDL") {
            # Attempt Smart Download
            $PageUrl = $ToolDataItem.URL
            
            # Construct the likely download URL: Replace "/tag/" with "/download/" and add ".exe"
            # Example: github.com/user/repo/releases/tag/v1.0 -> github.com/user/repo/releases/download/v1.0/ToolName.exe
            $DownloadGuess = $PageUrl -replace "/tag/", "/download/"
            $DownloadGuess += "/" + $ToolName + ".exe"
            
            $TempPath = "$env:TEMP\$ToolName.exe"

            # Check if already exists in Temp
            if (Test-Path $TempPath) {
                Write-Log "Found in Temp. Running..."
                Start-Process $TempPath
            }
            else {
                # Try to download
                Write-Log "Attempting download..."
                try {
                    Invoke-WebRequest -Uri $DownloadGuess -OutFile $TempPath -UseBasicParsing -ErrorAction Stop
                    Write-Log "Downloaded successfully. Running..."
                    Start-Process $TempPath
                }
                catch {
                    Write-Log "Auto-download failed."
                    Write-Log "Opening browser for manual download..."
                    # Fallback: Open the release page
                    Start-Process $PageUrl
                }
            }
        }
    })

    $CatTab.Controls.Add($Btn)
    $yPos += 40 
}

# --- WEBS CATEGORY (Placeholder) ---
 $WebsTab = $Tabs["Webs"]
 $Placeholder = New-Object System.Windows.Forms.Label
 $Placeholder.Text = "No web tools added yet."
 $Placeholder.Location = New-Object System.Drawing.Point(20, 20)
 $Placeholder.ForeColor = [System.Drawing.Color]::Gray
 $WebsTab.Controls.Add($Placeholder)

# --- SHOW GUI ---
[void]$Form.ShowDialog()
