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
        <LinearGradientBrush x:Key="WinBg" StartPoint="0,0" EndPoint="1,1">
            <GradientStop Color="#05070B" Offset="0"/>
            <GradientStop Color="#09111B" Offset="0.5"/>
            <GradientStop Color="#071B27" Offset="1"/>
        </LinearGradientBrush>

        <LinearGradientBrush x:Key="SidebarBg" StartPoint="0,0" EndPoint="0,1">
            <GradientStop Color="#0B1118" Offset="0"/>
            <GradientStop Color="#0D1520" Offset="1"/>
        </LinearGradientBrush>

        <LinearGradientBrush x:Key="CardBg" StartPoint="0,0" EndPoint="1,1">
            <GradientStop Color="#101824" Offset="0"/>
            <GradientStop Color="#0B1017" Offset="1"/>
        </LinearGradientBrush>

        <LinearGradientBrush x:Key="LaunchBg" StartPoint="0,0" EndPoint="1,1">
            <GradientStop Color="#39E5FF" Offset="0"/>
            <GradientStop Color="#00A8D8" Offset="1"/>
        </LinearGradientBrush>

        <SolidColorBrush x:Key="BorderSoft" Color="#1C2A3C"/>

        <!-- Thin scrollbar -->
        <Style TargetType="ScrollBar">
            <Setter Property="Width" Value="3"/>
            <Setter Property="Background" Value="Transparent"/>
        </Style>

        <!-- Sidebar tool button -->
        <Style x:Key="SidebarBtn" TargetType="Button">
            <Setter Property="Background" Value="Transparent"/>
            <Setter Property="Foreground" Value="#8EA2B6"/>
            <Setter Property="FontSize" Value="13"/>
            <Setter Property="FontWeight" Value="Normal"/>
            <Setter Property="BorderThickness" Value="0"/>
            <Setter Property="Cursor" Value="Hand"/>
            <Setter Property="HorizontalContentAlignment" Value="Left"/>
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="Button">
                        <Border x:Name="Bg" Background="{TemplateBinding Background}"
                                CornerRadius="12" Margin="0,2" Padding="14,10">
                            <TextBlock Text="{TemplateBinding Content}" Foreground="{TemplateBinding Foreground}"
                                       FontSize="{TemplateBinding FontSize}" FontWeight="{TemplateBinding FontWeight}"
                                       TextWrapping="Wrap"/>
                        </Border>
                        <ControlTemplate.Triggers>
                            <Trigger Property="IsMouseOver" Value="True">
                                <Setter TargetName="Bg" Property="Background" Value="#0F1E2E"/>
                                <Setter Property="Foreground" Value="#C8DCF0"/>
                            </Trigger>
                        </ControlTemplate.Triggers>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
        </Style>

        <!-- Active sidebar button -->
        <Style x:Key="ActiveSidebarBtn" TargetType="Button" BasedOn="{StaticResource SidebarBtn}">
            <Setter Property="Background" Value="#0D2A3F"/>
            <Setter Property="Foreground" Value="#74E8FF"/>
            <Setter Property="FontWeight" Value="SemiBold"/>
        </Style>

        <!-- Chrome buttons (min/close) -->
        <Style x:Key="ChromeBtn" TargetType="Button">
            <Setter Property="Width" Value="32"/>
            <Setter Property="Height" Value="32"/>
            <Setter Property="Foreground" Value="#4A6070"/>
            <Setter Property="FontSize" Value="14"/>
            <Setter Property="Background" Value="#12202E"/>
            <Setter Property="BorderThickness" Value="0"/>
            <Setter Property="Cursor" Value="Hand"/>
            <Setter Property="Margin" Value="6,0,0,0"/>
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="Button">
                        <Border x:Name="Bg" Background="{TemplateBinding Background}" CornerRadius="10">
                            <ContentPresenter HorizontalAlignment="Center" VerticalAlignment="Center"/>
                        </Border>
                        <ControlTemplate.Triggers>
                            <Trigger Property="IsMouseOver" Value="True">
                                <Setter TargetName="Bg" Property="Background" Value="#1A3045"/>
                                <Setter Property="Foreground" Value="White"/>
                            </Trigger>
                        </ControlTemplate.Triggers>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
        </Style>

        <!-- Launch button -->
        <Style x:Key="LaunchBtn" TargetType="Button">
            <Setter Property="Foreground" Value="#030C12"/>
            <Setter Property="FontSize" Value="14"/>
            <Setter Property="FontWeight" Value="Bold"/>
            <Setter Property="Height" Value="46"/>
            <Setter Property="BorderThickness" Value="0"/>
            <Setter Property="Cursor" Value="Hand"/>
            <Setter Property="Background" Value="{StaticResource LaunchBg}"/>
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="Button">
                        <Border x:Name="Bg" Background="{TemplateBinding Background}" CornerRadius="14">
                            <ContentPresenter HorizontalAlignment="Center" VerticalAlignment="Center"/>
                        </Border>
                        <ControlTemplate.Triggers>
                            <Trigger Property="IsMouseOver" Value="True">
                                <Setter TargetName="Bg" Property="Opacity" Value="0.88"/>
                            </Trigger>
                            <Trigger Property="IsEnabled" Value="False">
                                <Setter TargetName="Bg" Property="Background" Value="#0F1C28"/>
                                <Setter Property="Foreground" Value="#2A4055"/>
                            </Trigger>
                        </ControlTemplate.Triggers>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
        </Style>

    </Window.Resources>

    <Border CornerRadius="22" Background="{StaticResource WinBg}" BorderBrush="#1A2838" BorderThickness="1" Margin="10">
        <Border.Effect>
            <DropShadowEffect BlurRadius="32" ShadowDepth="0" Opacity="0.55"/>
        </Border.Effect>
        <Grid>
            <Grid.RowDefinitions>
                <RowDefinition Height="58"/>
                <RowDefinition Height="*"/>
            </Grid.RowDefinitions>

            <!-- Ambient glows -->
            <Ellipse Width="500" Height="500" Fill="#1DDCFF" Opacity="0.05"
                     HorizontalAlignment="Left" VerticalAlignment="Top" Margin="-160,-160,0,0"
                     IsHitTestVisible="False"/>
            <Ellipse Width="380" Height="380" Fill="#0E86FF" Opacity="0.04"
                     HorizontalAlignment="Right" VerticalAlignment="Bottom" Margin="0,0,-100,-100"
                     IsHitTestVisible="False"/>

            <!-- Titlebar -->
            <Border Grid.Row="0" Background="#080E16" CornerRadius="22,22,0,0"
                    BorderBrush="#142030" BorderThickness="0,0,0,1">
                <Grid Margin="20,0,16,0">
                    <Grid.ColumnDefinitions>
                        <ColumnDefinition Width="Auto"/>
                        <ColumnDefinition Width="*"/>
                        <ColumnDefinition Width="Auto"/>
                    </Grid.ColumnDefinitions>

                    <!-- Logo + title -->
                    <StackPanel Orientation="Horizontal" VerticalAlignment="Center">
                        <Border Width="36" Height="36" CornerRadius="11"
                                Background="#0D1E2E" BorderBrush="#1E3D55" BorderThickness="1">
                            <TextBlock Text="T" FontSize="18" FontWeight="Bold"
                                       Foreground="#74E8FF" HorizontalAlignment="Center" VerticalAlignment="Center"/>
                        </Border>
                        <StackPanel Margin="12,0,0,0" VerticalAlignment="Center">
                            <TextBlock Text="Tool Launcher" FontSize="16" FontWeight="SemiBold" Foreground="White"/>
                            <TextBlock Text="Screenshare Toolkit" FontSize="11" Foreground="#4A6070"/>
                        </StackPanel>
                    </StackPanel>

                    <!-- Chrome buttons -->
                    <StackPanel Grid.Column="2" Orientation="Horizontal" VerticalAlignment="Center">
                        <Button Name="MinBtn" Content="—" Style="{StaticResource ChromeBtn}"/>
                        <Button Name="CloseBtn" Content="✕" Style="{StaticResource ChromeBtn}"/>
                    </StackPanel>
                </Grid>
            </Border>

            <!-- Body -->
            <Grid Grid.Row="1" Margin="16,14,16,16">
                <Grid.ColumnDefinitions>
                    <ColumnDefinition Width="240"/>
                    <ColumnDefinition Width="14"/>
                    <ColumnDefinition Width="*"/>
                </Grid.ColumnDefinitions>

                <!-- Sidebar -->
                <Border Grid.Column="0" Background="{StaticResource SidebarBg}"
                        CornerRadius="18" BorderBrush="#192537" BorderThickness="1">
                    <DockPanel Margin="12,16,12,12">

                        <!-- Header -->
                        <StackPanel DockPanel.Dock="Top" Margin="6,0,6,14">
                            <TextBlock Text="Control Panel" FontSize="20" FontWeight="SemiBold" Foreground="White"/>
                            <TextBlock Text="Select a tool to launch." FontSize="12"
                                       Foreground="#4A6070" Margin="0,5,0,0" TextWrapping="Wrap"/>
                        </StackPanel>

                        <!-- System Apps button pinned at bottom -->
                        <Border DockPanel.Dock="Bottom" Margin="0,8,0,0">
                            <Button Name="ExtrasBtn" Style="{StaticResource SidebarBtn}"
                                    Content="⚙  System Apps" Foreground="#2E4A60"
                                    HorizontalContentAlignment="Left"/>
                        </Border>

                        <!-- Scrollable tool list -->
                        <ScrollViewer VerticalScrollBarVisibility="Auto" HorizontalScrollBarVisibility="Disabled">
                            <StackPanel>
                                <TextBlock Text="SCRIPTS" FontSize="10" FontWeight="Bold"
                                           Foreground="#1E3448" Margin="14,4,0,6"/>
                                <StackPanel Name="SidebarList"/>
                                <Rectangle Height="1" Fill="#0F1E2C" Margin="8,10,8,8"/>
                                <TextBlock Text="APPS" FontSize="10" FontWeight="Bold"
                                           Foreground="#1E3448" Margin="14,0,0,6"/>
                                <StackPanel Name="ExeList"/>
                            </StackPanel>
                        </ScrollViewer>
                    </DockPanel>
                </Border>

                <!-- Main panel -->
                <Grid Grid.Column="2">
                    <Grid.RowDefinitions>
                        <RowDefinition Height="Auto"/>
                        <RowDefinition Height="14"/>
                        <RowDefinition Height="*"/>
                        <RowDefinition Height="14"/>
                        <RowDefinition Height="Auto"/>
                    </Grid.RowDefinitions>

                    <!-- Status card -->
                    <Border Grid.Row="0" Background="{StaticResource CardBg}"
                            CornerRadius="18" BorderBrush="#1C2A3C" BorderThickness="1" Padding="22,20">
                        <Grid>
                            <Grid.ColumnDefinitions>
                                <ColumnDefinition Width="*"/>
                                <ColumnDefinition Width="Auto"/>
                            </Grid.ColumnDefinitions>
                            <StackPanel>
                                <TextBlock Name="DisplayTitle" Text="Select a Tool"
                                           FontSize="26" FontWeight="SemiBold" Foreground="White"/>
                                <TextBlock Name="DisplayDesc"
                                           Text="Choose a script or app from the sidebar to get started."
                                           FontSize="13" Foreground="#4E6880" Margin="0,8,0,0"
                                           TextWrapping="Wrap" MaxWidth="480"/>
                            </StackPanel>

                            <!-- Status chip -->
                            <Border Grid.Column="1" Width="100" Height="36" CornerRadius="18"
                                    Background="#0A1520" BorderBrush="#1E3448" BorderThickness="1"
                                    VerticalAlignment="Top">
                                <TextBlock Name="StateChip" Text="IDLE"
                                           HorizontalAlignment="Center" VerticalAlignment="Center"
                                           Foreground="#74E8FF" FontSize="12" FontWeight="Bold"/>
                            </Border>
                        </Grid>
                    </Border>

                    <!-- Log card -->
                    <Border Grid.Row="2" Background="{StaticResource CardBg}"
                            CornerRadius="18" BorderBrush="#1C2A3C" BorderThickness="1" Padding="22">
                        <DockPanel>
                            <TextBlock DockPanel.Dock="Top" Text="Activity Log"
                                       FontSize="12" Foreground="#2A4055" Margin="0,0,0,12"/>
                            <ScrollViewer VerticalScrollBarVisibility="Auto">
                                <TextBlock Name="LogPreview" Text="No activity yet."
                                           Foreground="#2A4A60" FontSize="12"
                                           FontFamily="Consolas" TextWrapping="Wrap"/>
                            </ScrollViewer>
                        </DockPanel>
                    </Border>

                    <!-- Launch button -->
                    <Border Grid.Row="4" Background="{StaticResource CardBg}"
                            CornerRadius="18" BorderBrush="#1C2A3C" BorderThickness="1" Padding="22,16">
                        <Grid>
                            <Grid.ColumnDefinitions>
                                <ColumnDefinition Width="*"/>
                                <ColumnDefinition Width="Auto"/>
                            </Grid.ColumnDefinitions>
                            <StackPanel VerticalAlignment="Center">
                                <TextBlock Name="ReadyLabel" Text="No tool selected"
                                           Foreground="#2A4055" FontSize="12"/>
                            </StackPanel>
                            <Button Grid.Column="1" Name="MainLaunchBtn" Content="LAUNCH"
                                    Style="{StaticResource LaunchBtn}" Width="160"
                                    IsEnabled="False"/>
                        </Grid>
                    </Border>
                </Grid>
            </Grid>
        </Grid>
    </Border>
