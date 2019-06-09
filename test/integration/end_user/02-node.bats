load '/opt/bats-support/load.bash'
load '/opt/bats-assert/load.bash'

@test "node installed and invocable" {
  run /bin/bash -c "dojo -c Dojofile.sut \"node --version\""
  # this is printed on test failure
  echo "output: $output"
  assert_line --partial "v10.16.0"
  assert_equal "$status" 0
}
@test "npm installed and invocable" {
  run /bin/bash -c "dojo -c Dojofile.sut \"npm --version\""
  # this is printed on test failure
  echo "output: $output"
  assert_line --partial "6.9.0"
  assert_equal "$status" 0
}
@test "yarn installed and invocable" {
  run /bin/bash -c "dojo -c Dojofile.sut \"yarn --version\""
  # this is printed on test failure
  echo "output: $output"
  assert_line --partial "1.16.0"
  assert_equal "$status" 0
}
