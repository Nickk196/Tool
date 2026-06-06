# ==============================================================================
# MECZ LAUNCHER v2.9 (NIRSOFT FIX - USER AGENT SPOOF)
# Features: All Tools Enlarged, Flat Cat Mascot, Fixed NirSoft Downloads
# Author: mecz.exe
# ==============================================================================

Add-Type -AssemblyName PresentationFramework
Add-Type -AssemblyName PresentationCore
Add-Type -AssemblyName WindowsBase
Add-Type -AssemblyName System.Xaml

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

# User32 Import
Add-Type -Name User32 -Namespace Win32 -MemberDefinition @"
[DllImport("user32.dll")] public static extern bool ReleaseCapture();
[DllImport("user32.dll")] public static extern int SendMessage(IntPtr hWnd, int Msg, int wParam, int lParam);
"@

 $userDir    = [Environment]::GetFolderPath("UserProfile")
 $downloads  = Join-Path $userDir "Downloads"
 $installDir = Join-Path $downloads "Mecz-Tools"

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

    # --- NIRSOFT (Direct Download) ---
    @{ Name="ExecutedProgramsList"; Category="NirSoft"; Type="DirectDownload"; URL="https://www.nirsoft.net/utils/executed_programs_list.zip" },
    @{ Name="WinPrefetchView"; Category="NirSoft"; Type="DirectDownload"; URL="https://www.nirsoft.net/utils/win_prefetch_view.zip" },
    @{ Name="UserAssistView"; Category="NirSoft"; Type="DirectDownload"; URL="https://www.nirsoft.net/utils/userassist_view.zip" },
    @{ Name="RegScanner"; Category="NirSoft"; Type="DirectDownload"; URL="https://www.nirsoft.net/utils/regscanner.zip" },
    @{ Name="LoadedDllView"; Category="NirSoft"; Type="DirectDownload"; URL="https://www.nirsoft.net/utils/loaded_dll_view.zip" },
    @{ Name="CompActivityView"; Category="NirSoft"; Type="DirectDownload"; URL="https://www.nirsoft.net/utils/computer_activity_view.zip" },
    @{ Name="UninstallView"; Category="NirSoft"; Type="DirectDownload"; URL="https://www.nirsoft.net/utils/uninstall_view.zip" },
    @{ Name="USBDevicesView"; Category="NirSoft"; Type="DirectDownload"; URL="https://www.nirsoft.net/utils/usb_devices_view.zip" },
    @{ Name="FileActivityWatch"; Category="NirSoft"; Type="DirectDownload"; URL="https://www.nirsoft.net/utils/file_activity_watch.zip" },
    @{ Name="BrowsingHistoryView"; Category="NirSoft"; Type="DirectDownload"; URL="https://www.nirsoft.net/utils/browsing_history_view.zip" },
    @{ Name="NetworkUsageView"; Category="NirSoft"; Type="DirectDownload"; URL="https://www.nirsoft.net/utils/network_usage_view.zip" },

    # --- ZIMMERMAN (Direct Download) ---
    @{ Name="JumpListExplorer"; Category="Zimmerman"; Type="DirectDownload"; URL="https://download.ericzimmermanstools.com/net9/JumpListExplorer.zip" },
    @{ Name="BStrings"; Category="Zimmerman"; Type="DirectDownload"; URL="https://download.ericzimmermanstools.com/net9/bstrings.zip" },
    @{ Name="PECmd"; Category="Zimmerman"; Type="DirectDownload"; URL="https://download.ericzimmermanstools.com/net9/PECmd.zip" },
    @{ Name="RECmd"; Category="Zimmerman"; Type="DirectDownload"; URL="https://download.ericzimmermanstools.com/net9/RECmd.zip" },
    @{ Name="LECmd"; Category="Zimmerman"; Type="DirectDownload"; URL="https://download.ericzimmermanstools.com/net9/LECmd.zip" },
    @{ Name="AmcacheParser"; Category="Zimmerman"; Type="DirectDownload"; URL="https://download.ericzimmermanstools.com/net9/AmcacheParser.zip" },
    @{ Name="AppCompatCacheParser"; Category="Zimmerman"; Type="DirectDownload"; URL="https://download.ericzimmermanstools.com/net9/AppCompatCacheParser.zip" },

    # --- OTHERS ---
    @{ Name="SystemInformer"; Category="Others"; Type="Web"; URL="https://www.systeminformer.com/canary" },
    @{ Name="DIE-engine"; Category="Others"; Type="Web"; URL="https://github.com/horsicq/DIE-engine/releases" },
    @{ Name="DQRKIS-FUCKER"; Category="Others"; Type="Cmd"; Command="Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/cheesecatlol/DQRKIS-FUCKER/refs/heads/main/DqrkisFucker.ps1')" },
    @{ Name="MacroDetector"; Category="Others"; Type="Cmd"; Command="Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/Nickk196/MacroDetector/refs/heads/main/MacroDetector.ps1')" }
)

