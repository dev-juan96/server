from fastapi import HTTPException
import mysql.connector
import logging
import time
import pdb
import sys
import os

class ExecutionQuery():
    def __init__(self, mysql_connection):
        self.mysql_connection = mysql_connection
        
    def select_mysql(self, query, params = None, one=True):
        connection = None
        cursor = None
        try:
            connection = self.mysql_connection.connect()
            if connection is None:
                raise Exception("No se pudo crear la conexión a la base de datos.")
            cursor = connection.cursor()
            cursor.execute(query, params)
            datos = cursor.fetchone() if one else cursor.fetchall()
            # if cursor.with_rows:
            #     cursor.fetchall()
            return datos
        except mysql.connector.Error as err:
            self.mysql_connection.connection.rollback()
            logging.error(f"Error al consultar datos: {err}")
        except Exception as e:
            logging.error(f"Error inesperado: {e}")
            raise HTTPException(status_code=500, detail=f"Error inesperado: {str(e)}")
        finally:
            if cursor:
                cursor.close()
            if connection:
                connection.close()
    
    def insert_or_update(self,query,params,one=True):
        connection = None
        cursor = None
        try:
            connection = self.mysql_connection.connect()
            cursor = connection.cursor()
            cursor.execute(query,params)
            if not one:
                new_data = cursor.fetchone() if one else cursor.fetchall()
                connection.commit()
                return new_data
            connection.commit()
            return True
        except mysql.connector.Error as err:
            self.mysql_connection.connection.rollback()
            logging.error(f"Error al insertar datos: {err}")
            return False
        except Exception as e:
            logging.error(f"Error inesperado: {e}")
            raise HTTPException(status_code=500, detail=f"Error inesperado: {str(e)}")
        finally:
            if cursor:
                cursor.close()
            if connection:
                connection.close()