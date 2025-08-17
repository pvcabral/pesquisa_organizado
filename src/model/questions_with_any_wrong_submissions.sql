SELECT 
    s.question_id,
    COUNT(DISTINCT s.id) AS total_wrong_submissions,
    q.title
FROM lop2teste.submission s
LEFT JOIN lop2teste.question q ON q.id = s.question_id
WHERE s.class_id = 'd0122069-129b-4207-812d-ab50a082eb18'
  AND s.hitPercentage = 0
GROUP BY s.question_id, q.title
ORDER BY total_wrong_submissions DESC;
