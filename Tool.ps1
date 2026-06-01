Add-Type -AssemblyName PresentationFramework
Add-Type -AssemblyName System.Windows.Forms

# --- XAML GUI Definition ---
[xml]$xaml = @"
<Window 
    xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
    xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
    Title="Tool Launcher"
    Width="1020"
    Height="680"
    WindowStartupLocation="CenterScreen"
    WindowStyle="None"
    AllowsTransparency="True"
    Background="Transparent"
    ResizeMode="NoResize"
    Topmost="False">

    <Window.Resources>

        <!-- Scrollbar styling -->
        <Style TargetType="ScrollBar">
            <Setter Property="Width" Value="4"/>
            <Setter Property="Background" Value="Transparent"/>
        </Style>

        <Style x:Key="SidebarButton" TargetType="Button">
            <Setter Property="Background" Value="Transparent"/>
            <Setter Property="Foreground" Value="#AAAAAA"/>
            <Setter Property="FontFamily" Value="Segoe UI"/>
            <Setter Property="FontSize" Value="13"/>
            <Setter Property="FontWeight" Value="Normal"/>
            <Setter Property="BorderThickness" Value="0"/>
            <Setter Property="HorizontalContentAlignment" Value="Left"/>
            <Setter Property="Padding" Value="18,10"/>
            <Setter Property="Cursor" Value="Hand"/>
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="Button">
                        <Border x:Name="Bg" Background="{TemplateBinding Background}" CornerRadius="4" Margin="6,2">
                            <TextBlock Text="{TemplateBinding Content}" TextWrapping="Wrap"
                                       TextAlignment="Left" VerticalAlignment="Center"
                                       Padding="{TemplateBinding Padding}"/>
                        </Border>
                        <ControlTemplate.Triggers>
                            <Trigger Property="IsMouseOver" Value="True">
                                <Setter TargetName="Bg" Property="Background" Value="#2A2A2A"/>
                            </Trigger>
                        </ControlTemplate.Triggers>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
        </Style>

        <Style x:Key="ActiveSidebarButton" TargetType="Button" BasedOn="{StaticResource SidebarButton}">
            <Setter Property="Background" Value="#0D3F66"/>
            <Setter Property="Foreground" Value="#60AAFF"/>
            <Setter Property="FontWeight" Value="SemiBold"/>
        </Style>

        <Style x:Key="LaunchButton" TargetType="Button">
            <Setter Property="Background" Value="#0078D4"/>
            <Setter Property="Foreground" Value="White"/>
            <Setter Property="FontFamily" Value="Segoe UI"/>
            <Setter Property="FontSize" Value="13"/>
            <Setter Property="FontWeight" Value="SemiBold"/>
            <Setter Property="BorderThickness" Value="0"/>
            <Setter Property="Cursor" Value="Hand"/>
            <Setter Property="Height" Value="42"/>
            <Setter Property="Width" Value="180"/>
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="Button">
                        <Border x:Name="Bg" Background="{TemplateBinding Background}" CornerRadius="6">
                            <ContentPresenter HorizontalAlignment="Center" VerticalAlignment="Center"/>
                        </Border>
                        <ControlTemplate.Triggers>
                            <Trigger Property="IsMouseOver" Value="True">
                                <Setter TargetName="Bg" Property="Background" Value="#1A8FE3"/>
                            </Trigger>
                            <Trigger Property="IsEnabled" Value="False">
                                <Setter TargetName="Bg" Property="Background" Value="#1C1C1C"/>
                            </Trigger>
                        </ControlTemplate.Triggers>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
        </Style>

        <Style x:Key="ChromeButton" TargetType="Button">
            <Setter Property="Background" Value="Transparent"/>
            <Setter Property="Foreground" Value="#555"/>
            <Setter Property="FontSize" Value="13"/>
            <Setter Property="BorderThickness" Value="0"/>
            <Setter Property="Cursor" Value="Hand"/>
            <Setter Property="Width" Value="32"/>
            <Setter Property="Height" Value="32"/>
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="Button">
                        <Border x:Name="Bg" Background="{TemplateBinding Background}" CornerRadius="4">
                            <ContentPresenter HorizontalAlignment="Center" VerticalAlignment="Center"/>
                        </Border>
                        <ControlTemplate.Triggers>
                            <Trigger Property="IsMouseOver" Value="True">
                                <Setter TargetName="Bg" Property="Background" Value="#2A2A2A"/>
                                <Setter Property="Foreground" Value="White"/>
                            </Trigger>
                        </ControlTemplate.Triggers>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
        </Style>

    </Window.Resources>

    <Border Background="#E81E1E1E" CornerRadius="10" BorderBrush="#2A2A2A" BorderThickness="1" Margin="8">
        <Border.Effect>
            <DropShadowEffect Color="Black" BlurRadius="20" ShadowDepth="4" Opacity="0.6"/>
        </Border.Effect>
        <Grid>
            <Grid.ColumnDefinitions>
                <ColumnDefinition Width="210"/>
                <ColumnDefinition Width="*"/>
            </Grid.ColumnDefinitions>

            <!-- Sidebar -->
            <Border Grid.Column="0" Background="#161616" CornerRadius="10,0,0,10">
                <DockPanel>
                    <!-- Sidebar Header -->
                    <StackPanel DockPanel.Dock="Top" Margin="18,22,18,12">
                        <TextBlock Text="TOOL LAUNCHER" Foreground="#333" FontSize="10"
                                   FontWeight="Bold" FontFamily="Segoe UI"/>
                        <Rectangle Height="1" Fill="#1F1F1F" Margin="0,12,0,0"/>
                    </StackPanel>

                    <!-- System Apps at bottom -->
                    <Border DockPanel.Dock="Bottom" Padding="12,12,12,16">
                        <Button Name="ExtrasBtn" Content="⚙  System Apps"
                                Foreground="#555" Background="Transparent" BorderThickness="0"
                                HorizontalAlignment="Stretch" Cursor="Hand"
                                FontSize="12" FontFamily="Segoe UI" Padding="8,8"
                                HorizontalContentAlignment="Left">
                            <Button.Template>
                                <ControlTemplate TargetType="Button">
                                    <Border x:Name="Bg" Background="{TemplateBinding Background}"
                                            CornerRadius="4" Padding="{TemplateBinding Padding}">
                                        <ContentPresenter HorizontalAlignment="{TemplateBinding HorizontalContentAlignment}"/>
                                    </Border>
                                    <ControlTemplate.Triggers>
                                        <Trigger Property="IsMouseOver" Value="True">
                                            <Setter TargetName="Bg" Property="Background" Value="#1E1E1E"/>
                                            <Setter Property="Foreground" Value="#888"/>
                                        </Trigger>
                                    </ControlTemplate.Triggers>
                                </ControlTemplate>
                            </Button.Template>
                        </Button>
                    </Border>

                    <!-- Tool List -->
                    <ScrollViewer VerticalScrollBarVisibility="Auto" HorizontalScrollBarVisibility="Disabled" Margin="0,0,0,0">
                        <StackPanel>
                            <TextBlock Text="SCRIPTS" Foreground="#333" FontSize="10"
                                       FontWeight="Bold" FontFamily="Segoe UI" Margin="18,8,0,6"/>
                            <StackPanel Name="SidebarList" Margin="6,0,6,0"/>
                            <Rectangle Height="1" Fill="#1F1F1F" Margin="12,10,12,6"/>
                            <TextBlock Text="APPS" Foreground="#333" FontSize="10"
                                       FontWeight="Bold" FontFamily="Segoe UI" Margin="18,0,0,6"/>
                            <StackPanel Name="ExeList" Margin="6,0,6,0"/>
                        </StackPanel>
                    </ScrollViewer>
                </DockPanel>
            </Border>

            <!-- Main Content Area -->
            <Grid Grid.Column="1" Margin="36,28,36,28">
                <Grid.RowDefinitions>
                    <RowDefinition Height="Auto"/>
                    <RowDefinition Height="*"/>
                    <RowDefinition Height="Auto"/>
                </Grid.RowDefinitions>

                <!-- Top Chrome Buttons -->
                <StackPanel Grid.Row="0" Orientation="Horizontal" HorizontalAlignment="Right">
                    <Button Name="MinBtn" Content="─" Style="{StaticResource ChromeButton}" Margin="0,0,4,0"/>
                    <Button Name="CloseBtn" Content="✕" Style="{StaticResource ChromeButton}"/>
                </StackPanel>

                <!-- Center Info -->
                <StackPanel Grid.Row="1" VerticalAlignment="Center">
                    <TextBlock Name="DisplayTitle" Text="Select a Tool"
                               FontSize="32" FontWeight="Light" Foreground="White"
                               FontFamily="Segoe UI" Margin="0,0,0,8"/>
                    <Rectangle Height="1" Fill="#222" Width="400" HorizontalAlignment="Left" Margin="0,0,0,16"/>
                    <TextBlock Name="DisplayDesc"
                               Text="Choose a tool from the sidebar to see details and launch it."
                               FontSize="13" Foreground="#555" MaxWidth="560"
                               TextWrapping="Wrap" FontFamily="Segoe UI" LineHeight="20"/>
                </StackPanel>

                <!-- Bottom Launch Area -->
                <StackPanel Grid.Row="2">
                    <Button Name="MainLaunchBtn" Content="LAUNCH" Style="{StaticResource LaunchButton}"
                            IsEnabled="False" Opacity="0.4" HorizontalAlignment="Left"/>
                    <TextBlock Name="LogPreview" Text="No tool selected."
                               Foreground="#333" FontSize="11" Margin="2,10,0,0"
                               FontFamily="Consolas"/>
                </StackPanel>
            </Grid>
        </Grid>
    </Border>
