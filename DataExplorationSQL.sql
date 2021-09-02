/* 
Data exploration using SQL 
Covid data extracted from 18th Jan upto 27th July.
Data taken from https://ourworldindata.org/covid-deaths
*/


select* 
from PortfolioProject..CovidDeaths order by 3,4;

select *
from PortfolioProject..CovidVaccinations order by 3,4;

--Total deaths vs Total cases 
Select location, date, total_cases, total_deaths, (total_cases/total_deaths)*100 as Death_Percentage
from PortfolioProject..CovidDeaths
order by 1,2

--Total deaths vs Total cases in India
Select Location, date, total_cases,total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
From PortfolioProject..CovidDeaths
Where location like '%India%'
and continent is not null 
order by 1,2

--Total cases vs population in India
--Showing what percentage of population contracted covid
Select location, date,population,total_cases, (total_cases/total_deaths)*100 
as Percent_Population_infected
from PortfolioProject..CovidDeaths
where location like 'India'
order by 1,2

-- Death percentage of entire world 
Select 'world' as location,SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths,
SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentage
From PortfolioProject..CovidDeaths
where continent is not null 
order by 1,2

--Total Death count according to continents
Select location, SUM(cast(new_deaths as int)) as TotalDeathCount
From PortfolioProject..CovidDeaths
Where continent is null 
and location not in ('World', 'European Union', 'International')
Group by location
order by TotalDeathCount desc

--Percentage of population affected in each country 
Select Location, Population, MAX(total_cases) as HighestInfectionCount,  
Max((total_cases/population))*100 as PercentPopulationInfected
From PortfolioProject..CovidDeaths
Group by Location, Population
order by PercentPopulationInfected desc

-- Details including date
Select Location, Population,date, MAX(total_cases) as HighestInfectionCount,  Max((total_cases/population))*100 as PercentPopulationInfected
From PortfolioProject..CovidDeaths
Group by Location, Population, date
order by PercentPopulationInfected desc

