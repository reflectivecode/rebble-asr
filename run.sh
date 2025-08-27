#!/usr/bin/env sh
set -o errexit
set -o pipefail
set -o nounset

rm -f "${GOOGLE_APPLICATION_CREDENTIALS}"
touch "${GOOGLE_APPLICATION_CREDENTIALS}"
chmod 0600 "${GOOGLE_APPLICATION_CREDENTIALS}"
echo "${ASR_CREDENTIALS}" >> "${GOOGLE_APPLICATION_CREDENTIALS}"

exec gunicorn -k gevent -b 0.0.0.0:$PORT asr:app
