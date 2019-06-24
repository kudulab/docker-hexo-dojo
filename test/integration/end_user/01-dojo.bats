load '/opt/bats-support/load.bash'
load '/opt/bats-assert/load.bash'

@test "/usr/bin/entrypoint.sh returns 0" {
  run /bin/bash -c "dojo -c Dojofile.sut \"pwd && whoami\""
  # this is printed on test failure
  echo "output: $output"
  assert_output --partial "dojo init finished"
  assert_output --partial "hexoide"
  refute_output --partial "root"
  assert_equal "$status" 0
}

@test "locale are set and perl does not complain" {
  run /bin/bash -c "dojo -c Dojofile.sut \"perl --version\""
  refute_output --partial "Setting locale failed"
  assert_output --partial "This is perl 5"
  assert_equal "$status" 0
}
