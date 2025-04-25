from dotenv import load_dotenv
from datetime import datetime
import mysql.connector
import pdb

load_dotenv()

class ConectionDB:
        def __init__(self, db, host, database, user, password, port):
            self.db = db
            self.host = host
            self.database = database
            self.user = user
            self.password = password
            self.port = port
            self.connection = None
        
        def connect(self):
            if self.connection is not None:
                try:
                    self.connection.cursor().execute('SELECT 1')
                    return self.connection
                except mysql.connector.Error as err:
                      self.disconnect()
            attempts = 0
            max_attempts = 3
            while attempts < max_attempts:
                try:
                    
                    if self.db == 'MySQL':
                        self.connection = mysql.connector.connect(
                            user=self.user,
                            password=self.password,
                            host=self.host,
                            database=self.database,
                            port=self.port
                        )
                    else:
                        print('Base de datos no soportada')
                        return None
                    return self.connection
                except mysql.connector.Error as err:
                    if err.errno == errorcode.ER_ACCESS_DENIED_ERROR:
                      print("Something is wrong with your user name or password")
                    elif err.errno == errorcode.ER_BAD_DB_ERROR:
                      print("Database does not exist")
                    else:
                      print(err)
                else:
                  self.disconnect()
                               
        def disconnect(self):
            if self.connection:
                self.connection.close()
            print("Conexión cerrada")                        
