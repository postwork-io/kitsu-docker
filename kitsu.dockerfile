FROM ubuntu:18.04


RUN apt-get update
RUN apt-get install -y nginx git dos2unix

ADD ./zou /etc/nginx/sites-available
RUN dos2unix /etc/nginx/sites-available/zou
RUN ln -s /etc/nginx/sites-available/zou /etc/nginx/sites-enabled

RUN rm /etc/nginx/sites-enabled/default

RUN cd /opt && git clone -b build https://github.com/cgwire/kitsu

WORKDIR /opt/kitsu

RUN git checkout build

CMD ["nginx", "-g", "daemon off;"]