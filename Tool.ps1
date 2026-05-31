Add-Type -AssemblyName PresentationFramework
Add-Type -AssemblyName System.Windows.Forms

# --- XAML GUI Definition (Sidebar + Dashboard Style) ---
[xml]$xaml = @"
<Window 
    xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
    xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
    Title="Obsidian Dashboard"
    Width="1000"
    Height="650"
    WindowStartupLocation="CenterScreen"
    WindowStyle="None"
    AllowsTransparency="True"
    Background="Transparent"
    ResizeMode="NoResize"
    Topmost="False">

    <Window.Resources>
        <!-- Sidebar Button Style -->
        <Style x:Key="SidebarButton" TargetType="Button">
            <Setter Property="Background" Value="Transparent"/>
            <Setter Property="Foreground" Value="#a0a0a0"/>
            <Setter Property="FontFamily" Value="Segoe UI"/>
            <Setter Property="FontSize" Value="14"/>
            <Setter Property="FontWeight" Value="Normal"/>
            <Setter Property="BorderThickness" Value="0"/>
            <Setter Property="HorizontalContentAlignment" Value="Left"/>
            <Setter Property="Padding" Value="20,15"/>
            <Setter Property="Cursor" Value="Hand"/>
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="Button">
                        <Border Background="{TemplateBinding Background}" Padding="{TemplateBinding Padding}">
                            <ContentPresenter/>
                        </Border>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
            <Style.Triggers>
                <Trigger Property="IsMouseOver" Value="True">
                    <Setter Property="Background" Value="#22ffffff"/>
                    <Setter Property="Foreground" Value="White"/>
                </Trigger>
            </Style.Triggers>
        </Style>

        <!-- Active Sidebar Button Style (Applied via code) -->
        <Style x:Key="ActiveSidebarButton" TargetType="Button" BasedOn="{StaticResource SidebarButton}">
            <Setter Property="Background" Value="#e94560"/>
            <Setter Property="Foreground" Value="White"/>
            <Setter Property="FontWeight" Value="SemiBold"/>
        </Style>
        
        <!-- Big Launch Button Style -->
        <Style x:Key="LaunchButton" TargetType="Button">
            <Setter Property="Background" Value="#e94560"/>
            <Setter Property="Foreground" Value="White"/>
            <Setter Property="FontFamily" Value="Segoe UI"/>
            <Setter Property="FontSize" Value="16"/>
            <Setter Property="FontWeight" Value="Bold"/>
            <Setter Property="BorderThickness" Value="0"/>
            <Setter Property="Cursor" Value="Hand"/>
            <Setter Property="Height" Value="50"/>
            <Setter Property="Width" Value="200"/>
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="Button">
                        <Border Background="{TemplateBinding Background}" CornerRadius="25">
                            <Border.Effect>
                                <DropShadowEffect Color="#e94560" BlurRadius="10" ShadowDepth="0" Opacity="0.4"/>
                            </Border.Effect>
                            <ContentPresenter HorizontalAlignment="Center" VerticalAlignment="Center"/>
                        </Border>
                        <ControlTemplate.Triggers>
                            <Trigger Property="IsMouseOver" Value="True">
                                <Setter Property="Background" Value="#ff5e78"/>
                                <Setter Property="RenderTransform">
                                    <Setter.Value>
                                        <ScaleTransform ScaleX="1.05" ScaleY="1.05"/>
                                    </Setter.Value>
                                </Setter>
                            </Trigger>
                        </ControlTemplate.Triggers>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
        </Style>
    </Window.Resources>

    <Grid Margin="10">
        <!-- Main Border -->
        <Border Background="#DD1a1a2e" CornerRadius="15" BorderBrush="#e94560" BorderThickness="1">
            <Grid>
                <Grid.ColumnDefinitions>
                    <ColumnDefinition Width="220"/> <!-- Sidebar -->
                    <ColumnDefinition Width="*"/>     <!-- Content -->
                </Grid.ColumnDefinitions>

                <!-- Sidebar (Left) -->
                <Border Grid.Column="0" Background="#0f0f1a" CornerRadius="15,0,0,15" BorderBrush="#2a2a3d" BorderThickness="0,0,1,0">
                    <StackPanel>
                        <!-- Logo Area -->
                        <StackPanel Margin="20,30,20,20">
                            <Border Width="50" Height="50" Background="#e94560" CornerRadius="25" HorizontalAlignment="Left">
                                <TextBlock Text="O" Foreground="White" FontSize="30" FontWeight="Bold" HorizontalAlignment="Center" VerticalAlignment="Center"/>
                            </Border>
                            <TextBlock Text="OBSIDIAN" Foreground="White" FontSize="18" FontWeight="SemiBold" Margin="0,10,0,0" FontFamily="Segoe UI"/>
                            <TextBlock Text="Launcher" Foreground="#666" FontSize="12" Margin="0,0,0,5" FontFamily="Segoe UI"/>
                        </StackPanel>

                        <!-- Tool List Buttons -->
                        <ScrollViewer VerticalScrollBarVisibility="Auto">
                            <StackPanel Name="SidebarList">
                                <!-- Buttons are generated/controlled by PowerShell -->
                            </StackPanel>
                        </ScrollViewer>
                        
                        <!-- Footer in Sidebar -->
                        <TextBlock Text="v2.0 Stable" Foreground="#444" FontSize="10" HorizontalAlignment="Center" Margin="0,20,0,20"/>
                    </StackPanel>
                </Border>

                <!-- Dashboard (Right) -->
                <Grid Grid.Column="1" Margin="40">
                    <Grid.RowDefinitions>
                        <RowDefinition Height="Auto"/> <!-- Header -->
                        <RowDefinition Height="*"/>     <!-- Info Display -->
                        <RowDefinition Height="Auto"/> <!-- Action Area -->
                    </Grid.RowDefinitions>

                    <!-- Close Button (Absolute Position) -->
                    <Button Content="✕" Width="30" Height="30" Background="Transparent" Foreground="#666" FontSize="16" BorderThickness="0" Cursor="Hand" HorizontalAlignment="Right" VerticalAlignment="Top" Name="CloseBtn" Margin="0,-10,0,0"/>
                    <Button Content="−" Width="30" Height="30" Background="Transparent" Foreground="#666" FontSize="18" BorderThickness="0" Cursor="Hand" HorizontalAlignment="Right" VerticalAlignment="Top" Name="MinBtn" Margin="0,-10,35,0"/>

                    <!-- Tool Display Info -->
                    <StackPanel Grid.Row="1" VerticalAlignment="Center">
                        <TextBlock Text="SELECT A TOOL" Foreground="#e94560" FontSize="14" FontWeight="Bold"/>
                        
                        <TextBlock Name="DisplayTitle" Text="Welcome" FontSize="48" FontWeight="Light" Foreground="White" Margin="0,10,0,10" FontFamily="Segoe UI">
                            <TextBlock.Effect>
                                <DropShadowEffect Color="#e94560" BlurRadius="10" ShadowDepth="0" Opacity="0.3"/>
                            </TextBlock.Effect>
                        </TextBlock>
                        
                        <TextBlock Name="DisplayDesc" Text="Select a module from the sidebar to view details and execute." FontSize="16" Foreground="#8892b0" Width="500" TextWrapping="Wrap" Margin="0,0,0,30"/>
                    </StackPanel>

                    <!-- Launch Button -->
                    <StackPanel Grid.Row="2" HorizontalAlignment="Left" Margin="0,0,0,40">
                        <Button Name="MainLaunchBtn" Content="LAUNCH TOOL" Style="{StaticResource LaunchButton}" IsEnabled="False" Opacity="0.5"/>
                        <TextBlock Name="LogPreview" Text="Ready..." Foreground="#444" FontSize="11" Margin="10,10,0,0" FontFamily="Consolas"/>
                    </StackPanel>

                </Grid>
            </Grid>
        </Border>
    </Grid>
