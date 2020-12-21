#!/usr/bin/env bash

@test "Say Hi!" {
  run bash hello_world.bash

  [ "$status" -eq 0 ]
  [ "$output" = "Hello, World!" ]
}

# run the test
# bats hello_world_test.sh