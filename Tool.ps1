# ==============================================================================
# NIC LAUNCHER - Forensic Tool Suite
# Merged from Tesla Launcher Framework & ScreenShare Tool Functionality
# ==============================================================================

Add-Type -AssemblyName PresentationFramework
Add-Type -AssemblyName PresentationCore
Add-Type -AssemblyName WindowsBase
Add-Type -AssemblyName System.Xaml
Add-Type -AssemblyName System.IO.Compression.FileSystem

# User32 Import for Draggable Window (kept for compatibility, though WPF uses DragMove mostly)
Add-Type -Name User32 -Namespace Win32 -MemberDefinition @"
[DllImport("user32.dll")] public static extern bool ReleaseCapture();
[DllImport("user32.dll")] public static extern int SendMessage(IntPtr hWnd, int Msg, int wParam, int lParam);
"@

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

# --- CONFIGURATION ---
 $userDir   = [Environment]::GetFolderPath("UserProfile")
 $downloads = Join-Path $userDir "Downloads"
 $installDir = Join-Path $downloads "Nic-Tools"
 $version   = "1.0"

 $announcementTitle = "Welcome to Nic Launcher"
 $announcementMessage = @"
Welcome to the Nic Launcher.

This tool provides a streamlined interface to manage and launch forensic analysis tools.

Features:
• Direct GitHub Integration
• One-Click Launching
• Command Execution Support
• Activity Logging

Select a category from the main panel to get started.
"@

# --- TOOL DATA (Merged from ScreenShare Tool) ---
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

# ==============================================================================
# XAML UI (PURPLE THEME - "NIC" BRANDING)
# ==============================================================================

