# An analysis of Alpine F1 team and McLaren's performance in the 2022 Formula 1 Constructors’ World Championship.

[View Presentation on Tableau](https://public.tableau.com/shared/CJWJ8HQZH?:display_count=n&:origin=viz_share_link)

## Background:
There have been 10 teams competing for the constructors championship since 2016 in Formula 1 (F1). Three teams have dominated the top standings since then. Given the budgets and resources available, it was difficult for other teams to break into that barrier. The introduction of a cost cap ($145m) in 2021 intended to reduce the financial advantage these teams had and increase the level of competition across the 10 teams on the grid. In 2022, the race between McLaren and Alpine F1 team mid teams for fourth place were very close throughout the season.

## Objective: 
Our aim was to analyze the performance of McLaren and the Alpine F1 team using factors that impacted results across different races. Based on the results, we could conclude whether the cost cap had an effect on the 2022 season. Results were measured using the following metrics: 
* Championship points per team.
* Team with least number of incidents due to mechanical failure. 
* Driver performance per race (point earning consistency, position gains, least incidents due to crash/collision).

## Target audience:
This project is intended for Formula 1 fans who are also interested in sports analytics. As data-driven decision making continues to influence the evolution of sports, the interest in big data from fans has been growing.  It is the intention to have these results compared to the 2023 season and further developed into a predictive model for future seasons. 

## Data Collection:
 Data for this project was collected from [Kaggle](https://www.kaggle.com/datasets/rohanrao/formula-1-world-championship-1950-2020).
 Data set was originally compiled from [ergast.com](http://ergast.com/mrd/) by Rohan Rao. 
 
## Methodology: 
### Data quality check and preliminary analysis.
Data downloaded from Kaggle was already organized into 14 cvs files, 644,7200 rows and 121 columns in total, which was easier to use than from the original source at ergast.com. 
Preliminary data quality check was done in excel. The following issues were identified:
* Names with special characters appeared incorrectly. E.g. “R√§ikk√∂nen” instead of “Räikkönen”.
* Data stretched from 1950-2023. Changes to the sport over time resulted in missing data for categories depending on the year. For example:
*	The driver number system was not introduced officially until 1974 and driver code names only appeared in the 90’s. 
*	World Constructors’ Champion (or its equivalent title did not exist until 1958). 
*	Sprint races were introduced in 2021 and only occurs at some of the Grand Prix. It is still in the testing phase. 
*	Free practice sessions and qualifying race start times are not available prior to 2022.
*	Constructors no longer exist or rebranded under a new name, some more than once. For example:
    * Renault --> Alpine
    * Spyker F1 --> Force India --> Racing Point --> Aston Martin
    * Sauber --> Alfa Romeo 
*	Some tables used ID numbers only, other tables were a reference key for these IDs.
*	Some missing data which was indicated by N or sometimes blank. 
*	Lap times were separated into two columns (time, milliseconds) but milliseconds were not included for fastest lap time.
*	There were no duplicates in the data. 

### Based on the above observations the following actions were taken: 
1.	Created a new database by importing the files downloaded locally using SQLite on DBeaver. 
2.	Narrow the scope of the analysis and define objectives and key KPIs.
3.	Range of data was reduced to 2022 only.
4.	“Midfield team” was defined as any competing team that placed below 3rd in the Constructors Championship. “In competition for 4th” was defined as a team having earned 35 points and above in the Constructors Championship.  
5.	SQL queries were done utilizing joins to generate tables based on the above parameters.
    * driver performance per race by completion status, position gained/lost end of race and points in race. 
    * constructor performance by race
    * pit stop strategy per race
    * driver qualifying lap performance
    * driver sprint performance
    * driver race performance per lap
6.	Gained/lost position was calculated per race per driver. 
7.	Drivers date of birth was used to calculate age. Age column was used instead for driver data. 
9.	Where there is missing information or N:
    * These must remain as is in the dataset since they indicate where a driver did not participate/finish, incurred a penalty or was disqualified in an event or in the case of sprint races, where the event was not held. 
10.	No names within the 2022 driver list had issues with special characters so correction was not needed. 
11. Sprint points were left seperate from driver points. 

#### Updates from preliminary analysis:
1.  All teams that participated in the 2022 season were included in this project. 
2.  Focus teams for 4th position was narrowed down to McLaren and the Alpine F1 team since a large gap between 5th and 6th place on the constructors table was identified upon further analysis. 
3.  While this project compares McLaren and the Alpine F1 team, the interactive charts in the presentation allow users to compare other teams’ performance as well. 
4.  An interactive dashboard was created to allow users to view individual driver performance and team pit strategy per race. 
5.  Data cleaning was done in excel and SQL, aggregate calculations were performed in SQL and tableau. It was decided that Python was not necessary for this project however, the fasf1 python package will be utilized for future analysis. 
6.  Tyre strategy analysis was not included as originally planned due to time constraints. It will be included as an update to this project. 

## Results
The analysis answered the following questions regarding McLaren and the Alpine F1 team: 
1.  Which team had the most reliable car?
      + McLaren was identified as having the most reliable car since they had fewer mechanical incidents throughout the season. 
2.  Which team driver had the most consistent performance? 
      + McLaren - Lando Norris with an average starting position of 8 and finish position of 8 on the grid. 
      + Alpine F1 Team - Fernando Alonso with an average starting position of 9 and finish position of 9 on the grid.  
      + On average, both drivers were more likely to at least maintain position on the grid and earn points in a race, improving their team’s overall chance of moving up in standings.
<img width="1426" alt="Screenshot 2023-10-08 at 3 57 51 PM" src="https://github.com/Krysahoy/F1_analysis_2022/assets/116768441/a893a782-5a95-47b4-9042-04a7782e44e6">


3.  Which team had the most consistent driver duo performance?
      + The Alpine F1 Team had a more consistent points distribution between the drivers than McLaren which saw the majority of the team's points coming from Lando.
       <img width="862" alt="Screenshot 2023-10-08 at 3 51 23 PM" src="https://github.com/Krysahoy/F1_analysis_2022/assets/116768441/d5f0e790-774c-4c57-a26a-9c90c94be2e3">


4.  Give an example of when pit stop strategies positively/negatively affect Championship standings. Were there external factors involved? 
      + Using the [Dashboard](https://public.tableau.com/shared/7S2RC3ZR3?:display_count=n&:origin=viz_share_link) to view the Imola race, we can see that Lando used the recommended 1 stop pit strategy to his advantage. This earned him a podium finish (3rd place) and 15 points. His teammate Daniel Ricciardo was forced to use a 3 stop pit strategy due to causing a collision incident. Daniel started 6th on the grid and finished 18th. This series of events contributed to him slipping far on the grid. For the Alpine F1 team, Alonso was forced to retire in the first lap due to a collision with another driver and Ocon incurred a time penalty due to an unsafe release during his pit stop. As a result, McLaren was able to gain 22 points to Alpine’s zero, maintaining their Constructor championship 4th standing after that race.
        
        <img width="1414" alt="Screenshot 2023-10-08 at 4 33 11 PM" src="https://github.com/Krysahoy/F1_analysis_2022/assets/116768441/a205fd10-6f76-40c1-a09e-507339265173">

5.  Do sprint race results improve race day chances of earning points?
      + Using Imola as an example again, both Lando and Daniel of McLaren were able to gain points (4 and 3 respectively) in the sprint race. This helped boost their final points total (15+ 4+3 = 22). Overall, performance in sprint races did not have a major influence on race day performance but points earned during sprint races did contribute positively to overall points for driver and constructor standings. 
6.  Did the cost cap make a difference in the constructor standings in the 2022 season?
     + By the end of the season, there was a 342 point gap between 3rd and 4th positions on the constructors standings. At the start of the season, McLaren being 4th place constructors in 2021 were aiming to be a possible contender for 3rd in 2022. This goal changed to maintaining the 4th place position in 2022. Based on the results, we can infer that had Daniel Riccardo performed as well as his teammate, they would have placed 4th. On the other hand, even in that scenario, the gap between 3rd and 4th was too great for McLaren to have been considered a serious contender for 3rd. Regarding the Alpine F1 team, even if they were able to produce a more reliable car for Alonso, they would not have been able to provide a car that could contest 3rd position. In conclusion we can say that the effect of the cost cap was not immediately seen in the 2022 season. The regulation change may influence results in the long run, therefore a yearly analysis should be done to be able to determine effects over a period of time.
  
       
     <img width="1447" alt="Screenshot 2023-10-08 at 3 54 10 PM" src="https://github.com/Krysahoy/F1_analysis_2022/assets/116768441/8ab532f3-4a25-4602-8087-16a28e8a81d1">
    
