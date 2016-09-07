# docker-hexoide

[IDE](https://github.com/ai-traders/ide) docker image to work with
 [Hexo](https://hexo.io/) blog.

## Usage
1. Install [IDE](https://github.com/ai-traders/ide)
2. Provide an Idefile:
```
IDE_DOCKER_IMAGE="hexoide:0.1.0"
```
3. Run, example commands:
```bash
ide
ide hexo --version
ide hexo init
ide hexo generate
ide hexo deploy
```

By default, current directory in docker container is `/ide/work`.

### Configuration
Those files are used inside gitide docker image:

1. `~/.ssh/config` -- will be generated on docker container start
2. `~/.ssh/id_rsa` -- it must exist locally, because it is a secret
2. `~/.gitconfig` -- if exists locally, will be copied
3. `~/.profile` -- will be generated on docker container start, in
   order to ensure current directory is `/ide/work`.

## Development

### Dependencies
Bash, IDE, and Docker daemon. Needed is docker IDE image with:
  * Docker daemon
  * IDE (we run IDE in IDE)
  * ruby

All the below tests are supposed to be invoked inside an IDE docker image:
```bash
ide
bundle install
```

### Fast tests
```bash
# Run repocritic linting.
bundle exec rake style

# Build a docker image with IDE configs only and test it
bundle exec rake build_configs_image && bundle exec rake test_ide_configs
```

**OR** you can run those (Test-Kitchen) tests also this way (1 tests suite example):
```bash
bundle exec kitchen converge configs-docker
bundle exec kitchen verify configs-docker
bundle exec kitchen destroy configs-docker
```

Here `.kitchen.yml` is used.

### Build
Build hexoide docker image. This will generate imagerc file
(dockerimagerake gem is responsible for this).

```bash
bundle exec rake build
```

### Long tests
Having built the hexoide docker image, there are 2 kind of tests available:

```bash
# Test-Kitchen tests, test that ide_configs are set and that system packages are
# installed
bundle exec rake kitchen


# Invoke ide command using Idefiles and the just built hexoide docker image
bundle exec rake install_ide # IDE should be installed in IDE docker image
bundle exec rake end_user
```

**OR** you can run Test-Kitchen tests also this way:
```bash
source image/imagerc
bundle exec kitchen converge default
bundle exec kitchen verify default
bundle exec kitchen destroy default
```

Here `.kitchen.image.yml` is used.

### dockerimagerake
**Gem dockerimagerake** is used to:
 * provide test rake tasks
 * create imagerc file and source it for rake tasks
 * provide docker image build rake task
 * provide release and publish rake tasks
Those rake tasks are used in `ci.gocd.yaml` file.
