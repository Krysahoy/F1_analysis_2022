--Driver performance per race by completion status, position gained/lost end of race and points in race. 
Select r2.date AS Race_Date, 
	d.forename||' '||d.surname AS Driver_Name,
	c2.name AS Constructor_name,
	(r2.date- d.dob)as age,
	s.status AS Driver_status,
	c.name AS Circuit,
	c.location|| ', '||c.country AS Location, 
	c.lat as Latitude,
	c.lng as Longitude,
	r.grid as Grid_position_start,
	r."position" as Position_finish,
	r.grid - r."position"  as gained_or_lost_position,
	r.points as points_race
From races r2 
left join results r on r.raceId  = r2.raceId 
left join circuits c  on c.circuitId = r2.circuitId 
LEFT join constructors c2 on c2.constructorId = r.constructorId 
left join lap_times lt on lt.raceId  = r.raceId  
left join drivers d on d.driverId = r.driverId 
left join driver_standings ds on ds.raceId  = r.raceId 
left join status s on s.statusId = r.statusId 
where "year" ='2022' 
Group by Race_Date, Driver_name, Constructor_name, Circuit, Location, Latitude, Longitude

--Constructor performance by race
Select r2.date AS Race_Date,
	c.name as Constructor_name,
	r2.name as Circuit,
	cs.points as Constructor_Points,
	cs.position as Constructor_Standings
FROM races r2
Left join constructor_standings cs on cs.raceId  = r2.raceId 
left join constructors c on c.constructorId = cs.constructorId 
left join results r on r.constructorId = c.constructorId 
Left join constructor_results cr on cr.raceId  = r.raceId 
where "year" ='2022' 
group by Race_Date,Constructor_name, Constructor_points, Circuit, Constructor_Standings
order by Race_Date

--pit stop strategy per race
select r2.date, d.forename||' '||d.surname AS Driver_Name, 
r2.name as Circuit,
ps.stop,
ps.lap as Lap_number, 
ps.time as Time_of_Day, 
ps.duration as seconds,
ps.milliseconds
from drivers d 
join pit_stops ps on ps.driverId = d.driverId 
join races r2 on r2.raceId = ps.raceId 
where r2."year" = '2022' 
order by date, Time_of_Day

--Driver qualifying lap performance
select r2.quali_date, d.forename||' '||d.surname AS Driver_Name, 
r2.name as Circuit,
q.q1, q.q2, q.q3
from drivers d 
join qualifying q on d.driverId = q.driverId 
join races r2 on r2.raceId = q.raceId 
where r2."year" = '2022' 
order by quali_date, q1,q2,q3

--driver sprint performance
select r2.sprint_date , d.forename||' '||d.surname AS Driver_Name, 
r2.name as Circuit,
sr.grid as Grid_position,
sr."position" as finish_position,
sr.laps as Number_of_laps,
sr.time||''||sr.milliseconds as Lap_time,
sr.fastestLap, sr.fastestLapTime,
sr.points
from drivers d 
join sprint_results sr on d.driverId = sr.driverId 
join races r2 on r2.raceId = sr.raceId 
where r2."year" = '2022' 

--Driver race performance per lap 
select r2.date, d.forename||' '||d.surname AS Driver_Name, 
r2.name as Circuit,
lt.lap,
lt."position" ,
lt.time||''||lt.milliseconds as Lap_time
from drivers d
join lap_times lt on lt.driverId = d.driverId 
join races r2 on r2.raceId = lt.raceId 
where r2."year" = '2022' 