</Window>
"@

[xml]$extrasXaml = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="System Apps" Width="260" Height="400"
        WindowStartupLocation="CenterScreen"
        WindowStyle="None" ResizeMode="NoResize"
        AllowsTransparency="True" Background="Transparent">
    <Border CornerRadius="18" BorderBrush="#1A2838" BorderThickness="1" Margin="8">
        <Border.Background>
            <LinearGradientBrush StartPoint="0,0" EndPoint="0,1">
                <GradientStop Color="#0B1118" Offset="0"/>
                <GradientStop Color="#0D1520" Offset="1"/>
            </LinearGradientBrush>
        </Border.Background>
        <Border.Effect>
            <DropShadowEffect BlurRadius="24" ShadowDepth="0" Opacity="0.5"/>
        </Border.Effect>
        <Grid Margin="16">
            <Grid.RowDefinitions>
                <RowDefinition Height="Auto"/>
                <RowDefinition Height="*"/>
                <RowDefinition Height="Auto"/>
            </Grid.RowDefinitions>
            <TextBlock Text="SYSTEM APPS" FontSize="10" FontWeight="Bold"
                       Foreground="#1E3448" Margin="0,0,0,14"/>
            <ScrollViewer Grid.Row="1" VerticalScrollBarVisibility="Auto">
                <StackPanel Name="ExtrasList"/>
            </ScrollViewer>
            <Button Grid.Row="2" Name="CloseExtrasBtn" Content="CLOSE"
                    Height="34" Margin="0,14,0,0" Cursor="Hand"
                    FontSize="12" FontWeight="SemiBold" BorderThickness="0">
                <Button.Background>
                    <SolidColorBrush Color="#0F1C28"/>
                </Button.Background>
                <Button.Foreground>
                    <SolidColorBrush Color="#2A4055"/>
                </Button.Foreground>
                <Button.Template>
                    <ControlTemplate TargetType="Button">
                        <Border Background="{TemplateBinding Background}" CornerRadius="10">
                            <ContentPresenter HorizontalAlignment="Center" VerticalAlignment="Center"/>
                        </Border>
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
        @{Name="Meow Mod Analyzer";   Desc="Advanced Minecraft mod analysis utility.";         Cmd="powershell -ExecutionPolicy Bypass -Command `"Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/MeowTonynoh/MeowModAnalyzer/main/MeowModAnalyzer.ps1')`""},
        @{Name="Macro Detector";      Desc="Detects mouse macros and autoclickers.";           Cmd="powershell -ExecutionPolicy Bypass -Command `"Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/Nickk196/MacroDetector/refs/heads/main/MacroDetector.ps1')`""},
        @{Name="Service Checker";     Desc="Analyzes running system services for anomalies.";  Cmd="powershell -ExecutionPolicy Bypass -Command `"Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/praiselily/lilith-ps/refs/heads/main/Services.ps1')`""},
        @{Name="Schedule Tasks";      Desc="Lists and checks signed scheduled tasks.";         Cmd="powershell -ExecutionPolicy Bypass -Command `"Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/praiselily/lilith-ps/refs/heads/main/Signed-Scheduled-Tasks')`""},
        @{Name="Faker Detection";     Desc="Identifies VPN and hotspot usage.";                Cmd="powershell -ExecutionPolicy Bypass -Command `"Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/praiselily/WeHateFakers/refs/heads/main/HotspotLogs.ps1')`""},
        @{Name="Directory Scanner";   Desc="Scans common directories for specific files.";     Cmd="powershell -ExecutionPolicy Bypass -Command `"Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/praiselily/lilith-ps/refs/heads/main/CommonDirectories.ps1')`""},
        @{Name="NicTool Downloader";  Desc="Downloads SSTool, System Informer and utilities."; Cmd="CUSTOM_NIC_DOWNLOADER"},
        @{Name="JAR Scanner";         Desc="Scans JAR files for malicious content.";           Cmd="powershell -ExecutionPolicy Bypass -Command `"Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/NoDiff-del/JARParser/refs/heads/main/JARParser.ps1')`""},
        @{Name="Alt Detector";        Desc="Identifies alternative accounts and identifiers."; Cmd="powershell -ExecutionPolicy Bypass -Command `"Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/Enr1c0o/Powershell-Scripts/refs/heads/main/Alt-Detector.ps1')`""},
        @{Name="Dqrkis Finder";       Desc="Locates Dqrkis in active sessions.";              Cmd="powershell -ExecutionPolicy Bypass -Command `"Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/cheesecatlol/DQRKIS-FUCKER/refs/heads/main/DqrkisFucker.ps1')`""},
        @{Name="Signature";           Desc="Signature checker for file verification.";         Cmd="powershell -ExecutionPolicy Bypass -Command `"Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/bacanoicua/Screenshare/main/RedLotusSignatures.ps1')`""},
        @{Name="BAM";                 Desc="Background Activity Monitoring.";                  Cmd="powershell -ExecutionPolicy Bypass -Command `"Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/PureIntent/ScreenShare/main/RedLotusBam.ps1')`""}
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
            $btn.Foreground                 = [System.Windows.Media.SolidColorBrush][System.Windows.Media.Color]::FromRgb(0x4A,0x60,0x70)
            $btn.Margin                     = "0,3"
            $btn.Height                     = 34
            $btn.FontFamily                 = "Segoe UI"
            $btn.FontSize                   = 13
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
            $btn.Add_MouseLeave({ $this.Foreground = [System.Windows.Media.SolidColorBrush][System.Windows.Media.Color]::FromRgb(0x4A,0x60,0x70) })
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
