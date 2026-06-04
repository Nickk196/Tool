# ==============================================================================
# MECZ LAUNCHER
# Clean, Traced-Free, Customized for mecz.exe
# ==============================================================================

Add-Type -AssemblyName PresentationFramework
Add-Type -AssemblyName PresentationCore
Add-Type -AssemblyName WindowsBase
Add-Type -AssemblyName System.Xaml
Add-Type -AssemblyName System.IO.Compression.FileSystem

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

# User32 Import
Add-Type -Name User32 -Namespace Win32 -MemberDefinition @"
[DllImport("user32.dll")] public static extern bool ReleaseCapture();
[DllImport("user32.dll")] public static extern int SendMessage(IntPtr hWnd, int Msg, int wParam, int lParam);
"@

# --- CONFIGURATION ---
 $userDir    = [Environment]::GetFolderPath("UserProfile")
 $downloads  = Join-Path $userDir "Downloads"
 $installDir = Join-Path $downloads "Mecz-Tools"
 $version    = "2.0"

 $announcementTitle = "Welcome to Mecz Launcher"
 $announcementMessage = @"
Welcome to the Mecz Launcher.

Developed by mecz.exe (GitHub: Nickk196).

A clean, streamlined interface for forensic tools.
"@

# --- TOOL DATA ---
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

    # --- TONYNOH (MEOW) ---
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

# ==============================================================================
# XAML UI (CLEANER DESIGN - MECZ BRANDING)
# ==============================================================================

