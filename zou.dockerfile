FROM ubuntu:20.04


RUN apt-get update

# third party software
RUN apt-get install -y xmlsec1 ffmpeg postgresql-client dos2unix

# python 3.12
run apt-get install -y software-properties-common &&\
    add-apt-repository ppa:deadsnakes/ppa -y &&\
    apt-get update &&\
    apt-get install python3.12 python3.12-venv python3.12-dev

# create zou user
RUN useradd --home /opt/zou zou &&\
    mkdir /opt/zou &&\
    chown zou: /opt/zou &&\
    mkdir /opt/zou/backups &&\
    chown zou: /opt/zou/backups

WORKDIR /opt/zou

# install zou and its dependencies:
RUN python3.12 -m venvzouenv &&\
    . zouenv/bin/activate &&\
    zouenv/bin/python -m pip install --upgrade pip &&\
    zouenv/bin/python -m pip install zou &&\

RUN mkdir /opt/zou/previews &&\
    mkdir /opt/zou/tmp &&\
    mkdir /opt/zou/logs &&\
    mkdir /etc/zou

ADD ./gunicorn.conf.py /etc/zou
ADD ./gunicorn-events.conf.py /etc/zou

ADD ./zou_entrypoint.sh .
RUN dos2unix ./zou_entrypoint.sh
RUN chmod u+x ./zou_entrypoint.sh

ADD ./first_run.sh .
RUN dos2unix ./first_run.sh
RUN chmod u+x ./first_run.sh

ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

ENTRYPOINT [ "./zou_entrypoint.sh" ]
