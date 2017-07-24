#!/bin/bash

source platform.secrets.sh

jobs=(job/sample_pipelines/job/joda-time job/sample_pipelines/job/game-of-life job/sample_pipelines/job/libotrio)
MINWAIT=2
MAXWAIT=5

while [ 1 ]; do
  nextjob=${jobs[$RANDOM % ${#jobs[@]}]} # Random next job
  waittime=$[$RANDOM % ($MAXWAIT - $MINWAIT) + $MINWAIT] # Random wait time
  echo "Triggering $nextjob"
  docker exec jenkins curl -s -X POST jenkins:${PASSWORD_JENKINS}@localhost:8080/jenkins/$nextjob/build
  echo "Waiting $waittime minutes."
  sleep $(($waittime*60))
done
