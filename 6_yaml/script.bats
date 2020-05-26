#!/usr/bin/env bash

load $HOME/test/'test_helper/batsassert/load.bash'
load $HOME/test/'test_helper/batscore/load.bash'

testFile="f.txt"
taskId=1
function setup(){
  echo "" > "$testFile"
  source script.sh
}
function teardown(){
  rm "$testFile"
}

#integration test, getTask mocked but we run entire script
@test "IT: fileContainsCorrectStatus" {
  function getTask(){
    status=false
  }
  export -f getTask
  run run_main $taskId "$testFile"
  assert_success
  run cat "$testFile"
  assert_output "false"
}
#unti test with mock
@test "getTaskReturnsFalse" {
  function curl(){
    cat data.json
  }
  export -f curl
  run getTask "$taskId"
  assert_line --index 1 'false'
  unset curl
}
@test "getTaskReturnsTrue" {
  function curl(){
    cat dataFalse.json
  }
  export -f curl
  run getTask "$taskId"
  assert_line --index 1 'true'
  unset curl
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
  run run_main $taskId "$testFile"
  assert_success
  run cat "$testFile"
  assert_output "false"
}