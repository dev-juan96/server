from pydantic import BaseModel
from datetime import date
class UserData(BaseModel):
    nombres: str
    apellidos: str
    telefono: int
    email: str
    ciudad: str
    fecha_nacimiento: date