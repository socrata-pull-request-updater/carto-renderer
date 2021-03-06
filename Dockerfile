FROM socrata/base-xenial

WORKDIR /app

RUN DEBIAN_FRONTEND=noninteractive apt-get -y update && \
    DEBIAN_FRONTEND=noninteractive apt-get -y install python-mapnik python-pip
RUN pip install --upgrade pip 

RUN mkdir -p /app/carto_renderer

ENV LOG_LEVEL INFO

ADD frozen.txt /app/
RUN pip install -r /app/frozen.txt

COPY ship.d /etc/ship.d/
ADD carto_renderer /app/carto_renderer
RUN date -u +"%Y-%m-%dT%H:%M:%SZ" > /app/build-time.txt
