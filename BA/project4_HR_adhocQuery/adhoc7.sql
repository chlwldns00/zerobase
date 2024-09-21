
SELECT Department, JobLevel
round (avg (hn.Monthly Income), 1) AS avg_income
, LEAD (round (avg (hn.Monthly Income), 1)) OVER (PARTITION BY Department ORDER BY JobLevel) AS next_level_income
LEAD (round (avg (hn. Monthly Income), 1)) OVER (PARTITION BY Department ORDER BY JobLevel) - round (avg (hn.Monthly Income), 1) AS gap 100 -> 105 (105-100) / 100 = 5/ 100 = 5%
, round(
(LEAD (avg (hn. MonthlyIncome)) OVER (PARTITION BY Department ORDER BY JobLevel) - avg (hn.Monthly Income))
/ avg (hn.Monthly Income) 100
, 1)
As increase_rate
FROM hr.hr_cate hc
LEFT JOIN hr.hr_number hn ON hc.EmployeeNumber = hn. EmployeeNumber
WHERE Attrition = 'No'
GROUP BY 1,2
ORDER BY 1,2
;