[xml]$xaml = @"
<Window
    xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
    xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
    Title="Nic Launcher"
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
        <!-- Purple Theme Brushes -->
        <LinearGradientBrush x:Key="WindowBackground" StartPoint="0,0" EndPoint="1,1">
            <GradientStop Color="#140021" Offset="0"/>
            <GradientStop Color="#1B0B2E" Offset="0.5"/>
            <GradientStop Color="#0F001A" Offset="1"/>
        </LinearGradientBrush>

        <LinearGradientBrush x:Key="SidebarBackground" StartPoint="0,0" EndPoint="0,1">
            <GradientStop Color="#1E0033" Offset="0"/>
            <GradientStop Color="#240046" Offset="1"/>
        </LinearGradientBrush>

        <LinearGradientBrush x:Key="PrimaryButtonBrush" StartPoint="0,0" EndPoint="1,1">
            <GradientStop Color="#9D4EDD" Offset="0"/>
            <GradientStop Color="#7B2CBF" Offset="1"/>
        </LinearGradientBrush>

        <LinearGradientBrush x:Key="DangerButtonBrush" StartPoint="0,0" EndPoint="1,1">
            <GradientStop Color="#560BAD" Offset="0"/>
            <GradientStop Color="#3C096C" Offset="1"/>
        </LinearGradientBrush>

        <LinearGradientBrush x:Key="NeutralButtonBrush" StartPoint="0,0" EndPoint="1,1">
            <GradientStop Color="#3C096C" Offset="0"/>
            <GradientStop Color="#240046" Offset="1"/>
        </LinearGradientBrush>

        <LinearGradientBrush x:Key="CardBackground" StartPoint="0,0" EndPoint="1,1">
            <GradientStop Color="#240046" Offset="0"/>
            <GradientStop Color="#10002B" Offset="1"/>
        </LinearGradientBrush>

        <SolidColorBrush x:Key="BorderBrushSoft" Color="#5A189A"/>

        <!-- Button Styles -->
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
                                BorderBrush="#7B2CBF"
                                BorderThickness="1">
                            <Border.Effect>
                                <DropShadowEffect BlurRadius="18" ShadowDepth="0" Opacity="0.22" Color="#9D4EDD"/>
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
                                <Setter TargetName="Root" Property="BorderBrush" Value="#E0AAFF"/>
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
    </Window.Resources>

    <Grid>
        <Border CornerRadius="24" Background="{StaticResource WindowBackground}" BorderBrush="#5A189A" BorderThickness="1">
            <Border.Effect>
                <DropShadowEffect BlurRadius="30" ShadowDepth="0" Opacity="0.45" Color="#10002B"/>
            </Border.Effect>

            <Grid>
                <Grid.RowDefinitions>
                    <RowDefinition Height="64"/>
                    <RowDefinition Height="*"/>
                </Grid.RowDefinitions>

                <!-- Decorative Purple Blobs -->
                <Ellipse Width="560" Height="560" Fill="#9D4EDD" Opacity="0.05" HorizontalAlignment="Left" VerticalAlignment="Top" Margin="-190,-180,0,0"/>
                <Ellipse Width="430" Height="430" Fill="#7B2CBF" Opacity="0.05" HorizontalAlignment="Right" VerticalAlignment="Bottom" Margin="0,0,-120,-130"/>

                <!-- Header -->
                <Border Grid.Row="0" Background="#10002B" CornerRadius="24,24,0,0" BorderBrush="#3C096C" BorderThickness="0,0,0,1">
                    <Grid Margin="18,0,18,0">
                        <Grid.ColumnDefinitions>
                            <ColumnDefinition Width="Auto"/>
                            <ColumnDefinition Width="*"/>
                            <ColumnDefinition Width="Auto"/>
                        </Grid.ColumnDefinitions>

                        <StackPanel Orientation="Horizontal" VerticalAlignment="Center">
                            <Border Width="40" Height="40" CornerRadius="13" Background="#240046" BorderBrush="#7B2CBF" BorderThickness="1">
                                <TextBlock Text="N" FontSize="20" FontWeight="Bold" Foreground="#E0AAFF" HorizontalAlignment="Center" VerticalAlignment="Center"/>
                            </Border>
                            <StackPanel Margin="12,0,0,0" VerticalAlignment="Center">
                                <TextBlock Text="Nic Launcher" FontSize="18" FontWeight="SemiBold" Foreground="White"/>
                                <TextBlock Text="Nic Forensic Tools" FontSize="11" Foreground="#C77DFF" Margin="0,2,0,0"/>
                            </StackPanel>
                        </StackPanel>

                        <StackPanel Grid.Column="2" Orientation="Horizontal" VerticalAlignment="Center">
                            <Button x:Name="InfoButtonTop" Content="ⓘ" Style="{StaticResource SmallWindowButtonStyle}" Background="#240046"/>
                            <Button x:Name="MinButton" Content="—" Style="{StaticResource SmallWindowButtonStyle}"/>
                            <Button x:Name="CloseButton" Content="✕" Style="{StaticResource SmallWindowButtonStyle}" Background="#3C096C"/>
                        </StackPanel>
                    </Grid>
                </Border>

                <!-- Main Content Area -->
                <Grid Grid.Row="1" Margin="20">
                    <Grid.ColumnDefinitions>
                        <ColumnDefinition Width="280"/>
                        <ColumnDefinition Width="20"/>
                        <ColumnDefinition Width="*"/>
                    </Grid.ColumnDefinitions>

                    <!-- Sidebar -->
                    <Border Grid.Column="0" Background="{StaticResource SidebarBackground}" CornerRadius="22" BorderBrush="#5A189A" BorderThickness="1" Padding="20">
                        <StackPanel>
                            <TextBlock Text="Control Center" FontSize="24" FontWeight="SemiBold" Foreground="White"/>
                            <TextBlock Text="Manage your forensic toolkit." TextWrapping="Wrap" Margin="0,8,0,0" Foreground="#E0AAFF" FontSize="13"/>
                            
                            <Button x:Name="OpenFolderButton" Tag="&#xE838;" Content="Open Tool Folder" Style="{StaticResource ActionButtonStyle}" Background="#3C096C" Margin="0,20,0,0"/>
                            
                            <Button x:Name="ClearCacheButton" Tag="&#xE74D;" Content="Clear Downloads" Style="{StaticResource ActionButtonStyle}" Background="#240046"/>

                            <Button x:Name="ExitButton" Tag="&#xE8BB;" Content="Exit Launcher" Style="{StaticResource ActionButtonStyle}" Background="#10002B" Margin="0,20,0,0"/>
                            
                            <Border Background="#10002B" CornerRadius="18" Padding="16" BorderBrush="#5A189A" BorderThickness="1">
                                <StackPanel>
                                    <TextBlock Text="Install Path" FontSize="12" Foreground="#C77DFF"/>
                                    <TextBlock x:Name="LocationText" Margin="0,8,0,0" TextWrapping="Wrap" Foreground="White" FontSize="13"/>
                                    <TextBlock x:Name="VersionText" Text="Version 1.0" Foreground="#E0AAFF" FontSize="12" Margin="0,10,0,0" FontWeight="Bold"/>
                                </StackPanel>
                            </Border>
                        </StackPanel>
                    </Border>

                    <!-- Tool Panel (Right Side) -->
                    <Grid Grid.Column="2">
                        <Grid.RowDefinitions>
                            <RowDefinition Height="Auto"/>
                            <RowDefinition Height="16"/>
                            <RowDefinition Height="*"/>
                            <RowDefinition Height="16"/>
                            <RowDefinition Height="200"/>
                        </Grid.RowDefinitions>

                        <!-- Status Card -->
                        <Border Grid.Row="0" Style="{StaticResource CardBorderStyle}">
                            <Grid>
                                <Grid.ColumnDefinitions>
                                    <ColumnDefinition Width="*"/>
                                    <ColumnDefinition Width="Auto"/>
                                </Grid.ColumnDefinitions>
                                <StackPanel>
                                    <TextBlock x:Name="StatusText" Text="Ready" FontSize="30" FontWeight="SemiBold" Foreground="White"/>
                                    <TextBlock x:Name="SubStatusText" Text="Select a category to begin." Margin="0,8,0,0" FontSize="14" Foreground="#E0AAFF"/>
                                </StackPanel>
                                <Border Grid.Column="1" Width="40" Height="40" CornerRadius="12" Background="#240046">
                                    <TextBlock Text="&#xE8F7;" FontFamily="Segoe MDL2 Assets" FontSize="18" Foreground="#9D4EDD" HorizontalAlignment="Center" VerticalAlignment="Center"/>
                                </Border>
                            </Grid>
                        </Border>

                        <!-- TOOLS TAB CONTROL (Middle) -->
                        <Border Grid.Row="2" Background="#10002B" CornerRadius="15" BorderBrush="#5A189A" BorderThickness="1" Padding="5">
                            <TabControl x:Name="ToolsTabControl" Background="Transparent" BorderThickness="0">
                                <TabControl.Resources>
                                    <Style TargetType="TabItem">
                                        <Setter Property="Template">
                                            <Setter.Value>
                                                <ControlTemplate TargetType="TabItem">
                                                    <Grid>
                                                        <Border Name="Border" Margin="5,5,5,0" Background="Transparent" BorderBrush="Transparent" BorderThickness="1,1,1,0" CornerRadius="8,8,0,0" Padding="15,10">
                                                            <ContentPresenter x:Name="ContentSite" VerticalAlignment="Center" HorizontalAlignment="Center" ContentSource="Header" RecognizesAccessKey="True"/>
                                                        </Border>
                                                    </Grid>
                                                    <ControlTemplate.Triggers>
                                                        <Trigger Property="IsSelected" Value="True">
                                                            <Setter Property="Panel.ZIndex" Value="100" />
                                                            <Setter TargetName="Border" Property="Background" Value="#3C096C" />
                                                            <Setter TargetName="Border" Property="BorderBrush" Value="#9D4EDD" />
                                                            <Setter Property="Foreground" Value="White"/>
                                                        </Trigger>
                                                        <Trigger Property="IsSelected" Value="False">
                                                            <Setter Property="Foreground" Value="#C77DFF"/>
                                                        </Trigger>
                                                    </ControlTemplate.Triggers>
                                                </ControlTemplate>
                                            </Setter.Value>
                                        </Setter>
                                    </Style>
                                </TabControl.Resources>
                                <!-- Tabs will be injected here via PowerShell -->
                            </TabControl>
                        </Border>

                        <!-- Activity Console (Bottom) -->
                        <Border Grid.Row="4" Style="{StaticResource CardBorderStyle}">
                            <Grid>
                                <Grid.RowDefinitions>
                                    <RowDefinition Height="Auto"/>
                                    <RowDefinition Height="16"/>
                                    <RowDefinition Height="*"/>
                                </Grid.RowDefinitions>
                                
                                <TextBlock Text="Activity Console" FontSize="22" FontWeight="SemiBold" Foreground="White"/>
                                
                                <Border Grid.Row="2"
                                        CornerRadius="18"
                                        Background="#0F001A"
                                        BorderBrush="#3C096C"
                                        BorderThickness="1"
                                        Padding="14">
                                    <TextBox x:Name="ActivityBox"
                                             Background="Transparent"
                                             Foreground="#E0AAFF"
                                             BorderThickness="0"
                                             FontFamily="Consolas"
                                             FontSize="13"
                                             IsReadOnly="True"
                                             VerticalScrollBarVisibility="Auto"
                                             TextWrapping="Wrap"
                                             AcceptsReturn="True"/>
                                </Border>
                            </Grid>
                        </Border>
                    </Grid>
                </Grid>
            </Grid>
        </Border>

        <!-- Info Overlay (Recycled from Tesla) -->
        <Grid x:Name="InfoRoot" Visibility="Collapsed" Opacity="0" Background="#A0000000">
            <Border Width="620" Padding="24" CornerRadius="22" Background="#10002B" BorderBrush="#5A189A" BorderThickness="1" HorizontalAlignment="Center" VerticalAlignment="Center">
                <Border.Effect>
                    <DropShadowEffect BlurRadius="30" ShadowDepth="0" Opacity="0.35" Color="#10002B"/>
                </Border.Effect>
                <Grid>
                    <Grid.RowDefinitions>
                        <RowDefinition Height="Auto"/>
                        <RowDefinition Height="18"/>
                        <RowDefinition Height="*"/>
                        <RowDefinition Height="20"/>
                        <RowDefinition Height="Auto"/>
                    </Grid.RowDefinitions>
                    <Grid>
                        <Grid.ColumnDefinitions>
                            <ColumnDefinition Width="Auto"/>
                            <ColumnDefinition Width="*"/>
                            <ColumnDefinition Width="Auto"/>
                        </Grid.ColumnDefinitions>
                        <Border Width="44" Height="44" CornerRadius="14" Background="#240046" BorderBrush="#7B2CBF" BorderThickness="1">
                            <TextBlock Text="N" HorizontalAlignment="Center" VerticalAlignment="Center" FontSize="21" FontWeight="Bold" Foreground="#E0AAFF"/>
                        </Border>
                        <StackPanel Grid.Column="1" Margin="14,0,0,0">
                            <TextBlock Text="About Nic Launcher" FontSize="22" FontWeight="SemiBold" Foreground="White"/>
                            <TextBlock Text="Nic Forensic Tools Information" Foreground="#C77DFF" FontSize="12" Margin="0,4,0,0"/>
                        </StackPanel>
                        <Button x:Name="InfoCloseButton" Grid.Column="2" Content="✕" Width="34" Height="34" Style="{StaticResource SmallWindowButtonStyle}" Background="#3C096C"/>
                    </Grid>
                    <StackPanel Grid.Row="2">
                        <Border CornerRadius="16" Background="#0F001A" BorderBrush="#5A189A" BorderThickness="1" Padding="16">
                            <TextBlock TextWrapping="Wrap" Foreground="#E0AAFF" FontSize="13">
