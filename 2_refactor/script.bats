#!/usr/bin/env bash

load $HOME/test/'test_helper/batsassert/load.bash'
load $HOME/test/'test_helper/batscore/load.bash'

#e2e test
@test "fileContainsCorrectId" {
  taskId=1
  fileName=file.txt
  run sh script.sh $taskId $fileName
  [ "$status" -eq 0 ] #exit code is 0
  run cat $fileName
  [ "$output" == "false" ]
}