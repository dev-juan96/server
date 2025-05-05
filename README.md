# Backend API

## Version 0.0.1

#### Se crea proyecto BACKEND con fast API, esta api esta basada en python el cual permite crear las diferentes peticiones RESTFULL de manera optima y sensilla, tiene como finalidad tomar el control de los datos que ingresan del cliente y definir si mandarlos a la base de datos modificarlos o disponer de estos seun la funcionalidad que exista

## Prerequisitos

#### Para garantizar la funcionalidad del API se tiene que tener instalado lo siguiente:

*   FasApi
*   Uvicornr
*   PyJWT
*   python-dotenv
*   paramiko
*   mysql.connector

## Ejecucion del API

#### Para la ejecucion del api en modo desarrollador se lanzal comando:

*   python3 -m uvicorn main:app --host 0.0.0.0 --port 7536 --reload (en linux)
*   python -m uvicorn main:app --host 0.0.0.0 --port 7536 --reload (en windows)

Para la ejecucion en el entorno de "produccion" se lanza el comando

*   python3 -m uvicorn main:app --host 0.0.0.0 --port 7536 --workers 4 (en linux)
*   python -m uvicorn main:app --host 0.0.0.0 --port 7536 --workers 4 (en windows)

## Ambiente de pruebas y documentacion

FastApi cuenta con su propio ambiente de pruebas donde se le puedan pasar datos y ver como es el comportamiento, junto a este ambiente tambien se encuentra la documentacion de las peticiones RESTFULL, la uvicación de estos elementos se pueden encontrar en las rutas: 

*   host/docs (validacion de peticiones)
*   host/redoc (solo documentacion de las peticiones)

## Notas de desarrollo

Durante la instalacion del api tanto en windows como en linux se identifico lo siguiente:

1.  La version de python afecta
    1.  Tener en cuenta que las versiones cambian y agregan funcionalidades nuevas, hay que validar los cambios y las versiones que se manejan de las bibliaotecas
2.  Crear un ambiente virtual para el almacenamiento de las bibliotecas
    1.  Contener un ambiente virtual de python alejado de la instalacion global permite gestionar los paquetes y las versiones de una mejor manera

# Historico de cambios

## 0.0.1

*   Se crea proyecto y se almacena esta primera version en GitHub para el manejo de versiones, esta contiene la conexion a la base de datos de MySQL junto con una peticion get que trae los datos de usuarios