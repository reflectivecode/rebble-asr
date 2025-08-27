FROM python:3.13-alpine
COPY requirements.txt /requirements.txt
RUN apk add --no-cache \
      speex \
      speexdsp \
      speex-dev \
      speexdsp-dev \
      git \
      build-base \
 && git clone https://github.com/pebble-dev/pyspeex.git \
 && pip install cython setuptools \
 && cd pyspeex \
 && make \
 && python setup.py install \
 && cd .. \
 && rm -rf pyspeex \
 && apk del --no-cache speex-dev speexdsp-dev git \
 && pip install -r requirements.txt \
 && apk del --no-cache build-base
COPY . /code
WORKDIR /code

RUN addgroup -S flaskgroup \
 && adduser -S -G flaskgroup -h /home/flask -s /bin/sh flask \
 && mkdir -p /home/flask \
 && chown -R flask:flaskgroup /home/flask /code

USER flask

ENV PORT=5000
ENV GOOGLE_APPLICATION_CREDENTIALS=/home/flask/google.json

CMD /code/run.sh