[xml]$xaml = @"
<Window
    xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
    xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
    Title="Mecz Launcher"
    Width="1250"
    Height="780"
    MinWidth="1250"
    MinHeight="780"
    WindowStartupLocation="CenterScreen"
    ResizeMode="NoResize"
    WindowStyle="None"
    AllowsTransparency="True"
    Background="Transparent"
    FontFamily="Segoe UI">

    <Window.Resources>
        <!-- Mecz Theme (Clean Purple) -->
        <SolidColorBrush x:Key="WindowBackground" Color="#12091F"/>
        <SolidColorBrush x:Key="SidebarBackground" Color="#1A0E2E"/>
        <SolidColorBrush x:Key="PrimaryButton" Color="#7B2CBF"/>
        <SolidColorBrush x:Key="PrimaryButtonHover" Color="#9D4EDD"/>
        <SolidColorBrush x:Key="CardBackground" Color="#240046"/>
        <SolidColorBrush x:Key="BorderBrush" Color="#5A189A"/>
        <SolidColorBrush x:Key="TextMain" Color="#FFFFFF"/>
        <SolidColorBrush x:Key="TextSub" Color="#E0AAFF"/>

        <Style x:Key="CleanButtonStyle" TargetType="Button">
            <Setter Property="Background" Value="{StaticResource CardBackground}"/>
            <Setter Property="Foreground" Value="{StaticResource TextMain}"/>
            <Setter Property="FontSize" Value="14"/>
            <Setter Property="FontWeight" Value="Medium"/>
            <Setter Property="Height" Value="50"/>
            <Setter Property="Margin" Value="0,0,0,10"/>
            <Setter Property="Cursor" Value="Hand"/>
            <Setter Property="BorderThickness" Value="0"/>
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="Button">
                        <Border Background="{TemplateBinding Background}" CornerRadius="8" Padding="15,0">
                            <ContentPresenter HorizontalAlignment="Left" VerticalAlignment="Center"/>
                        </Border>
                        <ControlTemplate.Triggers>
                            <Trigger Property="IsMouseOver" Value="True">
                                <Setter Property="Background" Value="{StaticResource PrimaryButton}"/>
                            </Trigger>
                        </ControlTemplate.Triggers>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
        </Style>

        <Style x:Key="WindowBtnStyle" TargetType="Button">
            <Setter Property="Background" Value="Transparent"/>
            <Setter Property="Foreground" Value="White"/>
            <Setter Property="FontWeight" Value="Bold"/>
            <Setter Property="Cursor" Value="Hand"/>
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="Button">
                        <Border Background="{TemplateBinding Background}" CornerRadius="5" Padding="8">
                            <ContentPresenter HorizontalAlignment="Center" VerticalAlignment="Center"/>
                        </Border>
                        <ControlTemplate.Triggers>
                            <Trigger Property="IsMouseOver" Value="True">
                                <Setter Property="Background" Value="#33FFFFFF"/>
                            </Trigger>
                        </ControlTemplate.Triggers>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
        </Style>
    </Window.Resources>

    <Grid>
        <Border CornerRadius="16" Background="{StaticResource WindowBackground}" BorderBrush="{StaticResource BorderBrush}" BorderThickness="1">
            <Grid>
                <Grid.RowDefinitions>
                    <RowDefinition Height="50"/>
                    <RowDefinition Height="*"/>
                </Grid.RowDefinitions>

                <!-- Header -->
                <Border Grid.Row="0" Background="{StaticResource SidebarBackground}" CornerRadius="16,16,0,0">
                    <Grid Margin="20,0">
                        <Grid.ColumnDefinitions>
                            <ColumnDefinition Width="*"/>
                            <ColumnDefinition Width="Auto"/>
                        </Grid.ColumnDefinitions>

                        <StackPanel Orientation="Horizontal" VerticalAlignment="Center">
                            <TextBlock Text="Mecz" FontSize="20" FontWeight="Bold" Foreground="{StaticResource PrimaryButtonHover}"/>
                            <TextBlock Text=" Launcher" FontSize="20" FontWeight="SemiBold" Foreground="{StaticResource TextMain}" Margin="5,0,0,0"/>
                            <TextBlock Text=" | by mecz.exe" FontSize="12" Foreground="{StaticResource TextSub}" Margin="15,0,0,0" VerticalAlignment="Center"/>
                        </StackPanel>

                        <StackPanel Grid.Column="1" Orientation="Horizontal" VerticalAlignment="Center">
                            <Button x:Name="InfoBtn" Content="?" Style="{StaticResource WindowBtnStyle}" Margin="0,0,5,0" Width="30"/>
                            <Button x:Name="MinBtn" Content="—" Style="{StaticResource WindowBtnStyle}" Width="30"/>
                            <Button x:Name="CloseBtn" Content="✕" Style="{StaticResource WindowBtnStyle}" Width="30"/>
                        </StackPanel>
                    </Grid>
                </Border>

                <!-- Main Body -->
                <Grid Grid.Row="1" Margin="20">
                    <Grid.ColumnDefinitions>
                        <ColumnDefinition Width="220"/>
                        <ColumnDefinition Width="15"/>
                        <ColumnDefinition Width="*"/>
                    </Grid.ColumnDefinitions>

                    <!-- Sidebar -->
                    <Border Grid.Column="0" Background="{StaticResource SidebarBackground}" CornerRadius="12" Padding="15">
                        <StackPanel>
                            <TextBlock Text="Menu" FontSize="12" Foreground="{StaticResource TextSub}" Margin="0,0,0,10"/>
                            
                            <Button x:Name="OpenFolderBtn" Content="Open Folder" Style="{StaticResource CleanButtonStyle}"/>
                            <Button x:Name="ClearCacheBtn" Content="Clear Cache" Style="{StaticResource CleanButtonStyle}"/>
                            
                            <Border Height="1" Background="{StaticResource BorderBrush}" Margin="0,10"/>
                            
                            <TextBlock Text="About" FontSize="12" Foreground="{StaticResource TextSub}" Margin="0,0,0,10" TextWrapping="Wrap"/>
                            <TextBlock Text="GitHub: Nickk196" FontSize="11" Foreground="Gray" TextWrapping="Wrap" Margin="0,0,0,5"/>
                            <TextBlock Text="Discord: mecz.exe" FontSize="11" Foreground="Gray" TextWrapping="Wrap"/>
                        </StackPanel>
                    </Border>

                    <!-- Content -->
                    <Grid Grid.Column="2">
                        <Grid.RowDefinitions>
                            <RowDefinition Height="Auto"/>
                            <RowDefinition Height="15"/>
                            <RowDefinition Height="*"/>
                            <RowDefinition Height="15"/>
                            <RowDefinition Height="180"/>
                        </Grid.RowDefinitions>

                        <!-- Top Status -->
                        <Border Grid.Row="0" Background="{StaticResource CardBackground}" CornerRadius="10" Padding="20">
                            <Grid>
                                <Grid.ColumnDefinitions>
                                    <ColumnDefinition Width="*"/>
                                    <ColumnDefinition Width="Auto"/>
                                </Grid.ColumnDefinitions>
                                <StackPanel>
                                    <TextBlock x:Name="StatusTitle" Text="Ready" FontSize="24" FontWeight="SemiBold" Foreground="White"/>
                                    <TextBlock x:Name="StatusSub" Text="Select a tool to launch." FontSize="13" Foreground="{StaticResource TextSub}" Margin="0,5,0,0"/>
                                </StackPanel>
                                <Border Grid.Column="1" Background="{StaticResource PrimaryButton}" Width="10" Height="40" CornerRadius="5"/>
                            </Grid>
                        </Border>

                        <!-- Tools Area -->
                        <Border Grid.Row="2" Background="#0F001A" CornerRadius="10" BorderBrush="{StaticResource BorderBrush}" BorderThickness="1" Padding="5">
                            <TabControl x:Name="ToolsTab" Background="Transparent" BorderThickness="0">
                                <TabControl.Resources>
                                    <Style TargetType="TabItem">
                                        <Setter Property="Template">
                                            <Setter.Value>
                                                <ControlTemplate TargetType="TabItem">
                                                    <Border Name="Border" Background="Transparent" Margin="5,5,5,0" Padding="10,5" CornerRadius="5,5,0,0">
                                                        <ContentPresenter x:Name="ContentSite" ContentSource="Header" VerticalAlignment="Center"/>
                                                    </Border>
                                                    <ControlTemplate.Triggers>
                                                        <Trigger Property="IsSelected" Value="True">
                                                            <Setter TargetName="Border" Property="Background" Value="{StaticResource PrimaryButton}"/>
                                                            <Setter Property="Foreground" Value="White"/>
                                                        </Trigger>
                                                        <Trigger Property="IsSelected" Value="False">
                                                            <Setter Property="Foreground" Value="{StaticResource TextSub}"/>
                                                        </Trigger>
                                                    </ControlTemplate.Triggers>
                                                </ControlTemplate>
                                            </Setter.Value>
                                        </Setter>
                                    </Style>
                                </TabControl.Resources>
                            </TabControl>
                        </Border>

                        <!-- Log -->
                        <Border Grid.Row="4" Background="#050208" CornerRadius="10" BorderBrush="{StaticResource BorderBrush}" BorderThickness="1" Padding="15">
                            <Grid>
                                <TextBlock Text="CONSOLE" FontSize="10" Foreground="Gray" Margin="0,0,0,5"/>
                                <TextBox x:Name="LogBox" 
                                         Background="Transparent" 
                                         Foreground="#00FF00" 
                                         BorderThickness="0" 
                                         FontFamily="Consolas" 
                                         FontSize="12" 
                                         IsReadOnly="True" 
                                         VerticalScrollBarVisibility="Auto"
                                         TextWrapping="Wrap"
                                         Padding="0,0,0,5"/>
                            </Grid>
                        </Border>

                    </Grid>
                </Grid>
            </Grid>
        </Border>

        <!-- Info Overlay -->
        <Grid x:Name="InfoPanel" Visibility="Collapsed" Background="#AA000000">
            <Border Width="400" Background="{StaticResource WindowBackground}" CornerRadius="10" BorderBrush="{StaticResource BorderBrush}" BorderThickness="1" Padding="20" HorizontalAlignment="Center" VerticalAlignment="Center">
                <StackPanel>
                    <TextBlock Text="About Mecz Launcher" FontSize="18" FontWeight="Bold" Foreground="White" HorizontalAlignment="Center"/>
                    <TextBlock Text="v2.0" FontSize="12" Foreground="Gray" HorizontalAlignment="Center" Margin="0,5,0,20"/>
                    
                    <TextBlock Text="Developer: mecz.exe" Foreground="White" Margin="0,5"/>
                    <TextBlock Text="GitHub: Nickk196" Foreground="White" Margin="0,5"/>
                    <TextBlock Text="Discord: mecz.exe" Foreground="White" Margin="0,5,20,0"/>
                    
                    <Button Content="Close" Style="{StaticResource CleanButtonStyle}" HorizontalAlignment="Center" Margin="0,10,0,0" x:Name="CloseInfoBtn"/>
                </StackPanel>
            </Border>
        </Grid>
    </Grid>
