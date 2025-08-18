SELECT 
    DATE(created_at) AS submission_date,
    COUNT(*) AS total_submissions
FROM submission
WHERE class_id = '8813d508-dc24-47e2-a33f-8d2ca66cab29'
GROUP BY DATE(created_at)
ORDER BY submission_date;