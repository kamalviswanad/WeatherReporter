# WeatherReporter
The script uses Open Meteo API to send information of present days' weather based on input.

You can download the file and use it in your code by calling :

Import-Module '{Filepath}\OpenMeteoModule.psm1'
OpenMeteo -DailyVariable 'argument(s)'

And don't forget to add your Discord Server's Webhook in the OpenMeteo-Module.

You can use the following arguments:

<img width="1561" height="278" alt="image" src="https://github.com/user-attachments/assets/0465b5e3-b291-4f6e-80a3-491662c8e3bd" />
<img width="1551" height="443" alt="image" src="https://github.com/user-attachments/assets/4fa46483-78a7-41d5-8f13-28d1102822bb" />

You can add more than 1 argument but make sure to add a comma after each argument
Example: 

Import-Module 'C:\Users\gajav\Downloads\OpenMeteoModule.psm1'
OpenMeteo -DailyVariable 'sunrise,sunset'


