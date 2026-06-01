Add-Type -AssemblyName PresentationFramework
Add-Type -AssemblyName System.Windows.Forms

[xml]$xaml = @"
<Window
    xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
    xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
    Title="Tool Launcher"
    Width="1000"
    Height="650"
    WindowStartupLocation="CenterScreen"
    ResizeMode="NoResize"
    WindowStyle="None"
    AllowsTransparency="True"
    Background="Transparent"
    FontFamily="Segoe UI">

    <Window.Resources>
        <!-- Colors -->
        <SolidColorBrush x:Key="WinBg" Color="#0F0F0F"/>
        <SolidColorBrush x:Key="SidebarBg" Color="#141414"/>
        <SolidColorBrush x:Key="CardBg" Color="#1A1A1A"/>
        <SolidColorBrush x:Key="BorderBrush" Color="#333333"/>
        <SolidColorBrush x:Key="AccentRed" Color="#D92525"/>

        <!-- Category Button (Sidebar) -->
        <Style x:Key="CatBtn" TargetType="Button">
            <Setter Property="Background" Value="Transparent"/>
            <Setter Property="Foreground" Value="#888"/>
            <Setter Property="FontSize" Value="13"/>
            <Setter Property="FontWeight" Value="Normal"/>
            <Setter Property="BorderThickness" Value="0"/>
            <Setter Property="Cursor" Value="Hand"/>
            <Setter Property="HorizontalContentAlignment" Value="Left"/>
            <Setter Property="Height" Value="35"/>
            <Setter Property="Padding" Value="15,0"/>
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="Button">
                        <Border x:Name="Bg" Background="{TemplateBinding Background}">
                            <ContentPresenter HorizontalAlignment="{TemplateBinding HorizontalContentAlignment}" VerticalAlignment="Center"/>
                        </Border>
                        <ControlTemplate.Triggers>
                            <Trigger Property="IsMouseOver" Value="True">
                                <Setter Property="Foreground" Value="White"/>
                                <Setter Property="Background" Value="#222"/>
                            </Trigger>
                        </ControlTemplate.Triggers>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
        </Style>

        <!-- Active Category Button -->
        <Style x:Key="ActiveCatBtn" TargetType="Button" BasedOn="{StaticResource CatBtn}">
            <Setter Property="Foreground" Value="White"/>
            <Setter Property="FontWeight" Value="Bold"/>
            <Setter Property="Background" Value="#D92525"/> <!-- Red Active -->
        </Style>

        <!-- Tool Button (Main Area) -->
        <Style x:Key="ToolBtn" TargetType="Button">
            <Setter Property="Background" Value="#252526"/>
            <Setter Property="Foreground" Value="#CCC"/>
            <Setter Property="FontSize" Value="13"/>
            <Setter Property="BorderThickness" Value="0"/>
            <Setter Property="Cursor" Value="Hand"/>
            <Setter Property="Height" Value="40"/>
            <Setter Property="Margin" Value="0,0,0,5"/>
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="Button">
                        <Border x:Name="Bg" Background="{TemplateBinding Background}" CornerRadius="4" Padding="15,0">
                            <Grid>
                                <TextBlock Text="{TemplateBinding Content}" HorizontalAlignment="Left" VerticalAlignment="Center" Foreground="{TemplateBinding Foreground}"/>
                            </Grid>
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

        <Style TargetType="ScrollBar">
            <Setter Property="Width" Value="5"/>
            <Setter Property="Background" Value="Transparent"/>
            <Setter Property="Foreground" Value="#444"/>
        </Style>
    </Window.Resources>

    <Border CornerRadius="8" Background="{StaticResource WinBg}" BorderBrush="{StaticResource BorderBrush}" BorderThickness="1" Margin="10">
        <Grid>
            <Grid.RowDefinitions>
                <RowDefinition Height="40"/>
                <RowDefinition Height="*"/>
            </Grid.RowDefinitions>

            <!-- Header -->
            <Border Grid.Row="0" Background="#141414" CornerRadius="8,8,0,0" BorderBrush="{StaticResource BorderBrush}" BorderThickness="0,0,0,1">
                <Grid Margin="15,0,10,0">
                    <TextBlock Text="OrbDiff" FontSize="14" FontWeight="Bold" Foreground="#D92525" VerticalAlignment="Center"/>
                    <StackPanel Orientation="Horizontal" HorizontalAlignment="Right">
                        <Button Name="MinBtn" Content="—" Foreground="#888" Background="Transparent" BorderThickness="0" Cursor="Hand" Width="30" Margin="5,0"/>
                        <Button Name="CloseBtn" Content="✕" Foreground="#888" Background="Transparent" BorderThickness="0" Cursor="Hand" Width="30" Margin="5,0"/>
                    </StackPanel>
                </Grid>
            </Border>

            <!-- Body -->
            <Grid Grid.Row="1">
                <Grid.ColumnDefinitions>
                    <ColumnDefinition Width="180"/>
                    <ColumnDefinition Width="1"/>
                    <ColumnDefinition Width="*"/>
                </Grid.ColumnDefinitions>

                <Rectangle Grid.Column="1" Fill="#333" Width="1"/>

                <!-- Sidebar Categories -->
                <Border Grid.Column="0" Background="{StaticResource SidebarBg}">
                    <StackPanel Name="CategoryList" Margin="0,10,0,0"/>
                </Border>

                <!-- Main Content -->
                <Grid Grid.Column="2" Margin="20,20,20,20">
                    <Grid.RowDefinitions>
                        <RowDefinition Height="Auto"/>
                        <RowDefinition Height="10"/>
                        <RowDefinition Height="*"/>
                        <RowDefinition Height="Auto"/>
                    </Grid.RowDefinitions>

                    <!-- Info Header -->
                    <Border Grid.Row="0" Background="{StaticResource CardBg}" BorderBrush="{StaticResource BorderBrush}" BorderThickness="1" Padding="15" CornerRadius="4">
                        <Grid>
                            <TextBlock Name="DisplayTitle" Text="Select a Tool" FontSize="18" FontWeight="Bold" Foreground="White" VerticalAlignment="Center"/>
                            <TextBlock Name="DisplayCat" Text="CATEGORY" FontSize="10" Foreground="#D92525" VerticalAlignment="Center" Margin="0,0,15,0" HorizontalAlignment="Right"/>
                        </Grid>
                    </Border>

                    <!-- Tool List -->
                    <ScrollViewer Grid.Row="2" VerticalScrollBarVisibility="Auto">
                        <StackPanel Name="ToolContainer"/>
                    </ScrollViewer>

                    <!-- Launch Area -->
                    <Border Grid.Row="3" Background="{StaticResource CardBg}" BorderBrush="{StaticResource BorderBrush}" BorderThickness="1" Padding="15,10" Margin="0,10,0,0" CornerRadius="4">
                        <Grid>
                            <TextBlock Name="ReadyLabel" Text="No tool selected" Foreground="#666" FontSize="12" VerticalAlignment="Center"/>
                            <Button Name="MainLaunchBtn" Content="LAUNCH" Background="#D92525" Foreground="White" FontWeight="Bold" Padding="20,5" BorderThickness="0" Cursor="Hand" HorizontalAlignment="Right" CornerRadius="4" IsEnabled="False">
                                <Button.Template>
                                    <ControlTemplate TargetType="Button">
                                        <Border Background="{TemplateBinding Background}" CornerRadius="4" Padding="{TemplateBinding Padding}">
                                            <ContentPresenter HorizontalAlignment="Center" VerticalAlignment="Center"/>
                                        </Border>
                                        <ControlTemplate.Triggers>
                                            <Trigger Property="IsMouseOver" Value="True">
                                                <Setter Property="Background" Value="#FF3333"/>
                                            </Trigger>
                                        </ControlTemplate.Triggers>
                                    </ControlTemplate>
                                </Button.Template>
                            </Button>
                        </Grid>
                    </Border>
                </Grid>
            </Grid>
        </Grid>
    </Border>
