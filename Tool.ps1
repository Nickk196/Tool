# ==============================================================================
# MECZ LAUNCHER v4.0 (CYBER HOLO DESIGN)
# Features: Neon Glow, HUD Interface, Enter Key = Meow
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
    @{ Name="MeowDoomsdayFucker"; Category="Tonynoh"; Type="GitHub"; URL="https://github.com/MeowTonynoh/MeowDoomsdayFucker/releases/tag/V.1.2" },
    @{ Name="MeowModAnalyzer"; Category="Tonynoh"; Type="Cmd"; Command="Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/MeowTonynoh/MeowModAnalyzer/main/MeowModAnalyzer.ps1')" },
    @{ Name="MeowResolver"; Category="Tonynoh"; Type="GitHub"; URL="https://github.com/MeowTonynoh/MeowResolver/releases/tag/MeowResolver" },
    @{ Name="MeowNovowareFucker"; Category="Tonynoh"; Type="GitHub"; URL="https://github.com/MeowTonynoh/MeowNovowareFucker/releases/tag/V1" },
    @{ Name="MeowImportsChecker"; Category="Tonynoh"; Type="GitHub"; URL="https://github.com/MeowTonynoh/MeowImportsChecker/releases/tag/MeowImportsChecker" },
    @{ Name="PSHunter"; Category="Praiselily"; Type="GitHub"; URL="https://github.com/praiselily/PSHunter/releases/tag/Built" },
    @{ Name="AltDetector"; Category="Praiselily"; Type="GitHub"; URL="https://github.com/praiselily/AltDetector/releases/tag/Detector" },
    @{ Name="HotspotLogs"; Category="Praiselily"; Type="Cmd"; Command="iwr https://raw.githubusercontent.com/praiselily/WeHateFakers/refs/heads/main/HotspotLogs.ps1 | iex" },
    @{ Name="CommonDirectories"; Category="Praiselily"; Type="Cmd"; Command="Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/praiselily/lilith-ps/refs/heads/main/CommonDirectories.ps1')" },
    @{ Name="HarddiskConverter"; Category="Praiselily"; Type="Cmd"; Command="Invoke-Expression (Invoke-RestMethod https://raw.githubusercontent.com/praiselily/lilith-ps/refs/heads/main/HarddiskConverter.ps1)" },
    @{ Name="Services"; Category="Praiselily"; Type="Cmd"; Command="Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/praiselily/lilith-ps/refs/heads/main/Services.ps1')" },
    @{ Name="Signed-Scheduled-Tasks"; Category="Praiselily"; Type="Cmd"; Command="Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/praiselily/lilith-ps/refs/heads/main/Signed-Scheduled-Tasks.ps1')" },
    @{ Name="RedLotus-Mod-Analyzer"; Category="RedLotus"; Type="GitHub"; URL="https://github.com/ItzIceHere/RedLotus-Mod-Analyzer/releases/tag/RL" },
    @{ Name="RedLotus-Task-Sentinel"; Category="RedLotus"; Type="GitHub"; URL="https://github.com/ItzIceHere/RedLotus-Task-Sentinel/releases/tag/RL" },
    @{ Name="RedLotusAltChecker"; Category="RedLotus"; Type="GitHub"; URL="https://github.com/ItzIceHere/RedLotusAltChecker/releases/tag/RL" },
    @{ Name="WinPrefetchView (NirSoft)"; Category="Others"; Type="Web"; URL="https://www.nirsoft.net/utils/win_prefetch_view.html" },
    @{ Name="CompActivityView (NirSoft)"; Category="Others"; Type="Web"; URL="https://www.nirsoft.net/utils/computer_activity_view.html" },
    @{ Name="AmcacheParser (EZ Tools)"; Category="Others"; Type="Web"; URL="https://download.ericzimmermanstools.com/net9/AmcacheParser.zip" },
    @{ Name="SystemInformer"; Category="Others"; Type="Web"; URL="https://www.systeminformer.com/canary" },
    @{ Name="DIE-engine"; Category="Others"; Type="Web"; URL="https://github.com/horsicq/DIE-engine/releases" },
    @{ Name="DQRKIS-FUCKER"; Category="Others"; Type="Cmd"; Command="Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/cheesecatlol/DQRKIS-FUCKER/refs/heads/main/DqrkisFucker.ps1')" },
    @{ Name="MacroDetector"; Category="Others"; Type="Cmd"; Command="Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/Nickk196/MacroDetector/refs/heads/main/MacroDetector.ps1')" }
)

