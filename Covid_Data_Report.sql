/* a. Datewise likewood of dying due to covid- totalcase vs totaldeath in india. */

select date, total_cases, total_cases 
	from "CovidDeaths" 
	where location like '%India%' ;

/* b.Total % of death out of entire population in india.*/

select (max(total_deaths)/avg(cast(population as integer)) )*100 as totaldeath
	from "CovidDeaths" 
	where location like '%India%';

/* c. Verify by getting in seprately.*/

select total_deaths, population from "CovidDeaths" where location like '%India%';

/* d. Country with highest death as % of population.*/
select location,(max(total_deaths)/avg(cast(population as bigint)) *100) 
	as totaldeath
	from "CovidDeaths" group by location order by totaldeath desc; 

/* e. Total % of covid +ve case in india.*/
select  location,(max(total_cases)/avg(cast(population as bigint))*100) as positivecase
	from "CovidDeaths" where location like '%India%' group by location ;

/* f. Total % of covid +ve case in World.*/
select  location,(max(total_cases)/avg(cast(population as bigint))*100) as positivecase
	from "CovidDeaths" group by location order by positivecase desc;
/* g. continetwise +ve case.*/
select  location,max(total_cases) as total_case
	from "CovidDeaths" where  continent is null group by location order by total_case desc;
 
/* h. continentwise death.*/
select  location,max(total_deaths) as death_case
	from "CovidDeaths" where continent is null group by  location order by death_case desc;

/* i. Daily newscase vs hospitalization vs icu_patient in india.*/
select date, new_cases, hosp_patients, icu_patients
	from "CovidDeaths"
    where location like '%India%';

/* j. country wise age 65>.*/

select cd.date,cd.location, cv.aged_65_older
	from "CovidDeaths" cd join "CovidVaccinations" cv
     on cd.iso_code = cv.iso_code and cd.date = cv.date;

/* k. country wise toatl vaccinated persons.*/

select cd.location, max(cv.people_fully_vaccinated) as fully_vaccinated
	from "CovidDeaths" cd join "CovidVaccinations" cv 
    on cd.iso_code = cv.iso_code 
	where cd.continent is not null
	group by cd.location order by fully_vaccinated desc;
