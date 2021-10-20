#Plugins for Windows & Linux authentication (Count #33)
$plugins = 24269,34252,35703,35704,19506,20811,21745,24786,26917,10394,110695,141118,110095,11149,110385,104410,110723,35705,35706,12634,117885,19762,84238,10400,10428,13855,102094,24272,22869,57033,26921,117886,117887

Add-Type -AssemblyName System.Windows.Forms
Write-Output "Please make sure the first column is selected in the list. Auto type is going to perform in "
for ($i = 10; $i -ge 1; $i-- )
{
    Write-Progress -Activity "Auto type is going to perform in " -SecondsRemaining $i
    Start-Sleep -Milliseconds 1000
}
foreach ($plugin in $plugins)
{
  Write-Output "Workin on Plugin ID: $plugin"
  Start-Sleep -s 0.7; [System.Windows.Forms.SendKeys]::SendWait("{ENTER}")
  Start-Sleep -s 0.7; [System.Windows.Forms.SendKeys]::SendWait("plugin id")
  Start-Sleep -s 0.7; [System.Windows.Forms.SendKeys]::SendWait("{ENTER}")
  Start-Sleep -s 0.7; [System.Windows.Forms.SendKeys]::SendWait("{TAB}")
  Start-Sleep -s 0.7; [System.Windows.Forms.SendKeys]::SendWait("{TAB}")
  Start-Sleep -s 0.7; [System.Windows.Forms.SendKeys]::SendWait("$plugin")
  Start-Sleep -s 0.7; [System.Windows.Forms.SendKeys]::SendWait("{TAB}")
}
Write-Output "Task completed"
