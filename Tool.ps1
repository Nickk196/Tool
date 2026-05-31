Add-Type -AssemblyName PresentationFramework
Add-Type -AssemblyName System.Windows.Forms

# --- XAML GUI Definition (Sidebar + Dashboard Style) ---
[xml]$xaml = @"
<Window 
    xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
    xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
    Title="Obsidian Dashboard"
    Width="1050"
    Height="700"
    WindowStartupLocation="CenterScreen"
    WindowStyle="None"
    AllowsTransparency="True"
    Background="Transparent"
    ResizeMode="NoResize"
    Topmost="False">

    <Window.Resources>
        <!-- Sidebar Button Style -->
        <Style x:Key="SidebarButton" TargetType="Button">
            <Setter Property="Background" Value="Transparent"/>
            <Setter Property="Foreground" Value="#a0a0a0"/>
            <Setter Property="FontFamily" Value="Segoe UI"/>
            <Setter Property="FontSize" Value="14"/>
            <Setter Property="FontWeight" Value="Normal"/>
            <Setter Property="BorderThickness" Value="0"/>
            <Setter Property="HorizontalContentAlignment" Value="Left"/>
            <Setter Property="Padding" Value="20,10"/>
            <Setter Property="Cursor" Value="Hand"/>
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="Button">
                        <Border Background="{TemplateBinding Background}" Padding="{TemplateBinding Padding}">
                            <TextBlock Text="{TemplateBinding Content}" 
                                       TextWrapping="Wrap" 
                                       TextAlignment="Left" 
                                       VerticalAlignment="Center"/>
                        </Border>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
            <Style.Triggers>
                <Trigger Property="IsMouseOver" Value="True">
                    <Setter Property="Background" Value="#22ffffff"/>
                    <Setter Property="Foreground" Value="White"/>
                </Trigger>
            </Style.Triggers>
        </Style>

        <!-- Active Sidebar Button Style -->
        <Style x:Key="ActiveSidebarButton" TargetType="Button" BasedOn="{StaticResource SidebarButton}">
            <Setter Property="Background" Value="#e94560"/>
            <Setter Property="Foreground" Value="White"/>
            <Setter Property="FontWeight" Value="SemiBold"/>
        </Style>
        
        <!-- Big Launch Button Style -->
        <Style x:Key="LaunchButton" TargetType="Button">
            <Setter Property="Background" Value="#e94560"/>
            <Setter Property="Foreground" Value="White"/>
            <Setter Property="FontFamily" Value="Segoe UI"/>
            <Setter Property="FontSize" Value="16"/>
            <Setter Property="FontWeight" Value="Bold"/>
            <Setter Property="BorderThickness" Value="0"/>
            <Setter Property="Cursor" Value="Hand"/>
            <Setter Property="Height" Value="50"/>
            <Setter Property="Width" Value="200"/>
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="Button">
                        <Border Background="{TemplateBinding Background}" CornerRadius="25">
                            <Border.Effect>
                                <DropShadowEffect Color="#e94560" BlurRadius="10" ShadowDepth="0" Opacity="0.4"/>
                            </Border.Effect>
                            <ContentPresenter HorizontalAlignment="Center" VerticalAlignment="Center"/>
                        </Border>
                        <ControlTemplate.Triggers>
                            <Trigger Property="IsMouseOver" Value="True">
                                <Setter Property="Background" Value="#ff5e78"/>
                                <Setter Property="RenderTransform">
                                    <Setter.Value>
                                        <ScaleTransform ScaleX="1.05" ScaleY="1.05"/>
                                    </Setter.Value>
                                </Setter>
                            </Trigger>
                        </ControlTemplate.Triggers>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
        </Style>
    </Window.Resources>

    <Grid Margin="10">
        <!-- Main Border -->
        <Border Background="#DD1a1a2e" CornerRadius="15" BorderBrush="#e94560" BorderThickness="1">
            <Grid>
                <Grid.ColumnDefinitions>
                    <ColumnDefinition Width="260"/>
                    <ColumnDefinition Width="*"/>
                </Grid.ColumnDefinitions>

                <!-- Sidebar (Left) -->
                <Border Grid.Column="0" Background="#0f0f1a" CornerRadius="15,0,0,15" BorderBrush="#2a2a3d" BorderThickness="0,0,1,0">
                    <StackPanel>
                        <!-- Logo Area -->
                        <StackPanel Margin="20,30,20,20">
                            <Border Width="50" Height="50" Background="#e94560" CornerRadius="25" HorizontalAlignment="Left">
                                <TextBlock Text="O" Foreground="White" FontSize="30" FontWeight="Bold" HorizontalAlignment="Center" VerticalAlignment="Center"/>
                            </Border>
                            <TextBlock Text="OBSIDIAN" Foreground="White" FontSize="18" FontWeight="SemiBold" Margin="0,10,0,0" FontFamily="Segoe UI"/>
                            <TextBlock Text="Launcher" Foreground="#666" FontSize="12" Margin="0,0,0,5" FontFamily="Segoe UI"/>
                        </StackPanel>

                        <!-- Tool List Buttons -->
                        <ScrollViewer VerticalScrollBarVisibility="Auto">
                            <StackPanel Name="SidebarList"/>
                        </ScrollViewer>
                        
                        <!-- Extras Button -->
                        <Button Name="ExtrasBtn" Content="Extras / EXEs" Foreground="#e94560" Background="Transparent" BorderThickness="0" HorizontalAlignment="Center" Margin="0,10,0,0" Cursor="Hand" FontSize="12" FontWeight="Bold"/>

                        <!-- Footer in Sidebar -->
                        <TextBlock Text="v2.1 Stable" Foreground="#444" FontSize="10" HorizontalAlignment="Center" Margin="0,20,0,20"/>
                    </StackPanel>
                </Border>

                <!-- Dashboard (Right) -->
                <Grid Grid.Column="1" Margin="40">
                    <Grid.RowDefinitions>
                        <RowDefinition Height="Auto"/>
                        <RowDefinition Height="*"/>
                        <RowDefinition Height="Auto"/>
                    </Grid.RowDefinitions>

                    <!-- Window Controls (Top Right) -->
                    <StackPanel Orientation="Horizontal" HorizontalAlignment="Right" VerticalAlignment="Top" Margin="0,-10,0,0" ZIndex="10">
                        <Button Content="−" Width="30" Height="30" Background="Transparent" Foreground="#666" FontSize="18" BorderThickness="0" Cursor="Hand" Name="MinBtn" Margin="0,0,5,0"/>
                        <Button Content="✕" Width="30" Height="30" Background="Transparent" Foreground="#666" FontSize="16" BorderThickness="0" Cursor="Hand" Name="CloseBtn"/>
                    </StackPanel>

                    <!-- Tool Display Info -->
                    <StackPanel Grid.Row="1" VerticalAlignment="Center">
                        <TextBlock Text="SELECT A TOOL" Foreground="#e94560" FontSize="14" FontWeight="Bold"/>
                        <TextBlock Name="DisplayTitle" Text="Welcome" FontSize="48" FontWeight="Light" Foreground="White" Margin="0,10,0,10" FontFamily="Segoe UI">
                            <TextBlock.Effect>
                                <DropShadowEffect Color="#e94560" BlurRadius="10" ShadowDepth="0" Opacity="0.3"/>
                            </TextBlock.Effect>
                        </TextBlock>
                        <TextBlock Name="DisplayDesc" Text="Select a module from the sidebar to view details and execute." FontSize="16" Foreground="#8892b0" Width="500" TextWrapping="Wrap" Margin="0,0,0,30"/>
                    </StackPanel>

                    <!-- Launch Button -->
                    <StackPanel Grid.Row="2" HorizontalAlignment="Left" Margin="0,0,0,40">
                        <Button Name="MainLaunchBtn" Content="LAUNCH TOOL" Style="{StaticResource LaunchButton}" IsEnabled="False" Opacity="0.5"/>
                        <TextBlock Name="LogPreview" Text="Ready..." Foreground="#444" FontSize="11" Margin="10,10,0,0" FontFamily="Consolas"/>
                    </StackPanel>
                </Grid>
            </Grid>
        </Border>
    </Grid>
