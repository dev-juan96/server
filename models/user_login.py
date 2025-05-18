from pydantic import BaseModel
from datetime import date

class UserLogin(BaseModel):
    correo:str
    password:str