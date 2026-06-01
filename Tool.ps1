# Required for WPF (Windows Presentation Foundation)
Add-Type -AssemblyName PresentationFramework

# --- DEFINE THE XAML (GUI LAYOUT) ---
# Note: We removed 'CornerRadius' from the Button tags to fix the error.
[xml]$xaml = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="PowerTools Launcher" Height="450" Width="600" WindowStartupLocation="CenterScreen">
    
    <Grid Margin="10">
        <Grid.RowDefinitions>
            <RowDefinition Height="*"/> <!-- Tabs Area -->
            <RowDefinition Height="100"/> <!-- Log Area -->
        </Grid.RowDefinitions>

        <!-- Tab Control -->
        <TabControl Grid.Row="0">
            <TabItem Header="Orbdiff">
                <StackPanel Margin="20">
                    <TextBlock Text="Run Orbdiff Tool" FontWeight="Bold" Margin="0,0,0,10"/>
                    <Button Name="Btn_Orbdiff" Content="Execute Orbdiff" Height="40" Width="200"/>
                </StackPanel>
            </TabItem>

            <TabItem Header="Spokwn">
                <StackPanel Margin="20">
                    <TextBlock Text="Run Spokwn Tool" FontWeight="Bold" Margin="0,0,0,10"/>
                    <Button Name="Btn_Spokwn" Content="Execute Spokwn" Height="40" Width="200"/>
                </StackPanel>
            </TabItem>

            <TabItem Header="RedLotus">
                <StackPanel Margin="20">
                    <TextBlock Text="Run RedLotus Tool" FontWeight="Bold" Margin="0,0,0,10"/>
                    <Button Name="Btn_RedLotus" Content="Execute RedLotus" Height="40" Width="200"/>
                </StackPanel>
            </TabItem>

            <TabItem Header="Tonynoh">
                <StackPanel Margin="20">
                    <TextBlock Text="Run Tonynoh Tool" FontWeight="Bold" Margin="0,0,0,10"/>
                    <Button Name="Btn_Tonynoh" Content="Execute Tonynoh" Height="40" Width="200"/>
                </StackPanel>
            </TabItem>

            <TabItem Header="Praiselily">
                <StackPanel Margin="20">
                    <TextBlock Text="Run Praiselily Tool" FontWeight="Bold" Margin="0,0,0,10"/>
                    <Button Name="Btn_Praiselily" Content="Execute Praiselily" Height="40" Width="200"/>
                </StackPanel>
            </TabItem>

            <TabItem Header="Others">
                <StackPanel Margin="20">
                    <TextBlock Text="Run Other Tools" FontWeight="Bold" Margin="0,0,0,10"/>
                    <Button Name="Btn_Others" Content="Execute Others" Height="40" Width="200"/>
                </StackPanel>
            </TabItem>

            <TabItem Header="Webs">
                <StackPanel Margin="20">
                    <TextBlock Text="Run Web Tools" FontWeight="Bold" Margin="0,0,0,10"/>
                    <Button Name="Btn_Webs" Content="Execute Webs" Height="40" Width="200"/>
                </StackPanel>
            </TabItem>
        </TabControl>

        <!-- Log Output -->
        <GroupBox Header="Activity Log" Grid.Row="1" Margin="0,10,0,0">
            <TextBox Name="OutputLog" IsReadOnly="True" VerticalScrollBarVisibility="Auto" TextWrapping="Wrap" Background="Black" Foreground="Green" FontFamily="Consolas"/>
        </GroupBox>
    </Grid>
</Window>
"@

# --- PARSE XAML AND CREATE WINDOW ---
 $reader = (New-Object System.Xml.XmlNodeReader $xaml) 
 $Window = [Windows.Markup.XamlReader]::Load($reader)

# --- FIND BUTTONS AND TEXTBOX ---
 $Btn_Orbdiff    = $Window.FindName("Btn_Orbdiff")
 $Btn_Spokwn     = $Window.FindName("Btn_Spokwn")
 $Btn_RedLotus   = $Window.FindName("Btn_RedLotus")
 $Btn_Tonynoh    = $Window.FindName("Btn_Tonynoh")
 $Btn_Praiselily = $Window.FindName("Btn_Praiselily")
 $Btn_Others     = $Window.FindName("Btn_Others")
 $Btn_Webs       = $Window.FindName("Btn_Webs")
 $OutputLog      = $Window.FindName("OutputLog")

# --- HELPER FUNCTION TO WRITE TO LOG ---
function Write-Log {
    param ([string]$msg)
    $timestamp = Get-Date -Format "HH:mm:ss"
    $OutputLog.AppendText("[$timestamp] $msg`r`n")
    $OutputLog.ScrollToEnd()
}

# --- ADD CLICK EVENTS ---

 $Btn_Orbdiff.Add_Click({
    Write-Log "Starting Orbdiff..."
    # PLACE ORBDIFF CODE HERE
    Start-Sleep -Milliseconds 500
    Write-Log "Orbdiff finished."
})

 $Btn_Spokwn.Add_Click({
    Write-Log "Starting Spokwn..."
    # PLACE SPOKWN CODE HERE
    Write-Log "Spokwn finished."
})

 $Btn_RedLotus.Add_Click({
    Write-Log "Starting RedLotus..."
    # PLACE REDLOTUS CODE HERE
    Write-Log "RedLotus finished."
})

 $Btn_Tonynoh.Add_Click({
    Write-Log "Starting Tonynoh..."
    # PLACE TONYNOH CODE HERE
    Write-Log "Tonynoh finished."
})

 $Btn_Praiselily.Add_Click({
    Write-Log "Starting Praiselily..."
    # PLACE PRAISELILY CODE HERE
    Write-Log "Praiselily finished."
})

 $Btn_Others.Add_Click({
    Write-Log "Starting Others..."
    # PLACE OTHERS CODE HERE
    Write-Log "Others finished."
})

 $Btn_Webs.Add_Click({
    Write-Log "Starting Webs..."
    # PLACE WEBS CODE HERE
    # Example: Start-Process "https://google.com"
    Write-Log "Webs finished."
})

# --- SHOW GUI ---
 $OutputLog.Text = "System Ready."
 $Window.ShowDialog() | Out-Null