</Window>
"@

# --- FIX: Closing delimiter was "# instead of "@  ---
[xml]$extrasXaml = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="System Apps"
        Width="280"
        Height="420"
        WindowStartupLocation="CenterScreen"
        WindowStyle="None"
        ResizeMode="NoResize"
        AllowsTransparency="True"
        Background="Transparent"
        Topmost="False">
    <Border Background="#E81E1E1E" CornerRadius="8" BorderBrush="#2A2A2A" BorderThickness="1" Margin="8">
        <Border.Effect>
            <DropShadowEffect Color="Black" BlurRadius="16" ShadowDepth="3" Opacity="0.5"/>
        </Border.Effect>
        <Grid Margin="16">
            <Grid.RowDefinitions>
                <RowDefinition Height="Auto"/>
                <RowDefinition Height="*"/>
                <RowDefinition Height="Auto"/>
            </Grid.RowDefinitions>
            <TextBlock Text="SYSTEM APPS" FontSize="10" Foreground="#333"
                       FontWeight="Bold" FontFamily="Segoe UI" Margin="0,0,0,16"/>
            <ScrollViewer Grid.Row="1" VerticalScrollBarVisibility="Auto">
                <StackPanel Name="ExtrasList"/>
            </ScrollViewer>
            <Button Grid.Row="2" Content="CLOSE" Background="#1A1A1A" Foreground="#555"
                    BorderThickness="0" Height="32" Cursor="Hand" Name="CloseExtrasBtn"
                    Margin="0,16,0,0" FontFamily="Segoe UI" FontSize="12"/>
        </Grid>
    </Border>
