#!/usr/bin/env bash

load $HOME/test/'test_helper/batsassert/load.bash'
load $HOME/test/'test_helper/batscore/load.bash'

@test "E2E: fileContainsCorrectStatus" {
  run sh script.sh
  [ "$status" -eq 0 ] #exit code is 0
  run cat file.txt
  [ "$output" == "false" ]
}