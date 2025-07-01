WITH female_grandchildren AS (
    SELECT 
        g.id AS grandparent_id,
        COUNT(DISTINCT gc.id) AS female_grandchildren_count
    FROM 
        person g
    JOIN 
        person p ON (p.mother_id = g.id OR p.father_id = g.id)
    JOIN 
        person gc ON (gc.mother_id = p.id OR gc.father_id = p.id)
    WHERE 
        gc.gender = 'F'
    GROUP BY 
        g.id
)
SELECT 
    p.first_name, 
    p.last_name
FROM 
    person p
JOIN 
    female_grandchildren fg ON p.id = fg.grandparent_id
ORDER BY 
    fg.female_grandchildren_count DESC
LIMIT 1;