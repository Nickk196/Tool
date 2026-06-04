# Required Assemblies
Add-Type -AssemblyName PresentationFramework
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# User32 Import for Window Dragging
Add-Type -Name User32 -Namespace Win32 -MemberDefinition @"
[DllImport("user32.dll")] public static extern bool ReleaseCapture();
[DllImport("user32.dll")] public static extern int SendMessage(IntPtr hWnd, int Msg, int wParam, int lParam);
"@

# --- TOOL DATA (From Script 1) ---
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

    # --- OTHERS ---
    @{ Name="WinPrefetchView (NirSoft)"; Category="Others"; Type="Web"; URL="https://www.nirsoft.net/utils/win_prefetch_view.html" },
    @{ Name="CompActivityView (NirSoft)"; Category="Others"; Type="Web"; URL="https://www.nirsoft.net/utils/computer_activity_view.html" },
    @{ Name="AmcacheParser (EZ Tools)"; Category="Others"; Type="Web"; URL="https://download.ericzimmermanstools.com/net9/AmcacheParser.zip" },
    @{ Name="SystemInformer"; Category="Others"; Type="Web"; URL="https://www.systeminformer.com/canary" },
    @{ Name="DIE-engine"; Category="Others"; Type="Web"; URL="https://github.com/horsicq/DIE-engine/releases" },
    @{ Name="DQRKIS-FUCKER"; Category="Others"; Type="Cmd"; Command="Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/cheesecatlol/DQRKIS-FUCKER/refs/heads/main/DqrkisFucker.ps1')" },
    @{ Name="MacroDetector"; Category="Others"; Type="Cmd"; Command="Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/Nickk196/MacroDetector/refs/heads/main/MacroDetector.ps1')" }
)

# --- HELPER FUNCTION ---
function Get-GitHubExeUrl {
    param([string]$ReleaseUrl)
    if ($ReleaseUrl -match "github\.com/([^/]+)/([^/]+)/releases/tag/([^/]+)") {
        $User = $matches[1]; $Repo = $matches[2]; $Tag = $matches[3]
        $ApiUrl = "https://api.github.com/repos/$User/$Repo/releases/tags/$Tag"
        try {
            $ProgressPreference = 'SilentlyContinue'
            $Response = Invoke-RestMethod -Uri $ApiUrl -ErrorAction Stop
            $ProgressPreference = 'Continue'
            $Asset = $Response.assets | Where-Object { $_.name -like "*.exe" } | Select-Object -First 1
            if ($Asset) { return $Asset.browser_download_url }
        } catch { }
    }
    return $null
}

