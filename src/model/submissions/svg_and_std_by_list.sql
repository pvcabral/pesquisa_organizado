SELECT 
    s.listQuestions_id AS list_id,
    l.title AS list_name,
    ROUND(AVG(s.TimeConsuming), 2) AS avg_time,
    ROUND(STDDEV_POP(s.TimeConsuming), 2) AS stddev_time
FROM submission s
LEFT JOIN listquestions l ON l.id = s.listQuestions_id
WHERE s.class_id = '8813d508-dc24-47e2-a33f-8d2ca66cab29'
  AND l.id IS NOT NULL
GROUP BY s.listQuestions_id, l.title
ORDER BY avg_time DESC;