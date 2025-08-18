if __name__ == "__main__":
    from src.utils.operations_db import DatabaseOperations

    database = DatabaseOperations('root', 'admin', 'localhost', '3306', 'lop2teste')

    with open('pesquisa_organizado/src/models/questions/query_questions_by_difficulty.sql', 'r', encoding='utf-8') as file:
        sql_query = file.read()

    database.fetch_all(sql_query)