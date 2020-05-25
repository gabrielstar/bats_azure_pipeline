#!/usr/bin/env bash

load $HOME/test/'test_helper/batsassert/load.bash'
load $HOME/test/'test_helper/batscore/load.bash'

function setup(){
  echo "" > f.txt
}
function teardown(){
  rm f.txt
}

#unit test - 2 IFs, 2 test
@test "saveResponseSavesStatusToFileOnFalse" {
  source script.sh
  run saveResponse f.txt false
  run cat f.txt
  [ "$output" == "false" ]
}

@test "saveResponseFileEmptyOnNonFalseStatus" {
  source script.sh
  run saveResponse f.txt completed
  run cat f.txt
  [ "$output" == "" ]
}

#e2e test
@test "E2E: fileContainsCorrectStatus" {
  taskId=1
  fileName=file.txt
  run sh script.sh $taskId $fileName
  [ "$status" -eq 0 ] #exit code is 0
  run cat $fileName
  [ "$output" == "false" ]
}
