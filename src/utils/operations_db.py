from sqlalchemy import create_engine
from sqlalchemy import text

import pandas as pd


class DatabaseOperations:

    def __init__(self, username: str, password: str, host: str, port: str, database: str):
        """
        Classe para auxiliar nas operações de banco de dados 

        :param username: Nome de usuário do banco de dados
        :param password: Senha do banco de dados
        :param host: Endereço do host do banco de dados
        :param port: Porta do banco de dados
        :param database: Nome do banco de dados
        """
        self.__username = username
        self.__password = password
        self.__host = host
        self.__port = port
        self.__database = database

    @property
    def engine(self) -> str:
        db_url = f"mysql+pymysql://{self.__username}:{self.__password}@{self.__host}:{self.__port}/{self.__database}"
        return create_engine(db_url)

    def execute_query(self, query: str, params: dict = None) -> None:
        """
        Executa uma query SQL

        :param query: A query SQL a ser executada
        :param params: Os parâmetros a serem utilizados na query
        """
        with self.engine.connect() as connection:
            result = connection.execute(text(query), params)
            return result

    def fetch_all(self, query: str, params: dict = None) -> pd.DataFrame:
        """
        Busca todos os resultados de uma query SQL

        :param query: A query SQL a ser executada
        :param params: Os parâmetros a serem utilizados na query
        """
        with self.engine.connect() as connection:
            df = pd.read_sql(text(query), connection, params=params)
        return df
