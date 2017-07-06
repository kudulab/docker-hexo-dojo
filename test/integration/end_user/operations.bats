load '/opt/bats-support/load.bash'
load '/opt/bats-assert/load.bash'

@test "/usr/bin/entrypoint.sh returns 0" {
  run /bin/bash -c "ide --idefile Idefile.to_be_tested \"pwd && whoami\""
  # this is printed on test failure
  echo "output: $output"
  assert_line --partial "ide init finished"
  assert_line --partial "/ide/work"
  assert_line --partial "hexoide"
  refute_output "root"
  assert_equal "$status" 0
}
@test "PATH is set correctly" {
  run /bin/bash -c "ide --idefile Idefile.to_be_tested \"env | grep PATH\""
  # this is printed on test failure
  echo "output: $output"
  assert_line --partial "/home/ide/hexoide-yarn/node_modules/.bin"
  assert_equal "$status" 0
}
@test "has node installed and it is invocable" {
  run /bin/bash -c "ide --idefile Idefile.to_be_tested \"node --version\""
  # this is printed on test failure
  echo "output: $output"
  assert_line --partial "v6.9.5"
  assert_equal "$status" 0
}
@test "has npm installed and it is invocable" {
  run /bin/bash -c "ide --idefile Idefile.to_be_tested \"npm --version\""
  # this is printed on test failure
  echo "output: $output"
  assert_line --partial "3.10.10"
  assert_equal "$status" 0
}
@test "clean before" {
  run /bin/bash -c "ide --idefile Idefile.to_be_tested \"rm -rf node_modules\""
  assert_equal "$status" 0
}
@test "hexo is installed" {
  run /bin/bash -c "ide --idefile Idefile.to_be_tested \"hexo --version\""
  # this is printed on test failure
  echo "output: $output"
  assert_line --partial "hexo-cli: 1.0.3"
  assert_line --partial "node: 6.9.5"
  assert_equal "$status" 0
}
@test "clean after" {
  run /bin/bash -c "ide --idefile Idefile.to_be_tested \"rm -rf node_modules\""
  assert_equal "$status" 0
}
@test "rsync is installed" {
  # without the "npm config set color false" assert fails
  run /bin/bash -c "ide --idefile Idefile.to_be_tested \"rsync --version\""
  # this is printed on test failure
  echo "output: $output"
  assert_line --partial "rsync  version 3."
  assert_equal "$status" 0
}
@test "can git clone from github" {
  run /bin/bash -c "ide --idefile Idefile.to_be_tested \"rm -rf docker-gitide && git clone https://github.com/ai-traders/docker-gitide && rm -rf docker-gitide\""
  assert_output --partial "Cloning into 'docker-gitide'..."
  assert_equal "$status" 0
}
