/*
Question: What are the top skills based on salary?
- Look at the average salary associated with each skill for Data Analyst positions
- Focuses on roles with specified salaries, regardless of location
- Why? It reveals how different skills impact salary levels for Data Analysts and helps identify
  the most financially rewarding skills to acquire or improve
*/

SELECT
    skills,
    ROUND(AVG(salary_year_avg), 0) as avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL 
GROUP BY 
    skills
ORDER BY
    avg_salary DESC
LIMIT 25 ; 

/*
Here's a breakdown of the results for top paying skills for data analyst.
- Hight demand for BigData & ML Skills: top salaries are commanded by analyst skilled in big data technologies (PySpark, Couchbase),
  machine learning tools (DataRobot, Jupyter), and Python libraries (Pandas, NumPy).
- Software development & development proficiency: knowledge in development and deployment tools (GitLab, Kubernetes, Airflow).
- Cloud computing expertise: familiarity with cloud and data engineering tools (Elasticsearch, Databricks, GCP)