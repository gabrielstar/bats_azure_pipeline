#!/usr/bin/env bash

function getTask(){
    local taskId=$1
    #make a call
    response=$(curl -X GET https://jsonplaceholder.typicode.com/todos/"$taskId")
    echo $response

    #get status of task wihtout jq or helpers
    echo $response | awk -F: '{print $5}' | awk '{print $1}'
    status=$(echo $response | awk -F: '{print $5}' | awk '{print $1}')
}

function saveResponse(){
  local fileName=$1
  local status=$2
  if [ "$status" != "false" ]; then
    echo "Status of task completion is not correct: $status"
    exit 1
  else
    echo "Status of task completion is correct: $status"
    echo "$status" > "$fileName"
  fi
}

function run_main(){
  local taskId=$1
  local fileName=$2
  getTask "$taskId"
  saveResponse "$fileName" "$status" #whichever parameteres we need externally
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  run_main $1 $2
fi