# ==============================================================================
# XAML UI
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
    Focusable="True"
    FontFamily="Segoe UI">

    <Window.Resources>
        <!-- Midnight Theme -->
        <SolidColorBrush x:Key="MainBg" Color="#0D0613"/>
        <SolidColorBrush x:Key="SidebarBg" Color="#160B24"/>
        <SolidColorBrush x:Key="CardBg" Color="#1F0F30"/>
        <SolidColorBrush x:Key="Accent" Color="#9D4EDD"/>
        <SolidColorBrush x:Key="TextMain" Color="#F3E5F5"/>
        <SolidColorBrush x:Key="TextMuted" Color="#B39DDB"/>
        <SolidColorBrush x:Key="ConsoleBg" Color="#050309"/>

        <!-- Discord Blurple -->
        <SolidColorBrush x:Key="DiscordColor" Color="#5865F2"/>
        <!-- GitHub Dark -->
        <SolidColorBrush x:Key="GithubColor" Color="#24292F"/>

        <Style x:Key="BaseButton" TargetType="Button">
            <Setter Property="Background" Value="Transparent"/>
            <Setter Property="Foreground" Value="{StaticResource TextMain}"/>
            <Setter Property="FontSize" Value="13"/>
            <Setter Property="FontWeight" Value="Medium"/>
            <Setter Property="Height" Value="42"/>
            <Setter Property="Margin" Value="0,0,0,8"/>
            <Setter Property="Cursor" Value="Hand"/>
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="Button">
                        <Border Background="{TemplateBinding Background}">
                            <ContentPresenter HorizontalAlignment="Left" VerticalAlignment="Center" Margin="15,0"/>
                        </Border>
                        <ControlTemplate.Triggers>
                            <Trigger Property="IsMouseOver" Value="True">
                                <Setter Property="Background" Value="#1F0F30"/>
                            </Trigger>
                        </ControlTemplate.Triggers>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
        </Style>

        <Style x:Key="SocialBtn" TargetType="Button" BasedOn="{StaticResource BaseButton}">
            <Setter Property="Height" Value="36"/>
            <Setter Property="FontSize" Value="12"/>
            <Setter Property="FontWeight" Value="SemiBold"/>
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="Button">
                        <Border Background="{TemplateBinding Background}" CornerRadius="4">
                            <ContentPresenter HorizontalAlignment="Center" VerticalAlignment="Center" Margin="10,0"/>
                        </Border>
                        <ControlTemplate.Triggers>
                            <Trigger Property="IsMouseOver" Value="True">
                                <Setter Property="Opacity" Value="0.8"/>
                            </Trigger>
                        </ControlTemplate.Triggers>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
        </Style>

        <Style x:Key="TitleBarButton" TargetType="Button">
            <Setter Property="Background" Value="Transparent"/>
            <Setter Property="Foreground" Value="{StaticResource TextMuted}"/>
            <Setter Property="Width" Value="40"/>
            <Setter Property="Height" Value="30"/>
            <Setter Property="Cursor" Value="Hand"/>
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="Button">
                        <Border Background="{TemplateBinding Background}">
                            <ContentPresenter HorizontalAlignment="Center" VerticalAlignment="Center"/>
                        </Border>
                        <ControlTemplate.Triggers>
                            <Trigger Property="IsMouseOver" Value="True">
                                <Setter Property="Background" Value="#33FFFFFF"/>
                                <Setter Property="Foreground" Value="White"/>
                            </Trigger>
                        </ControlTemplate.Triggers>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
        </Style>
    </Window.Resources>

    <Grid>
        <!-- Main Window Background (No Border) -->
        <Border Background="{StaticResource MainBg}">
            <Grid>
                <Grid.RowDefinitions>
                    <RowDefinition Height="45"/>
                    <RowDefinition Height="*"/>
                </Grid.RowDefinitions>

                <!-- Header -->
                <Border Grid.Row="0" Background="{StaticResource SidebarBg}">
                    <Grid Margin="20,0">
                        <Grid.ColumnDefinitions>
                            <ColumnDefinition Width="*"/>
                            <ColumnDefinition Width="Auto"/>
                        </Grid.ColumnDefinitions>

                        <StackPanel Orientation="Horizontal" VerticalAlignment="Center">
                            <TextBlock Text="MECZ" FontSize="16" FontWeight="Bold" Foreground="{StaticResource Accent}"/>
                            <TextBlock Text="LAUNCHER" FontSize="16" FontWeight="SemiBold" Foreground="{StaticResource TextMain}" Margin="8,0,0,0"/>
                        </StackPanel>

                        <StackPanel Grid.Column="1" Orientation="Horizontal">
                            <Button x:Name="DiscordHeaderBtn" Style="{StaticResource TitleBarButton}" Content="D" Foreground="{StaticResource DiscordColor}"/>
                            <Button x:Name="GithubHeaderBtn" Style="{StaticResource TitleBarButton}" Content="G" Foreground="White"/>
                            <Button x:Name="MinBtn" Style="{StaticResource TitleBarButton}" Content="—"/>
                            <Button x:Name="CloseBtn" Style="{StaticResource TitleBarButton}" Content="✕"/>
                        </StackPanel>
                    </Grid>
                </Border>

                <!-- Content -->
                <Grid Grid.Row="1" Margin="20,20,20,20">
                    <Grid.ColumnDefinitions>
                        <ColumnDefinition Width="200"/>
                        <ColumnDefinition Width="20"/>
                        <ColumnDefinition Width="*"/>
                    </Grid.ColumnDefinitions>

                    <!-- Sidebar -->
                    <StackPanel Grid.Column="0" Background="{StaticResource SidebarBg}">
                        
                        <!-- THE CAT -->
                        <TextBlock Text="🐈" FontSize="80" HorizontalAlignment="Center" Foreground="{StaticResource Accent}" Margin="0,10,0,10"/>

                        <!-- Section: Main -->
                        <TextBlock Text="SYSTEM" FontSize="10" Foreground="{StaticResource TextMuted}" FontWeight="Bold" Margin="12,15,12,8"/>
                        <Button x:Name="OpenFolderBtn" Content="Open Folder" Style="{StaticResource BaseButton}"/>
                        <Button x:Name="ClearCacheBtn" Content="Clear Cache" Style="{StaticResource BaseButton}"/>
                        
                        <!-- Section: Social -->
                        <TextBlock Text="CONNECT" FontSize="10" Foreground="{StaticResource TextMuted}" FontWeight="Bold" Margin="12,20,12,8"/>
                        <Button x:Name="DiscordBtn" Content="Discord: mecz.exe" Style="{StaticResource SocialBtn}" Background="{StaticResource DiscordColor}" Foreground="White"/>
                        <Button x:Name="GithubBtn" Content="GitHub: Nickk196" Style="{StaticResource SocialBtn}" Background="{StaticResource GithubColor}" Foreground="White"/>
                        
                        <TextBlock Text="v2.9 | NirSoft Fixed" FontSize="10" Foreground="#555" Margin="12,40,12,15" HorizontalAlignment="Center"/>
                    </StackPanel>

                    <!-- Main Panel -->
                    <Grid Grid.Column="2">
                        <Grid.RowDefinitions>
                            <RowDefinition Height="Auto"/>
                            <RowDefinition Height="12"/>
                            <RowDefinition Height="*"/>
                            <RowDefinition Height="12"/>
                            <RowDefinition Height="150"/>
                        </Grid.RowDefinitions>

                        <!-- Status -->
                        <Border Grid.Row="0" Background="{StaticResource CardBg}">
                            <Grid Margin="15,10">
                                <Grid.ColumnDefinitions>
                                    <ColumnDefinition Width="*"/>
                                    <ColumnDefinition Width="Auto"/>
                                </Grid.ColumnDefinitions>
                                <StackPanel VerticalAlignment="Center">
                                    <TextBlock x:Name="StatusTitle" Text="Ready" FontSize="18" FontWeight="Medium" Foreground="{StaticResource TextMain}"/>
                                    <TextBlock x:Name="StatusSub" Text="Select a tool to begin" FontSize="11" Foreground="{StaticResource TextMuted}"/>
                                </StackPanel>
                                <Ellipse Grid.Column="1" Width="8" Height="8" Fill="{StaticResource Accent}"/>
                            </Grid>
                        </Border>

                        <!-- Tools -->
                        <Border Grid.Row="2" Background="#0D0613">
                            <TabControl x:Name="ToolsTab" Background="Transparent" BorderThickness="0">
                                <TabControl.Resources>
                                    <Style TargetType="TabItem">
                                        <Setter Property="Template">
                                            <Setter.Value>
                                                <ControlTemplate TargetType="TabItem">
                                                    <Border Name="Border" Background="Transparent" Margin="4,4,4,0">
                                                        <ContentPresenter ContentSource="Header" VerticalAlignment="Center" Margin="12,6"/>
                                                    </Border>
                                                    <ControlTemplate.Triggers>
                                                        <Trigger Property="IsSelected" Value="True">
                                                            <Setter TargetName="Border" Property="Background" Value="{StaticResource Accent}"/>
                                                            <Setter Property="Foreground" Value="White"/>
                                                        </Trigger>
                                                        <Trigger Property="IsSelected" Value="False">
                                                            <Setter Property="Foreground" Value="{StaticResource TextMuted}"/>
                                                        </Trigger>
                                                    </ControlTemplate.Triggers>
                                                </ControlTemplate>
                                            </Setter.Value>
                                        </Setter>
                                    </Style>
                                </TabControl.Resources>
                            </TabControl>
                        </Border>

                        <!-- Console -->
                        <Border Grid.Row="4" Background="{StaticResource ConsoleBg}">
                            <Grid Margin="10">
                                <TextBlock Text="TERMINAL" FontSize="9" Foreground="#555" Margin="0,0,0,5"/>
                                <TextBox x:Name="LogBox" 
                                         Background="Transparent" 
                                         Foreground="#9D4EDD" 
                                         BorderThickness="0" 
                                         FontFamily="Consolas" 
                                         FontSize="11" 
                                         IsReadOnly="True" 
                                         VerticalScrollBarVisibility="Auto"
                                         TextWrapping="Wrap"/>
                            </Grid>
                        </Border>
                    </Grid>
                </Grid>
            </Grid>
        </Border>
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
 $DiscordBtn = $window.FindName("DiscordBtn")
 $GithubBtn = $window.FindName("GithubBtn")
 $DiscordHeaderBtn = $window.FindName("DiscordHeaderBtn")
 $GithubHeaderBtn = $window.FindName("GithubHeaderBtn")

 $MinBtn = $window.FindName("MinBtn")
 $CloseBtn = $window.FindName("CloseBtn")

 $StatusTitle = $window.FindName("StatusTitle")
 $StatusSub = $window.FindName("StatusSub")
 $LogBox = $window.FindName("LogBox")
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
 $Categories = @("Orbdiff", "Spokwn", "RedLotus", "Tonynoh", "Praiselily", "NirSoft", "Zimmerman", "Others")

