#!/bin/bash
if [ ! -f /opt/zou/tmp/initialized ]; then
    /bin/bash touch /opt/zou/tmp/initialized
    /bin/bash -c "./first_run.sh ${ADMIN_USERNAME} ${ADMIN_PASSWORD}"

if [ "$1" == "api" ]; then
    echo "Starting Zou API server"
    /bin/bash -c "/opt/zou/zouenv/bin/gunicorn  -c /etc/zou/gunicorn.conf.py -b ${hostname}:5000 zou.app:app"

elif [ "$1" == "events" ]; then
    echo "Starting Zou events server"
    /bin/bash -c "/opt/zou/zouenv/bin/gunicorn -c /etc/zou/gunicorn-events.conf.py -b ${hostname}:5001 zou.event_stream:app"

elif [ "$1" == "worker" ]; then
    echo "Starting RQ Zou Worker"
    /bin/bash -c "/opt/zou/zouenv/bin/rq worker -c zou.job_settings"
elif [ "$1" == "init" ]; then
    /bin/bash -c "./first_run.sh $2 $3"
else
    /bin/bash
fi