</Window>
"@

try {
    $reader = New-Object System.Xml.XmlNodeReader $xaml
    $window = [Windows.Markup.XamlReader]::Load($reader)

    $CategoryList = $window.FindName("CategoryList")
    $ToolContainer = $window.FindName("ToolContainer")
    $DisplayTitle = $window.FindName("DisplayTitle")
    $DisplayCat = $window.FindName("DisplayCat")
    $ReadyLabel = $window.FindName("ReadyLabel")
    $MainLaunchBtn = $window.FindName("MainLaunchBtn")
    $MinBtn = $window.FindName("MinBtn")
    $CloseBtn = $window.FindName("CloseBtn")

    $global:CurrentCmd = $null

    # --- Tool Data ---
    $tools = @(
        # RedLotus
        @{Name="RedLotus BAM"; Desc="Background Activity Monitor"; Category="RedLotus"; Cmd="powershell -ExecutionPolicy Bypass -Command `"Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/PureIntent/ScreenShare/main/RedLotusBam.ps1')`""},
        @{Name="RedLotus Sig"; Desc="File Signature Checker"; Category="RedLotus"; Cmd="powershell -ExecutionPolicy Bypass -Command `"Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/bacanoicua/Screenshare/main/RedLotusSignatures.ps1')`""},

        # Tonynoh
        @{Name="Meow Mod Analyzer"; Desc="Minecraft Mod Analysis"; Category="Tonynoh"; Cmd="powershell -ExecutionPolicy Bypass -Command `"Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/MeowTonynoh/MeowModAnalyzer/main/MeowModAnalyzer.ps1')`""},
        @{Name="Meow Doomsday"; Desc="Doomsday Analysis Tool"; Category="Tonynoh"; Cmd="EXE:https://github.com/MeowTonynoh/MeowDoomsdayFucker/releases/download/V.1.2/MeowDoomsdayFucker.exe"},
        @{Name="Meow Imports"; Desc="Executable Import Checker"; Category="Tonynoh"; Cmd="EXE:https://github.com/MeowTonynoh/MeowImportsChecker/releases/download/MeowImportsChecker/MeowImportsChecker.exe"},
        @{Name="Meow Resolver"; Desc="DNS/Address Resolver"; Category="Tonynoh"; Cmd="EXE:https://github.com/MeowTonynoh/MeowResolver/releases/download/MeowResolver/MeowResolver.exe"},

        # Praiselily
        @{Name="Service Checker"; Desc="Analyze System Services"; Category="Praiselily"; Cmd="powershell -ExecutionPolicy Bypass -Command `"Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/praiselily/lilith-ps/refs/heads/main/Services.ps1')`""},
        @{Name="Schedule Tasks"; Desc="List Signed Tasks"; Category="Praiselily"; Cmd="powershell -ExecutionPolicy Bypass -Command `"Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/praiselily/lilith-ps/refs/heads/main/Signed-Scheduled-Tasks')`""},
        @{Name="Common Dirs"; Desc="Scan Common Directories"; Category="Praiselily"; Cmd="powershell -ExecutionPolicy Bypass -Command `"Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/praiselily/lilith-ps/refs/heads/main/CommonDirectories.ps1')`""},
        @{Name="Faker Detector"; Desc="VPN/Hotspot Detection"; Category="Praiselily"; Cmd="powershell -ExecutionPolicy Bypass -Command `"Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/praiselily/WeHateFakers/refs/heads/main/HotspotLogs.ps1')`""},

        # Orbdiff
        @{Name="SSTool"; Desc="Screenshot Tool"; Category="Orbdiff"; Cmd="EXE:https://github.com/Orbdiff/SSTool/releases/download/yay/SSTool.exe"},

        # Spokwn
        @{Name="Macro Detector"; Desc="Mouse/AutoClicker Detection"; Category="Spokwn"; Cmd="powershell -ExecutionPolicy Bypass -Command `"Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/Nickk196/MacroDetector/refs/heads/main/MacroDetector.ps1')`""},
        @{Name="JAR Scanner"; Desc="Malicious JAR Content Scan"; Category="Spokwn"; Cmd="powershell -ExecutionPolicy Bypass -Command `"Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/NoDiff-del/JARParser/refs/heads/main/JARParser.ps1')`""},

        # Others
        @{Name="Alt Detector"; Desc="Identify Alt Accounts"; Category="Others"; Cmd="powershell -ExecutionPolicy Bypass -Command `"Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/Enr1c0o/Powershell-Scripts/refs/heads/main/Alt-Detector.ps1')`""},
        @{Name="Prefetch View"; Desc="Nirsoft Prefetch Viewer"; Category="Others"; Cmd="EXE:https://www.nirsoft.net/utils/winprefetchview.zip"},
        @{Name="System Informer"; Desc="Process Manager"; Category="Others"; Cmd="WEB:https://github.com/winsiderss/systeminformer/releases"},

        # Webs
        @{Name="Google"; Desc="Search Web"; Category="Webs"; Cmd="WEB:https://www.google.com"},
        @{Name="Bing"; Desc="Search Web"; Category="Webs"; Cmd="WEB:https://www.bing.com"},
        @{Name="Virustotal"; Desc="Scan Files"; Category="Webs"; Cmd="WEB:https://www.virustotal.com"},
        @{Name="Hybrid Analysis"; Desc="Malware Analysis"; Category="Webs"; Cmd="WEB:https://www.hybrid-analysis.com"}
    )

    $categories = @("RedLotus", "Tonynoh", "Praiselily", "Orbdiff", "Spokwn", "Others", "Webs")

    # --- Functions ---

    function Clear-ToolSelection {
        foreach ($c in $ToolContainer.Children) {
            if ($c -is [System.Windows.Controls.Button]) { 
                $c.Background = "#252526" 
                $c.Foreground = "#CCC"
            }
        }
        $global:CurrentCmd = $null
        $MainLaunchBtn.IsEnabled = $false
        $DisplayTitle.Text = "Select a Tool"
        $ReadyLabel.Text = "No tool selected"
    }

    function Show-Category {
        param($catName)
        
        # Update Sidebar Styles
        foreach ($c in $CategoryList.Children) {
            if ($c -is [System.Windows.Controls.Button]) { 
                if ($c.Content -eq $catName) { $c.Style = $window.FindResource("ActiveCatBtn") }
                else { $c.Style = $window.FindResource("CatBtn") }
            }
        }

        # Clear Main View
        $ToolContainer.Children.Clear()
        $DisplayCat.Text = $catName.ToUpper()
        Clear-ToolSelection

        # Populate Tools
        $catTools = $tools | Where-Object { $_.Category -eq $catName }
        
        foreach ($t in $catTools) {
            $btn = New-Object System.Windows.Controls.Button
            $btn.Content = $t.Name
            $btn.Style = $window.FindResource("ToolBtn")
            
            # Add metadata
            $btn | Add-Member -NotePropertyName "CmdData" -Value $t.Cmd
            $btn | Add-Member -NotePropertyName "DescData" -Value $t.Desc

            $btn.Add_Click({
                param($sender, $e)
                Clear-ToolSelection
                
                # Highlight selected button
                $sender.Background = "#D92525"
                $sender.Foreground = "White"

                $global:CurrentCmd = $sender.CmdData
                $DisplayTitle.Text = $sender.Content
                $ReadyLabel.Text = $sender.DescData
                $MainLaunchBtn.IsEnabled = $true
            }.GetNewClosure())

            $ToolContainer.Children.Add($btn) | Out-Null
        }
    }

    # --- Init Sidebar ---
    foreach ($cat in $categories) {
        $btn = New-Object System.Windows.Controls.Button
        $btn.Content = $cat
        $btn.Style = $window.FindResource("CatBtn")
        
        $btn.Add_Click({
            param($sender, $e)
            Show-Category -catName $sender.Content
        }.GetNewClosure())

        $CategoryList.Children.Add($btn) | Out-Null
    }

    # --- Select Default ---
    Show-Category -catName "RedLotus"

    # --- Launch Logic ---
    $MainLaunchBtn.Add_Click({
        if (-not $global:CurrentCmd) { return }
        
        try {
            if ($global:CurrentCmd -like "WEB:*") {
                Start-Process $global:CurrentCmd.Substring(4)
            }
            elseif ($global:CurrentCmd -like "EXE:*") {
                $url = $global:CurrentCmd.Substring(4)
                $file = Split-Path $url -Leaf
                $path = Join-Path $env:TEMP $file
                Invoke-WebRequest -Uri $url -OutFile $path -UseBasicParsing
                Start-Process $path
            }
            else {
                # Run PS Script
                $tempFile = Join-Path $env:TEMP ([Guid]::NewGuid().ToString() + ".ps1")
                "Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass -Force`r`n$global:CurrentCmd" | Out-File $tempFile -Encoding UTF8
                Start-Process "cmd.exe" -ArgumentList "/k", "powershell -NoExit -ExecutionPolicy Bypass -File `"$tempFile`""
            }
        }
        catch {
            [System.Windows.MessageBox]::Show("Error: " + $_.Exception.Message)
        }
    })

    # Window Controls
    $MinBtn.Add_Click({ $window.WindowState = [Windows.WindowState]::Minimized })
    $CloseBtn.Add_Click({ $window.Close() })
    $window.Add_MouseLeftButtonDown({ if ($_.OriginalSource -isnot [System.Windows.Controls.Button]) { $window.DragMove() } })

    $window.ShowDialog() | Out-Null

} catch {
    Write-Error $_.Exception.Message
}
