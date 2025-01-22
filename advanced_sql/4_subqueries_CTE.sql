/*
In Handling Dates exercise, we create 3 tables: january_jobs, february_jobs, march_jobs.
These tables were permanent. And the only way to delete them is by dropping them.

Now imagine we don't need to create an permament tables-not table but temporary result set.
We can create temporary result set using SubQueries and CTEs.
*/

-- Let's make a SubQuery for january_jobs table --
SELECT *
FROM ( -- subquery start here
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1
) AS january_jobs; 
-- subquery ends here 

/*
!!! NOTE: instead of creating a table, it creates a temporary result set 
specifically for only january month data.
*/

-------

/*
    CTEs
    !!! You can either do do subquery or CTEs-both gives you the same result if
    you're looking for same question.
*/
WITH january_jobs AS (
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1
)
SELECT *
FROM january_jobs; 


------

/*
 let's look at harder subqueries problems.
 Let's find companies that don't require degree for the job.
*/

SELECT 
    company_id,
    name AS company_name
FROM 
    company_dim -- reminder: know your table. the company name is not in job_postings_fact but in company_dim.
WHERE company_id IN ( --start of subquery: the company_id is the column that connects company_dim to job_postings_fact table.
    SELECT 
        company_id
       -- job_no_degree_mention
    FROM 
        job_postings_fact
    WHERE
        job_no_degree_mention = true
);


/*
 let's look at harder CTEs problems.
Find the companies that have the most job openings.
- Get the total number of job postings per company id (job_posting_fact)
- Return the total number of jobs with the company name (company_dim)
*/

--these are wrong. just here for view
WITH company_id AS (
    SELECT DISTINCT
        company_id,
        COUNT(job_id) AS job_number
    FROM 
        job_postings_fact
    GROUP BY company_id
)
SELECT 
    COUNT(name) AS jobs_per_company
FROM
    company_dim
LIMIT 10;


SELECT 
    *
FROM 
    company_dim -- outside query b/c 
LIMIT 5;


SELECT 
    *
FROM 
    job_postings_fact -- outside query b/c 
LIMIT 5;


-- Correct solution --

--first, try solving Q1.
SELECT
    company_id,
    COUNT(*) 
FROM
    job_postings_fact
GROUP BY -- let's group by the column that we aggregate to, company_id
    company_id

--now, let's make CTE by defining with WITH statement and end it with the same table_name.
WITH company_job_count AS ( -- company_job_count is a table name-we can name it here
    SELECT
        company_id,
        COUNT(*) 
    FROM
        job_postings_fact
    GROUP BY 
        company_id
)
SELECT *
FROM
    company_job_count; 

-- now we have to join the two tables.
-- Left table is company_dim. Right table is job_postings_fact.
WITH company_job_count AS ( 
    SELECT
        company_id,
        COUNT(*) AS total_jobs --make alias
    FROM
        job_postings_fact
    GROUP BY 
        company_id
)
/*
this is for the Q2
SELECT name 
FROM company_dim
*/
SELECT 
    company_dim.name AS company_name, -- including company_dim we are making sure the name is from this table.
    company_job_count.total_jobs -- we want to know total jobs too-and we make sure total_jobs belongs to which table.
FROM company_dim
LEFT JOIN company_job_count ON company_job_count.company_id = company_dim.company_id
-- note: company_job_count is a table2
ORDER BY 
    total_jobs DESC; --we make sure to put highest job number at top.


--Final and clear query
WITH company_job_count AS ( 
    SELECT
        company_id,
        COUNT(*) AS total_jobs 
    FROM
        job_postings_fact
    GROUP BY 
        company_id
)

SELECT 
    company_dim.name AS company_name, 
    company_job_count.total_jobs 
FROM company_dim
LEFT JOIN company_job_count ON company_job_count.company_id = company_dim.company_id
ORDER BY 
    total_jobs DESC; 
