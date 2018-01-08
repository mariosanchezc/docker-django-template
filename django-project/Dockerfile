FROM fernandodev93/ubuntu16_python35

LABEL AUTOR "fernandodev93"

ARG DJANGO_ENV

ENV PYTHONUNBUFFERED 1

ENV PYTHONIOENCODING UTF-8

ENV LANG C.UTF-8

ENV LC_CTYPE="en_US.UTF-8"

ENV DJANGO_DIR "/django-project"  

RUN mkdir ${DJANGO_DIR}

WORKDIR ${DJANGO_DIR}

ADD Requirements/ ${DJANGO_DIR}/Requirements

RUN pip3 install -r Requirements/${DJANGO_ENV}.txt

ADD . ${DJANGO_DIR}