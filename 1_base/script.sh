#!/usr/bin/env bash

#make a call
response=$(curl -X GET https://jsonplaceholder.typicode.com/todos/1)
echo $response

#get status of task wihtout jq or helpers
echo $response | awk -F: '{print $5}' | awk '{print $1}'
status=$(echo $response | awk -F: '{print $5}' | awk '{print $1}')

if [ "$status" != "false" ]; then
  echo "Status of task completion is not correct: $status"
  exit 1
else
  echo "Status of task completion is correct: $status"
  echo "$status" > file.txt
fi

