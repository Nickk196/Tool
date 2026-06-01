I have updated the script to match the visual style of the image you provided (Black/Dark Gray theme, Red accents, "OrbDiff" and "Spokwn" branding, and flat rectangular buttons).

Here is the complete, updated PowerShell script:

```powershell
Add-Type -AssemblyName PresentationFramework
Add-Type -AssemblyName System.Windows.Forms

[xml]$xaml = @"
<Window
    xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
    xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
    Title="Tool Launcher"
    Width="1100"
    Height="720"
    WindowStartupLocation="CenterScreen"
    ResizeMode="NoResize"
    WindowStyle="None"
    AllowsTransparency="True"
    Background="Transparent"
    FontFamily="Segoe UI">

    <Window.Resources>
        <!-- Dark Theme Resources -->
        <SolidColorBrush x:Key="WinBg" Color="#0F0F0F"/>
        <SolidColorBrush x:Key="SidebarBg" Color="#141414"/>
        <SolidColorBrush x:Key="CardBg" Color="#1A1A1A"/>
        <SolidColorBrush x:Key="BorderBrush" Color="#333333"/>
        
        <!-- Accent Red -->
        <SolidColorBrush x:Key="AccentRed" Color="#D92525"/>
        <SolidColorBrush x:Key="AccentRedDark" Color="#8A1515"/>

        <!-- Button Styles -->
        <Style x:Key="SidebarBtn" TargetType="Button">
            <Setter Property="Background" Value="#252526"/>
            <Setter Property="Foreground" Value="#CCCCCC"/>
            <Setter Property="FontSize" Value="13"/>
            <Setter Property="FontWeight" Value="Normal"/>
            <Setter Property="BorderThickness" Value="0"/>
            <Setter Property="Cursor" Value="Hand"/>
            <Setter Property="HorizontalContentAlignment" Value="Left"/>
            <Setter Property="Height" Value="40"/>
            <Setter Property="Margin" Value="0,2"/>
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="Button">
                        <Border x:Name="Bg" Background="{TemplateBinding Background}" CornerRadius="4" Padding="12,0">
                            <ContentPresenter HorizontalAlignment="{TemplateBinding HorizontalContentAlignment}" VerticalAlignment="Center"/>
                        </Border>
                        <ControlTemplate.Triggers>
                            <Trigger Property="IsMouseOver" Value="True">
                                <Setter TargetName="Bg" Property="Background" Value="#37373D"/>
                                <Setter Property="Foreground" Value="White"/>
                            </Trigger>
                        </ControlTemplate.Triggers>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
        </Style>

        <!-- Active Sidebar Button (Red Style) -->
        <Style x:Key="ActiveSidebarBtn" TargetType="Button" BasedOn="{StaticResource SidebarBtn}">
            <Setter Property="Background" Value="#D92525"/> <!-- Red Background -->
            <Setter Property="Foreground" Value="White"/>
            <Setter Property="FontWeight" Value="SemiBold"/>
        </Style>

        <!-- Chrome Buttons -->
        <Style x:Key="ChromeBtn" TargetType="Button">
            <Setter Property="Width" Value="30"/>
            <Setter Property="Height" Value="30"/>
            <Setter Property="Foreground" Value="#888"/>
            <Setter Property="Background" Value="Transparent"/>
            <Setter Property="BorderThickness" Value="0"/>
            <Setter Property="Cursor" Value="Hand"/>
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="Button">
                        <Border x:Name="Bg" Background="{TemplateBinding Background}" CornerRadius="4">
                            <ContentPresenter HorizontalAlignment="Center" VerticalAlignment="Center"/>
                        </Border>
                        <ControlTemplate.Triggers>
                            <Trigger Property="IsMouseOver" Value="True">
                                <Setter TargetName="Bg" Property="Background" Value="#333"/>
                                <Setter Property="Foreground" Value="White"/>
                            </Trigger>
                        </ControlTemplate.Triggers>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
        </Style>

        <!-- Launch Button -->
        <Style x:Key="LaunchBtn" TargetType="Button">
            <Setter Property="Foreground" Value="White"/>
            <Setter Property="FontSize" Value="14"/>
            <Setter Property="FontWeight" Value="Bold"/>
            <Setter Property="Height" Value="38"/>
            <Setter Property="BorderThickness" Value="0"/>
            <Setter Property="Cursor" Value="Hand"/>
            <Setter Property="Background" Value="#D92525"/>
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="Button">
                        <Border x:Name="Bg" Background="{TemplateBinding Background}" CornerRadius="4">
                            <ContentPresenter HorizontalAlignment="Center" VerticalAlignment="Center"/>
                        </Border>
                        <ControlTemplate.Triggers>
                            <Trigger Property="IsMouseOver" Value="True">
                                <Setter TargetName="Bg" Property="Background" Value="#FF3333"/>
                            </Trigger>
                            <Trigger Property="IsEnabled" Value="False">
                                <Setter TargetName="Bg" Property="Background" Value="#333"/>
                                <Setter Property="Foreground" Value="#555"/>
                            </Trigger>
                        </ControlTemplate.Triggers>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
        </Style>

        <Style TargetType="ScrollBar">
            <Setter Property="Width" Value="6"/>
            <Setter Property="Background" Value="Transparent"/>
            <Setter Property="Foreground" Value="#444"/>
        </Style>
    </Window.Resources>

    <Border CornerRadius="8" Background="{StaticResource WinBg}" BorderBrush="{StaticResource BorderBrush}" BorderThickness="1" Margin="10">
        <Border.Effect>
            <DropShadowEffect BlurRadius="20" ShadowDepth="0" Opacity="0.6" Color="Black"/>
        </Border.Effect>
        <Grid>
            <Grid.RowDefinitions>
                <RowDefinition Height="40"/>
                <RowDefinition Height="*"/>
            </Grid.RowDefinitions>

            <!-- Titlebar -->
            <Border Grid.Row="0" Background="#141414" CornerRadius="8,8,0,0" BorderBrush="{StaticResource BorderBrush}" BorderThickness="0,0,0,1">
                <Grid Margin="15,0,10,0">
                    <Grid.ColumnDefinitions>
                        <ColumnDefinition Width="Auto"/>
                        <ColumnDefinition Width="*"/>
                        <ColumnDefinition Width="Auto"/>
                    </Grid.ColumnDefinitions>

                    <!-- Branding -->
                    <StackPanel Orientation="Horizontal" VerticalAlignment="Center">
                        <TextBlock Text="OrbDiff" FontSize="14" FontWeight="Bold" Foreground="#D92525" VerticalAlignment="Center"/>
                        <TextBlock Text="  |  " FontSize="14" Foreground="#444" VerticalAlignment="Center"/>
                        <TextBlock Text="Spokwn" FontSize="14" FontWeight="Normal" Foreground="#AAA" VerticalAlignment="Center"/>
                    </StackPanel>

                    <!-- Chrome -->
                    <StackPanel Grid.Column="2" Orientation="Horizontal" VerticalAlignment="Center">
                        <Button Name="MinBtn" Content="—" Style="{StaticResource ChromeBtn}" FontSize="16" Margin="5,0,0,0"/>
                        <Button Name="CloseBtn" Content="✕" Style="{StaticResource ChromeBtn}" FontSize="12" Margin="5,0,0,0"/>
                    </StackPanel>
                </Grid>
            </Border>

            <!-- Body -->
            <Grid Grid.Row="1" Margin="0">
                <Grid.ColumnDefinitions>
                    <ColumnDefinition Width="220"/>
                    <ColumnDefinition Width="1"/> <!-- Separator -->
                    <ColumnDefinition Width="*"/>
                </Grid.ColumnDefinitions>

                <!-- Separator Line -->
                <Rectangle Grid.Column="1" Fill="#333" Width="1"/>

                <!-- Sidebar -->
                <Border Grid.Column="0" Background="{StaticResource SidebarBg}">
                    <DockPanel Margin="10,15,10,10">

                        <!-- Header -->
                        <TextBlock DockPanel.Dock="Top" Text="TOOLS" FontSize="10" FontWeight="Bold" Foreground="#555" Margin="0,0,0,10"/>

                        <!-- Scrollable List -->
                        <ScrollViewer VerticalScrollBarVisibility="Auto">
                            <StackPanel>
                                <TextBlock Text="SCRIPTS" FontSize="10" FontWeight="Bold" Foreground="#444" Margin="5,5,0,8"/>
                                <StackPanel Name="SidebarList"/>
                                <TextBlock Text="APPS" FontSize="10" FontWeight="Bold" Foreground="#444" Margin="5,20,0,8"/>
                                <StackPanel Name="ExeList"/>
                            </StackPanel>
                        </ScrollViewer>

                        <!-- Extras Button -->
                        <Button DockPanel.Dock="Bottom" Name="ExtrasBtn" Content="⚙ System Apps" 
                                Style="{StaticResource SidebarBtn}" Height="35" Foreground="#666" Margin="0,10,0,0"/>
                    </DockPanel>
                </Border>

                <!-- Main Content -->
                <Grid Grid.Column="2" Margin="20,25,20,20">
                    <Grid.RowDefinitions>
                        <RowDefinition Height="Auto"/>
                        <RowDefinition Height="20"/>
                        <RowDefinition Height="*"/>
                        <RowDefinition Height="20"/>
                        <RowDefinition Height="Auto"/>
                    </Grid.RowDefinitions>

                    <!-- Top Info Card -->
                    <Border Grid.Row="0" Background="{StaticResource CardBg}" BorderBrush="{StaticResource BorderBrush}" BorderThickness="1" Padding="25,20" CornerRadius="4">
                        <Grid>
                            <StackPanel>
                                <TextBlock Name="DisplayTitle" Text="Select a Tool" FontSize="24" FontWeight="Bold" Foreground="White"/>
                                <TextBlock Name="DisplayDesc" Text="Choose a script or app from the sidebar to get started." FontSize="13" Foreground="#777" Margin="0,8,0,0"/>
                            </StackPanel>
                            
                            <!-- Status Badge -->
                            <Border HorizontalAlignment="Right" VerticalAlignment="Top" Background="#1A1A1A" BorderBrush="#333" BorderThickness="1" CornerRadius="4" Padding="10,6">
                                <TextBlock Name="StateChip" Text="IDLE" Foreground="#D92525" FontSize="10" FontWeight="Bold" LetterSpacing="2"/>
                            </Border>
                        </Grid>
                    </Border>

                    <!-- Log Console -->
                    <Border Grid.Row="2" Background="#0F0F0F" BorderBrush="{StaticResource BorderBrush}" BorderThickness="1" Padding="15" CornerRadius="4">
                        <DockPanel>
                            <TextBlock DockPanel.Dock="Top" Text="CONSOLE OUTPUT" FontSize="10" Foreground="#555" Margin="0,0,0,8"/>
                            <ScrollViewer VerticalScrollBarVisibility="Auto">
                                <TextBlock Name="LogPreview" Text="Waiting for command..." Foreground="#555" FontSize="11" FontFamily="Consolas" TextWrapping="Wrap"/>
                            </ScrollViewer>
                        </DockPanel>
                    </Border>

                    <!-- Launch Action -->
                    <Grid Grid.Row="4">
                        <Button Name="MainLaunchBtn" Content="LAUNCH TOOL" Style="{StaticResource LaunchBtn}" IsEnabled="False" Width="150" HorizontalAlignment="Right"/>
                        <TextBlock Name="ReadyLabel" Text="No tool selected" Foreground="#555" FontSize="12" VerticalAlignment="Center" Margin="0,0,170,0"/>
                    </Grid>
                </Grid>
            </Grid>
        </Grid>
    </Border>
</Window>
"@

[xml]$extrasXaml = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="System Apps" Width="260" Height="380"
        WindowStartupLocation="CenterScreen"
        WindowStyle="None" ResizeMode="NoResize"
        AllowsTransparency="True" Background="Transparent">
    <Border CornerRadius="6" BorderBrush="#333" BorderThickness="1" Margin="8">
        <Border.Background>
            <SolidColorBrush Color="#141414"/>
        </Border.Background>
        <Border.Effect>
            <DropShadowEffect BlurRadius="15" ShadowDepth="0" Opacity="0.5" Color="Black"/>
        </Border.Effect>
        <Grid Margin="15">
            <Grid.RowDefinitions>
                <RowDefinition Height="Auto"/>
                <RowDefinition Height="*"/>
                <RowDefinition Height="Auto"/>
            </Grid.RowDefinitions>
            <TextBlock Text="SYSTEM SHORTCUTS" FontSize="10" FontWeight="Bold" Foreground="#D92525" Margin="0,0,0,15"/>
            <ScrollViewer Grid.Row="1" VerticalScrollBarVisibility="Auto">
                <StackPanel Name="ExtrasList"/>
            </ScrollViewer>
            <Button Grid.Row="2" Name="CloseExtrasBtn" Content="CLOSE" Height="32" Margin="0,15,0,0" Cursor="Hand"
                    FontSize="11" FontWeight="Bold" BorderThickness="0" Foreground="White" Background="#252526">
                 <Button.Template>
                    <ControlTemplate TargetType="Button">
                        <Border Background="{TemplateBinding Background}" CornerRadius="4">
                            <ContentPresenter HorizontalAlignment="Center" VerticalAlignment="Center"/>
                        </Border>
                        <ControlTemplate.Triggers>
                            <Trigger Property="IsMouseOver" Value="True">
                                <Setter Property="Background" Value="#37373D"/>
                            </Trigger>
                        </ControlTemplate.Triggers>
                    </ControlTemplate>
                </Button.Template>
            </Button>
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
    $ReadyLabel    = $window.FindName("ReadyLabel")
    $StateChip     = $window.FindName("StateChip")
    $CloseBtn      = $window.FindName("CloseBtn")
    $MinBtn        = $window.FindName("MinBtn")
    $ExtrasBtn     = $window.FindName("ExtrasBtn")

    $global:CurrentCmd = $null

    # --- Tool Definitions ---
    $tools = @(
        @{Name="DPS - Analyzer";    Desc="Analyzes DPS memory (Red Lotus).";       Cmd="powershell -ExecutionPolicy Bypass -Command `"Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/PureIntent/ScreenShare/main/RedLotusBam.ps1')`""},
        @{Name="Meow Mod Analyzer"; Desc="Advanced Minecraft mod analysis utility."; Cmd="powershell -ExecutionPolicy Bypass -Command `"Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/MeowTonynoh/MeowModAnalyzer/main/MeowModAnalyzer.ps1')`""},
        @{Name="Macro Detector";    Desc="Detects mouse macros and autoclickers.";  Cmd="powershell -ExecutionPolicy Bypass -Command `"Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/Nickk196/MacroDetector/refs/heads/main/MacroDetector.ps1')`""},
        @{Name="Service Checker";   Desc="Analyzes running system services.";       Cmd="powershell -ExecutionPolicy Bypass -Command `"Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/praiselily/lilith-ps/refs/heads/main/Services.ps1')`""},
        @{Name="Schedule Tasks";    Desc="Lists signed scheduled tasks.";           Cmd="powershell -ExecutionPolicy Bypass -Command `"Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/praiselily/lilith-ps/refs/heads/main/Signed-Scheduled-Tasks')`""},
        @{Name="Faker Detection";   Desc="Identifies VPN and hotspot usage.";       Cmd="powershell -ExecutionPolicy Bypass -Command `"Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/praiselily/WeHateFakers/refs/heads/main/HotspotLogs.ps1')`""},
        @{Name="Directory Scanner"; Desc="Scans directories for specific files.";   Cmd="powershell -ExecutionPolicy Bypass -Command `"Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/praiselily/lilith-ps/refs/heads/main/CommonDirectories.ps1')`""},
        @{Name="NicTool Downloader";Desc="Downloads SSTool, System Informer.";      Cmd="CUSTOM_NIC_DOWNLOADER"},
        @{Name="JAR Scanner";       Desc="Scans JAR files for malicious content.";  Cmd="powershell -ExecutionPolicy Bypass -Command `"Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/NoDiff-del/JARParser/refs/heads/main/JARParser.ps1')`""},
        @{Name="Alt Detector";      Desc="Identifies alternative accounts.";       Cmd="powershell -ExecutionPolicy Bypass -Command `"Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/Enr1c0o/Powershell-Scripts/refs/heads/main/Alt-Detector.ps1')`""},
        @{Name="Dqrkis Finder";     Desc="Locates Dqrkis in active sessions.";      Cmd="powershell -ExecutionPolicy Bypass -Command `"Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/cheesecatlol/DQRKIS-FUCKER/refs/heads/main/DqrkisFucker.ps1')`""},
        @{Name="Signature";         Desc="Signature checker for verification.";     Cmd="powershell -ExecutionPolicy Bypass -Command `"Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/bacanoicua/Screenshare/main/RedLotusSignatures.ps1')`""}
    )

    $exeApps = @(
        @{Name="SSTool";             Url="https://github.com/Orbdiff/SSTool/releases/download/yay/SSTool.exe";                                            Desc="Screenshot tool utility."},
        @{Name="MeowDoomsdayFucker"; Url="https://github.com/MeowTonynoh/MeowDoomsdayFucker/releases/download/V.1.2/MeowDoomsdayFucker.exe";             Desc="Meow Doomsday analysis tool."},
        @{Name="MeowImportsChecker"; Url="https://github.com/MeowTonynoh/MeowImportsChecker/releases/download/MeowImportsChecker/MeowImportsChecker.exe"; Desc="Checks imports in executables."},
        @{Name="MeowResolver";       Url="https://github.com/MeowTonynoh/MeowResolver/releases/download/MeowResolver/MeowResolver.exe";                   Desc="Meow DNS/address resolver."}
    )

    function Set-SelectionState {
        param($title, $desc, $cmd)
        $DisplayTitle.Text       = $title
        $DisplayDesc.Text        = $desc
        $global:CurrentCmd       = $cmd
        $MainLaunchBtn.IsEnabled = $true
        $ReadyLabel.Text         = "Ready to launch: $title"
        $StateChip.Text          = "READY"
        $StateChip.Foreground    = "#D92525"
    }

    function Clear-AllSelections {
        foreach ($c in $SidebarList.Children) {
            if ($c -is [System.Windows.Controls.Button]) { $c.Style = $window.FindResource("SidebarBtn") }
        }
        foreach ($c in $ExeList.Children) {
            if ($c -is [System.Windows.Controls.Button]) { $c.Style = $window.FindResource("SidebarBtn") }
        }
    }

    # --- Script buttons ---
    function Create-SidebarButton {
        param($Name, $Cmd, $Desc)
        $btn = New-Object System.Windows.Controls.Button
        $btn.Content = $Name
        $btn.Style   = $window.FindResource("SidebarBtn")
        $btn | Add-Member -NotePropertyName CmdData  -NotePropertyValue $Cmd
        $btn | Add-Member -NotePropertyName DescData -NotePropertyValue $Desc

        $btn.Add_Click({
            param($sender, $e)
            Clear-AllSelections
            $sender.Style = $window.FindResource("ActiveSidebarBtn")
            Set-SelectionState -title $sender.Content -desc $sender.DescData -cmd $sender.CmdData
        }.GetNewClosure())

        $SidebarList.Children.Add($btn) | Out-Null
    }

    # --- Exe buttons ---
    function Create-ExeButton {
        param($Name, $Url, $Desc)
        $btn = New-Object System.Windows.Controls.Button
        $btn.Content = $Name
        $btn.Style   = $window.FindResource("SidebarBtn")
        $btn | Add-Member -NotePropertyName ExeUrl  -NotePropertyValue $Url
        $btn | Add-Member -NotePropertyName DescData -NotePropertyValue $Desc

        $btn.Add_Click({
            param($sender, $e)
            Clear-AllSelections
            $sender.Style = $window.FindResource("ActiveSidebarBtn")
            Set-SelectionState -title $sender.Content -desc $sender.DescData -cmd ("EXE:" + $sender.ExeUrl)
        }.GetNewClosure())

        $ExeList.Children.Add($btn) | Out-Null
    }

    foreach ($tool in $tools) { Create-SidebarButton -Name $tool.Name -Cmd $tool.Cmd -Desc $tool.Desc }
    foreach ($app  in $exeApps) { Create-ExeButton  -Name $app.Name  -Url $app.Url  -Desc $app.Desc }

    # --- System Apps popup ---
    $ExtrasBtn.Add_Click({
        $r2        = New-Object System.Xml.XmlNodeReader $extrasXaml
        $winExtras = [Windows.Markup.XamlReader]::Load($r2)
        $listE     = $winExtras.FindName("ExtrasList")
        $closeE    = $winExtras.FindName("CloseExtrasBtn")

        $myExes = @(
            @{Name="Notepad";      Path="notepad.exe";  Args=$null},
            @{Name="Calculator";   Path="calc.exe";     Args=$null},
            @{Name="Paint";        Path="mspaint.exe";  Args=$null},
            @{Name="Task Manager"; Path="taskmgr.exe";  Args=$null},
            @{Name="Recycle Bin";  Path="explorer.exe"; Args="::{645FF040-5081-101B-9F08-00AA002F954E}"},
            @{Name="Recent Files"; Path="explorer.exe"; Args="shell:Recent"},
            @{Name="Temp Folder";  Path="explorer.exe"; Args=$env:TEMP},
            @{Name="Prefetch";     Path="explorer.exe"; Args="C:\Windows\Prefetch"}
        )

        foreach ($exe in $myExes) {
            $btn = New-Object System.Windows.Controls.Button
            $btn.Content                    = $exe.Name
            $btn.Background                 = [System.Windows.Media.Brushes]::Transparent
            $btn.Foreground                 = [System.Windows.Media.SolidColorBrush][System.Windows.Media.Color]::FromRgb(0xCC,0xCC,0xCC)
            $btn.Margin                     = "0,2"
            $btn.Height                     = "32"
            $btn.FontFamily                 = "Segoe UI"
            $btn.FontSize                   = 12
            $btn.Cursor                     = [System.Windows.Input.Cursors]::Hand
            $btn.HorizontalContentAlignment = [System.Windows.HorizontalAlignment]::Left
            $btn.Padding                    = "10,0"
            $btn.BorderThickness            = 0
            $lPath = $exe.Path
            $lArgs = $exe.Args
            $btn.Add_Click({
                try {
                    if ([string]::IsNullOrWhiteSpace($lArgs)) { Start-Process $lPath }
                    else { Start-Process $lPath -ArgumentList $lArgs }
                } catch { [System.Windows.MessageBox]::Show("Could not launch: $lPath") }
            }.GetNewClosure())
            $btn.Add_MouseEnter({ $this.Foreground = [System.Windows.Media.Brushes]::White })
            $btn.Add_MouseLeave({ $this.Foreground = [System.Windows.Media.SolidColorBrush][System.Windows.Media.Color]::FromRgb(0xCC,0xCC,0xCC) })
            $listE.Children.Add($btn) | Out-Null
        }

        $closeE.Add_Click({ $winExtras.Close() })
        $winExtras.Add_MouseLeftButtonDown({
            if ($_.OriginalSource -isnot [System.Windows.Controls.Button]) { $winExtras.DragMove() }
        })
        $winExtras.ShowDialog() | Out-Null
    })

    # --- Launch ---
    $MainLaunchBtn.Add_Click({
        if (-not $global:CurrentCmd) { return }
        try {
            $StateChip.Text  = "RUNNING"
            $LogPreview.Text = "Initializing..."
            $tempFile        = Join-Path $env:TEMP ([Guid]::NewGuid().ToString() + ".ps1")

            if ($global:CurrentCmd -like "EXE:*") {
                $exeUrl  = $global:CurrentCmd.Substring(4)
                $exeName = Split-Path $exeUrl -Leaf
                $exeTmp  = Join-Path $env:TEMP $exeName
                $LogPreview.Text = "Downloading $exeName..."
                try {
                    Invoke-WebRequest -Uri $exeUrl -OutFile $exeTmp -UseBasicParsing
                    $LogPreview.Text = "Launched: $exeName"
                    $StateChip.Text  = "DONE"
                    Start-Process $exeTmp
                } catch {
                    [System.Windows.MessageBox]::Show("Failed to download:`n$exeUrl`n`n$_")
                    $StateChip.Text  = "ERROR"
                    $LogPreview.Text = "Download failed."
                }
                return
            }

            if ($global:CurrentCmd -eq "CUSTOM_NIC_DOWNLOADER") {
                $script = @'
Write-Host "NicToolDownloader" -ForegroundColor Cyan
Write-Host "==================" -ForegroundColor Cyan
$dir = "C:\SS"
if (!(Test-Path $dir)) { New-Item -ItemType Directory -Path $dir -Force | Out-Null; Write-Host "[INFO] Created $dir" -ForegroundColor Green }
else { Write-Host "[INFO] $dir exists" -ForegroundColor Gray }
Write-Host "[AUTO] Fetching latest System Informer..." -ForegroundColor Cyan
$siUrl = $null
try {
    $rel   = Invoke-RestMethod "https://api.github.com/repos/winsiderss/systeminformer/releases" -Headers @{Accept="application/vnd.github.v3+json"}
    $asset = $rel[0].assets | Where-Object { $_.name -match "systeminformer-.*-setup\.exe" } | Select-Object -First 1
    if ($asset) { $siUrl = $asset.browser_download_url; Write-Host "[AUTO] $($asset.name)" -ForegroundColor Green }
} catch { Write-Host "[WARN] GitHub API failed." -ForegroundColor Yellow }
if (!$siUrl) { $siUrl = "https://github.com/winsiderss/systeminformer/releases/download/v4.0.26144/systeminformer-4.0.26144-setup.exe" }
$urls = @(
    "https://github.com/Orbdiff/SSTool/releases/download/yay/SSTool.exe",
    "https://github.com/MeowTonynoh/MeowDoomsdayFucker/releases/download/V.1.2/MeowDoomsdayFucker.exe",
    "https://github.com/MeowTonynoh/MeowImportsChecker/releases/download/MeowImportsChecker/MeowImportsChecker.exe",
    "https://github.com/MeowTonynoh/MeowResolver/releases/download/MeowResolver/MeowResolver.exe",
    $siUrl,
    "https://www.nirsoft.net/utils/winprefetchview.zip"
)
foreach ($u in $urls) {
    $f = Split-Path $u -Leaf; Write-Host "  $f..." -NoNewline
    try { Invoke-WebRequest $u -OutFile (Join-Path $dir $f) -UseBasicParsing; Write-Host " OK" -ForegroundColor Green }
    catch { Write-Host " FAILED" -ForegroundColor Red }
}
Write-Host "[DONE] Created by cheese cat & nic" -ForegroundColor Yellow
Read-Host "Press Enter to exit"
'@
                $script | Out-File $tempFile -Encoding UTF8
                $LogPreview.Text = "Running NicTool Downloader..."
            } else {
                $c = $global:CurrentCmd
                "Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass -Force`r`n$c" | Out-File $tempFile -Encoding UTF8
                $LogPreview.Text = "Process started."
            }

            Start-Process "cmd.exe" -ArgumentList "/k", "powershell -NoExit -ExecutionPolicy Bypass -File `"$tempFile`""
            $StateChip.Text = "DONE"

        } catch {
            [System.Windows.MessageBox]::Show("Error: $_")
            $StateChip.Text  = "ERROR"
            $LogPreview.Text = "Error occurred."
        }
    })

    $MinBtn.Add_Click({   $window.WindowState = [Windows.WindowState]::Minimized })
    $CloseBtn.Add_Click({ $window.Close() })

    $window.Add_MouseLeftButtonDown({
        if ($_.OriginalSource -isnot [System.Windows.Controls.Button] -and
            $_.OriginalSource -isnot [System.Windows.Controls.TextBox]) { $window.DragMove() }
    })

    $window.ShowDialog() | Out-Null

} catch {
    Write-Error $_.Exception.Message
}
```
