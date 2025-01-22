-- Manipulate Tables Example
-- The following statements are used to manipulate tables.

-- Creating table --

CREATE TABLE job_applied (
    job_id INT, 
    application_sent_date DATE,
    custome_resume BOOLEAN, 
    resume_file_name VARCHAR(255),
    cover_letter_sent BOOLEAN,
    cover_letter_file_name VARCHAR(255),
    status VARCHAR(50)
);

-- Inserting data into --

INSERT INTO job_applied
            (job_id,
            application_sent_date,
            custome_resume,
            resume_file_name,
            cover_letter_sent,
            cover_letter_file_name,
            status)
VALUES      (1,
            '2024-02-01',
            true,
            'resume_01.pdf',
            true,
            'cover_letter_01.pdf',
            'submitted'),
            (2,
            '2024-02-02',
            false,
            'resume_02.pdf',
            false,
            NULL,
            'interview scheduled'),
            (3,
            '2024-02-03',
            true,
            'resume_03.pdf',
            true,
            'cover_letter_03.pdf',
            'ghosted'),
            (4,
            '2024-02-04',
            true,
            'resume_04.pdf',
            false,
            NULL,
            'submitted'),
            (5,
            '2024-02-05',
            false,
            'resume_05.pdf',
            true,
            'cover_letter_05.pdf',
            'rejected');
            
 SELECT *
 FROM job_applied;     

 -- Altering table: add, delete, or modify columns --

ALTER TABLE job_applied
ADD contact VARCHAR(50);

SELECT *
FROM job_applied

-- Updating existing data: update, set, where --

UPDATE job_applied
SET    contact = 'Erlich Bachman'
WHERE  job_id = 1;

UPDATE job_applied
SET    contact = 'Dinesh Chugtai'
WHERE  job_id = 2;

UPDATE job_applied
SET    contact = 'Bertram Gilfoyle'
WHERE  job_id = 3;

UPDATE job_applied
SET    contact = 'Jian Yang'
WHERE  job_id = 4;

UPDATE job_applied
SET    contact = 'Big Head'
WHERE  job_id = 5;

-- Renaming Column --

ALTER TABLE job_applied
RENAME COLUMN contact TO contact_name; 

ALTER TABLE job_applied
RENAME COLUMN custome_resume TO custom_resume; 

SELECT *
FROM job_applied

-- Altering Column: change data type, set/change default value, drop default value --

ALTER TABLE job_applied
ALTER COLUMN contact_name TYPE TEXT; 
-- change column's data type: contact_name CHARAC VARYING(50) to TEXT
-- NOTE: tho there are some limitations. strings can't be changed to integer and vice versa.
SELECT *
FROM job_applied

-- Dropping Column --

ALTER TABLE job_applied
DROP COLUMN contact_name;
-- I am not dropping any column and table here but if I had run it there would be no column and table.

-- Dropping Table --
DROP TABLE job_applied; 

-- Be extremely careful whenever you are doing DROP COLUMN or DROP TABLE as it is
    --is extremely permanent. 