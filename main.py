#from process.request_data_validator import RequestDataValidator
#from process.request_end_process import RequestEndProcess
#from models_api.estatus_process import EstatusProcess
from fastapi.exceptions import RequestValidationError
from models.user_data import UserData
from process.request_user import RequestUser
from fastapi import FastAPI, HTTPException, Request
#from fastapi.middleware.cors import CORSMiddleware
#import documentation.text_info as text_info 
from fastapi.responses import JSONResponse
from database.connection_db import ConectionDB
from fastapi import FastAPI
from typing import Union
import logging
import os

app = FastAPI()

@app.exception_handler(RequestValidationError)
async def validation_exception_handler(request: Request, exc: RequestValidationError):
    custom_errors = exc.errors()
    for error in custom_errors:
        error["msg"] = "El valor proporcionado no es válido para el campo: " + " -> ".join(map(str, error["loc"][1:]))
    return JSONResponse(
        status_code=422,
        content={"detail": "Datos inválidos proporcionados", "errors": custom_errors},
    )

def get_credential_database():
    return ConectionDB(
        "MySQL",
        os.getenv('HOST_MySQL'),
        os.getenv('SSID_MySQL'),
        os.getenv('USER_MySQL'),
        os.getenv('PASS_MySQL'),
        os.getenv('PORT_MySQL'),
    )

@app.get("/users")
async def read_user():
    try:
        mysql = get_credential_database()
        users = RequestUser(mysql)
        result = users._execute("get_users")
        return JSONResponse(status_code=200, content={"result": "Finalizo procesamiento", "data":result})
    except Exception as e:
        logging.basicConfig(level=logging.ERROR,
                    format='%(asctime)s - %(levelname)s - %(message)s')
        logging.error(f"Ocurrio un problema: {str(e)}")
        raise HTTPException(status_code=400, detail=f"Error: {str(e)}")
    
@app.post("/user/new")
async def create_user(data: UserData):
    try:
        value_data = data.dic()
        mysql = get_credential_database()
        users = RequestUser(mysql)
        result = users._execute("create_users", value_data)
        return JSONResponse(status_code=200, content={"result": "Finalizo procesamiento", "data":result})
    except Exception as e:
        logging.basicConfig(level=logging.ERROR,
                    format='%(asctime)s - %(levelname)s - %(message)s')
        logging.error(f"Ocurrio un problema: {str(e)}")
        raise HTTPException(status_code=400, detail=f"Error: {str(e)}") 