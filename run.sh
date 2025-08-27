#!/usr/bin/env sh
set -o errexit
set -o pipefail
set -o nounset

rm -f /home/flask/google.json
touch /home/flask/google.json
chmod 0600 /home/flask/google.json
echo "${ASR_CREDENTIALS}" >> /home/flask/google.json

export GOOGLE_APPLICATION_CREDENTIALS=/home/flask/google.json

exec gunicorn -k gevent -b 0.0.0.0:$PORT asr:app
