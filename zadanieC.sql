WITH FamilyMembers AS (
    SELECT p1.id AS person_id, p1.salary
    FROM Person p1

    UNION

    SELECT spouse.id, spouse.salary
    FROM Person p
    JOIN Person spouse ON spouse.id = p.spouse_id

    UNION

    SELECT child.id, child.salary
    FROM Person p
    JOIN Person child ON child.mother_id = p.id OR child.father_id = p.id

    UNION

    SELECT parent.id, parent.salary
    FROM Person p
    LEFT JOIN Person parent ON p.mother_id = parent.id OR p.father_id = parent.id
),
FamilyGroups AS (
    SELECT person_id, SUM(salary) AS total_salary
    FROM FamilyMembers
    GROUP BY person_id
),
LeastPaidFamily AS (
    SELECT person_id
    FROM FamilyGroups
    ORDER BY total_salary ASC
    LIMIT 1
)
SELECT first_name, last_name
FROM Person
WHERE id = (SELECT person_id FROM LeastPaidFamily);
