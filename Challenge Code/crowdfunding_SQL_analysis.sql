-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- Link to schema: https://app.quickdatabasediagrams.com/#/d/5JiDL7
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.
-- written by EMPRR

-- Challenge Bonus queries.
-- 1. (2.5 pts)
-- Retrieve all the number of backer_counts in descending order for each `cf_id` for the "live" campaigns. 
SELECT ca.backers_count,
	ca.cf_id,
	ca.outcome
FROM campaign as ca
WHERE (ca.outcome = 'live')
ORDER BY ca.backers_count DESC;

-- 2. (2.5 pts)
-- Using the "backers" table confirm the results in the first query.
SELECT COUNT(b.cf_id), 
	b.cf_id,
	ca.outcome
FROM backers as b
LEFT JOIN campaign as ca
ON (b.cf_id = ca.cf_id)
WHERE (ca.outcome = 'live')
GROUP BY (b.cf_id, ca.outcome)
ORDER BY count DESC;

-- 3. (5 pts)
-- Create a table that has the first and last name, and email address of each contact.
-- and the amount left to reach the goal for all "live" projects in descending order. 
SELECT
	co.first_name,
	co.last_name,
	co.email,
	(ca.goal - ca.pledged) AS left_to_goal
FROM contacts as co
LEFT JOIN campaign as ca
ON (co.contact_id = ca.contact_id)
WHERE (ca.outcome = 'live')
ORDER BY left_to_goal DESC
;

-- 4. (5 pts)
-- THIS QUERY REUSED FOR BOTH FINAL DELIVERABLE TABLES IN THE DATABASE
-- Create a table, "email_backers_remaining_goal_amount" that contains the email address of each backer in descending order, 
-- and has the first and last name of each backer, the cf_id, company name, description, 
-- end date of the campaign, and the remaining amount of the campaign goal as "Left of Goal". 
SELECT
	b.email,
	b.first_name,
	b.last_name,
	ca.cf_id,
	ca.company_name,
	ca.description,
	ca.end_date,
	(ca.goal - ca.pledged) AS left_to_goal
INTO email_backers_remaining_goal_amount
FROM backers as b
INNER JOIN campaign as ca
ON (b.cf_id = ca.cf_id)
WHERE (ca.outcome = 'live')
ORDER BY b.last_name ASC
;

-- Check the table
SELECT * from email_backers_remaining_goal_amount;

