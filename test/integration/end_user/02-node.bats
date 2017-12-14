load '/opt/bats-support/load.bash'
load '/opt/bats-assert/load.bash'

@test "node installed and invocable" {
  run /bin/bash -c "ide --idefile Idefile.to_be_tested \"node --version\""
  # this is printed on test failure
  echo "output: $output"
  assert_line --partial "v9.3.0"
  assert_equal "$status" 0
}
@test "npm installed and invocable" {
  run /bin/bash -c "ide --idefile Idefile.to_be_tested \"npm --version\""
  # this is printed on test failure
  echo "output: $output"
  assert_line --partial "5.5.1"
  assert_equal "$status" 0
}
@test "yarn installed and invocable" {
  run /bin/bash -c "ide --idefile Idefile.to_be_tested \"yarn --version\""
  # this is printed on test failure
  echo "output: $output"
  assert_line --partial "1.3.2"
  assert_equal "$status" 0
}