</Window>
"@

# ==============================================================================
# LOGIC
# ==============================================================================

 $reader = New-Object System.Xml.XmlNodeReader $xaml
 $window = [Windows.Markup.XamlReader]::Load($reader)

# Find Elements
 $OpenFolderBtn = $window.FindName("OpenFolderBtn")
 $ClearCacheBtn = $window.FindName("ClearCacheBtn")
 $InfoBtn = $window.FindName("InfoBtn")
 $MinBtn = $window.FindName("MinBtn")
 $CloseBtn = $window.FindName("CloseBtn")
 $CloseInfoBtn = $window.FindName("CloseInfoBtn")

 $StatusTitle = $window.FindName("StatusTitle")
 $StatusSub = $window.FindName("StatusSub")
 $LogBox = $window.FindName("LogBox")
 $InfoPanel = $window.FindName("InfoPanel")
 $ToolsTab = $window.FindName("ToolsTab")

function Write-Log {
    param([string]$msg)
    $time = Get-Date -Format "HH:mm:ss"
    $LogBox.AppendText("[$time] $msg`r`n")
    $LogBox.ScrollToEnd()
}

function Set-Status {
    param($t, $s)
    $StatusTitle.Text = $t
    $StatusSub.Text = $s
}

function Get-GitHubExeUrl {
    param([string]$ReleaseUrl)
    if ($ReleaseUrl -match "github\.com/([^/]+)/([^/]+)/releases/tag/([^/]+)") {
        $User = $matches[1]; $Repo = $matches[2]; $Tag = $matches[3]
        $ApiUrl = "https://api.github.com/repos/$User/$Repo/releases/tags/$Tag"
        try {
            $Response = Invoke-RestMethod -Uri $ApiUrl -ErrorAction Stop
            $Asset = $Response.assets | Where-Object { $_.name -like "*.exe" } | Select-Object -First 1
            if ($Asset) { return $Asset.browser_download_url }
        } catch { }
    }
    return $null
}

