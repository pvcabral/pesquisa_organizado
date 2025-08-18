WITH questoes_por_lista AS (
    SELECT list_id, COUNT(DISTINCT question_id) AS total_questoes
    FROM listhasquestion
    WHERE list_id IN :listas
    GROUP BY list_id
),
submissoes_alunos AS (
    SELECT s.user_id, s.listQuestions_id AS list_id,
           COUNT(DISTINCT CASE WHEN s.hitPercentage = 100 THEN s.question_id END) AS acertos
    FROM submission s
    WHERE s.listQuestions_id IN :listas
      AND s.class_id = :turma
    GROUP BY s.user_id, s.listQuestions_id
)
SELECT a.user_id, a.enrollment, s.list_id, s.acertos, q.total_questoes
FROM classHasUser a
LEFT JOIN submissoes_alunos s ON s.user_id = a.user_id
LEFT JOIN questoes_por_lista q ON q.list_id = s.list_id
WHERE a.class_id = :turma
ORDER BY a.user_id, s.list_id