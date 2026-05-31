Add-Type -AssemblyName PresentationFramework
Add-Type -AssemblyName System.Windows.Forms

# --- XAML GUI Definition (Safe/Compatible) ---
[xml]$xaml = @"
<Window 
    xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
    xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
    Title="GLITCH_LAUNCHER"
    Width="900"
    Height="650"
    WindowStartupLocation="CenterScreen"
    WindowStyle="None"
    AllowsTransparency="True"
    Background="Transparent"
    ResizeMode="NoResize"
    Topmost="False">

    <Window.Resources>
        <!-- Simplified Button Style -->
        <Style x:Key="NeonButton" TargetType="Button">
            <Setter Property="Background" Value="#0A0A0A"/>
            <Setter Property="Foreground" Value="#00FFCC"/>
            <Setter Property="FontFamily" Value="Consolas"/>
            <Setter Property="FontSize" Value="14"/>
            <Setter Property="FontWeight" Value="Bold"/>
            <Setter Property="BorderBrush" Value="#1A1A1A"/>
            <Setter Property="BorderThickness" Value="1"/>
            <Setter Property="Cursor" Value="Hand"/>
            <Setter Property="Height" Value="80"/>
            <Setter Property="Margin" Value="10"/>
            <Style.Triggers>
                <Trigger Property="IsMouseOver" Value="True">
                    <Setter Property="Background" Value="#111111"/>
                    <Setter Property="BorderBrush" Value="#00FFCC"/>
                    <Setter Property="Foreground" Value="White"/>
                </Trigger>
                <Trigger Property="IsPressed" Value="True">
                    <Setter Property="Background" Value="#00FFCC"/>
                    <Setter Property="Foreground" Value="Black"/>
                </Trigger>
            </Style.Triggers>
        </Style>

        <Style x:Key="HeaderLabel" TargetType="TextBlock">
            <Setter Property="Foreground" Value="#FF0055"/>
            <Setter Property="FontFamily" Value="Consolas"/>
            <Setter Property="FontWeight" Value="Bold"/>
            <Setter Property="FontSize" Value="24"/>
        </Style>
    </Window.Resources>

    <Grid>
        <Border Background="#DD050505" CornerRadius="12" BorderBrush="#333" BorderThickness="1">
            <Grid Margin="20">
                <Grid.RowDefinitions>
                    <RowDefinition Height="Auto"/>
                    <RowDefinition Height="*"/>
                    <RowDefinition Height="Auto"/>
                </Grid.RowDefinitions>

                <!-- Header -->
                <Grid Grid.Row="0" Margin="0,0,0,20">
                    <StackPanel Orientation="Horizontal">
                        <TextBlock Text="> SYSTEM_ROOT" Style="{StaticResource HeaderLabel}"/>
                        <TextBlock Text=" :: CMD_EXECUTOR" Foreground="#00FFCC" FontFamily="Consolas" FontSize="24" FontWeight="Bold" Margin="10,0,0,0"/>
                    </StackPanel>
                    
                    <StackPanel Orientation="Horizontal" HorizontalAlignment="Right">
                        <Button Content="EXIT" Width="60" Height="25" Background="#330000" Foreground="Red" BorderThickness="0" FontFamily="Consolas" Cursor="Hand" Name="CloseBtn"/>
                    </StackPanel>
                </Grid>

                <!-- Tools Grid -->
                <UniformGrid Grid.Row="1" Columns="3" Rows="3">
                    <Button Name="BtnMeow" Content="[ ANALYZE_MODS ]" Style="{StaticResource NeonButton}"/>
                    <Button Name="BtnMacro" Content="[ MACRO_DETECT ]" Style="{StaticResource NeonButton}"/>
                    <Button Name="BtnService" Content="[ SERVICE_CHK ]" Style="{StaticResource NeonButton}"/>
                    
                    <Button Name="BtnTask" Content="[ SCHED_TASKS ]" Style="{StaticResource NeonButton}"/>
                    <Button Name="BtnFaker" Content="[ FAKER_DETECT ]" Style="{StaticResource NeonButton}"/>
                    <Button Name="BtnDir" Content="[ DIR_SCANNER ]" Style="{StaticResource NeonButton}"/>
                    
                    <Button Name="BtnDown" Content="[ TOOL_DL ]" Style="{StaticResource NeonButton}"/>
                    <Button Name="BtnJar" Content="[ JAR_PARSER ]" Style="{StaticResource NeonButton}"/>
                    <Button Content="[ N/A ]" IsEnabled="False" Background="#111" Foreground="#333" BorderBrush="#222" FontFamily="Consolas" Cursor="Arrow"/>
                </UniformGrid>

                <!-- Log Console -->
                <Border Grid.Row="2" Background="#000000" CornerRadius="4" BorderBrush="#333" BorderThickness="1" Padding="10" Margin="0,20,0,0" Height="150">
                    <ScrollViewer VerticalScrollBarVisibility="Auto">
                        <RichTextBox Name="LogConsole" IsReadOnly="True" Background="Transparent" BorderThickness="0" Foreground="#00FF00" FontFamily="Consolas" FontSize="12">
                            <FlowDocument>
                                <Paragraph>
                                    <Run Text="[INIT] Launcher loaded..."/>
                                    <LineBreak/>
                                    <Run Text="[WAIT] Select a module." Foreground="#888888"/>
                                </Paragraph>
                            </FlowDocument>
                        </RichTextBox>
                    </ScrollViewer>
                </Border>

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
    $BtnMeow    = $window.FindName("BtnMeow")
    $BtnMacro   = $window.FindName("BtnMacro")
    $BtnService = $window.FindName("BtnService")
    $BtnTask    = $window.FindName("BtnTask")
    $BtnFaker   = $window.FindName("BtnFaker")
    $BtnDir     = $window.FindName("BtnDir")
    $BtnDown    = $window.FindName("BtnDown")
    $BtnJar     = $window.FindName("BtnJar")
    $CloseBtn   = $window.FindName("CloseBtn")
    $LogConsole = $window.FindName("LogConsole")

    # Logging Function
    function Write-Log {
        param([string]$Message, [string]$Color = "Green")
        
        $run = New-Object System.Windows.Documents.Run
        $run.Text = "[$(Get-Date -Format 'HH:mm:ss')] $Message`n"
        
        $brush = [Windows.Media.Brushes]::Green
        if ($Color -eq "Red") { $brush = [Windows.Media.Brushes]::Red }
        if ($Color -eq "Cyan") { $brush = [Windows.Media.Brushes]::Cyan }
        if ($Color -eq "Gray") { $brush = [Windows.Media.Brushes]::Gray }
        
        $run.Foreground = $brush

        $para = New-Object System.Windows.Documents.Paragraph
        $para.Inlines.Add($run)
        
        $LogConsole.Document.Blocks.Add($para)
        $LogConsole.ScrollToEnd()
    }

    # Tool Launcher Helper (Opens CMD window, runs PowerShell command inside it)
    function Invoke-Tool {
        param([string]$Name, [string]$Command)
        Write-Log "INITIATING: $Name..." "Cyan"
        
        # 1. Create a temporary .ps1 file
        $tempFileName = [Guid]::NewGuid().ToString() + ".ps1"
        $tempFilePath = Join-Path $env:TEMP $tempFileName
        
        # 2. Write the command to the file
        $fileContent = @"
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
 $Command
"@
        Set-Content -Path $tempFilePath -Value $fileContent
        
        # 3. Execute via CMD
        # /K = Keep the window open after execution
        # We ask CMD to run PowerShell, which then runs the script file
        Start-Process cmd.exe -ArgumentList "/k", "powershell -NoExit -ExecutionPolicy Bypass -File `"$tempFilePath`""
    }

    # --- Event Hooks ---

    # 1. MeowModAnalyzer
    $BtnMeow.Add_Click({
        Invoke-Tool -Name "MeowModAnalyzer" -Command "powershell -ExecutionPolicy Bypass -Command `"Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/MeowTonynoh/MeowModAnalyzer/main/MeowModAnalyzer.ps1')`""
    })

    # 2. MouseMacroFinder
    $BtnMacro.Add_Click({
        Invoke-Tool -Name "MouseMacroFinder" -Command "powershell -ExecutionPolicy Bypass -Command `"Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/Nickk196/MacroDetector/refs/heads/main/MacroDetector.ps1')`""
    })

    # 3. Service Checker
    $BtnService.Add_Click({
        Invoke-Tool -Name "Service Checker" -Command "powershell Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass && powershell Invoke-Expression (Invoke-RestMethod https://raw.githubusercontent.com/praiselily/lilith-ps/refs/heads/main/Services.ps1)"
    })

    # 4. Schedule Task
    $BtnTask.Add_Click({
        Invoke-Tool -Name "Schedule Task" -Command "powershell -Command `"Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass; Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/praiselily/lilith-ps/refs/heads/main/Signed-Scheduled-Tasks')`""
    })

    # 5. Faker Detection
    $BtnFaker.Add_Click({
        Invoke-Tool -Name "Faker Detection" -Command "powershell -ExecutionPolicy Bypass -Command `"iwr https://raw.githubusercontent.com/praiselily/WeHateFakers/refs/heads/main/HotspotLogs.ps1 | iex`""
    })

    # 6. Directory Scanner
    $BtnDir.Add_Click({
        Invoke-Tool -Name "Directory Scanner" -Command "powershell -Command `"Set-ExecutionPolicy Bypass -Scope Process; Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/praiselily/lilith-ps/refs/heads/main/CommonDirectories.ps1')`""
    })

    # 7. Tool Downloader
    $BtnDown.Add_Click({
        Invoke-Tool -Name "Tool Downloader" -Command "powershell -ExecutionPolicy Bypass -Command `"Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/Nickk196/ToolDownloader/refs/heads/main/ToolDownloader.ps1')`""
    })

    # 8. JARParser
    $BtnJar.Add_Click({
        Invoke-Tool -Name "JARParser" -Command "powershell Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass && powershell Invoke-Expression (Invoke-RestMethod https://raw.githubusercontent.com/NoDiff-del/JARParser/refs/heads/main/JARParser.ps1)"
    })

    # Close Button
    $CloseBtn.Add_Click({
        $window.Close()
    })

    # Make Window Draggable
    $window.Add_MouseLeftButtonDown({
        $window.DragMove()
    })

    # Show GUI
    $window.ShowDialog() | Out-Null

} catch {
    Write-Host "CRITICAL ERROR: $_" -ForegroundColor Red
    Read-Host "Press Enter to exit"
}
