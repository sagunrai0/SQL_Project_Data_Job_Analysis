--Advanced: Handling Dates ---

SELECT '2023-02-19'; -- it gives a string 

SELECT '2023-02-19' :: DATE ; -- this converts the datatype in date format.

-- Let's try some others:
SELECT 
    '2023-02-19'::DATE,
    '123'::INTEGER,
    'true'::BOOLEAN,
    '3.14'::REAL; 

-- Example
-- Notice that in our orignial data we have date and timestamp w/o time zone.
SELECT 
    job_title_short AS title,
    job_location AS location,
    job_posted_date AS date
FROM
    job_postings_fact
LIMIT 5; 

-- Let's say we don't want the timestamp in job_posted_date, instead we want only DATE.
SELECT 
    job_title_short AS title,
    job_location AS location,
    job_posted_date::DATE AS date -- it automatically clean up and remove the time.
FROM
    job_postings_fact
LIMIT 5; 
 
-- Let's go back to our date and timestamp w/o time zone, but now we want to have the time zone.
SELECT 
    job_title_short AS title,
    job_location AS location,
    job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST' AS date_time
FROM
    job_postings_fact
LIMIT 5; 

-- NOTE: You can google postgres documentation to see all time zones out there. 
-- postgresql.org/docs/7.2/timezones.html


-- Extract: year, month, day
SELECT 
    job_title_short AS title,
    job_location AS location,
    job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST' AS date_time,
    EXTRACT(MONTH FROM job_posted_date) AS date_month,
    EXTRACT(YEAR FROM job_posted_date) AS date_year
FROM
    job_postings_fact
LIMIT 5; 

/*
what is extract useful for? 
it is really useful when we use this w/ the combination of like GROUP BY function,
we could do larger trend w/ SQL. Specifically, let's say we want to look for how job
postings are looking from month to month, we can start w/ this:
*/
SELECT 
    COUNT(job_id) AS job_posted_count, -- we're aggregrating by using COUNT of this job_id for each month.
    EXTRACT(MONTH FROM job_posted_date) AS month
FROM
    job_postings_fact
WHERE 
    job_title_short = 'Data Analyst' -- specifying for DA
GROUP BY
    month
ORDER BY
    job_posted_count DESC; -- order by count; 


/*
PRACTICE QUESTIONS
Q1. write a query to find the average salary both yearly (salary_year_avg) and hourly (salary_hour_avg) for 
job postings that were posted after June 1, 2023. Group the results by job schedule type.

Q2. Write a query to count the number of job postings for each month in 2023, adusting the job_posted_date, to be
in 'America/New_York' time zone before extracting (hint) the month. Assume the job_posted_date is stored in UTC. 
Group by and order by the month.

Q3. Write a query to find companies (include company name) that have posted jobs offering health insurance, where
these postings were made in the second quarter of 2023. Use data extraction to filter by quarter.
*/

