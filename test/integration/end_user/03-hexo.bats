load '/opt/bats-support/load.bash'
load '/opt/bats-assert/load.bash'

@test "PATH is set correctly" {
  run /bin/bash -c "dojo -c Dojofile.sut \"env | grep PATH\""
  # this is printed on test failure
  echo "output: $output"
  assert_line --partial "/home/dojo/hexoide-yarn/node_modules/.bin"
  assert_equal "$status" 0
}
@test "clean before" {
  run /bin/bash -c "rm -rf $(pwd)/test/integration/test_dojo_work/node_modules"
  assert_equal "$status" 0
}
@test "hexo is installed" {
  run /bin/bash -c "dojo -c Dojofile.sut \"hexo --version\""
  # this is printed on test failure
  echo "output: $output"
  assert_line --partial "hexo-cli: 1.0.3"
  assert_line --partial "node: 10.16.0"
  assert_equal "$status" 0
}
@test "clean after" {
  run /bin/bash -c "rm -rf $(pwd)/test/integration/test_dojo_work/node_modules"
  assert_equal "$status" 0
}
@test "rsync is installed" {
  # without the "npm config set color false" assert fails
  run /bin/bash -c "dojo -c Dojofile.sut \"rsync --version\""
  # this is printed on test failure
  echo "output: $output"
  assert_line --partial "rsync  version 3."
  assert_equal "$status" 0
}
@test "can git clone from github" {
  run /bin/bash -c "dojo -c Dojofile.sut \"rm -rf docker-gitide && git clone https://github.com/ai-traders/docker-gitide && rm -rf docker-gitide\""
  assert_output --partial "Cloning into 'docker-gitide'..."
  assert_equal "$status" 0
}
