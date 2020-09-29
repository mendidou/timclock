# timclock
 for now the employe need to be on the specified location ,to check-in.
 so to test the location please test it on xcode and fake the office-location:
 "<wpt lat="32.3247551" lon="34.9238288">"
  

Time clock app for employee , using localisation and notification this app is helping employee the check and check out . 
some points on my app:  
1)LOCATION: it is using localisation to check if the user is inside the region of 100 meters around the office. 
2)NOTIFICATION :it is continue updating the localisation even in background and if the user is going out of the region the app send a "reminder" notification for check out. 
3)FIREBASE : even if the app is closed and a guard is started ,the next time user will open the app the clock timer will continue counting with the real time.... 
4)TABLEVIEW work with dictionnary and arrays sorting : finally the is a resume callendar with a table view for all the hours . 
THE TIMER IS STILL RUNNING EVEN IF THE APP AS BEEN CLOSED, EVERY TIME THE APP IS OPENED AGAIN , 
WE ARE CHECKIN THE TIME STAMP SINCE THE LASTE CONNECTION AND CONTINU RUNNIG THE TIMER.
futur updates for the app :  
1) give the possibility to check with the wifi 
2) allow the employees to fill up differents form (tofes 101...)

![](Simulator%20Screen%20Shot%20-%20iPhone%2011%20Pro%20Max%20-%202020-07-01%20at%2000.42.46.png)
![](https://github.com/mendidou/timclock/blob/master/Simulator%20Screen%20Shot%20-%20iPhone%2011%20Pro%20Max%20-%202020-07-01%20at%2000.43.03.png)
![](https://github.com/mendidou/timclock/blob/master/Simulator%20Screen%20Shot%20-%20iPhone%2011%20Pro%20Max%20-%202020-07-01%20at%2000.46.06.png)
![](https://github.com/mendidou/timclock/blob/master/Simulator%20Screen%20Shot%20-%20iPhone%2011%20Pro%20Max%20-%202020-07-01%20at%2000.46.08.png)
![](https://github.com/mendidou/timclock/blob/master/Simulator%20Screen%20Shot%20-%20iPhone%2011%20Pro%20Max%20-%202020-07-01%20at%2000.46.14.png)
![](https://github.com/mendidou/timclock/blob/master/Simulator%20Screen%20Shot%20-%20iPhone%2011%20Pro%20Max%20-%202020-07-01%20at%2000.46.18.png)
![](https://github.com/mendidou/timclock/blob/master/Simulator%20Screen%20Shot%20-%20iPhone%2011%20Pro%20Max%20-%202020-07-01%20at%2000.46.18.png)
![](https://github.com/mendidou/timclock/blob/master/Simulator%20Screen%20Shot%20-%20iPhone%2011%20Pro%20Max%20-%202020-07-01%20at%2000.46.25.png)
![](https://github.com/mendidou/timclock/blob/master/Simulator%20Screen%20Shot%20-%20iPhone%2011%20Pro%20Max%20-%202020-07-01%20at%2000.48.35.png)
![](https://github.com/mendidou/timclock/blob/master/Simulator%20Screen%20Shot%20-%20iPhone%2011%20Pro%20Max%20-%202020-07-01%20at%2000.48.40.png)