</Window>
"@

# --- XAML for Extras Window ---
[xml]$extrasXaml = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="External Tools"
        Width="350"
        Height="500"
        WindowStartupLocation="CenterScreen"
        WindowStyle="None"
        ResizeMode="NoResize"
        Background="#1a1a2e"
        Topmost="False">
    
    <Border Background="#DD1a1a2e" CornerRadius="10" BorderBrush="#e94560" BorderThickness="1" Margin="10">
        <Grid Margin="20">
            <Grid.RowDefinitions>
                <RowDefinition Height="Auto"/>
                <RowDefinition Height="*"/>
                <RowDefinition Height="Auto"/>
            </Grid.RowDefinitions>
            <TextBlock Text="EXTERNAL APPS" FontSize="18" Foreground="White" FontWeight="Bold" Margin="0,0,0,20"/>
            <ScrollViewer Grid.Row="1" VerticalScrollBarVisibility="Auto">
                <StackPanel Name="ExtrasList"/>
            </ScrollViewer>
            <Button Grid.Row="2" Content="CLOSE" Background="#333" Foreground="White" BorderThickness="0" Height="30" Cursor="Hand" Name="CloseExtrasBtn" Margin="0,20,0,0"/>
        </Grid>
    </Border>
</Window>
"@

# --- Custom Downloader Script ---
 $script_NicToolDownloader = @'
