
-- UNION 

-- Getting jobs and companies from January
SELECT 
    job_title_short,
    company_id,
    job_location
FROM 
    january_jobs

UNION -- combine another table

-- Getting jobs and companies from february
SELECT 
    job_title_short,
    company_id,
    job_location
FROM 
    february_jobs

UNION -- combine another table

-- Getting jobs and companies from March
SELECT 
    job_title_short,
    company_id,
    job_location
FROM 
    march_jobs




-- ALL UNION

-- Getting jobs and companies from January
SELECT 
    job_title_short,
    company_id,
    job_location
FROM 
    january_jobs

UNION ALL -- combine another table

-- Getting jobs and companies from february
SELECT 
    job_title_short,
    company_id,
    job_location
FROM 
    february_jobs

UNION ALL -- combine another table

-- Getting jobs and companies from March
SELECT 
    job_title_short,
    company_id,
    job_location
FROM 
    march_jobs



