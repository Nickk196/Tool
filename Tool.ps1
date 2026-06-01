# Load required Windows Forms assemblies
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# --- CREATE THE MAIN FORM ---
 $Form = New-Object System.Windows.Forms.Form
 $Form.Text = "PowerTools Launcher"
 $Form.Size = New-Object System.Drawing.Size(600, 450)
 $Form.StartPosition = "CenterScreen"
 $Form.FormBorderStyle = "FixedDialog" # Prevent resizing
 $Form.MaximizeBox = $false

# --- CREATE THE OUTPUT LOG (Bottom of screen) ---
 $OutputLog = New-Object System.Windows.Forms.TextBox
 $OutputLog.Multiline = $true
 $OutputLog.ScrollBars = "Vertical"
 $OutputLog.ReadOnly = $true
 $OutputLog.BackColor = [System.Drawing.Color]::Black
 $OutputLog.ForeColor = [System.Drawing.Color]::Green
 $OutputLog.Font = New-Object System.Drawing.Font("Consolas", 9)
 $OutputLog.Location = New-Object System.Drawing.Point(10, 320)
 $OutputLog.Size = New-Object System.Drawing.Size(560, 80)
 $OutputLog.Text = "Ready... Waiting for input."

# Add the Output Log to the Form
 $Form.Controls.Add($OutputLog)

# Helper function to write to the log box
function Write-Log {
    param([string]$message)
    $timestamp = Get-Date -Format "HH:mm:ss"
    $OutputLog.AppendText("`n[$timestamp] $message")
    $OutputLog.ScrollToCaret()
}

# --- CREATE THE TAB CONTROL ---
 $TabControl = New-Object System.Windows.Forms.TabControl
 $TabControl.Location = New-Object System.Drawing.Point(10, 10)
 $TabControl.Size = New-Object System.Drawing.Size(560, 300)
 $Form.Controls.Add($TabControl)

# Define your requested categories
 $Categories = @("Orbdiff", "Spokwn", "RedLotus", "Tonynoh", "Praiselily", "Others", "Webs")

# --- LOOP TO CREATE TABS AND BUTTONS ---
foreach ($Cat in $Categories) {
    
    # 1. Create the Tab Page
    $TabPage = New-Object System.Windows.Forms.TabPage
    $TabPage.Text = $Cat
    $TabPage.BackColor = [System.Drawing.Color]::White
    $TabPage.Font = New-Object System.Drawing.Font("Segoe UI", 10)
    
    # 2. Create a generic button for this tab
    $Button = New-Object System.Windows.Forms.Button
    $Button.Text = "Run $Cat Script"
    $Button.Location = New-Object System.Drawing.Point(20, 30)
    $Button.Size = New-Object System.Drawing.Size(200, 50)
    $Button.FlatStyle = "Flat"
    $Button.BackColor = [System.Drawing.Color]::FromArgb(45, 45, 45)
    $Button.ForeColor = [System.Drawing.Color]::White

    # 3. Define what happens when the button is clicked
    # We use a closure to capture the specific category name for this iteration
    $CurrentCategory = $Cat
    
    $Button.Add_Click({
        # Update Log
        Write-Log "Executing [$CurrentCategory]..."
        
        # =========================================================
        # --- CUSTOMIZE YOUR SCRIPTS HERE ---
        # =========================================================
        
        switch ($CurrentCategory) {
            "Orbdiff"   { 
                # REPLACE THIS WITH YOUR ORBDIFF COMMAND
                Write-Log "Running Orbdiff logic..." 
                # Example: Start-Process "path\to\orbdiff.exe"
            }
            "Spokwn"    { 
                # REPLACE THIS WITH YOUR SPOKWN COMMAND
                Write-Log "Running Spokwn logic..." 
            }
            "RedLotus"  { 
                # REPLACE THIS WITH YOUR REDLOTUS COMMAND
                Write-Log "Running RedLotus logic..." 
            }
            "Tonynoh"   { 
                # REPLACE THIS WITH YOUR TONYNOH COMMAND
                Write-Log "Running Tonynoh logic..." 
            }
            "Praiselily"{ 
                # REPLACE THIS WITH YOUR PRAISELILY COMMAND
                Write-Log "Running Praiselily logic..." 
            }
            "Others"    { 
                # REPLACE THIS WITH YOUR OTHERS COMMAND
                Write-Log "Running Others logic..." 
            }
            "Webs"      { 
                # REPLACE THIS WITH YOUR WEBS COMMAND
                Write-Log "Running Webs logic..." 
                # Example: Start-Process "https://google.com"
            }
        }
        
        # =========================================================
        # --- END CUSTOMIZATION ---
        # =========================================================

        Write-Log "[$CurrentCategory] Finished."
    })

    # Add the button to the tab page, and the tab page to the control
    $TabPage.Controls.Add($Button)
    $TabControl.TabPages.Add($TabPage)
}

# --- CLEAR LOG BUTTON ---
 $ClearBtn = New-Object System.Windows.Forms.Button
 $ClearBtn.Text = "Clear Log"
 $ClearBtn.Location = New-Object System.Drawing.Point(480, 290) # Positioned just above the log
 $ClearBtn.Size = New-Object System.Drawing.Size(80, 30)
 $ClearBtn.Add_Click({ $OutputLog.Clear(); $OutputLog.Text = "Log cleared." })
 $Form.Controls.Add($ClearBtn)


# --- SHOW THE GUI ---
[void]$Form.ShowDialog()
