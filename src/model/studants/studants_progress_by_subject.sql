WITH listas AS (
    SELECT 'expressoes' AS assunto, '4f3452ae-87d4-4a5f-9532-c7634da2cff0' AS list_id
    UNION ALL
    SELECT 'expressoes', '70e6c800-7583-485d-ac9f-9c42c48dd785'
    UNION ALL
    SELECT 'expressoes', '42d5c4ad-7b44-4e4e-b2e5-2997785132c8'
    
    UNION ALL
    SELECT 'estrutura_de_decisao', 'dbfcc83c-f014-44ae-8260-f06d4e1370ba'
    UNION ALL
    SELECT 'estrutura_de_decisao', '70d1aa7e-00cb-4428-892f-9ac67cc50449'
    UNION ALL
    SELECT 'estrutura_de_decisao', 'f5b1d992-68de-4854-97d8-c4bd84bd593b'
    
    UNION ALL
    SELECT 'repeticao_condicional', 'dd1cd083-6c00-4605-9ff1-163bd4069363'
    UNION ALL
    SELECT 'repeticao_condicional', '0a2c49a2-482c-40d7-bc44-ee368f089560'
    UNION ALL
    SELECT 'repeticao_condicional', 'aca84206-87b2-4478-afa4-6193119cc06a'
    
    UNION ALL
    SELECT 'repeticao_contada', '34691c68-f01d-46ad-808d-6bbd44bcd9a2'
    UNION ALL
    SELECT 'repeticao_contada', '813dedaa-0989-489b-9804-3850ae4b83d1'
    UNION ALL
    SELECT 'repeticao_contada', 'f5bc770d-2ac7-4060-ab1c-e42b5541f7a7'
    
    UNION ALL
    SELECT 'vetores', '93cd33c4-109a-401e-87e9-e26ff5929d37'
    UNION ALL
    SELECT 'vetores', 'c4d09d1b-73a5-45c6-8a0d-ead669114b65'
    UNION ALL
    SELECT 'vetores', '1551e3ed-c875-4bb3-8e4e-58407df40776'
),
alunos AS (
    SELECT id AS enrollment, user_id, class_id
    FROM lop2teste.classHasUser
    WHERE class_id = '8813d508-dc24-47e2-a33f-8d2ca66cab29'
),
submissoes AS (
    SELECT 
        s.user_id,
        l.assunto,
        s.hitPercentage,
        s.question_id
    FROM lop2teste.submission s
    LEFT JOIN listas l
        ON s.listQuestions_id = l.list_id
    WHERE s.class_id = '8813d508-dc24-47e2-a33f-8d2ca66cab29'
      AND s.listQuestions_id IN (SELECT list_id FROM listas)
)
SELECT
    a.user_id,
    s.assunto,
    ROUND(SUM(CASE WHEN s.hitPercentage = 100 THEN 1 ELSE 0 END) / COUNT(s.question_id) * 100, 2) AS pct_acertos
FROM alunos a
LEFT JOIN submissoes s
    ON a.user_id = s.user_id
GROUP BY a.user_id, s.assunto
ORDER BY a.user_id, s.assunto;