# ==============================================================================
# XAML UI (CYBER HOLO DESIGN)
# ==============================================================================

[xml]$xaml = @"
<Window
    xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
    xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
    Title="Mecz Launcher"
    Width="1300"
    Height="800"
    WindowStartupLocation="CenterScreen"
    ResizeMode="NoResize"
    WindowStyle="None"
    AllowsTransparency="True"
    Background="Transparent"
    FontFamily="Consolas"
    Focusable="True">

    <Window.Resources>
        <!-- Cyber Theme -->
        <SolidColorBrush x:Key="MainBg" Color="#000000"/>
        <SolidColorBrush x:Key="PanelBg" Color="#0A0A0A"/>
        
        <!-- Neon Cyan -->
        <SolidColorBrush x:Key="NeonCyan" Color="#00F3FF"/>
        <!-- Neon Pink -->
        <SolidColorBrush x:Key="NeonPink" Color="#FF0055"/>
        <!-- Dim Cyan -->
        <SolidColorBrush x:Key="DimCyan" Color="#005F63"/>

        <!-- Text -->
        <SolidColorBrush x:Key="TextMain" Color="#E0E0E0"/>
        <SolidColorBrush x:Key="TextMuted" Color="#666666"/>

        <!-- Glow Effect -->
        <DropShadowEffect x:Key="NeonGlow" Color="#00F3FF" BlurRadius="10" ShadowDepth="0" Opacity="0.6"/>
        <DropShadowEffect x:Key="PinkGlow" Color="#FF0055" BlurRadius="10" ShadowDepth="0" Opacity="0.6"/>

        <!-- Styles -->
        <Style x:Key="HoloButton" TargetType="Button">
            <Setter Property="Background" Value="Transparent"/>
            <Setter Property="Foreground" Value="{StaticResource NeonCyan}"/>
            <Setter Property="FontSize" Value="12"/>
            <Setter Property="FontWeight" Value="Bold"/>
            <Setter Property="Height" Value="35"/>
            <Setter Property="Margin" Value="0,0,0,5"/>
            <Setter Property="BorderBrush" Value="{StaticResource DimCyan}"/>
            <Setter Property="BorderThickness" Value="1"/>
            <Setter Property="Cursor" Value="Hand"/>
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="Button">
                        <Border Background="{TemplateBinding Background}" BorderBrush="{TemplateBinding BorderBrush}" BorderThickness="{TemplateBinding BorderThickness}">
                            <ContentPresenter HorizontalAlignment="Center" VerticalAlignment="Center"/>
                        </Border>
                        <ControlTemplate.Triggers>
                            <Trigger Property="IsMouseOver" Value="True">
                                <Setter Property="Background" Value="{StaticResource NeonCyan}"/>
                                <Setter Property="Foreground" Value="Black"/>
                                <Setter Property="BorderBrush" Value="{StaticResource NeonCyan}"/>
                                <Setter Property="Effect" Value="{StaticResource NeonGlow}"/>
                            </Trigger>
                        </ControlTemplate.Triggers>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
        </Style>

        <Style x:Key="TitleBarButton" TargetType="Button">
            <Setter Property="Background" Value="Transparent"/>
            <Setter Property="Foreground" Value="White"/>
            <Setter Property="Width" Value="40"/>
            <Setter Property="Cursor" Value="Hand"/>
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="Button">
                        <Border Background="{TemplateBinding Background}">
                            <ContentPresenter HorizontalAlignment="Center" VerticalAlignment="Center"/>
                        </Border>
                        <ControlTemplate.Triggers>
                            <Trigger Property="IsMouseOver" Value="True">
                                <Setter Property="Foreground" Value="{StaticResource NeonCyan}"/>
                            </Trigger>
                        </ControlTemplate.Triggers>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
        </Style>
    </Window.Resources>

    <!-- Main Background -->
    <Border Background="{StaticResource MainBg}" BorderBrush="{StaticResource DimCyan}" BorderThickness="1" CornerRadius="2">
        <Grid>
            <Grid.RowDefinitions>
                <RowDefinition Height="40"/>
                <RowDefinition Height="*"/>
            </Grid.RowDefinitions>

            <!-- Header Bar -->
            <Border Grid.Row="0" Background="#050505" BorderBrush="#111" BorderThickness="0,0,0,1">
                <Grid Margin="15,0">
                    <Grid.ColumnDefinitions>
                        <ColumnDefinition Width="*"/>
                        <ColumnDefinition Width="Auto"/>
                    </Grid.ColumnDefinitions>
                    
                    <!-- Title -->
                    <TextBlock Grid.Column="0" VerticalAlignment="Center">
                        <Run Text="MECZ" Foreground="{StaticResource NeonCyan}" FontWeight="Bold" FontSize="14"/>
                        <Run Text="//" Foreground="{StaticResource TextMuted}"/>
                        <Run Text="SYSTEM" Foreground="White" FontSize="14"/>
                    </TextBlock>

                    <!-- Window Controls -->
                    <StackPanel Grid.Column="1" Orientation="Horizontal">
                        <Button x:Name="DiscordHeaderBtn" Style="{StaticResource TitleBarButton}" Content="D" Foreground="{StaticResource NeonPink}"/>
                        <Button x:Name="GithubHeaderBtn" Style="{StaticResource TitleBarButton}" Content="G"/>
                        <Button x:Name="MinBtn" Style="{StaticResource TitleBarButton}" Content="_"/>
                        <Button x:Name="CloseBtn" Style="{StaticResource TitleBarButton}" Content="X"/>
                    </StackPanel>
                </Grid>
            </Border>

            <!-- Content -->
            <Grid Grid.Row="1">
                <Grid.ColumnDefinitions>
                    <ColumnDefinition Width="180"/>
                    <ColumnDefinition Width="2"/>
                    <ColumnDefinition Width="*"/>
                </Grid.ColumnDefinitions>

                <!-- Sidebar (Holo Dock) -->
                <Border Grid.Column="0" Background="{StaticResource PanelBg}" BorderBrush="#111" BorderThickness="0,0,1,0">
                    <StackPanel Margin="10">
                        <TextBlock Text="SYS.OP" Foreground="{StaticResource TextMuted}" FontSize="10" Margin="0,0,0,10"/>
                        
                        <Button x:Name="OpenFolderBtn" Content="[ OPEN DIR ]" Style="{StaticResource HoloButton}"/>
                        <Button x:Name="ClearCacheBtn" Content="[ PURGE ]" Style="{StaticResource HoloButton}"/>
                        
                        <TextBlock Text="NET.LINK" Foreground="{StaticResource TextMuted}" FontSize="10" Margin="0,20,0,10"/>
                        
                        <Button x:Name="DiscordBtn" Content="DISCORD" Style="{StaticResource HoloButton}" Foreground="{StaticResource NeonPink}" BorderBrush="{StaticResource NeonPink}"/>
                        <Button x:Name="GithubBtn" Content="GITHUB" Style="{StaticResource HoloButton}"/>

                        <TextBlock Text="V.4.0 // HOLO" Foreground="#333" FontSize="9" Margin="0,50,0,0" HorizontalAlignment="Center"/>
                    </StackPanel>
                </Border>

                <!-- Vertical Divider Line -->
                <Border Grid.Column="1" Background="{StaticResource DimCyan}" HorizontalAlignment="Center" Width="1" Margin="0,10"/>

                <!-- Main Area -->
                <Grid Grid.Column="2" Margin="15,15,15,15">
                    <Grid.RowDefinitions>
                        <RowDefinition Height="Auto"/>
                        <RowDefinition Height="15"/>
                        <RowDefinition Height="*"/>
                        <RowDefinition Height="15"/>
                        <RowDefinition Height="160"/>
                    </Grid.RowDefinitions>

                    <!-- Status HUD -->
                    <Border Grid.Row="0" Background="{StaticResource PanelBg}" BorderBrush="{StaticResource DimCyan}" BorderThickness="1" Padding="10">
                        <Grid>
                            <Grid.ColumnDefinitions>
                                <ColumnDefinition Width="Auto"/>
                                <ColumnDefinition Width="15"/>
                                <ColumnDefinition Width="*"/>
                            </Grid.ColumnDefinitions>
                            
                            <TextBlock Grid.Column="0" Text=">" Foreground="{StaticResource NeonCyan}" FontSize="18" FontWeight="Bold"/>
                            <TextBlock x:Name="StatusTitle" Grid.Column="2" Text="READY" Foreground="{StaticResource TextMain}" FontSize="14" VerticalAlignment="Center"/>
                            <TextBlock x:Name="StatusSub" Grid.Column="2" Text="WAITING FOR INPUT..." Foreground="{StaticResource TextMuted}" FontSize="10" VerticalAlignment="Center" Margin="0,15,0,0"/>
                        </Grid>
                    </Border>

                    <!-- Tools Container -->
                    <Border Grid.Row="2" Background="{StaticResource PanelBg}" BorderBrush="{StaticResource DimCyan}" BorderThickness="1">
                        <TabControl x:Name="ToolsTab" Background="Transparent" BorderThickness="0">
                            <TabControl.Resources>
                                <Style TargetType="TabItem">
                                    <Setter Property="Template">
                                        <Setter.Value>
                                            <ControlTemplate TargetType="TabItem">
                                                <Border Name="Border" Background="Transparent" BorderBrush="Transparent" BorderThickness="1,1,1,0" Margin="5,5,5,0" Padding="15,8">
                                                    <ContentPresenter ContentSource="Header" VerticalAlignment="Center"/>
                                                </Border>
                                                <ControlTemplate.Triggers>
                                                    <Trigger Property="IsSelected" Value="True">
                                                        <Setter TargetName="Border" Property="Background" Value="#111"/>
                                                        <Setter TargetName="Border" Property="BorderBrush" Value="{StaticResource NeonCyan}"/>
                                                        <Setter Property="Foreground" Value="{StaticResource NeonCyan}"/>
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

                    <!-- Console (Terminal) -->
                    <Border Grid.Row="4" Background="Black" BorderBrush="{StaticResource DimCyan}" BorderThickness="1">
                        <Grid>
                            <!-- Header -->
                            <Border Background="#0F0F0F" Height="25" BorderBrush="#222" BorderThickness="0,0,0,1">
                                <TextBlock Text="TERMINAL_OUTPUT" Foreground="{StaticResource TextMuted}" FontSize="10" Margin="10,5,0,0"/>
                            </Border>
                            <!-- Output -->
                            <TextBox x:Name="LogBox" 
                                     Background="Transparent" 
                                     Foreground="#00FF41" 
                                     BorderThickness="0" 
                                     FontFamily="Consolas" 
                                     FontSize="11" 
                                     IsReadOnly="True" 
                                     VerticalScrollBarVisibility="Auto"
                                     TextWrapping="Wrap"
                                     Padding="10,30,10,10"
                                     Margin="0"
                                     CaretBrush="#00FF41"/>
                        </Grid>
                    </Border>

                </Grid>
            </Grid>
        </Grid>
    </Border>
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
        $Btn.Width = 140
        $Btn.Height = 45
        $Btn.Margin = "6"
        $Btn.FontSize = "11"
        $Btn.FontFamily = "Consolas"
        $Btn.FontWeight = "Bold"
        $Btn.Cursor = "Hand"
        
        $Btn.Background = "Transparent"
        $Btn.Foreground = "#E0E0E0"
        
        $Style = New-Object System.Windows.Style
        $Style.TargetType = [System.Windows.Controls.Button]
        $Setter = New-Object System.Windows.Setter
        $Setter.Property = [System.Windows.Controls.Control]::TemplateProperty
        $Setter.Value = [Windows.Markup.XamlReader]::Parse("
            <ControlTemplate xmlns='http://schemas.microsoft.com/winfx/2006/xaml/presentation' TargetType='Button'>
                <Border Background='{TemplateBinding Background}' BorderBrush='#222' BorderThickness='1' Padding='2'>
                    <ContentPresenter HorizontalAlignment='Center' VerticalAlignment='Center'/>
                </Border>
                <ControlTemplate.Triggers>
                    <Trigger Property='IsMouseOver' Value='True'>
                        <Setter Property='Background' Value='{StaticResource NeonCyan}'/>
                        <Setter Property='Foreground' Value='Black'/>
                        <Setter Property='BorderBrush' Value='{StaticResource NeonCyan}'/>
                        <Setter Property='Effect' Value='{StaticResource NeonGlow}'/>
                    </Trigger>
                </ControlTemplate.Triggers>
            </ControlTemplate>
        ")
        $Btn.Style = $Style
        
        $Btn.Add_Click({
            $TName = $_.Source.Content
            $TData = $ToolData | Where-Object { $_.Name -eq $TName }
            
            Set-Status "PROCESSING..." "EXECUTING: $TName"
            
            if ($TName -match "Meow") {
                Write-Log "Meow! 🐱"
            }

            Write-Log "INIT_SEQUENCE: $TName"
            
            if ($TData.Type -eq "Cmd") {
                try {
                    Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -Command `"$($TData.Command)`"" -WindowStyle Normal
                    Set-Status "RUNNING" "PROCESS ACTIVE"
                    Write-Log "SUCCESS: PROCESS STARTED"
                } catch {
                    Set-Status "ERROR" "EXECUTION FAILED"
                    Write-Log "ERROR: FAILED TO LAUNCH"
                }
            }
            elseif ($TData.Type -eq "Web") {
                Start-Process $TData.URL
                Set-Status "NAVIGATING" "OPENING LINK"
                Write-Log "BROWSER_LAUNCH: SUCCESS"
            }
            elseif ($TData.Type -eq "GitHub") {
                $TempPath = "$env:TEMP\$($TName).exe"
                if (Test-Path $TempPath) {
                    Start-Process $TempPath
                    Set-Status "LAUNCHING" "CACHED ASSET"
                    Write-Log "EXECUTION: LOCAL CACHE"
                } else {
                    Set-Status "DOWNLOADING" "FETCHING ASSET..."
                    $Link = Get-GitHubExeUrl -ReleaseUrl $TData.URL
                    if ($Link) {
                        try {
                            $ProgressPreference = 'SilentlyContinue'
                            Invoke-WebRequest -Uri $Link -OutFile $TempPath -UseBasicParsing
                            $ProgressPreference = 'Continue'
                            Start-Process $TempPath
                            Set-Status "SUCCESS" "DOWNLOAD COMPLETE"
                            Write-Log "DOWNLOAD: ASSET ACQUIRED"
                        } catch {
                            Set-Status "ERROR" "DOWNLOAD FAILED"
                            Start-Process $TData.URL
                        }
                    } else {
                        Set-Status "ERROR" "ASSET NOT FOUND"
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
    Set-Status "SYSTEM" "DIRECTORY OPENED"
})

 $ClearCacheBtn.Add_Click({
    $files = Get-ChildItem -Path $env:TEMP -Filter "*.exe" -ErrorAction SilentlyContinue | Where-Object { $_.Name -match "Prefetch|BAM|Meow|PSHunter" }
    if ($files) {
        $files | Remove-Item -Force -ErrorAction SilentlyContinue
        Write-Log "SYSTEM: CACHE PURGED"
        Set-Status "CLEAN" "TEMP FILES DELETED"
    } else {
        Write-Log "SYSTEM: NO CACHE FOUND"
    }
})

# --- MECZ FEATURE: GLOBAL ENTER KEY ---
 $window.Add_KeyDown({
    if ($_.Key -eq "Enter") {
        Write-Log "Meow! 🐱"
        Write-Host "Meow! 🐱"
    }
})

Write-Log "SYSTEM: MECZ LAUNCHER V4.0 INITIALIZED"
Write-Host "System Ready."

 $window.ShowDialog() | Out-Null