</Window>
"@

try {
    $reader = New-Object System.Xml.XmlNodeReader $xaml
    $window = [Windows.Markup.XamlReader]::Load($reader)

    $SidebarList   = $window.FindName("SidebarList")
    $ExeList       = $window.FindName("ExeList")
    $DisplayTitle  = $window.FindName("DisplayTitle")
    $DisplayDesc   = $window.FindName("DisplayDesc")
    $MainLaunchBtn = $window.FindName("MainLaunchBtn")
    $LogPreview    = $window.FindName("LogPreview")
    $CloseBtn      = $window.FindName("CloseBtn")
    $MinBtn        = $window.FindName("MinBtn")
    $ExtrasBtn     = $window.FindName("ExtrasBtn")

    $global:CurrentCmd = $null

    # --- Tool Definitions ---
    $tools = @(
        @{Name="Meow Mod Analyzer";   Desc="Advanced Minecraft mod analysis utility.";             Cmd="powershell -ExecutionPolicy Bypass -Command `"Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/MeowTonynoh/MeowModAnalyzer/main/MeowModAnalyzer.ps1')`""},
        @{Name="Macro Detector";      Desc="Detects mouse macros and autoclickers.";               Cmd="powershell -ExecutionPolicy Bypass -Command `"Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/Nickk196/MacroDetector/refs/heads/main/MacroDetector.ps1')`""},
        @{Name="Service Checker";     Desc="Analyzes running system services for anomalies.";      Cmd="powershell -ExecutionPolicy Bypass -Command `"Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/praiselily/lilith-ps/refs/heads/main/Services.ps1')`""},
        @{Name="Schedule Tasks";      Desc="Lists and checks signed scheduled tasks.";             Cmd="powershell -ExecutionPolicy Bypass -Command `"Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/praiselily/lilith-ps/refs/heads/main/Signed-Scheduled-Tasks')`""},
        @{Name="Faker Detection";     Desc="Identifies VPN and hotspot usage.";                    Cmd="powershell -ExecutionPolicy Bypass -Command `"Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/praiselily/WeHateFakers/refs/heads/main/HotspotLogs.ps1')`""},
        @{Name="Directory Scanner";   Desc="Scans common directories for specific files.";         Cmd="powershell -ExecutionPolicy Bypass -Command `"Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/praiselily/lilith-ps/refs/heads/main/CommonDirectories.ps1')`""},
        @{Name="NicTool Downloader";  Desc="Downloads SSTool, System Informer, and other utilities to C:\SS."; Cmd="CUSTOM_NIC_DOWNLOADER"},
        @{Name="JAR Scanner";         Desc="Scans JAR files for malicious content.";               Cmd="powershell -ExecutionPolicy Bypass -Command `"Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/praiselily/JARScanner/refs/heads/main/JARScanner.ps1')`""},
        @{Name="Alt Detector";        Desc="Identifies alternative accounts and identifiers.";     Cmd="powershell -ExecutionPolicy Bypass -Command `"Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/Enr1c0o/Powershell-Scripts/refs/heads/main/Alt-Detector.ps1')`""},
        @{Name="Dqrkis Finder";       Desc="Locates Dqrkis in active sessions.";                  Cmd="powershell -ExecutionPolicy Bypass -Command `"Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/cheesecatlol/DQRKIS-FUCKER/refs/heads/main/DqrkisFucker.ps1')`""},
        @{Name="Signature";           Desc="Signature checker for file verification.";             Cmd="powershell -ExecutionPolicy Bypass -Command `"Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/bacanoicua/Screenshare/main/RedLotusSignatures.ps1')`""},
        @{Name="BAM";                 Desc="Background Activity Monitoring.";                      Cmd="powershell -ExecutionPolicy Bypass -Command `"Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/PureIntent/ScreenShare/main/RedLotusBam.ps1')`""}
    )

    # --- Build Sidebar ---
    function Create-SidebarButton {
        param($Name, $Cmd, $Desc)
        $btn = New-Object System.Windows.Controls.Button
        $btn.Content = $Name
        $btn.Style   = $window.FindResource("SidebarButton")
        $btn | Add-Member -MemberType NoteProperty -Name "CmdData"  -Value $Cmd
        $btn | Add-Member -MemberType NoteProperty -Name "DescData" -Value $Desc

        $btn.Add_Click({
            param($sender, $e)
            foreach ($child in $SidebarList.Children) {
                if ($child -is [System.Windows.Controls.Button]) {
                    $child.Style = $window.FindResource("SidebarButton")
                }
            }
            foreach ($child in $ExeList.Children) {
                if ($child -is [System.Windows.Controls.Button]) {
                    $child.Style = $window.FindResource("SidebarButton")
                }
            }
            $sender.Style          = $window.FindResource("ActiveSidebarButton")
            $DisplayTitle.Text     = $sender.Content.ToString()
            $DisplayDesc.Text      = $sender.DescData
            $global:CurrentCmd     = $sender.CmdData
            $MainLaunchBtn.IsEnabled = $true
            $MainLaunchBtn.Opacity   = 1
            $LogPreview.Text       = "Ready — " + $sender.Content
        }.GetNewClosure())

        $SidebarList.Children.Add($btn) | Out-Null
    }

    foreach ($tool in $tools) {
        Create-SidebarButton -Name $tool.Name -Cmd $tool.Cmd -Desc $tool.Desc
    }

    # --- Local EXE Apps ---
    $exeApps = @(
        @{Name="SSTool";             Url="https://github.com/Orbdiff/SSTool/releases/download/yay/SSTool.exe";                                                Desc="Screenshot tool utility."},
        @{Name="MeowDoomsdayFucker"; Url="https://github.com/MeowTonynoh/MeowDoomsdayFucker/releases/download/V.1.2/MeowDoomsdayFucker.exe";                 Desc="Meow Doomsday analysis tool."},
        @{Name="MeowImportsChecker"; Url="https://github.com/MeowTonynoh/MeowImportsChecker/releases/download/MeowImportsChecker/MeowImportsChecker.exe";     Desc="Checks imports in executables."},
        @{Name="MeowResolver";       Url="https://github.com/MeowTonynoh/MeowResolver/releases/download/MeowResolver/MeowResolver.exe";                       Desc="Meow DNS/address resolver."}
    )

    function Create-ExeButton {
        param($Name, $Url, $Desc)
        $btn = New-Object System.Windows.Controls.Button
        $btn.Content = $Name
        $btn.Style   = $window.FindResource("SidebarButton")
        $btn | Add-Member -MemberType NoteProperty -Name "ExeUrl"  -Value $Url
        $btn | Add-Member -MemberType NoteProperty -Name "DescData" -Value $Desc

        $btn.Add_Click({
            param($sender, $e)
            foreach ($child in $SidebarList.Children) {
                if ($child -is [System.Windows.Controls.Button]) { $child.Style = $window.FindResource("SidebarButton") }
            }
            foreach ($child in $ExeList.Children) {
                if ($child -is [System.Windows.Controls.Button]) { $child.Style = $window.FindResource("SidebarButton") }
            }
            $sender.Style      = $window.FindResource("ActiveSidebarButton")
            $DisplayTitle.Text = $sender.Content.ToString()
            $DisplayDesc.Text  = $sender.DescData
            $global:CurrentCmd = "EXE:" + $sender.ExeUrl
            $MainLaunchBtn.IsEnabled = $true
            $MainLaunchBtn.Opacity   = 1
            $LogPreview.Text   = "Ready — " + $sender.Content
        }.GetNewClosure())

        $ExeList.Children.Add($btn) | Out-Null
    }

    foreach ($app in $exeApps) {
        Create-ExeButton -Name $app.Name -Url $app.Url -Desc $app.Desc
    }
    $ExtrasBtn.Add_Click({
        $reader2   = New-Object System.Xml.XmlNodeReader $extrasXaml
        $winExtras = [Windows.Markup.XamlReader]::Load($reader2)
        $listExtras  = $winExtras.FindName("ExtrasList")
        $closeExtras = $winExtras.FindName("CloseExtrasBtn")

        $myExes = @(
            @{Name="Notepad";      Path="notepad.exe";    Args=$null},
            @{Name="Calculator";   Path="calc.exe";       Args=$null},
            @{Name="Paint";        Path="mspaint.exe";    Args=$null},
            @{Name="Task Manager"; Path="taskmgr.exe";    Args=$null},
            @{Name="Recycle Bin";  Path="explorer.exe";   Args="::{645FF040-5081-101B-9F08-00AA002F954E}"},
            @{Name="Recent Files"; Path="explorer.exe";   Args="shell:Recent"},
            @{Name="Temp Folder";  Path="explorer.exe";   Args=$env:TEMP},
            @{Name="Prefetch";     Path="explorer.exe";   Args="C:\Windows\Prefetch"}
        )

        foreach ($exe in $myExes) {
            $btn = New-Object System.Windows.Controls.Button
            $btn.Content                   = $exe.Name
            $btn.Background                = [System.Windows.Media.Brushes]::Transparent
            $btn.Foreground                = [System.Windows.Media.Brushes]::Gray
            $btn.Margin                    = "0,3"
            $btn.Height                    = 34
            $btn.FontFamily                = "Segoe UI"
            $btn.FontSize                  = 13
            $btn.Cursor                    = [System.Windows.Input.Cursors]::Hand
            $btn.HorizontalContentAlignment = [System.Windows.HorizontalAlignment]::Left
            $btn.Padding                   = "10,0"
            $btn.BorderThickness           = 0

            # FIX: capture exe data in closure-local vars so $this doesn't lose scope
            $localPath = $exe.Path
            $localArgs = $exe.Args

            $btn.Add_Click({
                try {
                    if ([string]::IsNullOrWhiteSpace($localArgs)) {
                        Start-Process $localPath
                    } else {
                        Start-Process $localPath -ArgumentList $localArgs
                    }
                } catch {
                    [System.Windows.MessageBox]::Show("Could not launch: $localPath")
                }
            }.GetNewClosure())

            $btn.Add_MouseEnter({ $this.Foreground = "White";  $this.Background = "#252525" })
            $btn.Add_MouseLeave({ $this.Foreground = "Gray";   $this.Background = "Transparent" })

            $listExtras.Children.Add($btn) | Out-Null
        }

        $closeExtras.Add_Click({ $winExtras.Close() })

        # Allow dragging the extras window too
        $winExtras.Add_MouseLeftButtonDown({
            if ($_.OriginalSource -isnot [System.Windows.Controls.Button]) { $winExtras.DragMove() }
        })

        $winExtras.ShowDialog() | Out-Null
    })

    # --- Launch Button ---
    $MainLaunchBtn.Add_Click({
        if (-not $global:CurrentCmd) { return }

        try {
            $LogPreview.Text  = "Initializing..."
            $tempFileName     = [Guid]::NewGuid().ToString() + ".ps1"
            $tempFilePath     = Join-Path $env:TEMP $tempFileName

            # Direct EXE launch — download from URL to temp and run
            if ($global:CurrentCmd -like "EXE:*") {
                $exeUrl      = $global:CurrentCmd.Substring(4)
                $exeName     = Split-Path $exeUrl -Leaf
                $exeTempPath = Join-Path $env:TEMP $exeName
                try {
                    $LogPreview.Text = "Downloading $exeName..."
                    Invoke-WebRequest -Uri $exeUrl -OutFile $exeTempPath -UseBasicParsing
                    $LogPreview.Text = "Launching $exeName..."
                    Start-Process $exeTempPath
                } catch {
                    [System.Windows.MessageBox]::Show("Failed to download or launch:`n$exeUrl`n`n$_")
                    $LogPreview.Text = "Error occurred."
                }
                return
            }

            if ($global:CurrentCmd -eq "CUSTOM_NIC_DOWNLOADER") {
                # Embedded NicTool downloader — written as a self-contained script
                $scriptContent = @'
Write-Host "NicToolDownloader" -ForegroundColor Cyan
Write-Host "==================" -ForegroundColor Cyan
Write-Host ""

$downloadDir = "C:\SS"
if (!(Test-Path -Path $downloadDir)) {
    try {
        New-Item -ItemType Directory -Path $downloadDir -Force | Out-Null
        Write-Host "[INFO] Created directory at $downloadDir" -ForegroundColor Green
    } catch {
        Write-Host "[ERROR] Failed to create directory." -ForegroundColor Red
        Read-Host; exit
    }
} else {
    Write-Host "[INFO] Directory already exists at $downloadDir" -ForegroundColor Gray
}

Write-Host "[AUTO] Searching for latest System Informer version..." -ForegroundColor Cyan
$siUrl = $null
try {
    $apiUrl   = "https://api.github.com/repos/winsiderss/systeminformer/releases"
    $response = Invoke-RestMethod -Uri $apiUrl -Headers @{"Accept"="application/vnd.github.v3+json"} -ErrorAction Stop
    $asset    = $response[0].assets | Where-Object { $_.name -match "systeminformer-.*-setup\.exe" } | Select-Object -First 1
    if ($asset) {
        $siUrl = $asset.browser_download_url
        Write-Host "[AUTO] Found latest: $($asset.name)" -ForegroundColor Green
    } else {
        Write-Host "[WARN] Could not find setup file." -ForegroundColor Yellow
    }
} catch {
    Write-Host "[WARN] Failed to fetch from GitHub API." -ForegroundColor Yellow
}

if (-not $siUrl) {
    Write-Host "[FALLBACK] Using pinned version." -ForegroundColor DarkGray
    $siUrl = "https://github.com/winsiderss/systeminformer/releases/download/v4.0.26144/systeminformer-4.0.26144-setup.exe"
}

$urls = @(
    "https://github.com/Orbdiff/SSTool/releases/download/yay/SSTool.exe",
    "https://github.com/MeowTonynoh/MeowDoomsdayFucker/releases/download/V.1.2/MeowDoomsdayFucker.exe",
    "https://github.com/MeowTonynoh/MeowImportsChecker/releases/download/MeowImportsChecker/MeowImportsChecker.exe",
    "https://github.com/MeowTonynoh/MeowResolver/releases/download/MeowResolver/MeowResolver.exe",
    $siUrl,
    "https://www.nirsoft.net/utils/winprefetchview.zip"
)

Write-Host "[START] Downloading files..." -ForegroundColor Cyan
foreach ($url in $urls) {
    $fileName    = Split-Path $url -Leaf
    $destination = Join-Path $downloadDir $fileName
    Write-Host "  Downloading $fileName..." -NoNewline
    try {
        Invoke-WebRequest -Uri $url -OutFile $destination -UseBasicParsing
        Write-Host " [DONE]" -ForegroundColor Green
    } catch {
        Write-Host " [FAILED]" -ForegroundColor Red
    }
}

Write-Host ""
Write-Host "[FINISH] All tasks completed." -ForegroundColor Cyan
Write-Host "  Created by: cheese cat & nic" -ForegroundColor Yellow
Read-Host "  Press Enter to exit"
'@
                $scriptContent | Out-File -FilePath $tempFilePath -Encoding UTF8
                $LogPreview.Text = "Running NicTool Downloader..."

            } else {
                # Standard remote tool — just run the command directly
                # FIX: use single-quoted heredoc so $global:CurrentCmd expands correctly at runtime
                $capturedCmd = $global:CurrentCmd
                $scriptContent = "Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass -Force`r`n$capturedCmd"
                $scriptContent | Out-File -FilePath $tempFilePath -Encoding UTF8
                $LogPreview.Text = "Process started."
            }

            Start-Process "cmd.exe" -ArgumentList "/k", "powershell -NoExit -ExecutionPolicy Bypass -File `"$tempFilePath`""

        } catch {
            [System.Windows.MessageBox]::Show("Launcher Error: $_")
            $LogPreview.Text = "Error occurred."
        }
    })

    # --- Chrome Buttons ---
    $MinBtn.Add_Click({   $window.WindowState = [Windows.WindowState]::Minimized })
    $CloseBtn.Add_Click({ $window.Close() })

    # --- Draggable Window ---
    $window.Add_MouseLeftButtonDown({
        if ($_.OriginalSource -isnot [System.Windows.Controls.Button] -and
            $_.OriginalSource -isnot [System.Windows.Controls.TextBox]) {
            $window.DragMove()
        }
    })

    $window.ShowDialog() | Out-Null

} catch {
    Write-Error $_.Exception.Message
}
