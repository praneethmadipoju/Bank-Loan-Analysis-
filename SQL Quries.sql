create database Bank_Loan_analysis;

use Bank_Loan_analysis;

select * from finance_1;
select count(*) from finance_1;

select * from finance_2;
select count(*) from finance_2;


/*
--Year wise loan amount Stats
--Grade and sub grade wise revol_bal
--Total Payment for Verified Status Vs Total Payment for Non Verified Status
--State wise and month wise loan status
--Home ownership Vs last payment date stats

*/

-- KPI 1 --

select year(issue_d) as year_of_issue_d ,sum(loan_amnt) as Total_loan_amnt
from finance_1
group by year_of_issue_d
order by year_of_issue_d;

-- KPI 2 --

select 
grade, sub_grade, sum(revol_bal) as Total_revol_bal
from finance_1 inner join finance_2
on (finance_1.id=finance_2.id)
group by grade, sub_grade
order by grade, sub_grade;

-- KPI 3 --

select verification_status, 
concat("$", format(round(sum(Total_pymnt)/1000000,2),2),"M") as total_pymnt
from finance_1 inner join finance_2
on (finance_1.id=finance_2.id)
group by verification_status; 

-- KPI 4 --

select addr_state, last_credit_pull_d, loan_status 
from finance_1 inner join finance_2
on (finance_1.id=finance_2.id)
group by addr_state, last_credit_pull_d, loan_status 
order by last_credit_pull_d;

-- KPI 5 --

select home_ownership, last_pymnt_d,
concat("$", format(round(sum(last_pymnt_amnt)/10000,2),2),"K") as total_pymnt
from finance_1
 inner join 
 finance_2
on (finance_1.id=finance_2.id)
group by home_ownership, last_pymnt_d
order by last_pymnt_d desc, home_ownership desc;