Nic Launcher v1.0

A forged tool combining the Tesla UI framework with ScreenShare functionality.
For support or issues, please contact the administrator.

Permission is required for use.
                            </TextBlock>
                        </Border>
                    </StackPanel>
                    <StackPanel Grid.Row="4" Orientation="Horizontal" HorizontalAlignment="Right">
                        <Button x:Name="InfoOkButton" Content="Close" Style="{StaticResource ActionButtonStyle}" Background="{StaticResource PrimaryButtonBrush}" Width="140" Margin="0"/>
                    </StackPanel>
                </Grid>
            </Border>
        </Grid>
    </Grid>
</Window>
"@

# ==============================================================================
# LOGIC & INITIALIZATION
# ==============================================================================

# Load XAML
 $reader = New-Object System.Xml.XmlNodeReader $xaml
 $window = [Windows.Markup.XamlReader]::Load($reader)

# Find Elements
 $OpenFolderButton = $window.FindName("OpenFolderButton")
 $ClearCacheButton = $window.FindName("ClearCacheButton")
 $ExitButton       = $window.FindName("ExitButton")
 $CloseButton      = $window.FindName("CloseButton")
 $MinButton        = $window.FindName("MinButton")
 $InfoButtonTop    = $window.FindName("InfoButtonTop")

 $StatusText       = $window.FindName("StatusText")
 $SubStatusText    = $window.FindName("SubStatusText")
 $LocationText     = $window.FindName("LocationText")
 $ActivityBox      = $window.FindName("ActivityBox")
 $TabControl       = $window.FindName("ToolsTabControl")

 $InfoRoot         = $window.FindName("InfoRoot")
 $InfoCloseButton  = $window.FindName("InfoCloseButton")
 $InfoOkButton     = $window.FindName("InfoOkButton")

