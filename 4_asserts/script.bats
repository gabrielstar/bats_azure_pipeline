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

#unit test - 2 IFs, 2 test
@test "saveResponseSavesStatusToFileOnFalse" {
  run saveResponse "$testFile" false
  assert_output --partial "is correct"
  run cat f.txt
  assert_output "false"
}

@test "saveResponseFileEmptyOnNonFalseStatus" {
  run saveResponse "$testFile" true
  assert_output --partial "is not correct"
  run cat "$testFile"
  refute_output "false"
  assert_output ""
}

#e2e test
@test "E2E: fileContainsCorrectStatus" {
  taskId=1
  run run_main $taskId "$testFile"
  assert_success
  run cat "$testFile"
  assert_output "false"
}