# NicToolDownloader Integrated Script
Write-Host "NicToolDownloader" -ForegroundColor Cyan
Write-Host "==================" -ForegroundColor Cyan
Write-Host ""

# Configuration
 $downloadDir = "C:\SS"

# Create the directory if it does not exist
if (!(Test-Path -Path $downloadDir)) {
    try {
        New-Item -ItemType Directory -Path $downloadDir -Force | Out-Null
        Write-Host "[INFO] Created directory at $downloadDir" -ForegroundColor Green
    }
    catch {
        Write-Host "[ERROR] Failed to create directory. Please check permissions." -ForegroundColor Red
        Read-Host "Press Enter to exit"
        exit
    }
}
else {
    Write-Host "[INFO] Directory already exists at $downloadDir" -ForegroundColor Gray
}
Write-Host ""

# Automatic System Informer Logic
Write-Host "[AUTO] Searching for latest System Informer version..." -ForegroundColor Cyan
 $siUrl = $null
try {
    $apiUrl = "https://api.github.com/repos/winsiderss/systeminformer/releases"
    $response = Invoke-RestMethod -Uri $apiUrl -Headers @{"Accept"="application/vnd.github.v3+json"} -ErrorAction Stop
    $latestRelease = $response[0]
    $asset = $latestRelease.assets | Where-Object { $_.name -match "systeminformer-.*-setup\.exe" } | Select-Object -First 1
    
    if ($asset) {
        $siUrl = $asset.browser_download_url
        Write-Host "[AUTO] Found Latest: $($asset.name)" -ForegroundColor Green
    }
    else {
        Write-Host "[WARN] Could not find setup file in latest release." -ForegroundColor Yellow
    }
}
catch {
    Write-Host "[WARN] Failed to fetch from GitHub API (Network/Rate-Limit)." -ForegroundColor Yellow
}

# Fallback
if (-not $siUrl) {
    Write-Host "[FALLBACK] Using specific System Informer version." -ForegroundColor DarkGray
    $siUrl = "https://github.com/winsiderss/systeminformer/releases/download/v4.0.26144/systeminformer-4.0.26144-setup.exe"
}

