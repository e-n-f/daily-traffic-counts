daily-traffic-counts
--------------------

Probably the most interesting thing here is the tool for extrapolating
short counts from the available times of day to estimated counts for
the entire day.

It uses a CSV file format adapted from Montreal's intersection counts:

    source,name,misc,date,time,SB-Right,SB-Thru,SB-Left,WB-Right,WB-Thru,WB-Left,NB-Right,NB-Thru,NB-Left,EB-Right,EB-Thru,EB-Left,N-Ped,E-Ped,S-Ped,W-Ped,N-Bike,E-Bike,S-Bike,W-Bike,lat,lon

where the important part is the time, which needs to be in a format like

    15:45-16:00

to specify, in 24-hour time, what portion of the day was counted.

So if you have a file <code>oakland.csv</code> like this,
that counts two intersections for an hour each, but different hours:

    oakland/oak031661.txt,Lowell St -- Stanford Ave / Oakland  CA,x,4/14/2011,07:55-08:55,69,0,1,11,402,0,33,0,0,16,268,0,5,0,5,5,1,1,5,3,,
    oakland/oak031661.txt,Lowell St -- Stanford Ave / Oakland  CA,x,4/14/2011,16:55-17:55,63,0,1,23,407,0,56,0,0,11,716,0,14,0,1,6,3,0,8,6,,
    oakland/oak031661.txt,60th St -- Stanford Ave / Oakland  CA,x,4/14/2011,08:00-09:00,1,0,24,7,395,8,0,0,0,0,261,39,1,4,0,0,6,2,5,0,,
    oakland/oak031661.txt,60th St -- Stanford Ave / Oakland  CA,x,4/14/2011,17:00-18:00,1,0,54,11,405,5,0,0,0,0,741,43,0,0,0,2,10,2,8,0,,

and you want to be able to compare how busy they might be over
the whole day if they follow the general trend of other intersections,
do

    ./daily/estimate-peak-hour -24 oakland.csv > oakland-extrapolated.csv

and you will get a new file <code>oakland-extrapolated.csv</code> that provides
these estimates for the entire day:

    oakland/oak031661.txt,Lowell St -- Stanford Ave / Oakland  CA,x,4/14/2011,00:00-24:00,851.2,0.0,12.9,219.2,5216.6,0.0,573.9,0.0,0.0,174.1,6345.1,0.0,137.4,0.0,43.4,79.5,25.1,6.3,81.6,56.5,,
    oakland/oak031661.txt,60th St -- Stanford Ave / Oakland  CA,x,4/14/2011,00:00-24:00,13.0,0.0,508.5,117.3,5214.9,84.7,0.0,0.0,0.0,0.0,6531.7,534.5,7.2,29.0,0.0,14.5,100.1,25.0,81.3,0.0,,

The fractional crossings are false precision but hopefully make clearer that
these are estimates, not actual counts.

Data file
---------

The file of daily estimates for every intersection that I have been able to obtain any counts for
is in [daily/daily.csv](https://github.com/ericfischer/daily-traffic-counts/blob/master/daily/daily.csv).