# --- XAML GUI (PURPLE THEME) ---
[xml]$xaml = @"
<Window
    xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
    xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
    Title="ScreenShare Tool"
    Width="1320"
    Height="830"
    MinWidth="1320"
    MinHeight="830"
    WindowStartupLocation="CenterScreen"
    ResizeMode="NoResize"
    WindowStyle="None"
    AllowsTransparency="True"
    Background="Transparent"
    FontFamily="Segoe UI"
    Opacity="1">

    <Window.Resources>
        <!-- Purple Background -->
        <LinearGradientBrush x:Key="WindowBackground" StartPoint="0,0" EndPoint="1,1">
            <GradientStop Color="#1a0b2e" Offset="0"/>
            <GradientStop Color="#2d1b4e" Offset="0.5"/>
            <GradientStop Color="#1a0b2e" Offset="1"/>
        </LinearGradientBrush>

        <!-- Darker Sidebar -->
        <LinearGradientBrush x:Key="SidebarBackground" StartPoint="0,0" EndPoint="0,1">
            <GradientStop Color="#120921" Offset="0"/>
            <GradientStop Color="#1a0e2e" Offset="1"/>
        </LinearGradientBrush>

        <!-- Purple Primary Button -->
        <LinearGradientBrush x:Key="PrimaryButtonBrush" StartPoint="0,0" EndPoint="1,1">
            <GradientStop Color="#d980fa" Offset="0"/>
            <GradientStop Color="#9980fa" Offset="1"/>
        </LinearGradientBrush>

        <!-- Purple Danger Button -->
        <LinearGradientBrush x:Key="DangerButtonBrush" StartPoint="0,0" EndPoint="1,1">
            <GradientStop Color="#574b90" Offset="0"/>
            <GradientStop Color="#303952" Offset="1"/>
        </LinearGradientBrush>

        <!-- Neutral Button -->
        <LinearGradientBrush x:Key="NeutralButtonBrush" StartPoint="0,0" EndPoint="1,1">
            <GradientStop Color="#3c1a5b" Offset="0"/>
            <GradientStop Color="#2e1245" Offset="1"/>
        </LinearGradientBrush>

        <!-- Card Background -->
        <LinearGradientBrush x:Key="CardBackground" StartPoint="0,0" EndPoint="1,1">
            <GradientStop Color="#241038" Offset="0"/>
            <GradientStop Color="#1a0b2e" Offset="1"/>
        </LinearGradientBrush>

        <SolidColorBrush x:Key="BorderBrushSoft" Color="#5b2c6f"/>

        <Style x:Key="ActionButtonStyle" TargetType="Button">
            <Setter Property="Foreground" Value="White"/>
            <Setter Property="FontSize" Value="15"/>
            <Setter Property="FontWeight" Value="SemiBold"/>
            <Setter Property="Height" Value="56"/>
            <Setter Property="Margin" Value="0,0,0,14"/>
            <Setter Property="Cursor" Value="Hand"/>
            <Setter Property="BorderThickness" Value="0"/>
            <Setter Property="Background" Value="{StaticResource NeutralButtonBrush}"/>
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="Button">
                        <Border x:Name="Root"
                                Background="{TemplateBinding Background}"
                                CornerRadius="17"
                                BorderBrush="#6a2c91"
                                BorderThickness="1">
                            <Border.Effect>
                                <DropShadowEffect BlurRadius="18" ShadowDepth="0" Opacity="0.3" Color="#6a2c91"/>
                            </Border.Effect>

                            <Grid Margin="16,0,16,0">
                                <Grid.ColumnDefinitions>
                                    <ColumnDefinition Width="Auto"/>
                                    <ColumnDefinition Width="12"/>
                                    <ColumnDefinition Width="*"/>
                                </Grid.ColumnDefinitions>

                                <Border Width="36"
                                        Height="36"
                                        CornerRadius="11"
                                        Background="#30FFFFFF"
                                        BorderBrush="#50FFFFFF"
                                        BorderThickness="1"
                                        VerticalAlignment="Center">
                                    <TextBlock Text="{TemplateBinding Tag}"
                                               FontFamily="Segoe MDL2 Assets"
                                               FontSize="15"
                                               Foreground="White"
                                               HorizontalAlignment="Center"
                                               VerticalAlignment="Center"/>
                                </Border>

                                <ContentPresenter Grid.Column="2"
                                                  VerticalAlignment="Center"
                                                  RecognizesAccessKey="True"/>
                            </Grid>
                        </Border>

                        <ControlTemplate.Triggers>
                            <Trigger Property="IsMouseOver" Value="True">
                                <Setter TargetName="Root" Property="Opacity" Value="0.9"/>
                                <Setter TargetName="Root" Property="BorderBrush" Value="#d980fa"/>
                            </Trigger>
                            <Trigger Property="IsPressed" Value="True">
                                <Setter TargetName="Root" Property="Opacity" Value="0.75"/>
                            </Trigger>
                            <Trigger Property="IsEnabled" Value="False">
                                <Setter TargetName="Root" Property="Opacity" Value="0.4"/>
                            </Trigger>
                        </ControlTemplate.Triggers>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
        </Style>

        <Style x:Key="SmallWindowButtonStyle" TargetType="Button">
            <Setter Property="Width" Value="34"/>
            <Setter Property="Height" Value="34"/>
            <Setter Property="Margin" Value="8,0,0,0"/>
            <Setter Property="Foreground" Value="White"/>
            <Setter Property="FontSize" Value="16"/>
            <Setter Property="FontWeight" Value="Bold"/>
            <Setter Property="Background" Value="#20FFFFFF"/>
            <Setter Property="BorderThickness" Value="0"/>
            <Setter Property="Cursor" Value="Hand"/>
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="Button">
                        <Border x:Name="BtnBorder" Background="{TemplateBinding Background}" CornerRadius="10">
                            <ContentPresenter HorizontalAlignment="Center" VerticalAlignment="Center"/>
                        </Border>
                        <ControlTemplate.Triggers>
                            <Trigger Property="IsMouseOver" Value="True">
                                <Setter TargetName="BtnBorder" Property="Background" Value="#40FFFFFF"/>
                            </Trigger>
                            <Trigger Property="IsPressed" Value="True">
                                <Setter TargetName="BtnBorder" Property="Background" Value="#10FFFFFF"/>
                            </Trigger>
                        </ControlTemplate.Triggers>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
        </Style>

        <Style x:Key="CardBorderStyle" TargetType="Border">
            <Setter Property="CornerRadius" Value="22"/>
            <Setter Property="Padding" Value="22"/>
            <Setter Property="Background" Value="{StaticResource CardBackground}"/>
            <Setter Property="BorderBrush" Value="{StaticResource BorderBrushSoft}"/>
            <Setter Property="BorderThickness" Value="1"/>
        </Style>
        
        <!-- TabItem Style -->
        <Style TargetType="TabItem">
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="TabItem">
                        <Grid>
                            <Border Name="Border" Margin="0,0,0,-1" Background="Transparent" BorderBrush="Transparent" BorderThickness="1,1,1,0" CornerRadius="10,10,0,0">
                                <ContentPresenter x:Name="ContentSite" VerticalAlignment="Center" HorizontalAlignment="Center" ContentSource="Header" Margin="15,10"/>
                            </Border>
                        </Grid>
                        <ControlTemplate.Triggers>
                            <Trigger Property="IsSelected" Value="True">
                                <Setter TargetName="Border" Property="Background" Value="#4b2c75"/>
                                <Setter TargetName="Border" Property="BorderBrush" Value="#6a2c91"/>
                                <Setter Property="Foreground" Value="White"/>
                            </Trigger>
                            <Trigger Property="IsSelected" Value="False">
                                <Setter TargetName="Border" Property="Background" Value="Transparent"/>
                                <Setter Property="Foreground" Value="#a39eb5"/>
                            </Trigger>
                        </ControlTemplate.Triggers>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
        </Style>
    </Window.Resources>

    <Grid>
        <Border CornerRadius="24" Background="{StaticResource WindowBackground}" BorderBrush="#4b2c75" BorderThickness="1">
            <Border.Effect>
                <DropShadowEffect BlurRadius="30" ShadowDepth="0" Opacity="0.5" Color="#2e1245"/>
            </Border.Effect>

            <Grid>
                <Grid.RowDefinitions>
                    <RowDefinition Height="64"/>
                    <RowDefinition Height="*"/>
                </Grid.RowDefinitions>

                <!-- Decorative Blobs -->
                <Ellipse Width="560" Height="560" Fill="#d980fa" Opacity="0.05" HorizontalAlignment="Left" VerticalAlignment="Top" Margin="-190,-180,0,0"/>
                <Ellipse Width="430" Height="430" Fill="#9980fa" Opacity="0.05" HorizontalAlignment="Right" VerticalAlignment="Bottom" Margin="0,0,-120,-130"/>

                <!-- Header -->
                <Border Grid.Row="0" Background="#120921" CornerRadius="24,24,0,0" BorderBrush="#4b2c75" BorderThickness="0,0,0,1">
                    <Grid Margin="18,0,18,0">
                        <Grid.ColumnDefinitions>
                            <ColumnDefinition Width="Auto"/>
                            <ColumnDefinition Width="*"/>
                            <ColumnDefinition Width="Auto"/>
                        </Grid.ColumnDefinitions>

                        <StackPanel Orientation="Horizontal" VerticalAlignment="Center">
                            <Border Width="40" Height="40" CornerRadius="13" Background="#2e1245" BorderBrush="#6a2c91" BorderThickness="1">
                                <TextBlock Text="S" FontSize="20" FontWeight="Bold" Foreground="#d980fa" HorizontalAlignment="Center" VerticalAlignment="Center"/>
                            </Border>
                            <StackPanel Margin="12,0,0,0" VerticalAlignment="Center">
                                <TextBlock Text="ScreenShare Tool" FontSize="18" FontWeight="SemiBold" Foreground="White"/>
                                <TextBlock Text="Forensic Analysis Kit" FontSize="11" Foreground="#a39eb5" Margin="0,2,0,0"/>
                            </StackPanel>
                        </StackPanel>

                        <StackPanel Grid.Column="2" Orientation="Horizontal" VerticalAlignment="Center">
                            <Button x:Name="MinButton" Content="—" Style="{StaticResource SmallWindowButtonStyle}"/>
                            <Button x:Name="CloseButton" Content="✕" Style="{StaticResource SmallWindowButtonStyle}" Background="#571f1f"/>
                        </StackPanel>
                    </Grid>
                </Border>

                <!-- Main Content -->
                <Grid Grid.Row="1" Margin="20">
                    <Grid.ColumnDefinitions>
                        <ColumnDefinition Width="280"/>
                        <ColumnDefinition Width="20"/>
                        <ColumnDefinition Width="*"/>
                    </Grid.ColumnDefinitions>

                    <!-- Sidebar -->
                    <Border Grid.Column="0" Background="{StaticResource SidebarBackground}" CornerRadius="22" BorderBrush="#4b2c75" BorderThickness="1" Padding="20">
                        <StackPanel>
                            <TextBlock Text="Quick Actions" FontSize="16" FontWeight="SemiBold" Foreground="White" Margin="0,0,0,15"/>
                            
                            <Button x:Name="OpenFolderButton" Tag="&#xE838;" Content="Open Install Folder" Style="{StaticResource ActionButtonStyle}" Background="#2e1245"/>
                            
                            <Button x:Name="DiscordButton" Tag="&#xE8F2;" Content="Join Discord" Style="{StaticResource ActionButtonStyle}" Background="#2e1245"/>
                            
                            <Button x:Name="ExitButton" Tag="&#xE8BB;" Content="Exit Launcher" Style="{StaticResource ActionButtonStyle}" Background="#120921" Margin="0,20,0,0"/>
                            
                            <Border Background="#1a0e2e" CornerRadius="18" Padding="16" BorderBrush="#4b2c75" BorderThickness="1">
                                <StackPanel>
                                    <TextBlock Text="Current Status" FontSize="12" Foreground="#a39eb5"/>
                                    <TextBlock x:Name="StatusTextSmall" Margin="0,5,0,0" TextWrapping="Wrap" Foreground="#d980fa" FontSize="13" Text="Ready"/>
                                </StackPanel>
                            </Border>
                        </StackPanel>
                    </Border>

                    <!-- Content Area -->
                    <Grid Grid.Column="2">
                        <Grid.RowDefinitions>
                            <RowDefinition Height="Auto"/>
                            <RowDefinition Height="*"/>
                        </Grid.RowDefinitions>

                        <!-- Top Status Card -->
                        <Border Grid.Row="0" Style="{StaticResource CardBorderStyle}" Margin="0,0,0,15">
                            <Grid>
                                <Grid.ColumnDefinitions>
                                    <ColumnDefinition Width="*"/>
                                    <ColumnDefinition Width="Auto"/>
                                </Grid.ColumnDefinitions>
                                <StackPanel>
                                    <TextBlock x:Name="StatusTitle" Text="Ready to Work" FontSize="24" FontWeight="SemiBold" Foreground="White"/>
                                    <TextBlock x:Name="SubStatusText" Text="Select a tool category below to begin analysis." Margin="0,5,0,0" FontSize="13" Foreground="#a39eb5"/>
                                </StackPanel>
                                <Border Grid.Column="1" Width="40" Height="40" CornerRadius="12" Background="#3c1a5b">
                                    <TextBlock Text="&#xE8F7;" FontFamily="Segoe MDL2 Assets" FontSize="18" Foreground="#d980fa" HorizontalAlignment="Center" VerticalAlignment="Center"/>
                                </Border>
                            </Grid>
                        </Border>

                        <!-- Tools Tab Control -->
                        <Border Grid.Row="1" Background="#1a0b2e" CornerRadius="15" BorderBrush="#4b2c75" BorderThickness="1" Padding="10">
                            <TabControl x:Name="ToolsTabControl" Background="Transparent" BorderThickness="0">
                                <!-- Tabs will be injected here via PowerShell -->
                            </TabControl>
                        </Border>
                    </Grid>
                </Grid>
            </Grid>
        </Border>
    </Grid>
