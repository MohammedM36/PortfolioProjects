Select *
From PortfolioProject..CovidDeaths 
Where continent is not null
order by 3,4


--Select * 
--From PortfolioProject..CovidVaccinations 
--order by 3,4


Select Location, Date, total_cases, new_cases, total_deaths, Population
From PortfolioProject..CovidDeaths
Where continent is not null
order by 1,2


--Looking at Total cases vs Total Deaths

--Shows the likelihood of dying if you contract covid in your country

Select Location, Date, total_cases, total_deaths,
(convert(Float,total_deaths)/nullif(convert(float,total_cases),0)) * 100 as DeathPercentage
From PortfolioProject..CovidDeaths 
Where location like '%India%'
and continent is not null
order by 1,2


--Looking at Total cases vs Population

Select Location, Date, population,  total_cases,
(convert(Float,total_cases)/nullif(convert(float,population),0)) * 100 as PercentPopulationInfected
From PortfolioProject..CovidDeaths 
--Where location like '%India%'
Where continent is not null
order by 1,2



--Looking at Countries wiht highest Infection Rate compared to Population


Select Location, population,  MAX(total_cases) as HighestInfectionCount, MAX
(convert(Float,total_cases)/nullif(convert(float,population),0)) * 100 as PercentPopulationInfected
From PortfolioProject..CovidDeaths 
--Where location like '%India%'
Group by Location, population
order by PercentPopulationInfected desc


--Showing Countries with Highest Death Count per Population

Select Location, MAX(cast(Total_deaths as int)) as TotalDeathCount
From PortfolioProject..CovidDeaths 
--Where location like '%India%'
Where continent is not null
Group by Location 
Order by TotalDeathCount desc






--LET'S BREAK THINGS DOWN BY CONTINENT 


--showing the continents with the highest death count per population


Select continent, MAX(cast(Total_deaths as int)) as TotalDeathCount
From PortfolioProject..CovidDeaths 
--Where location like '%India%'
Where continent is not null
Group by continent 
Order by TotalDeathCount desc



--GLOBAL NUMBERS


Select  Date,SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM
	(new_cases)*100 as Deathpercentage
From PortfolioProject..CovidDeaths 
--Where location like '%India%'
Where continent is not null
Group by date
order by 1,2


--Looking at Total population vs Vaccinations


select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
,SUM(Convert(bigint,vac.new_vaccinations)) OVER (Partition by dea.location Order by dea.location,
 dea.Date) as RollingPeopleVaccinated
 ,(RollingPeopleVaccinated/population)*100
From PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
	on dea.location = vac.location
	and dea.date = vac.date
Where dea.continent is not null
order by 2,3


--Using CTE

with PopvsVac (Continent, Location, Date, Population,New_Vaccinations, RollingPeopleVaccinated)
as
(
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
,SUM(Convert(bigint,vac.new_vaccinations)) OVER (Partition by dea.location Order by dea.location,
 dea.Date) as RollingPeopleVaccinated
 --,(RollingPeopleVaccinated/population)*100
From PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
	on dea.location = vac.location
	and dea.date = vac.date
Where dea.continent is not null
--order by 2,3
)
select * ,(RollingPeopleVaccinated/Population)*100
From PopvsVac


--TEMP TABLE
Drop Table if exists #PercentPopulationVaccinated
Create Table #PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_vaccinations numeric,
RollingPeopleVaccinated numeric
)
Insert into #PercentPopulationVaccinated
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
,SUM(Convert(bigint,vac.new_vaccinations)) OVER (Partition by dea.location Order by dea.location,
 dea.Date) as RollingPeopleVaccinated
 --,(RollingPeopleVaccinated/population)*100
From PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
	on dea.location = vac.location
	and dea.date = vac.date
Where dea.continent is not null
--order by 2,3

select *, (RollingPeopleVaccinated/Population)*100
From #PercentPopulationVaccinated



--CREATING VIEW TO STORE DATA FOR LATER VISUALIZATION

Create view PercentPopulationVaccinated as
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
,SUM(Convert(bigint,vac.new_vaccinations)) OVER (Partition by dea.location Order by dea.location,
 dea.Date) as RollingPeopleVaccinated
 --,(RollingPeopleVaccinated/population)*100
From PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
	on dea.location = vac.location
	and dea.date = vac.date
Where dea.continent is not null
--order by 2,3

Select *
From #PercentPopulationVaccinated