</Window>
"@

# --- Backend Logic ---

try {
    # Parse XAML
    $reader = (New-Object System.Xml.XmlNodeReader $xaml) 
    $window = [Windows.Markup.XamlReader]::Load($reader)

    # Find Elements
    $SidebarList = $window.FindName("SidebarList")
    $DisplayTitle = $window.FindName("DisplayTitle")
    $DisplayDesc = $window.FindName("DisplayDesc")
    $MainLaunchBtn = $window.FindName("MainLaunchBtn")
    $LogPreview = $window.FindName("LogPreview")
    $CloseBtn = $window.FindName("CloseBtn")

    # Tool Data
    $tools = @(
        @{Name="Meow Mod Analyzer"; Desc="Advanced Minecraft mod analysis utility."; Cmd="powershell -ExecutionPolicy Bypass -Command `"Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/MeowTonynoh/MeowModAnalyzer/main/MeowModAnalyzer.ps1')`""},
        @{Name="Macro Detector"; Desc="Detects mouse macros and autoclickers."; Cmd="powershell -ExecutionPolicy Bypass -Command `"Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/Nickk196/MacroDetector/refs/heads/main/MacroDetector.ps1')`""},
        @{Name="Service Checker"; Desc="Analyzes running system services for anomalies."; Cmd="powershell Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass && powershell Invoke-Expression (Invoke-RestMethod https://raw.githubusercontent.com/praiselily/lilith-ps/refs/heads/main/Services.ps1)"},
        @{Name="Schedule Tasks"; Desc="Lists and checks signed scheduled tasks."; Cmd="powershell -Command `"Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass; Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/praiselily/lilith-ps/refs/heads/main/Signed-Scheduled-Tasks')`""},
        @{Name="Faker Detection"; Desc="Identifies VPN and hotspot usage."; Cmd="powershell -ExecutionPolicy Bypass -Command `"iwr https://raw.githubusercontent.com/praiselily/WeHateFakers/refs/heads/main/HotspotLogs.ps1 | iex`""},
        @{Name="Directory Scanner"; Desc="Scans common directories for specific files."; Cmd="powershell -Command `"Set-ExecutionPolicy Bypass -Scope Process; Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/praiselily/lilith-ps/refs/heads/main/CommonDirectories.ps1')`""},
        @{Name="Tool Downloader"; Desc="Downloads required utilities automatically."; Cmd="powershell -ExecutionPolicy Bypass -Command `"Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/Nickk196/ToolDownloader/refs/heads/main/ToolDownloader.ps1')`""},
        @{Name="JAR Parser"; Desc="Parses Java JAR files for metadata."; Cmd="powershell Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass && powershell Invoke-Expression (Invoke-RestMethod https://raw.githubusercontent.com/NoDiff-del/JARParser/refs/heads/main/JARParser.ps1)"},
        @{Name="Alt Detector"; Desc="Identifies alternative accounts and identifiers."; Cmd="powershell -ExecutionPolicy Bypass -Command `"Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/Enr1c0o/Powershell-Scripts/refs/heads/main/Alt-Detector.ps1')`""}
    )

    $currentCommand = ""

    # Function to Create Sidebar Buttons
    function Create-SidebarButton {
        param($Name, $Cmd, $Desc)

        $btn = New-Object System.Windows.Controls.Button
        $btn.Content = $Name
        $btn.Style = $window.FindResource("SidebarButton")
        
        # Attach metadata to button object for the event handler to access
        $btn | Add-Member -MemberType NoteProperty -Name "CmdData" -Value $Cmd
        $btn | Add-Member -MemberType NoteProperty -Name "DescData" -Value $Desc
        
        # Update the closure manually to capture variables
        $btn.Add_Click({
             param($sender, $e)
             # Reset styles
             foreach($child in $SidebarList.Children) {
                if($child -is [System.Windows.Controls.Button]) { $child.Style = $window.FindResource("SidebarButton") }
             }
             # Set Active
             $sender.Style = $window.FindResource("ActiveSidebarButton")
             
             # Update Display
             $DisplayTitle.Text = $sender.Content.ToString().ToUpper()
             $DisplayDesc.Text = $sender.DescData
             $global:CurrentCmd = $sender.CmdData
             
             $MainLaunchBtn.IsEnabled = $true
             $MainLaunchBtn.Opacity = 1
             $LogPreview.Text = "Ready to launch: " + $sender.Content
        }.GetNewClosure())

        $SidebarList.Children.Add($btn)
    }

    # Populate Sidebar
    foreach ($tool in $tools) {
        Create-SidebarButton -Name $tool.Name -Cmd $tool.Cmd -Desc $tool.Desc
    }

    # Launch Function
    $MainLaunchBtn.Add_Click({
        if($global:CurrentCmd) {
            $LogPreview.Text = "Initializing..."
            
            $tempFileName = [Guid]::NewGuid().ToString() + ".ps1"
            $tempFilePath = Join-Path $env:TEMP $tempFileName
            
            $fileContent = @"
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
 $global:CurrentCmd
"@
            Set-Content -Path $tempFilePath -Value $fileContent
            Start-Process cmd.exe -ArgumentList "/k", "powershell -NoExit -ExecutionPolicy Bypass -File `"$tempFilePath`""
            
            $LogPreview.Text = "Process started."
        }
    })

    # Close Button
    $CloseBtn.Add_Click({
        $window.Close()
    })

    # Draggable
    $window.Add_MouseLeftButtonDown({
        $window.DragMove()
    })

    $window.ShowDialog() | Out-Null

} catch {
    Write-Host "CRITICAL ERROR: $_" -ForegroundColor Red
    Read-Host "Press Enter to exit"
}
