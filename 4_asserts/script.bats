#!/usr/bin/env bash

load $HOME/test/'test_helper/batsassert/load.bash'
load $HOME/test/'test_helper/batscore/load.bash'

testFile="f.txt"
function setup(){
  echo "" > "$testFile"
  source script.sh
}
function teardown(){
  rm "$testFile"
}
#e2e test
@test "fileContainsCorrectId" {
  taskId=1
  run run_main $taskId "$testFile"
  assert_success
  run cat "$testFile"
  assert_output "false"
}

#unit test - 2 IFs, 2 test
@test "saveResponseWorksCorrectlyOnFalseStatus" {
  run saveResponse "$testFile" false
  assert_output --partial "is correct"
  run cat f.txt
  assert_output "false"
}

@test "fileIsEmptyOnIncorrectResponse" {
  run saveResponse "$testFile" completed
  assert_output --partial "is not correct"
  run cat "$testFile"
  refute_output "false"
  assert_output ""
}