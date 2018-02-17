# **TEMPLATE DJANGO DOCKER**

Este template se lo ha construido para crear de manera sencilla un proyecto en django

## La imagen docker está construido con lo siguiente:
- Ubuntu 16 con python3.6
- Django 2.0
- Postgresql
- Otras librerías python.

### PASO 1 Construcción de un proyecto usando Docker y Django

Luego de clonar el proyecto encontraras un archivo llamado create_project.sh
el cual contiene ciertas instrucciones para iniciar un proyecto.
Para ejecutar este script se coloca en el terminal por ejemplo lo siguiente:

**sh create_project.sh <django_project> <commercedb> <fernandodev93> <passwordfernandodev93> <COMMERCE>**

**EJEMPLO:**
**sh create_project.sh django_project commercedb fernandodev93 passwordfernandodev93 COMMERCE**

Parámetros enviados al script
- 1 django_project : nombre de la carpeta contenedora .
- 2 commercedb : nombre de la base de datos.
- 3 fernandodev93 : nombre del usuario del proyecto.
- 4 passwordfernandodev93 : password de la base de datos en postgres.
- 5 COMMERCE : nombre del proyecto en django.

### PASO 2 Eliminación de código:
- Copia del archivo base.py el valor de la variable SECRET_KEY y reemplazala en el archivo env_dev creado en la carpeta .env/.
- Luego de copiar la variable en el mismo archivo base.py se debe eliminar las siguientes líneas de código debido a que en el archivo local.py ya se hace referencia.

SECRET_KEY = 'SECRET' 

DEBUG = True

ALLOWED_HOSTS = []


DATABASES = {

    'default': {

        'ENGINE': 'django.db.backends.sqlite3',

        'NAME': os.path.join(BASE_DIR, 'db.sqlite3'),

    }

}

STATIC_URL = '/static/'


### PASO 3. Añada la variable DJANGO_SETTINGS_MODULE al archivo env_dev
DJANGO_SETTINGS_MODULE=COMMERCE.settings.local

* COMMERCE : es el nombre del proyecto de django pasado en el script anterior.

DJANGO_SECRET_KEY='SECRET del archivo base.py'

### PASO 4. Creación de una APP.
    Creación de una app:
        - docker-compose run django_project python3 manage.py startapp <NOMBRE app> <directorio>
        - y vuelva a construir con docker-compose build
        - Ejemplo:
            - Primero cree la carpeta de usuarios sin ningún contenido en el host. Ejem: mkdir apps/usuarios
            - Luego ejecute: docker-compose run django_project python3 manage.py startapp usuarios apps/usuarios
        

## Otras Configuraciones

### Ejecución del Proyecto
    - Si ya están instaladas las librerías en la carpeta vendors ejecute
        - docker-compose up -d django_project
    - Sino ejecute para que se instalen:
        - docker-compose up -d

### Ejecutar Migraciones
    - docker-compose run --rm django_project python3 manage.py makemigrations
    - docker-compose run --rm django_project python3 manage.py migrate

### Ejecución de TESTS
    Asegurese de tener configurado el archivo env_dev para test y sus requerimientos para test en el archivo test.txt
    - docker-compose -f tests.yml build
    - docker-compose -f tests.yml run --rm django_project

### Ejecución En Staging(Pre-Producción)
    Asegurese de tener configurado el archivo env_dev para staging y sus requerimientos para staging en el archivo staging.txt
    - docker-compose -f staging.yml build
    - docker-compose -f staging.yml run --rm django_project

### Ejecución En producción
    Asegurese de tener configurado el archivo env_dev para production y sus requerimientos para producción en el archivo production.txt
    - docker-compose -f production.yml build
    - docker-compose -f production.yml run --rm django_project