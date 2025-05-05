import database.sql_queries as queries
from database.execution_query import ExecutionQuery
from datetime import date
import json
import pdb
import os

class RequestUser():
    error={}
    def __init__(self, mysql_connection):
        self.mysql_connection = mysql_connection
    
    def _execute(self, action, params=None):
        mysql_connection = ExecutionQuery(self.mysql_connection)
        if action == "get_users":
            data = self._get_users(mysql_connection)
            return data
        elif action == "create_users":
            data_response = self._create_user(params)
            return data_response
    
    def _get_users(self, mysql_connection):
        result = mysql_connection.select_mysql(queries.select_data_test(),None, False)
        result = self._format_date(result)
        return result
    
    def _create_user(self, params):
        print(params)
    
    def _format_date(self, objeto):
        if isinstance(objeto, (list, tuple)):
            return [self._format_date(item)for item in objeto]
        elif isinstance(objeto, dict):
            return {key:self._format_date(value) for key, value in objeto.items()}
        elif isinstance(objeto, date):
            return objeto.isoformat()
        else:
            return objeto