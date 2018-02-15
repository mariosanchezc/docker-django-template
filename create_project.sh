# Script para creación del proyecto en Django con Docker
# $1 nombre de la carpeta contenedora
# $2 nombre de la base de datos
# $3 nombre del usuario del proyecto
# $4 password
# $5 nombre del proyecto en django

mkdir $1

mv -R Requirements/ $1


echo "FROM fernandodev93/ubuntu16_python35 

LABEL AUTOR 'fernandodev93' 

ARG DJANGO_ENV 

ENV PYTHONUNBUFFERED 1 

ENV PYTHONIOENCODING UTF-8 

ENV LANG C.UTF-8 

ENV LC_CTYPE='en_US.UTF-8' 

ENV DJANGO_DIR '/$1' 

RUN mkdir \${DJANGO_DIR}

WORKDIR \${DJANGO_DIR}

ADD Requirements/ \${DJANGO_DIR}/Requirements 

RUN pip3 install -r Requirements/\${DJANGO_ENV}.txt 

ADD . /\${DJANGO_DIR} 
" > $1/Dockerfile

sed -i 's/djangoproject/'$1'/g' -i base.yml docker-compose.yml  production.yml staging.yml tests.yml

sed -i 's/django_project/'$1'/g' -i base.yml docker-compose.yml  production.yml staging.yml tests.yml

sed -i 's/django_server/'$1'/g' -i base.yml docker-compose.yml  production.yml staging.yml tests.yml

mkdir .env/

echo "
DESARROLLO:
- POSTGRESQL
POSTGRES_DB=$2
POSTGRES_USER=$3
POSTGRES_PASSWORD=$4
PGDATA=/var/lib/postgresql/data/pgdata
DB_HOST=db
DB_PORT=5432
" > .env/.env_dev

docker-compose build 

docker volume create --name=db

docker-compose up vendors 

docker-compose run --rm $1 django-admin startproject $5 .

mkdir $1/$5/settings

touch $1/$5/settings/__init__.py

mv $1/$5/settings.py $1/$5/settings/base.py

echo "
from .base import *
# Quick-start development settings - unsuitable for production
# See https://docs.djangoproject.com/en/2.0/howto/deployment/checklist/

# SECURITY WARNING: keep the secret key used in production secret!
SECRET_KEY = os.environ.get('DJANGO_SECRET_KEY')


# SECURITY WARNING: don't run with debug turned on in production!
DEBUG = True

ALLOWED_HOSTS = ['*']

# Database
# https://docs.djangoproject.com/en/2.0/ref/settings/#databases

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql',
        'NAME': os.environ.get('POSTGRES_DB'),
        'USER': os.environ.get('POSTGRES_USER'),
        'PASSWORD': os.environ.get('POSTGRES_PASSWORD'),
        'HOST': os.environ.get('DB_HOST'),
        'PORT': os.environ.get('DB_PORT')
    },
}

STATIC_URL = '/static/'
STATIC_ROOT = 'staticfiles'

MEDIA_ROOT = 'media'
MEDIA_URL = '/media/'
" > $1/$5/settings/local.py

echo $1/$5/settings/staging.py $1/$5/settings/tests.py $1/$5/settings/production.py | xargs -n 1 cp $1/$5/settings/local.py

echo "Debes eliminar ciertas variables del base.py que se encuentran en local.py recuerdalo..!!"
echo "Debes añeadir las variables DJANGO_SETTINGS_MODULE y DJANGO_SECRET_KEY  en el archivo env_dev "