SELECT
    CASE 
        WHEN s.listQuestions_id = '4f3452ae-87d4-4a5f-9532-c7634da2cff0' THEN 'Expressões Aritméticas - Lista Resolvida (LOP)'
        WHEN s.listQuestions_id = '70e6c800-7583-485d-ac9f-9c42c48dd785' THEN 'Expressões Aritméticas - Lista Prática (LOP)'
        WHEN s.listQuestions_id = '42d5c4ad-7b44-4e4e-b2e5-2997785132c8' THEN 'Expressões Aritméticas - Lista de Exercícios (LOP)'
        WHEN s.listQuestions_id = 'dbfcc83c-f014-44ae-8260-f06d4e1370ba' THEN 'Estruturas de Decisão - Lista Resolvida (LOP)'
        WHEN s.listQuestions_id = '70d1aa7e-00cb-4428-892f-9ac67cc50449' THEN 'Estruturas de Decisão - Lista Prática (LOP)'
        WHEN s.listQuestions_id = 'f5b1d992-68de-4854-97d8-c4bd84bd593b' THEN 'Estruturas de Decisão - Lista de Exercícios (LOP)'
        WHEN s.listQuestions_id = 'dd1cd083-6c00-4605-9ff1-163bd4069363' THEN 'Repetição condicional - Lista Resolvida (LOP)'
        WHEN s.listQuestions_id = '0a2c49a2-482c-40d7-bc44-ee368f089560' THEN 'Repetição condicional - Lista Prática (LOP)'
        WHEN s.listQuestions_id = 'aca84206-87b2-4478-afa4-6193119cc06a' THEN 'Repetição condicional - Lista de Exercícios (LOP)'
        WHEN s.listQuestions_id = '34691c68-f01d-46ad-808d-6bbd44bcd9a2' THEN 'Repetição contada - Lista Resolvida (LOP)'
        WHEN s.listQuestions_id = '813dedaa-0989-489b-9804-3850ae4b83d1' THEN 'Repetição contada - Lista Prática (LOP)'
        WHEN s.listQuestions_id = 'f5bc770d-2ac7-4060-ab1c-e42b5541f7a7' THEN 'Repetição contada - Lista de Exercícios (LOP)'
        WHEN s.listQuestions_id = '93cd33c4-109a-401e-87e9-e26ff5929d37' THEN 'Vetores - Lista Resolvida (LOP)'
        WHEN s.listQuestions_id = 'c4d09d1b-73a5-45c6-8a0d-ead669114b65' THEN 'Vetores - Lista Prática (LOP)'
        WHEN s.listQuestions_id = '1551e3ed-c875-4bb3-8e4e-58407df40776' THEN 'Vetores - Lista de Exercícios (LOP)'
    END AS list_name,
    ROUND(
        SUM(CASE WHEN s.hitPercentage = 100 THEN 1 ELSE 0 END) 
        / NULLIF(COUNT(s.id), 0) * 100, 2
    ) AS pct_hits
FROM lop2teste.submission s
WHERE s.class_id = '8813d508-dc24-47e2-a33f-8d2ca66cab29'
  AND s.listQuestions_id IN (
        '4f3452ae-87d4-4a5f-9532-c7634da2cff0',
        '70e6c800-7583-485d-ac9f-9c42c48dd785',
        '42d5c4ad-7b44-4e4e-b2e5-2997785132c8',
        'dbfcc83c-f014-44ae-8260-f06d4e1370ba',
        '70d1aa7e-00cb-4428-892f-9ac67cc50449',
        'f5b1d992-68de-4854-97d8-c4bd84bd593b',
        'dd1cd083-6c00-4605-9ff1-163bd4069363',
        '0a2c49a2-482c-40d7-bc44-ee368f089560',
        'aca84206-87b2-4478-afa4-6193119cc06a',
        '34691c68-f01d-46ad-808d-6bbd44bcd9a2',
        '813dedaa-0989-489b-9804-3850ae4b83d1',
        'f5bc770d-2ac7-4060-ab1c-e42b5541f7a7',
        '93cd33c4-109a-401e-87e9-e26ff5929d37',
        'c4d09d1b-73a5-45c6-8a0d-ead669114b65',
        '1551e3ed-c875-4bb3-8e4e-58407df40776'
  )
GROUP BY s.listQuestions_id
ORDER BY list_name;