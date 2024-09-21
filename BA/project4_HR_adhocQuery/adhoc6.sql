SELECT Department, JobLevel, JobRole
, avg (hn.Monthly Income) AS avg_MonthlyIncome
9
10
, avg (hn. PercentSalaryHike) AS avg_PercentSalaryHike
11
, avg (hn.Monthly Income
12
, avg (hn.Monthly Income
13 FROM hr.hr cate hc
(1 + hn. Percent SalaryHike/100)) AS next_year_Monthly Income (1+ hn. Percent SalaryHike/100)) 12 AS next_year_Income
14 LEFT JOIN hr.hr_number hn ON hc.Employee Number - hn. EmployeeNumber 15 WHERE Attrition
16 GROUP BY 1,2,3
'No'
17
18
19