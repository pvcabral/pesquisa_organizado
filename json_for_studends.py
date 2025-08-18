import json
import pandas as pd

from src.utils.operations_db import DatabaseOperations

# IDs das listas
listas = [
    '4f3452ae-87d4-4a5f-9532-c7634da2cff0','70e6c800-7583-485d-ac9f-9c42c48dd785','42d5c4ad-7b44-4e4e-b2e5-2997785132c8',
    'dbfcc83c-f014-44ae-8260-f06d4e1370ba','70d1aa7e-00cb-4428-892f-9ac67cc50449','f5b1d992-68de-4854-97d8-c4bd84bd593b',
    'dd1cd083-6c00-4605-9ff1-163bd4069363','0a2c49a2-482c-40d7-bc44-ee368f089560','aca84206-87b2-4478-afa4-6193119cc06a',
    '34691c68-f01d-46ad-808d-6bbd44bcd9a2','813dedaa-0989-489b-9804-3850ae4b83d1','f5bc770d-2ac7-4060-ab1c-e42b5541f7a7',
    '93cd33c4-109a-401e-87e9-e26ff5929d37','c4d09d1b-73a5-45c6-8a0d-ead669114b65','1551e3ed-c875-4bb3-8e4e-58407df40776'
]

turma = '8813d508-dc24-47e2-a33f-8d2ca66cab29'

with open('src/model/questions_lists/query_for_submissions_and_questions.sql', 'r', encoding='utf-8') as file:
    sql_query = file.read()

database = DatabaseOperations('root', 'admin', 'localhost', '3306', 'lop2teste')
# Executar query via DatabaseOperations
df = database.fetch_all(sql_query, params={"listas": tuple(listas), "turma": turma})

# Calcular porcentagem de acertos
df['percentage'] = (df['acertos'].fillna(0) / df['total_questoes'].fillna(1) * 100).round(2)

# Pegar nomes das listas
query_nomes = "SELECT id, title FROM listquestions WHERE id IN :listas"
nomes_listas = database.fetch_all(query_nomes, params={"listas": tuple(listas)})
nomes_dict = dict(zip(nomes_listas.id, nomes_listas.title))
df['list_name'] = df['list_id'].map(nomes_dict).fillna(df['list_id'])


# Montar JSON
lista_geral = []
for user_id, group in df.groupby('user_id'):
    dict_estudante = {
        "user_id": user_id,
        "class_id": turma,
        "enrollment": group['enrollment'].iloc[0],
        "lists": [
            {"description": row['list_name'], "percentage": row['percentage']}
            for _, row in group.iterrows()
        ]
    }
    lista_geral.append(dict_estudante)

# Salvar JSON
with open('data_students_for_performance.json', 'w', encoding='utf-8') as f:
    json.dump(lista_geral, f, ensure_ascii=False, indent=4)

print("Arquivo JSON 'data_students_for_performance.json' criado com sucesso!")
