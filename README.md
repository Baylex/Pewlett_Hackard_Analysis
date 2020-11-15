# Pewlett_Hackard_Analysis
UT McCombs Data Boot Camp Mod 7 Employee Database with SQL

## Overview: 

After reviewing the employee files for Pewlett Hackard, an entity relationship diagram was created using quick database diagrams to gather and organize the key elements from various data tables.  The data was imported using postgres and the pgAdmin interface.  SQL queries were written to create data tables by joining primary keys from different data sets together and establishing foreign keys.  The leadership is concerned about a "silver tsunami," where there is a mass exodus of retiring employees creating a massive amount of job vacancies.  SQL queries were created to generate a list of retiring employees by title and a list of employees eligible for mentorship.    

Employee database relationship diagram for Pewlett Hackard:
![Pic 1](https://github.com/Baylex/Pewlett_Hackard_Analysis/blob/main/Analysis_Projects/HP_Analysis/Challenge_Documents/EmployeeDB.png)

## Results: 

1. With the first review of creating a list of potential "silver tsunamis," the query resulted in many duplicates due having multiple positions.
![Pic 2](https://github.com/Baylex/Pewlett_Hackard_Analysis/blob/main/Analysis_Projects/HP_Analysis/Challenge_Documents/duplicates_titles_pic.PNG)

2. Using the 'distinct on' SQL script, the duplicates were removed leaving the most recent job title to create a unique list of retiring employees.  

![Pic 3](https://github.com/Baylex/Pewlett_Hackard_Analysis/blob/main/Analysis_Projects/HP_Analysis/Challenge_Documents/unique_titles_pic.PNG)

3. Retiring Counts by Title for a total of 90,398 potential retirees.  
![Pic 4](https://github.com/Baylex/Pewlett_Hackard_Analysis/blob/main/Analysis_Projects/HP_Analysis/Challenge_Documents/Retiring_count_titles.PNG) 


4. Mentor Eligibility List of 1549 employees born in 1965.
![Pic 4](https://github.com/Baylex/Pewlett_Hackard_Analysis/blob/main/Analysis_Projects/HP_Analysis/Challenge_Documents/mentor_list.PNG)

## Summary: 
How many roles will need to be filled as the "silver tsunami" begins to make an impact?
The "silver tsunami" will have a significant impact of leaving 90398 vacancies.  

Are there enough qualified, retirement-ready employees in the departments to mentor the next generation of Pewlett Hackard employees?

Using the criteria of those born in 1965, the potential mentee list is 1,549 employees.  The gap between approximately 90,000 and 1,500 is significant.  

Creating a new query to further investigate the gap, compare the counts of the retiring and mentor eligible counts by titles.  There is a reasonable ratio of titles between to the two tables.   It is concnerning that no managers meet the mentor eligibilty requirement.  

To move forward with the approximantly 1,500 potential mentee list, the list of more than 90,000 retiring employees was narrowed to close the gap of matching mentor to mentee.  The mentor list was narrowed by being around age 35 when they started their current job title resulting in 5,521 employees that could be matched with the 1,549 mentees.  

Lessons form creating a mentoring program with the 1,549 mentees as a pilot program, can be studiesd and then expanded to more potential mentees by expanding the date criteria.
