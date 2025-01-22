
--PROBLEM 6:  Dates
/*
Create Tables from Other Tables
Question: 
    create three tables: Jan 2023 jobs, Feb 2023 jobs, Mar 2023 jobs
    Foreshadowing: This will be used in another practice problem below.
    HINTS: 
        Use CREATE TABLE table_name AS syntax to create your table.
        Look at a way to filter out only specific months (EXTRACT).
*/

--January
CREATE TABLE january_jobs AS
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1;

--February
CREATE TABLE february_jobs AS
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 2;

--March
CREATE TABLE march_jobs AS
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 3;

SELECT job_posted_date
FROM march_jobs

-- Problem 7 :  SubQueries & CTEs
/*
Find the count of the number of remote job postings per skill
    - Display the top 5 skills by their demand in remote jobs
    - Include skill ID, name, and count of postings requiring the skill 
*/

WITH remote_job_skills AS (
    SELECT
        skill_id,
        COUNT(*) AS skill_count
    FROM 
        skills_job_dim AS skills_to_job
    INNER JOIN job_postings_fact AS job_postings ON job_postings.job_id = skills_to_job.job_id
    WHERE
        job_postings.job_work_from_home = TRUE AND 
        job_postings.job_title_short = 'Data Analyst' -- if we want to look at Data Analyst must skill 
    GROUP BY 
        skill_id
)
SELECT 
    skills.skill_id,
    skills AS skill_name,
    skill_count
FROM remote_job_skills
INNER JOIN skills_dim AS skills ON skills.skill_id = remote_job_skills.skill_id
ORDER BY 
    skill_count DESC
LIMIT 5;


--Problem 8:    Unions
/*
Find job postings from the first quarter that have a salary greater than $70K.
- Combine job posting tables from the first quarter of 2023 (Jan_mar)
- Get job postings with an average yearly salary > $70,000
*/
SELECT 
    quarter1_job_postings.job_title_short,
    quarter1_job_postings.job_location,
    quarter1_job_postings.job_via,
    quarter1_job_postings.job_posted_date::DATE,
    salary_year_avg
FROM (
    SELECT *
    FROM january_jobs
    UNION ALL 
    SELECT *
    FROM february_jobs
    UNION ALL
    SELECT *
    FROM march_jobs
) AS quarter1_job_postings
WHERE
    salary_year_avg > 70000 AND
    job_title_short = 'Data Analyst'
ORDER BY 
    salary_year_avg DESC;