# Download Links
 $urls = @(
    "https://github.com/Orbdiff/SSTool/releases/download/yay/SSTool.exe",
    "https://github.com/MeowTonynoh/MeowDoomsdayFucker/releases/download/V.1.2/MeowDoomsdayFucker.exe",
    "https://github.com/MeowTonynoh/MeowImportsChecker/releases/download/MeowImportsChecker/MeowImportsChecker.exe",
    "https://github.com/MeowTonynoh/MeowResolver/releases/download/MeowResolver/MeowResolver.exe",
    $siUrl,
    "https://www.nirsoft.net/utils/winprefetchview.zip"
)

# Download Loop
Write-Host "[START] Downloading files..." -ForegroundColor Cyan
Write-Host ""

foreach ($url in $urls) {
    $fileName = Split-Path $url -Leaf
    $destination = Join-Path -Path $downloadDir -ChildPath $fileName
    Write-Host "Downloading $fileName..." -NoNewline
    
    try {
        Invoke-WebRequest -Uri $url -OutFile $destination -UseBasicParsing
        Write-Host " [DONE]" -ForegroundColor Green
    }
    catch {
        Write-Host " [FAILED]" -ForegroundColor Red
        Write-Host "  Error: $($_.Exception.Message)" -ForegroundColor DarkRed
    }
}

Write-Host ""
Write-Host "[FINISH] All tasks completed." -ForegroundColor Cyan
Write-Host ""

# Credits
 $sumSep = "=" * 40
Write-Host "  Created by  : " -NoNewline -ForegroundColor DarkGray
Write-Host "cheese cat" -ForegroundColor Yellow
Write-Host "  Discord     : " -NoNewline -ForegroundColor DarkGray
Write-Host "cheese_cat0" -ForegroundColor Yellow
Write-Host "  GitHub      : " -NoNewline -ForegroundColor DarkGray
Write-Host "github.com/cheesecatlol" -ForegroundColor Yellow
Write-Host ""
Write-Host "  Created by  : " -NoNewline -ForegroundColor DarkGray
Write-Host "nic" -ForegroundColor Yellow
Write-Host "  Discord     : " -NoNewline -ForegroundColor DarkGray
Write-Host "mecz.exe" -ForegroundColor Yellow
Write-Host "  GitHub      : " -NoNewline -ForegroundColor DarkGray
Write-Host "github.com/Nickk196" -ForegroundColor Yellow
Write-Host ""
Write-Host $sumSep -ForegroundColor DarkYellow
Write-Host ""
Read-Host "  Press Enter to exit"
'@

# --- Backend Logic ---

