SELECT 
    s.user_id,
    YEARWEEK(s.createdAt, 1) AS year_week,
    COUNT(s.id) AS total_submissions
FROM lop2teste.submission s
WHERE s.class_id = '8813d508-dc24-47e2-a33f-8d2ca66cab29'
  AND s.user_id IS NOT NULL
GROUP BY s.user_id, YEARWEEK(s.createdAt, 1)
ORDER BY total_submissions DESC;