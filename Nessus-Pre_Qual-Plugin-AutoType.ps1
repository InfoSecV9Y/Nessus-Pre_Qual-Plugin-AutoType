
<#
	By: Vinay
	
	Purpose:   This script is designed to type the plugin id's in the Nessus Filters list (Nessus Web UI). Which can be use as a pre-qualification scan to check the credential and connectivity issues before running the actual scan.
	
	Pre-Conditions: 
		1.Multiple filters list to be added on the filters screen before running the script
		2.Must select the first entry in the filters list when the timer is running
		3.Suggested to move the cursor to a different place from the filters screen to avoid any unexpected selection of filter type.
		
	Version: 0.1
	
	Last modified: 2021.Oct.20 7:00 PM
	
	Known Bugs:
		*Nil
		
	Pending Enhancements:
		*Can be updated with the plugin names to reduce the iterations
		*Selecting the filters using the PowerShell or js script driven by PowerShell send keys

	Updates:
		*NA
		
	Ref:
	   #Plugin id's list is collected from: https://community.tenable.com/s/article/Useful-plugins-to-troubleshoot-credential-scans
	
	#Plugins for Windows & Linux authentication (Count #33): 
		24269,34252,35703,35704,19506,20811,21745,24786,26917,10394,110695,141118,110095,11149,110385,104410,110723,35705,35706,12634,117885,19762,84238,10400,10428,13855,102094,24272,22869,57033,26921,117886,117887
	
	#Plugins for Windows, Linux & Database authentication (Count #48):
		24269,34252,35703,35704,19506,20811,19506,21745,24786,26917,10394,110695,141118,12634,25221,33851,110095,22073,10658,11219,14272,11149,110385,104410,110723,35705,35706,97993,12634,117885,19762,73204,72816,57399,57400,80860,65703,84231,84238,63062,10400,10428,13855,57033,102094,21745,10394,10400,10428,24272,22869,57033,26921,117886,117887
	

#>

# Initial confirmtion before running the Auto-Type operation

$plugins = 24269,34252,35703,35704,19506,20811,21745,24786,26917,10394,110695,141118,110095,11149,110385,104410,110723,35705,35706,12634,117885,19762,84238,10400,10428,13855,102094,24272,22869,57033,26921,117886,117887
$plugins_count=$plugins.length


"    Pre-Conditions: 
		1.Atleast `"$plugins_count`" filters are created on the filters screen before running the script
		2.Must select the first entry in the filters list when the timer is running
		3.Suggested to move the cursor to a different place from the filters screen to avoid any unexpected selection of filter type.
    
    Available inputs:
        Y/y/Yes/yes    -  Wait for 10 seconds and then run the script. Please dont forget to keep the focus on Nessus web UI.
        v/V            -  Perform Alt+Tab and start auto-type. This will reduce the script initial delay from 10 sec to less than 5 Sec.
        Anything else  -  Quit

    Note: Make sure above pre-requisites met before running the script. You may use the below JS code to automate adding of filters.


    Javascript code to add filters:
        document.getElementsByClassName(`"editor-plugins-toggle-enable`")[0].click()
        document.getElementsByClassName(`"advanced-search`")[0].click()
        add_filter=document.getElementsByClassName(`"glyphicons add`")
        for (i = 1; i < $plugins_count; i++ ) {add_filter[0].click()}

    Usage of Javascript code to add filters:
        1.On chrome web browser, navigate to Advanced Scan Policy >> Plugins 
        2.Press F12 to open developer tools
        3.Paste the code in console
        4.Change the Match type to `"ANY`"
        5.Select the first filter option to set the focus for auto typing.
        5.Comeback to this powershell console
        6.Press V or Y to proceed with the auto-typing

    Note: The above script is tested on Chrome Version 94.0.4606.61 on windows (Oct 2021). Nessus may change the approach in adding the filter so please use at your own risk."



Add-Type -AssemblyName System.Windows.Forms
$confirmation = Read-Host "Are you sure you want to proceed with Auto-Type? (y/yes/v/any)"
$startMs = Get-Date
if ($confirmation.ToLower() -eq 'v' ) {
    Start-Sleep -s 1; [System.Windows.Forms.SendKeys]::SendWait("%{TAB}");Start-Sleep -s 2.5; 
} elseif($confirmation.ToLower() -eq 'y' -or $confirmation.ToLower() -eq 'yes' ) {
    Write-Output "Please make sure the first column is selected in the list. Auto type is going to perform in 10 Seconds."
    for ($i = 10; $i -ge 1; $i-- )  {
        Write-Progress -Activity "Auto type is going to perform in " -SecondsRemaining $i
        Start-Sleep -Milliseconds 1000
    }
} else {
    ""
	"Wrong input received. Auto-typing operation cancelled."
	""
	"You may rerun the script and type Y/y/Yes/yes as an input if you want to proceed with the script execution"
    return
}


$middleMs = Get-Date


for($i=1; $i-le $plugins_count;$i++)  #foreach ($plugin in $plugins)
{
  $percentComplete = ($i / ($plugins_count*10)) * 100;   Write-Progress -Activity 'Auto-typing is in progress.' -Status "Completed $i out of $plugins_count" -PercentComplete $percentComplete
  "Progress: {0}/{1}. Workin on Plugin ID: {2}" -f $i,$plugins_count,$plugins[$i-1]
  Start-Sleep -s 0.5; [System.Windows.Forms.SendKeys]::SendWait("{ENTER}")
  Start-Sleep -s 0.7; [System.Windows.Forms.SendKeys]::SendWait("plugin id")
  Start-Sleep -s 0.7; [System.Windows.Forms.SendKeys]::SendWait("{ENTER}")
  Start-Sleep -s 0.5; [System.Windows.Forms.SendKeys]::SendWait("{TAB}")
  Start-Sleep -s 0.5; [System.Windows.Forms.SendKeys]::SendWait("{TAB}")
  Start-Sleep -s 0.7; [System.Windows.Forms.SendKeys]::SendWait("{0}" -f $plugins[$i-1])
  Start-Sleep -s 0.7; [System.Windows.Forms.SendKeys]::SendWait("{TAB}")
}
$endMs = Get-Date

Write-Output "Task completed. Total duration is $($endMs - $startMs)  .Auto typing took $($endMs - $middleMs)"