# Set Paths
 $LocationText.Text = $installDir

# UI Helpers
function Refresh-Ui {
    $window.Dispatcher.Invoke([Action]{}, [System.Windows.Threading.DispatcherPriority]::Background)
}

function Write-Activity {
    param([string]$Text)
    $timestamp = Get-Date -Format "HH:mm:ss"
    $ActivityBox.AppendText("[$timestamp] $Text`r`n")
    $ActivityBox.ScrollToEnd()
    Refresh-Ui
}

function Set-UiStatus {
    param([string]$Title, [string]$Sub)
    $StatusText.Text = $Title
    $SubStatusText.Text = $Sub
    Refresh-Ui
}

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
        } catch { Write-Activity "API Error for $Repo" }
    }
    return $null
}

# --- GENERATE TOOLS TABS ---
 $Categories = @("Orbdiff", "Spokwn", "RedLotus", "Tonynoh", "Praiselily", "Others")

foreach ($Cat in $Categories) {
    $TabItem = New-Object System.Windows.Controls.TabItem
    $TabItem.Header = $Cat
    
    # Scrollable Grid
    $ScrollViewer = New-Object System.Windows.Controls.ScrollViewer
    $ScrollViewer.VerticalScrollBarVisibility = "Auto"
    
    $WrapPanel = New-Object System.Windows.Controls.WrapPanel
    $WrapPanel.Margin = "10"
    
    $Tools = $ToolData | Where-Object { $_.Category -eq $Cat }
    
    foreach ($Tool in $Tools) {
        $Btn = New-Object System.Windows.Controls.Button
        $Btn.Content = $Tool.Name
        $Btn.Width = 160
        $Btn.Height = 70
        $Btn.Margin = "8"
        $Btn.FontSize = "13"
        $Btn.FontWeight = "SemiBold"
        $Btn.Cursor = "Hand"
        
        # Style definition for dynamic buttons
        $Btn.Background = "#240046"
        $Btn.Foreground = "White"
        
        # Template
        $Style = New-Object System.Windows.Style
        $Style.TargetType = [System.Windows.Controls.Button]
        $Setter = New-Object System.Windows.Setter
        $Setter.Property = [System.Windows.Controls.Control]::TemplateProperty
        $Setter.Value = [Windows.Markup.XamlReader]::Parse("
            <ControlTemplate xmlns='http://schemas.microsoft.com/winfx/2006/xaml/presentation' TargetType='Button'>
                <Border Background='{TemplateBinding Background}' CornerRadius='10' BorderThickness='1' BorderBrush='#5A189A'>
                    <ContentPresenter HorizontalAlignment='Center' VerticalAlignment='Center'/>
                    <Border.Effect>
                        <DropShadowEffect BlurRadius='5' ShadowDepth='0' Opacity='0.2' Color='Purple'/>
                    </Border.Effect>
                </Border>
                <ControlTemplate.Triggers>
                    <Trigger Property='IsMouseOver' Value='True'>
                        <Setter Property='Background' Value='#5A189A'/>
                    </Trigger>
                </ControlTemplate.Triggers>
            </ControlTemplate>
        ")
        $Btn.Style = $Style
        
        # Click Logic
        $Btn.Add_Click({
            $TName = $_.Source.Content
            $TData = $ToolData | Where-Object { $_.Name -eq $TName }
            
            Set-UiStatus -Title "Processing..." -Sub "Handling request for $TName"
            Write-Activity "Starting: $TName"
            
            if ($TData.Type -eq "Cmd") {
                Set-UiStatus -Title "Running Script" -Sub "Executing PowerShell command..."
                try {
                    Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -Command `"$($TData.Command)`"" -WindowStyle Normal
                    Set-UiStatus -Title "Success" -Sub "Script executed."
                    Write-Activity "Successfully launched script for $TName"
                } catch {
                    Set-UiStatus -Title "Error" -Sub "Failed to launch command."
                    Write-Activity "Error: $_"
                }
            }
            elseif ($TData.Type -eq "Web") {
                Set-UiStatus -Title "Opening Browser" -Sub "Navigating to website..."
                Start-Process $TData.URL
                Set-UiStatus -Title "Ready" -Sub "Website opened."
                Write-Activity "Opened web link for $TName"
            }
            elseif ($TData.Type -eq "GitHub") {
                $TempPath = "$env:TEMP\$($TName).exe"
                
                # Check if already downloaded
                if (Test-Path $TempPath) {
                    Set-UiStatus -Title "Launching" -Sub "Using cached local file."
                    Write-Activity "Found local file for $TName"
                    Start-Process $TempPath
                    Set-UiStatus -Title "Ready" -Sub "Tool launched."
                } else {
                    Set-UiStatus -Title "Downloading" -Sub "Fetching from GitHub..."
                    Write-Activity "Downloading $TName..."
                    $Link = Get-GitHubExeUrl -ReleaseUrl $TData.URL
                    
                    if ($Link) {
                        try {
                            $ProgressPreference = 'SilentlyContinue'
                            Invoke-WebRequest -Uri $Link -OutFile $TempPath -UseBasicParsing
                            $ProgressPreference = 'Continue'
                            Set-UiStatus -Title "Launching" -Sub "Download complete."
                            Start-Process $TempPath
                            Write-Activity "Downloaded and launched $TName"
                        } catch {
                            Set-UiStatus -Title "Error" -Sub "Download failed."
                            Write-Activity "Download failed for $TName. Opening release page..."
                            Start-Sleep -Seconds 1
                            Start-Process $TData.URL
                        }
                    } else {
                        Set-UiStatus -Title "Error" -Sub "Could not find exe."
                        Write-Activity "No EXE found in release. Opening page..."
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

# --- EVENT HANDLERS ---
 $window.Add_MouseLeftButtonDown({
    try { $window.DragMove() } catch {}
})

 $CloseButton.Add_Click({ $window.Close() })
 $MinButton.Add_Click({ $window.WindowState = "Minimized" })
 $ExitButton.Add_Click({ $window.Close() })

 $InfoButtonTop.Add_Click({
    $InfoRoot.Visibility = "Visible"
    $InfoRoot.Opacity = 0
    $anim = New-Object System.Windows.Media.Animation.DoubleAnimation(0, 1, [TimeSpan]::FromMilliseconds(200))
    $InfoRoot.BeginAnimation([System.Windows.UIElement]::OpacityProperty, $anim)
})

 $InfoCloseButton.Add_Click({
    $InfoRoot.Visibility = "Collapsed"
})
 $InfoOkButton.Add_Click({
    $InfoRoot.Visibility = "Collapsed"
})

 $OpenFolderButton.Add_Click({
    if (!(Test-Path $installDir)) { New-Item -ItemType Directory -Path $installDir | Out-Null }
    Start-Process $installDir
    Set-UiStatus -Title "Folder Opened" -Sub "Viewing $installDir"
})

 $ClearCacheButton.Add_Click({
    $cacheDir = $env:TEMP
    $files = Get-ChildItem -Path $cacheDir -Filter "*.exe" | Where-Object { $_.Name -match "Prefetch|BAM|Doomsday|Meow|PSHunter" } # Simple heuristic
    
    if ($files) {
        $count = ($files | Measure-Object).Count
        $files | Remove-Item -Force -ErrorAction SilentlyContinue
        Write-Activity "Cleared $count temporary tool files."
        Set-UiStatus -Title "Cache Cleared" -Sub "Removed $count temporary files."
    } else {
        Write-Activity "No temporary files found."
        Set-UiStatus -Title "Clean" -Sub "No temporary files found."
    }
})

# --- STARTUP ---
Write-Activity "Nic Launcher initialized."
Set-UiStatus -Title "Ready" -Sub "Select a category to begin."

# Show Announcement (Simple popup logic similar to Tesla)
 $window.Add_ContentRendered({
    # Using a simple message box for the announcement to save space, or you can implement the full popup grid
    # For this merge, we'll keep it simple in the log.
    Write-Activity "Welcome to Nic Launcher!"
    Write-Activity "New tools available in Orbdiff and Spokwn categories."
})

 $window.ShowDialog() | Out-Null