try {
    # Parse Main XAML
    $reader = (New-Object System.Xml.XmlNodeReader $xaml) 
    $window = [Windows.Markup.XamlReader]::Load($reader)

    # Find Main Elements
    $SidebarList = $window.FindName("SidebarList")
    $DisplayTitle = $window.FindName("DisplayTitle")
    $DisplayDesc = $window.FindName("DisplayDesc")
    $MainLaunchBtn = $window.FindName("MainLaunchBtn")
    $LogPreview = $window.FindName("LogPreview")
    $CloseBtn = $window.FindName("CloseBtn")
    $MinBtn   = $window.FindName("MinBtn")
    $ExtrasBtn = $window.FindName("ExtrasBtn")

    # Tool Data
    $tools = @(
        @{Name="Meow Mod Analyzer"; Desc="Advanced Minecraft mod analysis utility."; Cmd="powershell -ExecutionPolicy Bypass -Command `"Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/MeowTonynoh/MeowModAnalyzer/main/MeowModAnalyzer.ps1')`""},
        @{Name="Macro Detector"; Desc="Detects mouse macros and autoclickers."; Cmd="powershell -ExecutionPolicy Bypass -Command `"Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/Nickk196/MacroDetector/refs/heads/main/MacroDetector.ps1')`""},
        @{Name="Service Checker"; Desc="Analyzes running system services for anomalies."; Cmd="powershell Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass ; powershell Invoke-Expression (Invoke-RestMethod https://raw.githubusercontent.com/praiselily/lilith-ps/refs/heads/main/Services.ps1)"},
        @{Name="Schedule Tasks"; Desc="Lists and checks signed scheduled tasks."; Cmd="powershell -Command `"Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass; Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/praiselily/lilith-ps/refs/heads/main/Signed-Scheduled-Tasks')`""},
        @{Name="Faker Detection"; Desc="Identifies VPN and hotspot usage."; Cmd="powershell -ExecutionPolicy Bypass -Command `"iwr https://raw.githubusercontent.com/praiselily/WeHateFakers/refs/heads/main/HotspotLogs.ps1 | iex`""},
        @{Name="Directory Scanner"; Desc="Scans common directories for specific files."; Cmd="powershell -Command `"Set-ExecutionPolicy Bypass -Scope Process; Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/praiselily/lilith-ps/refs/heads/main/CommonDirectories.ps1')`""},
        @{Name="NicTool Downloader"; Desc="Downloads SSTool, System Informer, and other utilities to C:\SS."; Cmd="CUSTOM_NIC_DOWNLOADER"},
        @{Name="JAR Parser"; Desc="Parses Java JAR files for metadata."; Cmd="powershell Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass ; powershell Invoke-Expression (Invoke-RestMethod https://raw.githubusercontent.com/NoDiff-del/JARParser/refs/heads/main/JARParser.ps1)"},
        @{Name="Alt Detector"; Desc="Identifies alternative accounts and identifiers."; Cmd="powershell -ExecutionPolicy Bypass -Command `"Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/Enr1c0o/Powershell-Scripts/refs/heads/main/Alt-Detector.ps1')`""},
        @{Name="Dqrkis Finder"; Desc="Locates Dqrkis in active sessions."; Cmd="powershell -ExecutionPolicy Bypass -Command `"Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/cheesecatlol/DQRKIS-FUCKER/refs/heads/main/DqrkisFucker.ps1')`""},
        @{Name="Signature"; Desc="Signature Checker."; Cmd="powershell -ExecutionPolicy Bypass -Command `"Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/bacanoicua/Screenshare/main/RedLotusSignatures.ps1')`""},
        @{Name="BAM"; Desc="Backround Activity Monitoring."; Cmd="powershell -ExecutionPolicy Bypass -Command `"Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/PureIntent/ScreenShare/main/RedLotusBam.ps1')`""}
    )

    $currentCommand = ""

    # Function to Create Sidebar Buttons
    function Create-SidebarButton {
        param($Name, $Cmd, $Desc)

        $btn = New-Object System.Windows.Controls.Button
        $btn.Content = $Name
        $btn.Style = $window.FindResource("SidebarButton")
        
        $btn | Add-Member -MemberType NoteProperty -Name "CmdData" -Value $Cmd
        $btn | Add-Member -MemberType NoteProperty -Name "DescData" -Value $Desc
        
        $btn.Add_Click({
             param($sender, $e)
             foreach($child in $SidebarList.Children) {
                if($child -is [System.Windows.Controls.Button]) { $child.Style = $window.FindResource("SidebarButton") }
             }
             $sender.Style = $window.FindResource("ActiveSidebarButton")
             $DisplayTitle.Text = $sender.Content.ToString().ToUpper()
             $DisplayDesc.Text = $sender.DescData
             $global:CurrentCmd = $sender.CmdData
             $MainLaunchBtn.IsEnabled = $true
             $MainLaunchBtn.Opacity = 1
             $LogPreview.Text = "Ready to launch: " + $sender.Content
        }.GetNewClosure())

        $SidebarList.Children.Add($btn)
    }

    # Populate Sidebar
    foreach ($tool in $tools) {
        Create-SidebarButton -Name $tool.Name -Cmd $tool.Cmd -Desc $tool.Desc
    }

    # --- Extras Window Logic ---
    $ExtrasBtn.Add_Click({
        $reader2 = (New-Object System.Xml.XmlNodeReader $extrasXaml)
        $winExtras = [Windows.Markup.XamlReader]::Load($reader2)
        $listExtras = $winExtras.FindName("ExtrasList")
        $closeExtras = $winExtras.FindName("CloseExtrasBtn")

        $myExes = @(
            @{Name="Notepad"; Path="notepad.exe"},
            @{Name="Calculator"; Path="calc.exe"},
            @{Name="Paint"; Path="mspaint.exe"},
            @{Name="Task Manager"; Path="taskmgr.exe"}
        )

        foreach ($exe in $myExes) {
            $btn = New-Object System.Windows.Controls.Button
            $btn.Content = $exe.Name
            $btn.Background = "#0f3460"
            $btn.Foreground = "White"
            $btn.Margin = "0,5"
            $btn.Height = "35"
            $btn.FontFamily = "Segoe UI"
            $btn.Cursor = "Hand"
            $btn.Add_Click({
                try { Start-Process $this.Path } catch { [System.Windows.MessageBox]::Show("Could not launch: " + $this.Path) }
            }.GetNewClosure())
            $btn | Add-Member -MemberType NoteProperty -Name "Path" -Value $exe.Path
            $listExtras.Children.Add($btn)
        }

        $closeExtras.Add_Click({ $winExtras.Close() })
        $winExtras.ShowDialog() | Out-Null
    })

    # Main Launch Function
    $MainLaunchBtn.Add_Click({
        try {
            if($global:CurrentCmd) {
                $LogPreview.Text = "Initializing..."
                
                # --- SPECIAL HANDLING FOR NIC TOOL DOWNLOADER ---
                if ($global:CurrentCmd -eq "CUSTOM_NIC_DOWNLOADER") {
                    $tempFileName = [Guid]::NewGuid().ToString() + ".ps1"
                    $tempFilePath = Join-Path $env:TEMP $tempFileName
                    
                    try {
                        $script_NicToolDownloader | Out-File -FilePath $tempFilePath -Encoding UTF8
                        
                        # Robust Argument List
                        $psiArgs = "/k", "powershell -NoExit -ExecutionPolicy Bypass -File `"$tempFilePath`""
                        Start-Process "cmd.exe" -ArgumentList $psiArgs
                        
                        $LogPreview.Text = "Running NicTool Downloader..."
                    }
                    catch {
                        [System.Windows.MessageBox]::Show("Error preparing NicTool Downloader: $_")
                    }
                }
                # --- STANDARD WEB SCRIPTS ---
                else {
                    $tempFileName = [Guid]::NewGuid().ToString() + ".ps1"
                    $tempFilePath = Join-Path $env:TEMP $tempFileName
                    
                    $fileContent = @"
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
 $global:CurrentCmd
"@
                    Set-Content -Path $tempFilePath -Value $fileContent
                    
                    # Robust Argument List
                    $psiArgs = "/k", "powershell -NoExit -ExecutionPolicy Bypass -File `"$tempFilePath`""
                    Start-Process "cmd.exe" -ArgumentList $psiArgs
                    
                    $LogPreview.Text = "Process started."
                }
            }
        }
        catch {
            [System.Windows.MessageBox]::Show("Launcher Error: $_")
            $LogPreview.Text = "Error occurred."
        }
    })

    # Minimize Function
    $MinBtn.Add_Click({
        $window.WindowState = [Windows.WindowState]::Minimized
    })

    # Close Button
    $CloseBtn.Add_Click({
        $window.Close()
    })

    # Draggable
    $window.Add_MouseLeftButtonDown({
        $window.DragMove()
    })

    $window.ShowDialog() | Out-Null

} catch {
    Write-Host "CRITICAL ERROR: $_" -ForegroundColor Red
    Read-Host "Press Enter to exit"
}
