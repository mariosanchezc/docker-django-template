# **PROJECT DJANGO DOCKER**

## Construcción del Proyecto
    1. docker-compose build: Para instalar los requerimientos del proyecto
    2. docker-compose up vendors
        - verificar la creación de la carpeta vendors, donde se encuentran las librerías del proyecto.

## Creación del Proyecto.
    1. docker-compose run django_project django-admin startproject DJANGOPROJECT .
    2. Configurar los archivos de configuración

## Creación de una APP.
    3. Creación de una app:
        - docker-compose run django_project python3 manage.py startapp <NOMBRE app> <directorio>
        - Ejemplo:
            - Primero cree la carpeta de usuarios sin ningún contenido en el host.
            - Luego ejecute: docker-compose run django_project python3 manage.py startapp usuarios apps/usuarios

## Ejecución del Proyecto
    - Si ya están instaladas llas librerías en la carpeta vendors ejecute
        - docker-compose up -d django_project
    - Sino ejecute para que se instalen:
        - docker-compose up -d

## Ejecutar Migraciones
    - docker-compose run django_project python3 manage.py makemigrations
    - docker-compose run django_project python3 manage.py migrate

## Ejecución de TESTS
    - docker-compose -f tests.yml build
    - docker-compose -f tests.yml run --rm django_project

## Ejecución En producción
    - docker-compose -f production.yml build
    - docker-compose -f production.yml run --rm django_project

## Ejecución En Staging(Pre-Producción)
    - docker-compose -f staging.yml build
    - docker-compose -f staging.yml run --rm django_project