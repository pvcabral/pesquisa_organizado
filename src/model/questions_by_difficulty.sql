WITH lista_questoes AS (
    SELECT DISTINCT question_id
    FROM lop2teste.listhasquestion
    WHERE list_id IN (
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
),
submissoes AS (
    SELECT s.question_id,
           COUNT(DISTINCT s.id) AS total_submissions,
           COUNT(DISTINCT CASE WHEN s.hitPercentage = 100 THEN s.id END) AS correct_submissions
    FROM lop2teste.submission s
    INNER JOIN lista_questoes lq ON lq.question_id = s.question_id
    WHERE s.class_id = 'd0122069-129b-4207-812d-ab50a082eb18'
    GROUP BY s.question_id
)
SELECT 
    s.question_id,
    ROUND(ABS(s.correct_submissions - s.total_submissions) / s.total_submissions * 100, 2) AS percentage,
    q.title
FROM submissoes s
JOIN lop2teste.question q ON q.id = s.question_id
ORDER BY percentage ASC;