foreach ($Cat in $Categories) {
    $Tab = New-Object System.Windows.Controls.TabItem
    $Tab.Header = $Cat
    
    $Scroll = New-Object System.Windows.Controls.ScrollViewer
    $Scroll.VerticalScrollBarVisibility = "Auto"
    
    $Panel = New-Object System.Windows.Controls.WrapPanel
    $Panel.Margin = "8"
    
    $Tools = $ToolData | Where-Object { $_.Category -eq $Cat }
    
    foreach ($Tool in $Tools) {
        $Btn = New-Object System.Windows.Controls.Button
        $Btn.Content = $Tool.Name
        $Btn.Cursor = "Hand"
        $Btn.Background = "#1F0F30"
        $Btn.Foreground = "#F3E5F5"
        
        # --- UNIVERSAL BIG SIZE ---
        $Btn.Width = 260
        $Btn.Height = 80
        $Btn.FontSize = 14
        $Btn.Margin = "12"
        
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
                        <Setter Property='Background' Value='#9D4EDD'/>
                        <Setter Property='Foreground' Value='White'/>
                    </Trigger>
                </ControlTemplate.Triggers>
            </ControlTemplate>
        ")
        $Btn.Style = $Style
        
        $Btn.Add_Click({
            $TName = $_.Source.Content
            $TData = $ToolData | Where-Object { $_.Name -eq $TName }
            
            Set-Status "Processing" "Launching $TName..."
            
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
            elseif ($TData.Type -eq "DirectDownload") {
                # Logic for NirSoft/Zimmerman direct downloads
                if (!(Test-Path $installDir)) { New-Item -ItemType Directory -Path $installDir | Out-Null }
                
                $FileName = $TData.URL.Substring($TData.URL.LastIndexOf("/") + 1)
                $LocalPath = Join-Path $installDir $FileName
                
                if (Test-Path $LocalPath) {
                    Start-Process $LocalPath
                    Set-Status "Launched" "Using local file."
                    Write-Log "Launched $TName (Local)"
                } else {
                    Set-Status "Downloading" "Downloading $FileName..."
                    Write-Log "Downloading from: $($TData.URL)"
                    try {
                        $ProgressPreference = 'SilentlyContinue'
                        # --- FIX: SPOOF USER AGENT TO BYPASS NIRSOFT BLOCK ---
                        $UserAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
                        Invoke-WebRequest -Uri $TData.URL -OutFile $LocalPath -UserAgent $UserAgent -UseBasicParsing
                        $ProgressPreference = 'Continue'
                        
                        Start-Process $LocalPath
                        Set-Status "Success" "Download complete."
                        Write-Log "Downloaded $TName successfully."
                    } catch {
                        Set-Status "Error" "Download failed."
                        Write-Log "Error downloading $TName"
                    }
                }
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

 $DiscordBtn.Add_Click({ Start-Process "https://discord.com" })
 $GithubBtn.Add_Click({ Start-Process "https://github.com/Nickk196" })

 $DiscordHeaderBtn.Add_Click({ Start-Process "https://discord.com" })
 $GithubHeaderBtn.Add_Click({ Start-Process "https://github.com/Nickk196" })

 $OpenFolderBtn.Add_Click({
   if (!(Test-Path $installDir)) { New-Item -ItemType Directory -Path $installDir | Out-Null }
   Start-Process $installDir
   Set-Status "Folder" "Opened directory."
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

# --- MECZ FEATURE: GLOBAL ENTER KEY ---
 $window.Add_KeyDown({
   if ($_.Key -eq "Enter") {
       Write-Log "Meow! 🐱 (Pressed Enter)"
       Write-Host "Meow! 🐱"
   }
})

Write-Log "Mecz Launcher v2.9 initialized."
Write-Host "Mecz Launcher loaded. NirSoft download fixed!"

 $window.ShowDialog() | Out-Null