</Window>
"@

# --- PARSE XAML AND BUILD UI ---
 $reader = (New-Object System.Xml.XmlNodeReader $xaml) 
 $Window = [Windows.Markup.XamlReader]::Load($reader)

# Find Elements
 $BtnClose = $Window.FindName("CloseButton")
 $BtnMin = $Window.FindName("MinButton")
 $BtnOpenFolder = $Window.FindName("OpenFolderButton")
 $BtnDiscord = $Window.FindName("DiscordButton")
 $BtnExit = $Window.FindName("ExitButton")
 $StatusTitle = $Window.FindName("StatusTitle")
 $SubStatus = $Window.FindName("SubStatusText")
 $StatusSmall = $Window.FindName("StatusTextSmall")
 $TabControl = $Window.FindName("ToolsTabControl")

# --- EVENT HANDLERS ---

# Window Dragging
 $Window.Add_MouseDown({
    if ($_.Button -eq [System.Windows.Forms.MouseButtons]::Left) {
        [Win32.User32]::ReleaseCapture()
        [Win32.User32]::SendMessage((New-Object System.Windows.Interop.WindowInteropHelper($Window)).Handle, 0x0112, 0xF012, 0)
    }
})

# Button Clicks
 $BtnClose.Add_Click({ $Window.Close() })
 $BtnMin.Add_Click({ $Window.WindowState = "Minimized" })
 $BtnExit.Add_Click({ $Window.Close() })
 $BtnOpenFolder.Add_Click({ Start-Process $env:TEMP })
 $BtnDiscord.Add_Click({ Start-Process "https://discord.gg/cfnmHrqP3K" })