# --- POPULATE TABS ---
 $Categories = @("Orbdiff", "Spokwn", "RedLotus", "Tonynoh", "Praiselily", "Others")

foreach ($Cat in $Categories) {
    $Tab = New-Object System.Windows.Controls.TabItem
    $Tab.Header = $Cat
    
    $Scroll = New-Object System.Windows.Controls.ScrollViewer
    $Scroll.VerticalScrollBarVisibility = "Auto"
    
    $Panel = New-Object System.Windows.Controls.WrapPanel
    $Panel.Margin = "10"
    
    $Tools = $ToolData | Where-Object { $_.Category -eq $Cat }
    
    foreach ($Tool in $Tools) {
        $Btn = New-Object System.Windows.Controls.Button
        $Btn.Content = $Tool.Name
        $Btn.Width = 150
        $Btn.Height = 60
        $Btn.Margin = "8"
        $Btn.FontSize = "13"
        $Btn.Cursor = "Hand"
        
        # Clean Button Template
        $Btn.Background = "#240046"
        $Btn.Foreground = "White"
        
        $Style = New-Object System.Windows.Style
        $Style.TargetType = [System.Windows.Controls.Button]
        $Setter = New-Object System.Windows.Setter
        $Setter.Property = [System.Windows.Controls.Control]::TemplateProperty
        $Setter.Value = [Windows.Markup.XamlReader]::Parse("
            <ControlTemplate xmlns='http://schemas.microsoft.com/winfx/2006/xaml/presentation' TargetType='Button'>
                <Border Background='{TemplateBinding Background}' CornerRadius='6'>
                    <ContentPresenter HorizontalAlignment='Center' VerticalAlignment='Center'/>
                </Border>
                <ControlTemplate.Triggers>
                    <Trigger Property='IsMouseOver' Value='True'>
                        <Setter Property='Background' Value='#7B2CBF'/>
                    </Trigger>
                </ControlTemplate.Triggers>
            </ControlTemplate>
        ")
        $Btn.Style = $Style
        
        $Btn.Add_Click({
            $TName = $_.Source.Content
            $TData = $ToolData | Where-Object { $_.Name -eq $TName }
            
            Set-Status "Processing" "Launching $TName..."
            
            # MECZ FEATURE: Meow
            if ($TName -match "Meow") {
                Write-Log "Meow! 🐱"
            }

            Write-Log "Starting: $TName"
            
            if ($TData.Type -eq "Cmd") {
                try {
                    Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -Command `"$($TData.Command)`"" -WindowStyle Normal
                    Set-Status "Running" "Command executed."
                    Write-Log "Success: $TName launched."
                } catch {
                    Set-Status "Error" "Failed to launch."
                }
            }
            elseif ($TData.Type -eq "Web") {
                Start-Process $TData.URL
                Set-Status "Browser" "Opening link."
                Write-Log "Opened browser for $TName"
            }
            elseif ($TData.Type -eq "GitHub") {
                $TempPath = "$env:TEMP\$($TName).exe"
                if (Test-Path $TempPath) {
                    Start-Process $TempPath
                    Set-Status "Launched" "Using cached file."
                    Write-Log "Launched $TName (Cached)"
                } else {
                    Set-Status "Downloading" "Fetching from GitHub..."
                    $Link = Get-GitHubExeUrl -ReleaseUrl $TData.URL
                    if ($Link) {
                        try {
                            $ProgressPreference = 'SilentlyContinue'
                            Invoke-WebRequest -Uri $Link -OutFile $TempPath -UseBasicParsing
                            $ProgressPreference = 'Continue'
                            Start-Process $TempPath
                            Set-Status "Success" "Downloaded and ran."
                            Write-Log "Downloaded $TName successfully."
                        } catch {
                            Set-Status "Error" "Download failed."
                            Start-Process $TData.URL
                        }
                    } else {
                        Set-Status "Error" "Asset not found."
                        Start-Process $TData.URL
                    }
                }
            }
        })
        
        $Panel.Children.Add($Btn) | Out-Null
    }
    
    $Scroll.Content = $Panel
    $Tab.Content = $Scroll
    $ToolsTab.Items.Add($Tab) | Out-Null
}

# --- EVENTS ---
 $window.Add_MouseLeftButtonDown({ try { $window.DragMove() } catch {} })
 $CloseBtn.Add_Click({ $window.Close() })
 $MinBtn.Add_Click({ $window.WindowState = "Minimized" })

 $InfoBtn.Add_Click({ 
    $InfoPanel.Visibility = "Visible" 
    $InfoPanel.Opacity = 0
    $anim = New-Object System.Windows.Media.Animation.DoubleAnimation(0, 1, [TimeSpan]::FromMilliseconds(150))
    $InfoPanel.BeginAnimation([System.Windows.UIElement]::OpacityProperty, $anim)
})

 $CloseInfoBtn.Add_Click({ $InfoPanel.Visibility = "Collapsed" })

 $OpenFolderBtn.Add_Click({
    if (!(Test-Path $installDir)) { New-Item -ItemType Directory -Path $installDir | Out-Null }
    Start-Process $installDir
    Set-Status "Folder" "Opened Mecz Tools directory."
})

 $ClearCacheBtn.Add_Click({
    $files = Get-ChildItem -Path $env:TEMP -Filter "*.exe" -ErrorAction SilentlyContinue | Where-Object { $_.Name -match "Prefetch|BAM|Meow|PSHunter" }
    if ($files) {
        $files | Remove-Item -Force -ErrorAction SilentlyContinue
        Write-Log "Cleared temporary files."
        Set-Status "Clean" "Cache cleared."
    } else {
        Write-Log "No files to clear."
    }
})

Write-Log "Mecz Launcher initialized."
Write-Log "Welcome, mecz.exe."

 $window.ShowDialog() | Out-Null
