use pratice;
select * from ai_job_trends_dataset;
select distinct RequiredEducation from ai_job_trends_dataset;
#setting for safe updates
SET SQL_SAFE_UPDATES = 0;

#Changing the format of Bachelor degree
UPDATE ai_job_trends_dataset
SET `Required Education` = 'Bachelor degree'
WHERE `Required Education` = 'Bachelorâ€™s Degree';

# cleaning the education column
UPDATE ai_job_trends_dataset
SET `Required Education` = 'master degree'
WHERE `Required Education` IN (
    'Masterâ€™s Degree', 'Masters Degree', 'Master’s Degree', 'Master''s Degree'
);

#Top 10 Highest Paying Jobs at High Risk of Automation
SELECT `Job Title`, `Median Salary (USD)`, `Automation Risk (%)`
FROM ai_job_trends_dataset
WHERE `Automation Risk (%)` > 70
ORDER BY `Median Salary (USD)` DESC
LIMIT 10;

#Average Salary and Automation Risk by Industry
SELECT `Industry`,
       ROUND(AVG(`Median Salary (USD)`), 0) AS avg_salary,
       ROUND(AVG(`Automation Risk (%)`), 1) AS avg_automation_risk
FROM ai_job_trends_dataset
GROUP BY `Industry`
ORDER BY avg_automation_risk DESC;

#Jobs With High AI Impact but Increasing Demand
SELECT `Job Title`, `AI Impact Level`, `Job Status`, `Projected Openings (2030)`
FROM ai_job_trends_dataset
WHERE `AI Impact Level` = 'High'
  AND `Job Status` = 'Increasing'
ORDER BY `Projected Openings (2030)` DESC;

#Calculate Salary Growth Potential Between 2024 and 2030
SELECT `Job Title`,
       `Median Salary (USD)`,
       `Job Openings (2024)`,
       `Projected Openings (2030)`,
       ROUND((`Projected Openings (2030)` - `Job Openings (2024)`) / `Job Openings (2024)` * 100, 1) AS growth_percentage
FROM ai_job_trends_dataset
WHERE `Job Openings (2024)` > 0
ORDER BY growth_percentage DESC
LIMIT 10;

#Find Roles That Can Go Fully Remote
SELECT `Job Title`, `Remote Work Ratio (%)`, `Median Salary (USD)`
FROM ai_job_trends_dataset
WHERE `Remote Work Ratio (%)` = 100
ORDER BY `Median Salary (USD)` DESC;

#Compare Education Levels by Average Salary
SELECT `Required Education`,
       COUNT(*) AS job_count,
       ROUND(AVG(`Median Salary (USD)`), 0) AS avg_salary
FROM ai_job_trends_dataset
GROUP BY `Required Education`
ORDER BY avg_salary DESC;

#Use a Window Function: Rank High-Paying Jobs Per Industry
SELECT `Job Title`, `Industry`, `Median Salary (USD)`,
       RANK() OVER (PARTITION BY `Industry` ORDER BY `Median Salary (USD)` DESC) AS salary_rank
FROM ai_job_trends_dataset;

#Entry-Level Jobs with High Remote Potential
SELECT `Job Title`, `Median Salary (USD)`, `Remote Work Ratio (%)`, `Experience Required (Years)`
FROM ai_job_trends_dataset
WHERE `Experience Required (Years)` <= 2
  AND `Remote Work Ratio (%)` >= 70
ORDER BY `Median Salary (USD)` DESC;

# Filter by Country 
SELECT `Job Title`, `Location`, `Median Salary (USD)`
FROM ai_job_trends_dataset
WHERE `Location` = 'USA'
ORDER BY `Median Salary (USD)` DESC
LIMIT 10;

