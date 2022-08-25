--Inspecting tables

select top 5 *
from sql.dbo.accident;

select top 5 *
from sql.dbo.vehicle;

select top 5 *
from sql.dbo.casualty;


---------------------------------------------------------------------------------------------------------------------------------------------------
--Locations of accidents

update sql.dbo.accident
set latitude = replace(latitude, ',', '.');

update sql.dbo.accident
set longitude = replace(longitude, ',', '.');


select longitude, latitude, accident_index, accident_severity,
	case accident.accident_severity
        when '1' then 'Fatal'
        when '2' then 'Serious'
	when '3' then 'Slight'
	end as Severity
from sql.dbo.accident;
---------------------------------------------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------------------------------------------------------
--Number of accidents per severity and sex

select 
	accident.accident_severity, 
	count(*) as num_accidents, 
	vehicle.sex_of_driver,
	case vehicle.sex_of_driver
        	when '1' then 'Male'
        	when '2' then 'Female'
	end as Sex,
	case accident.accident_severity
        	when '1' then 'Fatal'
        	when '2' then 'Serious'
		when '3' then 'Slight'
	end as Severity
from SQL.dbo.accident as accident 
	inner join SQL.dbo.vehicle as vehicle on accident.accident_index = vehicle.accident_index
where 
	sex_of_driver != 3 and sex_of_driver != -1 
group by 
	accident.accident_severity, vehicle.sex_of_driver
order by 
	accident.accident_severity;

--Percentage accident severities/sex

select
    sex_of_driver,
    accident_severity,
	case vehicle.sex_of_driver
        	when '1' then 'Male'
        	when '2' then 'Female'
	end as Sex,
	case accident.accident_severity
        	when '1' then 'Fatal'
        	when '2' then 'Serious'
		when '3' then 'Slight'
	end as Severity,
    count(*) as Total,
    count(*) * 100.0 / sum(count(*)) over (partition by sex_of_driver) as PercentOfSex,
    count(*) * 100.0 / sum(count(*)) over () as PercentOfTotal
from
    sql.dbo.accident as accident
    inner join sql.dbo.vehicle as vehicle on
        accident.accident_index = vehicle.accident_index
where 
	sex_of_driver != 3 and sex_of_driver != -1 
group by
    sex_of_driver,
    accident_severity
order by
	Total desc;

---------------------------------------------------------------------------------------------------------------------------------------------------
--Weather conditions

select 
	weather_conditions, 
	count(*) as 'weather_count',
	case accident.weather_conditions
        	when '1' then 'Fine, no high winds'
        	when '2' then 'Rain, no high winds'
		when '3' then 'Snow, no high winds'
		when '4' then 'Fine, high winds'
        	when '5' then 'Rain, high winds'
		when '6' then 'Snow, high winds'
		when '7' then 'Fog or mist'
        	when '8' then 'Other'
		--when '9' then 'Unknown'
		else 'Unknown'
	end as Weather
from sql.dbo.accident
where 
	weather_conditions != -1
group by 
	weather_conditions
order by 
	weather_count desc;

---------------------------------------------------------------------------------------------------------------------------------------------------
--Date and time

--Days of the week

select 
	day_of_week, 
	count(*) as accidents_per_day,
	case accident.day_of_week
        	when '1' then 'Sunday'
        	when '2' then 'Monday'
		when '3' then 'Tuesday'
		when '4' then 'Wednesday'
        	when '5' then 'Thursday'
		when '6' then 'Friday'
		when '7' then 'Saturday'
    end as Day
from sql.dbo.accident
group by 
	day_of_week
order by 
	accidents_per_day desc;

-- Accident timing

alter table sql.dbo.accident
add accident_hour nvarchar (255);

update sql.dbo.accident
set accident_hour = substring(time, 1, charindex(':', time) -1);

-- Accident frequency per hour 

with 
	accidents_time as (select 	accident_hour, 
					count(accident_hour) as accidents_per_hour, 
					case accident_severity
						when '1' then 'Fatal'
						when '2' then 'Serious'
						when '3' then 'Slight'
					end as Severity,
					accident_severity, 
					sum(count(accident_hour)) over (partition by accident_severity) as total_per_severity
from sql.dbo.accident
group by 
	accident_hour, 
	accident_severity)
select *, 
	cast(accidents_per_hour as float)/ cast(total_per_severity as float) *100 as percentage_severity
from 
	accidents_time;

-- Altering table to extract accident month
alter table sql.dbo.accident
add accident_date date;

alter table sql.dbo.accident
add accident_month varchar(255);

update sql.dbo.accident
set accident_date = CONVERT(date, date ,103); 

update sql.dbo.accident
set accident_month = month(accident_date);

--Accidents per month

select 
	count(*), accident_month,  accident_hour
from sql.dbo.accident as accident
    inner join sql.dbo.vehicle as vehicle on
        accident.accident_index = vehicle.accident_index
group by 
	accident_month, accident_hour
order by 
	accident_month desc;


---------------------------------------------------------------------------------------------------------------------------------------------------

--Exploring data

-- casualty type for accident severity
select 
	casualty_type, 
	count(*), 
	accident_severity
from sql.dbo.accident as accident
    inner join sql.dbo.casualty as cas on
        accident.accident_index = cas.accident_index
group by 
	casualty_type, accident_severity
order by 
	count(*) desc;

-- age band of casualties

select 
	count(*), 
	age_band_of_casualty, 
	casualty_severity, 
	case casualty.age_band_of_casualty
		when '1'  then	'0 - 5'
		when '2'  then	'6 - 10'
		when '3'  then	'11 - 15'
		when '4'  then	'16 - 20'
		when '5'  then	'21 - 25'
		when '6'  then	'26 - 35'
		when '7'  then	'36 - 45'
		when '8'  then	'46 - 55'
		when '9'  then	'56 - 65'
		when '10' then  '66 - 75'
		when '11' then  'Over 75'
	end as age_group
from SQL.dbo.casualty
where 
	age_band_of_casualty != -1
group by 
	age_band_of_casualty, casualty_severity
order by 
	count(*) desc;

-- vehicle type

select 
	vehicle_type, 
	count(*)
from sql.dbo.accident as accident
    inner join sql.dbo.vehicle as vehicle on
        accident.accident_index = vehicle.accident_index
group by 
	vehicle_type
order by 
	count(*) desc;

-- light conditions

select 
	light_conditions, 
	count(*) 
from sql.dbo.accident
group by 
	light_conditions
order by 
	count(*) desc;
