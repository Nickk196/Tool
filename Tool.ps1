Add-Type -AssemblyName PresentationFramework
Add-Type -AssemblyName System.Windows.Forms

# --- XAML GUI Definition ---
[xml]$xaml = @"
<Window 
    xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
    xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
    Title="Tool Launcher"
    Width="1000"
    Height="700"
    WindowStartupLocation="CenterScreen"
    WindowStyle="None"
    AllowsTransparency="True"
    Background="Transparent"
    ResizeMode="NoResize"
    Topmost="False">

    <Window.Resources>
        <Style x:Key="SidebarButton" TargetType="Button">
            <Setter Property="Background" Value="Transparent"/>
            <Setter Property="Foreground" Value="#CCCCCC"/>
            <Setter Property="FontFamily" Value="Segoe UI"/>
            <Setter Property="FontSize" Value="14"/>
            <Setter Property="FontWeight" Value="Normal"/>
            <Setter Property="BorderThickness" Value="0"/>
            <Setter Property="HorizontalContentAlignment" Value="Left"/>
            <Setter Property="Padding" Value="20,12"/>
            <Setter Property="Cursor" Value="Hand"/>
            <Setter Property="RenderTransformOrigin" Value="0.5,0.5"/>
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="Button">
                        <Border Background="{TemplateBinding Background}" Padding="{TemplateBinding Padding}">
                            <TextBlock Text="{TemplateBinding Content}" TextWrapping="Wrap" TextAlignment="Left" VerticalAlignment="Center"/>
                        </Border>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
            <Style.Triggers>
                <Trigger Property="IsMouseOver" Value="True">
                    <Setter Property="Background" Value="#333333"/>
                    <Setter Property="Foreground" Value="White"/>
                    <Setter Property="RenderTransform">
                        <Setter.Value>
                            <ScaleTransform ScaleX="1.03" ScaleY="1.03"/>
                        </Setter.Value>
                    </Setter>
                </Trigger>
            </Style.Triggers>
        </Style>

        <Style x:Key="ActiveSidebarButton" TargetType="Button" BasedOn="{StaticResource SidebarButton}">
            <Setter Property="Background" Value="#007ACC"/>
            <Setter Property="Foreground" Value="White"/>
            <Setter Property="FontWeight" Value="SemiBold"/>
        </Style>
        
        <Style x:Key="LaunchButton" TargetType="Button">
            <Setter Property="Background" Value="#007ACC"/>
            <Setter Property="Foreground" Value="White"/>
            <Setter Property="FontFamily" Value="Segoe UI"/>
            <Setter Property="FontSize" Value="16"/>
            <Setter Property="FontWeight" Value="SemiBold"/>
            <Setter Property="BorderThickness" Value="0"/>
            <Setter Property="Cursor" Value="Hand"/>
            <Setter Property="Height" Value="50"/>
            <Setter Property="Width" Value="220"/>
            <Setter Property="RenderTransformOrigin" Value="0.5,0.5"/>
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="Button">
                        <Border Background="{TemplateBinding Background}" CornerRadius="4">
                            <ContentPresenter HorizontalAlignment="Center" VerticalAlignment="Center"/>
                        </Border>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
            <Style.Triggers>
                <Trigger Property="IsMouseOver" Value="True">
                    <Setter Property="Background" Value="#1E90FF"/>
                    <Setter Property="RenderTransform">
                        <Setter.Value>
                            <ScaleTransform ScaleX="1.05" ScaleY="1.05"/>
                        </Setter.Value>
                    </Setter>
                </Trigger>
            </Style.Triggers>
        </Style>
    </Window.Resources>

    <Grid Margin="5">
        <Border Background="#DD1E1E1E" CornerRadius="8" BorderBrush="#333333" BorderThickness="1">
            <Grid>
                <Grid.ColumnDefinitions>
                    <ColumnDefinition Width="220"/>
                    <ColumnDefinition Width="*"/>
                </Grid.ColumnDefinitions>
                <Border Grid.Column="0" Background="#252526" CornerRadius="8,0,0,8">
                    <StackPanel>
                        <TextBlock Text="TOOLS" Foreground="#888" FontSize="12" FontWeight="Bold" Margin="20,25,0,10" FontFamily="Segoe UI"/>
                        <ScrollViewer VerticalScrollBarVisibility="Auto">
                            <StackPanel Name="SidebarList"/>
                        </ScrollViewer>
                        <Button Name="ExtrasBtn" Content="System Apps" Foreground="#007ACC" Background="Transparent" BorderThickness="0" HorizontalAlignment="Left" Margin="20,10,0,20" Cursor="Hand" FontSize="12" FontWeight="SemiBold" Padding="20,10"/>
                    </StackPanel>
                </Border>
                <Grid Grid.Column="1" Margin="30">
                    <Grid.RowDefinitions>
                        <RowDefinition Height="Auto"/>
                        <RowDefinition Height="*"/>
                        <RowDefinition Height="Auto"/>
                    </Grid.RowDefinitions>
                    <StackPanel Orientation="Horizontal" HorizontalAlignment="Right" VerticalAlignment="Top" Margin="0,-10,0,0" ZIndex="10">
                        <Button Content="─" Width="30" Height="30" Background="Transparent" Foreground="#888" FontSize="16" BorderThickness="0" Cursor="Hand" Name="MinBtn" Margin="0,0,5,0"/>
                        <Button Content="✕" Width="30" Height="30" Background="Transparent" Foreground="#888" FontSize="12" BorderThickness="0" Cursor="Hand" Name="CloseBtn"/>
                    </StackPanel>
                    <StackPanel Grid.Row="1" VerticalAlignment="Center">
                        <TextBlock Name="DisplayTitle" Text="SELECT TOOL" FontSize="36" FontWeight="Light" Foreground="White" Margin="0,0,0,5" FontFamily="Segoe UI"/>
                        <TextBlock Name="DisplayDesc" Text="Choose a tool from the sidebar to begin." FontSize="14" Foreground="#888" Width="600" TextWrapping="Wrap" Margin="0,0,0,40"/>
                    </StackPanel>
                    <StackPanel Grid.Row="2" HorizontalAlignment="Left" Margin="0,0,0,40">
                        <Button Name="MainLaunchBtn" Content="LAUNCH" Style="{StaticResource LaunchButton}" IsEnabled="False" Opacity="0.5"/>
                        <TextBlock Name="LogPreview" Text="Ready" Foreground="#444" FontSize="11" Margin="10,10,0,0" FontFamily="Consolas"/>
                    </StackPanel>
                </Grid>
            </Grid>
        </Border>
    </Grid>
