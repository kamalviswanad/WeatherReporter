function OpenMeteo {
    param (
        [string]$DailyVariable
    )

# getting location- START
Add-Type -AssemblyName System.Device
$GeoWatcher = New-Object System.Device.Location.GeoCoordinateWatcher
$GeoWatcher.Start()

# Wait for the location service to become ready or for permission to be denied
while (($GeoWatcher.Status -ne 'Ready') -and ($GeoWatcher.Permission -ne 'Denied')) {
    Start-Sleep -Milliseconds 100
}

if ($GeoWatcher.Permission -eq 'Denied') {
    Write-Error "Access Denied for Location Information. Ensure location services are enabled and PowerShell has permission."
} else {
   $Location = $GeoWatcher.Position.Location 
   $Latitude = $Location.Latitude
   $Longitude = $Location.Longitude
}
$GeoWatcher.Stop()
#Location- END 

$URI = "https://api.open-meteo.com/v1/forecast?latitude=$($Latitude)&longitude=$($Longitude)&daily=$($DailyVariable)&timezone=auto"

do{
$CurrentTime= Get-Date -Format "hh:mm tt"
if($CurrentTime -match "03:20 PM"){
  try {
    $Result = Invoke-RestMethod -Uri $URI -ErrorAction Stop

    #Converting input into an arraylist and converting into a string
$currentarray = $currentvariable -split "," | ForEach-Object { $_.Trim() }
$Information 
foreach($variable in $currentarray){
$a = $Result.daily.$variable[0]
$Information += "{0}: {1} `n" -f $variable, $a
}

    # sending message to discord server
$Payload = @{
    content = "Here's your weather Information for $(Get-Date -Format "MM-dd-yyyy"): $Information"
    username = "WeatherReporter" #Can use any name 
            } | ConvertTo-Json

Invoke-RestMethod -Uri "{Your Discord Server's Webhook URL -Method Post -ContentType 'application/json" -Body $Payload
$Information = ""   #Clearing the information variable for next day's data
} catch {
    # 🛑 Output the full error details
    Write-Host "--- ERROR DETAILS ---" -ForegroundColor Red
     $_.Exception.details    # This shows the response from the server, if any
     $_.Exception.Message # The general error message
    Write-Host "--- END ERROR DETAILS ---" -ForegroundColor Red 
    continue
}
}else {
    Write-Host "It's not time yet."
}

Start-Sleep -Seconds 60
}while($true)

}

Export-ModuleMember -Function OpenMeteo
