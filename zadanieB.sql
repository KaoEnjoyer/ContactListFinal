SELECT 
    contract_type,
    AVG(employees_per_enterprise) AS avg_employees,
    AVG(avg_salary) AS avg_salary_per_contract
FROM (
    SELECT 
        enterprise_id,
        contract_type,
        COUNT(*) AS employees_per_enterprise,
        AVG(salary) AS avg_salary
    FROM 
        employment
    GROUP BY 
        enterprise_id, 
        contract_type
) AS enterprise_stats
GROUP BY 
    contract_type;