# Update Status Helper
function Set-Status {
    param($Title, $Sub)
    $StatusTitle.Text = $Title
    $SubStatus.Text = $Sub
    $StatusSmall.Text = $Title
}

# --- DYNAMIC TAB GENERATION ---

 $Categories = @("Orbdiff", "Spokwn", "RedLotus", "Tonynoh", "Praiselily", "Others")

foreach ($Cat in $Categories) {
    $TabItem = New-Object System.Windows.Controls.TabItem
    $TabItem.Header = $Cat
    
    # Scrollable Grid for Buttons
    $ScrollViewer = New-Object System.Windows.Controls.ScrollViewer
    $ScrollViewer.VerticalScrollBarVisibility = "Auto"
    $ScrollViewer.HorizontalScrollBarVisibility = "Disabled"
    
    $WrapPanel = New-Object System.Windows.Controls.WrapPanel
    $WrapPanel.Margin = "10"
    
    $Tools = $ToolData | Where-Object { $_.Category -eq $Cat }
    
    foreach ($Tool in $Tools) {
        $Btn = New-Object System.Windows.Controls.Button
        $Btn.Content = $Tool.Name
        $Btn.Width = 180
        $Btn.Height = 80
        $Btn.Margin = "10"
        $Btn.FontSize = "13"
        $Btn.FontWeight = "SemiBold"
        $Btn.Cursor = "Hand"
        
        # Purple Button Style for Tool Grid
        $Btn.Background = "#241038"
        $Btn.Foreground = "White"
        $Btn.BorderBrush = "#5b2c6f"
        $Btn.BorderThickness = "1"
        
        # Add Rounded Corners via Template
        $Style = New-Object System.Windows.Style
        $Style.TargetType = [System.Windows.Controls.Button]
        $Setter = New-Object System.Windows.Setter
        $Setter.Property = [System.Windows.Controls.Control]::TemplateProperty
        $Setter.Value = [Windows.Markup.XamlReader]::Parse("
            <ControlTemplate xmlns='http://schemas.microsoft.com/winfx/2006/xaml/presentation' TargetType='Button'>
                <Border Background='{TemplateBinding Background}' BorderBrush='{TemplateBinding BorderBrush}' BorderThickness='{TemplateBinding BorderThickness}' CornerRadius='10'>
                    <ContentPresenter HorizontalAlignment='Center' VerticalAlignment='Center'/>
                    <Border.Effect>
                        <DropShadowEffect BlurRadius='10' ShadowDepth='0' Opacity='0.2' Color='Purple'/>
                    </Border.Effect>
                </Border>
                <ControlTemplate.Triggers>
                    <Trigger Property='IsMouseOver' Value='True'>
                        <Setter Property='Background' Value='#4b2c75'/>
                        <Setter Property='BorderBrush' Value='#d980fa'/>
                    </Trigger>
                    <Trigger Property='IsPressed' Value='True'>
                        <Setter Property='Background' Value='#3c1a5b'/>
                    </Trigger>
                </ControlTemplate.Triggers>
            </ControlTemplate>
        ")
        $Btn.Style = $Style
        
        # Click Event
        $Btn.Add_Click({
            $TName = $_.Source.Content
            $TData = $ToolData | Where-Object { $_.Name -eq $TName }
            
            Set-Status -Title "Launching: $TName" -Sub "Processing request..."
            
            if ($TData.Type -eq "Cmd") {
                try {
                    Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -Command `"$($TData.Command)`"" -WindowStyle Normal
                    Set-Status -Title "Launched" -Sub "Command script executed."
                } catch {
                    Set-Status -Title "Error" -Sub "Failed to launch command."
                }
            }
            elseif ($TData.Type -eq "Web") {
                Start-Process $TData.URL
                Set-Status -Title "Opening Browser" -Sub "Navigating to source."
            }
            elseif ($TData.Type -eq "GitHub") {
                $TempPath = "$env:TEMP\$($TName).exe"
                if (Test-Path $TempPath) {
                    Start-Process $TempPath
                    Set-Status -Title "Running" -Sub "Started existing local file."
                } else {
                    Set-Status -Title "Downloading" -Sub "Fetching latest release from GitHub..."
                    $Link = Get-GitHubExeUrl -ReleaseUrl $TData.URL
                    if ($Link) {
                        try {
                            $ProgressPreference = 'SilentlyContinue'
                            Invoke-WebRequest -Uri $Link -OutFile $TempPath -UseBasicParsing
                            $ProgressPreference = 'Continue'
                            Start-Process $TempPath
                            Set-Status -Title "Success" -Sub "Downloaded and launched."
                        } catch {
                            Set-Status -Title "Download Error" -Sub "Falling back to browser..."
                            Start-Sleep -Seconds 1
                            Start-Process $TData.URL
                        }
                    } else {
                        Set-Status -Title "Asset Error" -Sub "Could not find .exe, opening page..."
                        Start-Sleep -Seconds 1
                        Start-Process $TData.URL
                    }
                }
            }
        })
        
        $WrapPanel.Children.Add($Btn) | Out-Null
    }
    
    $ScrollViewer.Content = $WrapPanel
    $TabItem.Content = $ScrollViewer
    $TabControl.Items.Add($TabItem) | Out-Null
}

# --- SHOW GUI ---
 $Window.ShowDialog() | Out-Null