</Window>
"@

[xml]$extrasXaml = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="System Apps"
        Width="300"
        Height="400"
        WindowStartupLocation="CenterScreen"
        WindowStyle="None"
        ResizeMode="NoResize"
        Background="#1E1E1E"
        Topmost="False">
    <Border Background="#DD1E1E1E" CornerRadius="8" BorderBrush="#333" BorderThickness="1" Margin="10">
        <Grid Margin="20">
            <Grid.RowDefinitions>
                <RowDefinition Height="Auto"/>
                <RowDefinition Height="*"/>
                <RowDefinition Height="Auto"/>
            </Grid.RowDefinitions>
            <TextBlock Text="APPLICATIONS" FontSize="14" Foreground="White" FontWeight="SemiBold" Margin="0,0,0,20"/>
            <ScrollViewer Grid.Row="1" VerticalScrollBarVisibility="Auto">
                <StackPanel Name="ExtrasList"/>
            </ScrollViewer>
            <Button Grid.Row="2" Content="CLOSE" Background="#333" Foreground="White" BorderThickness="0" Height="30" Cursor="Hand" Name="CloseExtrasBtn" Margin="0,20,0,0"/>
        </Grid>
    </Border>
</Window>
"#

try {
    $reader = (New-Object System.Xml.XmlNodeReader $xaml) 
    $window = [Windows.Markup.XamlReader]::Load($reader)

    $SidebarList = $window.FindName("SidebarList")
    $DisplayTitle = $window.FindName("DisplayTitle")
    $DisplayDesc = $window.FindName("DisplayDesc")
    $MainLaunchBtn = $window.FindName("MainLaunchBtn")
    $LogPreview = $window.FindName("LogPreview")
    $CloseBtn = $window.FindName("CloseBtn")
    $MinBtn   = $window.FindName("MinBtn")
    $ExtrasBtn = $window.FindName("ExtrasBtn")

    $global:CurrentCmd = ""

    # --- Tool Data (Fixed Quotes using Single Quotes for outer strings) ---
    $tools = @(
        @{Name="Meow Mod Analyzer"; Desc="Advanced Minecraft mod analysis utility."; Cmd='powershell -ExecutionPolicy Bypass -Command "Invoke-Expression (Invoke-RestMethod ''https://raw.githubusercontent.com/MeowTonynoh/MeowModAnalyzer/main/MeowModAnalyzer.ps1'')"'},
        @{Name="Macro Detector"; Desc="Detects mouse macros and autoclickers."; Cmd='powershell -ExecutionPolicy Bypass -Command "Invoke-Expression (Invoke-RestMethod ''https://raw.githubusercontent.com/Nickk196/MacroDetector/refs/heads/main/MacroDetector.ps1'')"'},
        @{Name="Service Checker"; Desc="Analyzes running system services for anomalies."; Cmd='powershell Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass ; powershell Invoke-Expression (Invoke-RestMethod https://raw.githubusercontent.com/praiselily/lilith-ps/refs/heads/main/Services.ps1)'},
        @{Name="Schedule Tasks"; Desc="Lists and checks signed scheduled tasks."; Cmd='powershell -Command "Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass; Invoke-Expression (Invoke-RestMethod ''https://raw.githubusercontent.com/praiselily/lilith-ps/refs/heads/main/Signed-Scheduled-Tasks'')"'},
        @{Name="Faker Detection"; Desc="Identifies VPN and hotspot usage."; Cmd='powershell -ExecutionPolicy Bypass -Command "iwr https://raw.githubusercontent.com/praiselily/WeHateFakers/refs/heads/main/HotspotLogs.ps1 | iex"'},
        @{Name="Directory Scanner"; Desc="Scans common directories for specific files."; Cmd='powershell -Command "Set-ExecutionPolicy Bypass -Scope Process; Invoke-Expression (Invoke-RestMethod ''https://raw.githubusercontent.com/praiselily/lilith-ps/refs/heads/main/CommonDirectories.ps1'')"'},
        @{Name="NicTool Downloader"; Desc="Downloads SSTool, System Informer, and other utilities to C:\SS."; Cmd='CUSTOM_NIC_DOWNLOADER'},
        @{Name="JAR Scanner"; Desc="Scans JAR files for malicious content."; Cmd='powershell -ExecutionPolicy Bypass -Command "iwr https://raw.githubusercontent.com/praiselily/JARScanner/refs/heads/main/JARScanner.ps1 | iex"'},
        @{Name="Alt Detector"; Desc="Identifies alternative accounts and identifiers."; Cmd='powershell -ExecutionPolicy Bypass -Command "Invoke-Expression (Invoke-RestMethod ''https://raw.githubusercontent.com/Enr1c0o/Powershell-Scripts/refs/heads/main/Alt-Detector.ps1'')"'},
        @{Name="Dqrkis Finder"; Desc="Locates Dqrkis in active sessions."; Cmd='powershell -ExecutionPolicy Bypass -Command "Invoke-Expression (Invoke-RestMethod ''https://raw.githubusercontent.com/cheesecatlol/DQRKIS-FUCKER/refs/heads/main/DqrkisFucker.ps1'')"'},
        @{Name="Signature"; Desc="Signature Checker."; Cmd='powershell -ExecutionPolicy Bypass -Command "Invoke-Expression (Invoke-RestMethod ''https://raw.githubusercontent.com/bacanoicua/Screenshare/main/RedLotusSignatures.ps1'')"'},
        @{Name="BAM"; Desc="Backround Activity Monitoring."; Cmd='powershell -ExecutionPolicy Bypass -Command "Invoke-Expression (Invoke-RestMethod ''https://raw.githubusercontent.com/PureIntent/ScreenShare/main/RedLotusBam.ps1'')"'}
    )

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
             $DisplayTitle.Text = $sender.Content.ToString()
             $DisplayDesc.Text = $sender.DescData
             $global:CurrentCmd = $sender.CmdData
             $MainLaunchBtn.IsEnabled = $true
             $MainLaunchBtn.Opacity = 1
             $LogPreview.Text = "Ready to launch: " + $sender.Content
        }.GetNewClosure())
        $SidebarList.Children.Add($btn)
    }

    foreach ($tool in $tools) {
        Create-SidebarButton -Name $tool.Name -Cmd $tool.Cmd -Desc $tool.Desc
    }

    $ExtrasBtn.Add_Click({
        $reader2 = (New-Object System.Xml.XmlNodeReader $extrasXaml)
        $winExtras = [Windows.Markup.XamlReader]::Load($reader2)
        $listExtras = $winExtras.FindName("ExtrasList")
        $closeExtras = $winExtras.FindName("CloseExtrasBtn")

        $myExes = @(
            @{Name="Notepad"; Path="notepad.exe"; Args=""},
            @{Name="Calculator"; Path="calc.exe"; Args=""},
            @{Name="Paint"; Path="mspaint.exe"; Args=""},
            @{Name="Task Manager"; Path="taskmgr.exe"; Args=""},
            @{Name="Recycle Bin"; Path="explorer.exe"; Args="::{645FF040-5081-101B-9F08-00AA002F954E}::"},
            @{Name="Recent Files"; Path="explorer.exe"; Args="shell:Recent"},
            @{Name="Temp Folder"; Path="explorer.exe"; Args="`"$env:TEMP`""},
            @{Name="Prefetch"; Path="explorer.exe"; Args="`"C:\Windows\Prefetch`""}
        )

        foreach ($exe in $myExes) {
            $btn = New-Object System.Windows.Controls.Button
            $btn.Content = $exe.Name
            $btn.Background = "Transparent"
            $btn.Foreground = "#CCC"
            $btn.Margin = "0,5"
            $btn.Height = "35"
            $btn.FontFamily = "Segoe UI"
            $btn.Cursor = "Hand"
            $btn.HorizontalContentAlignment = "Left"
            $btn.Padding = "10,0"
            $btn.RenderTransformOrigin = "0.5,0.5"
            $btn.RenderTransform = [Windows.Media.ScaleTransform]::new(1,1)
            
            $btn.Add_Click({
                try { 
                    $procArgs = $this.Args
                    if ([string]::IsNullOrWhiteSpace($procArgs)) { Start-Process $this.Path } 
                    else { Start-Process $this.Path -ArgumentList $procArgs }
                } catch { [System.Windows.MessageBox]::Show("Could not launch: " + $this.Path) }
            }.GetNewClosure())
            
            $btn.Add_MouseEnter({
                $this.Foreground = "White"; $this.Background = "#333"
                $this.RenderTransform = [Windows.Media.ScaleTransform]::new(1.05, 1.05)
            })
            $btn.Add_MouseLeave({
                $this.Foreground = "#CCC"; $this.Background = "Transparent"
                $this.RenderTransform = [Windows.Media.ScaleTransform]::new(1,1)
            })
            
            $btn | Add-Member -MemberType NoteProperty -Name "Path" -Value $exe.Path
            $btn | Add-Member -MemberType NoteProperty -Name "Args" -Value $exe.Args
            $listExtras.Children.Add($btn)
        }
        $closeExtras.Add_Click({ $winExtras.Close() })
        $winExtras.ShowDialog() | Out-Null
    })

    $MainLaunchBtn.Add_Click({
        try {
            if($global:CurrentCmd) {
                $LogPreview.Text = "Initializing..."
                $tempFileName = [Guid]::NewGuid().ToString() + ".ps1"
                $tempFilePath = Join-Path $env:TEMP $tempFileName
                
                # NicTool Downloader Script (Embedded safely)
                if ($global:CurrentCmd -eq "CUSTOM_NIC_DOWNLOADER") {
                    $scriptContent = @'
Write-Host "NicToolDownloader" -ForegroundColor Cyan
 $downloadDir = "C:\SS"
if (!(Test-Path -Path $downloadDir)) {
    try { New-Item -ItemType Directory -Path $downloadDir -Force | Out-Null; Write-Host "[INFO] Created directory at $downloadDir" -ForegroundColor Green }
    catch { Write-Host "[ERROR] Failed to create directory." -ForegroundColor Red; Read-Host; exit }
} else { Write-Host "[INFO] Directory already exists at $downloadDir" -ForegroundColor Gray }
Write-Host "[AUTO] Searching for latest System Informer version..." -ForegroundColor Cyan
 $siUrl = $null
try {
    $apiUrl = "https://api.github.com/repos/winsiderss/systeminformer/releases"
    $response = Invoke-RestMethod -Uri $apiUrl -Headers @{"Accept"="application/vnd.github.v3+json"} -ErrorAction Stop
    $asset = $response[0].assets | Where-Object { $_.name -match "systeminformer-.*-setup\.exe" } | Select-Object -First 1
    if ($asset) { $siUrl = $asset.browser_download_url; Write-Host "[AUTO] Found Latest: $($asset.name)" -ForegroundColor Green }
    else { Write-Host "[WARN] Could not find setup file." -ForegroundColor Yellow }
} catch { Write-Host "[WARN] Failed to fetch from GitHub." -ForegroundColor Yellow }
if (-not $siUrl) { Write-Host "[FALLBACK] Using specific version." -ForegroundColor DarkGray; $siUrl = "https://github.com/winsiderss/systeminformer/releases/download/v4.0.26144/systeminformer-4.0.26144-setup.exe" }
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
    $fileName = Split-Path $url -Leaf; $destination = Join-Path -Path $downloadDir -ChildPath $fileName
    Write-Host "Downloading $fileName..." -NoNewline
    try { Invoke-WebRequest -Uri $url -OutFile $destination -UseBasicParsing; Write-Host " [DONE]" -ForegroundColor Green }
    catch { Write-Host " [FAILED]" -ForegroundColor Red }
}
Write-Host "[FINISH] All tasks completed." -ForegroundColor Cyan
 $sumSep = "=" * 40
Write-Host "  Created by  : " -NoNewline -ForegroundColor DarkGray; Write-Host "cheese cat" -ForegroundColor Yellow
Write-Host "  Discord     : " -NoNewline -ForegroundColor DarkGray; Write-Host "cheese_cat0" -ForegroundColor Yellow
Write-Host "  GitHub      : " -NoNewline -ForegroundColor DarkGray; Write-Host "github.com/cheesecatlol" -ForegroundColor Yellow
Write-Host "  Created by  : " -NoNewline -ForegroundColor DarkGray; Write-Host "nic" -ForegroundColor Yellow
Write-Host "  Discord     : " -NoNewline -ForegroundColor DarkGray; Write-Host "mecz.exe" -ForegroundColor Yellow
Write-Host "  GitHub      : " -NoNewline -ForegroundColor DarkGray; Write-Host "github.com/Nickk196" -ForegroundColor Yellow
Write-Host $sumSep -ForegroundColor DarkYellow
Read-Host "  Press Enter to exit"
'@
                    $scriptContent | Out-File -FilePath $tempFilePath -Encoding UTF8
                    $LogPreview.Text = "Running NicTool Downloader..."
                }
                else {
                    $fileContent = @"
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
 $global:CurrentCmd
"@
                    $fileContent | Out-File -FilePath $tempFilePath -Encoding UTF8
                    $LogPreview.Text = "Process started."
                }
                
                $psiArgs = "/k", "powershell -NoExit -ExecutionPolicy Bypass -File `"$tempFilePath`""
                Start-Process "cmd.exe" -ArgumentList $psiArgs
            }
        }
        catch { [System.Windows.MessageBox]::Show("Launcher Error: $_"); $LogPreview.Text = "Error occurred." }
    })

    $MinBtn.Add_Click({ $window.WindowState = [Windows.WindowState]::Minimized })
    $CloseBtn.Add_Click({ $window.Close() })
    
    # Draggable Window Logic
    $window.Add_MouseLeftButtonDown({
        if ($_.OriginalSource -isnot [System.Windows.Controls.Button] -and $_.OriginalSource -isnot [System.Windows.Controls.TextBox]) { $window.DragMove() }
    })

    $window.ShowDialog() | Out-Null
}
catch { Write-Error $_.Exception.Message }
