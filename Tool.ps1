Add-Type -AssemblyName PresentationFramework
Add-Type -AssemblyName System.Windows.Forms

# --- XAML GUI Definition (Modern Glass/Obsidian Style - FIXED) ---
[xml]$xaml = @"
<Window 
    xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
    xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
    Title="Obsidian Launcher"
    Width="1000"
    Height="700"
    WindowStartupLocation="CenterScreen"
    WindowStyle="None"
    AllowsTransparency="True"
    Background="Transparent"
    ResizeMode="NoResize"
    Topmost="False">

    <Window.Resources>
        <!-- Modern Card Button Style -->
        <Style x:Key="ModernCard" TargetType="Button">
            <Setter Property="Background" Value="#0f3460"/>
            <Setter Property="Foreground" Value="#e94560"/>
            <Setter Property="FontFamily" Value="Segoe UI"/>
            <Setter Property="FontSize" Value="14"/>
            <Setter Property="FontWeight" Value="SemiBold"/>
            <Setter Property="BorderThickness" Value="0"/>
            <Setter Property="Cursor" Value="Hand"/>
            <Setter Property="Height" Value="100"/>
            <Setter Property="Margin" Value="10"/>
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="Button">
                        <Border Background="{TemplateBinding Background}" CornerRadius="8">
                            <Border.Effect>
                                <DropShadowEffect Color="Black" BlurRadius="5" ShadowDepth="2" Opacity="0.3"/>
                            </Border.Effect>
                            <Grid>
                                <!-- Icon Placeholder -->
                                <TextBlock Text="&#xE81C;" FontFamily="Segoe MDL2 Assets" FontSize="24" Foreground="#533483" HorizontalAlignment="Left" VerticalAlignment="Top" Margin="10,10,0,0"/>
                                <!-- Content -->
                                <ContentPresenter HorizontalAlignment="Center" VerticalAlignment="Center"/>
                            </Grid>
                        </Border>
                        <ControlTemplate.Triggers>
                            <Trigger Property="IsMouseOver" Value="True">
                                <Setter Property="Background" Value="#e94560"/>
                                <Setter Property="Foreground" Value="White"/>
                                <Setter Property="RenderTransform">
                                    <Setter.Value>
                                        <ScaleTransform ScaleX="1.02" ScaleY="1.02"/>
                                    </Setter.Value>
                                </Setter>
                            </Trigger>
                            <Trigger Property="IsPressed" Value="True">
                                <Setter Property="Background" Value="#c0354c"/>
                                <Setter Property="RenderTransform">
                                    <Setter.Value>
                                        <ScaleTransform ScaleX="0.98" ScaleY="0.98"/>
                                    </Setter.Value>
                                </Setter>
                            </Trigger>
                        </ControlTemplate.Triggers>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
        </Style>

        <!-- Header Style -->
        <Style x:Key="TitleText" TargetType="TextBlock">
            <Setter Property="FontFamily" Value="Segoe UI"/>
            <Setter Property="FontWeight" Value="Light"/>
            <Setter Property="FontSize" Value="28"/>
            <Setter Property="Foreground" Value="White"/>
        </Style>
    </Window.Resources>

    <Grid Margin="10">
        <!-- Main Border with Gradient Background -->
        <Border CornerRadius="15" BorderBrush="#e94560" BorderThickness="1">
            <Border.Background>
                <LinearGradientBrush StartPoint="0,0" EndPoint="1,1">
                    <GradientStop Color="#1a1a2e" Offset="0"/>
                    <GradientStop Color="#16213e" Offset="1"/>
                </LinearGradientBrush>
            </Border.Background>
            
            <Grid Margin="20">
                <Grid.RowDefinitions>
                    <RowDefinition Height="Auto"/> <!-- Header -->
                    <RowDefinition Height="*"/>     <!-- Content -->
                    <RowDefinition Height="Auto"/> <!-- Footer/Log -->
                </Grid.RowDefinitions>

                <!-- Header Section -->
                <Grid Grid.Row="0" Margin="0,10,0,20">
                    <StackPanel Orientation="Horizontal" VerticalAlignment="Center">
                        <Border Width="40" Height="40" Background="#e94560" CornerRadius="20">
                            <TextBlock Text="O" Foreground="White" FontSize="24" FontWeight="Bold" HorizontalAlignment="Center" VerticalAlignment="Center"/>
                        </Border>
                        <StackPanel Margin="15,0,0,0" VerticalAlignment="Center">
                            <TextBlock Text="OBSIDIAN" Style="{StaticResource TitleText}"/>
                            <TextBlock Text="Tool Suite v2.0" Foreground="#888" FontSize="12" FontFamily="Segoe UI"/>
                        </StackPanel>
                    </StackPanel>

                    <!-- Window Controls -->
                    <StackPanel Orientation="Horizontal" HorizontalAlignment="Right" VerticalAlignment="Center">
                        <Button Content="r" Width="30" Height="30" Background="Transparent" Foreground="White" BorderThickness="0" FontFamily="Marlett" Cursor="Hand" Name="MinBtn"/>
                        <Button Content="x" Width="30" Height="30" Background="#e94560" Foreground="White" BorderThickness="0" FontFamily="Segoe UI" FontWeight="Bold" Cursor="Hand" Name="CloseBtn" Margin="5,0,0,0"/>
                    </StackPanel>
                </Grid>

                <!-- Tools Grid -->
                <UniformGrid Grid.Row="1" Columns="3" Rows="3">
                    <Button Name="BtnMeow" Content="Meow Mod Analyzer" Style="{StaticResource ModernCard}"/>
                    <Button Name="BtnMacro" Content="Macro Detector" Style="{StaticResource ModernCard}"/>
                    <Button Name="BtnService" Content="Service Checker" Style="{StaticResource ModernCard}"/>
                    
                    <Button Name="BtnTask" Content="Schedule Tasks" Style="{StaticResource ModernCard}"/>
                    <Button Name="BtnFaker" Content="Faker Detection" Style="{StaticResource ModernCard}"/>
                    <Button Name="BtnDir" Content="Directory Scanner" Style="{StaticResource ModernCard}"/>
                    
                    <Button Name="BtnDown" Content="Tool Downloader" Style="{StaticResource ModernCard}"/>
                    <Button Name="BtnJar" Content="JAR Parser" Style="{StaticResource ModernCard}"/>
                    
                    <!-- Placeholder for Alt Detector -->
                    <Border Background="#0f3460" CornerRadius="8" Margin="10" BorderBrush="#333" BorderThickness="1" Opacity="0.5">
                        <Grid>
                            <TextBlock Text="ALT DETECTOR" HorizontalAlignment="Center" VerticalAlignment="Center" Foreground="#888" FontFamily="Segoe UI" FontWeight="Bold"/>
                            <TextBlock Text="(Command Missing)" HorizontalAlignment="Center" VerticalAlignment="Center" Margin="0,20,0,0" Foreground="#666" FontSize="10"/>
                        </Grid>
                    </Border>
                </UniformGrid>

                <!-- Log Console -->
                <Border Grid.Row="2" Background="#000000" CornerRadius="8" BorderBrush="#333" BorderThickness="1" Padding="10" Margin="0,20,0,0" Height="140">
                    <Grid>
                        <TextBlock Text="TERMINAL OUTPUT" Foreground="#e94560" FontSize="10" FontWeight="Bold" FontFamily="Consolas" Margin="0,0,0,5"/>
                        <ScrollViewer VerticalScrollBarVisibility="Auto" Margin="0,20,0,0">
                            <RichTextBox Name="LogConsole" IsReadOnly="True" Background="Transparent" BorderThickness="0" Foreground="#00FF00" FontFamily="Consolas" FontSize="11" Padding="0">
                                <FlowDocument>
                                    <Paragraph>
                                        <Run Text="System initialized." Foreground="#666"/>
                                    </Paragraph>
                                </FlowDocument>
                            </RichTextBox>
                        </ScrollViewer>
                    </Grid>
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
        param([string]$Message, [string]$Color = "White")
        
        $run = New-Object System.Windows.Documents.Run
        $run.Text = "[$(Get-Date -Format 'HH:mm:ss')] $Message`n"
        
        $brush = [Windows.Media.Brushes]::White
        if ($Color -eq "Green") { $brush = [Windows.Media.Brushes]::Lime }
        if ($Color -eq "Cyan") { $brush = [Windows.Media.Brushes]::Cyan }
        if ($Color -eq "Red") { $brush = [Windows.Media.Brushes]::Red }
        
        $run.Foreground = $brush

        $para = New-Object System.Windows.Documents.Paragraph
        $para.Inlines.Add($run)
        
        $LogConsole.Document.Blocks.Add($para)
        $LogConsole.ScrollToEnd()
    }

    # Tool Launcher Helper (Opens CMD, runs PowerShell script)
    function Invoke-Tool {
        param([string]$Name, [string]$Command)
        Write-Log "Starting $Name..." "Cyan"
        
        $tempFileName = [Guid]::NewGuid().ToString() + ".ps1"
        $tempFilePath = Join-Path $env:TEMP $tempFileName
        
        $fileContent = @"
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
 $Command
"@
        Set-Content -Path $tempFilePath -Value $fileContent
        
        # Launch CMD which runs PowerShell
        Start-Process cmd.exe -ArgumentList "/k", "powershell -NoExit -ExecutionPolicy Bypass -File `"$tempFilePath`""
    }

    # --- Event Hooks ---

    # 1. Meow Mod Analyzer
    $BtnMeow.Add_Click({
        Invoke-Tool -Name "Meow Mod Analyzer" -Command "powershell -ExecutionPolicy Bypass -Command `"Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/MeowTonynoh/MeowModAnalyzer/main/MeowModAnalyzer.ps1')`""
    })

    # 2. Macro Detector
    $BtnMacro.Add_Click({
        Invoke-Tool -Name "Macro Detector" -Command "powershell -ExecutionPolicy Bypass -Command `"Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/Nickk196/MacroDetector/refs/heads/main/MacroDetector.ps1')`""
    })

    # 3. Service Checker
    $BtnService.Add_Click({
        Invoke-Tool -Name "Service Checker" -Command "powershell Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass && powershell Invoke-Expression (Invoke-RestMethod https://raw.githubusercontent.com/praiselily/lilith-ps/refs/heads/main/Services.ps1)"
    })

    # 4. Schedule Tasks
    $BtnTask.Add_Click({
        Invoke-Tool -Name "Schedule Tasks" -Command "powershell -Command `"Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass; Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/praiselily/lilith-ps/refs/heads/main/Signed-Scheduled-Tasks')`""
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

    # 8. JAR Parser
    $BtnJar.Add_Click({
        Invoke-Tool -Name "JAR Parser" -Command "powershell Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass && powershell Invoke-Expression (Invoke-RestMethod https://raw.githubusercontent.com/NoDiff-del/JARParser/refs/heads/main/JARParser.ps1)"
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
