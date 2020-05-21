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
#e2e test
@test "fileContainsCorrectId" {
  run run_main $taskId "$testFile"
  assert_success
  run cat "$testFile"
  assert_output "false"
}
#integration test, mocked?
@test "fileContainsCorrectIdWhenGetTaskMocked" {
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