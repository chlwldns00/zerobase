
-- 과제 5

select Department, JobRole, JobLevel, count(*) as HC
from ba4_hr.hr_employee_attrition hea where 1=1
and Attrition = 'NO'
and YearsAtCompany >= 5
and YearsAtCompany
YearsInCurrentRole
and YearsSinceLastPromotion > 1
group by 1,2,3
order by 3 desc
;

