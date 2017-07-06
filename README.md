# docker-hexoide

[IDE](https://github.com/ai-traders/ide) docker image to work with
 [Hexo](https://hexo.io/) blog.

## Usage
1. Install [IDE](https://github.com/ai-traders/ide)
2. Provide an Idefile:
```
IDE_DOCKER_IMAGE="docker-registry.ai-traders.com/hexoide:latest"
```
3. Run, example commands:
```bash
ide
ide npm exec hexo --version
# if declared in package.json like this: "generate": "hexo generate"
# under section "scripts":
ide npm run generate
```

By default, current directory in docker container is `/ide/work`.

If you want to run this docker image without IDE entrypoint, run e.g.
```bash
docker run -ti --rm --entrypoint=/bin/bash docker-registry.ai-traders.com/hexoide:latest -c "/bin/bash"
```

### Configuration
Those files are used inside gitide docker image:

1. `~/.ssh/config` -- will be generated on docker container start
2. `~/.ssh/id_rsa` -- it must exist locally, because it is a secret
2. `~/.gitconfig` -- if exists locally, will be copied
3. `~/.profile` -- will be generated on docker container start, in
   order to ensure current directory is `/ide/work`.

## Development
### Dependencies
* Bash
* Docker daemon
* Ide

### Lifecycle
1. In a feature branch:
* you make changes
* and run tests:
    * `./tasks build_cfg`
    * `./tasks test_cfg`
    * `./tasks build`
    * `./tasks itest`
1. You decide that your changes are ready and you:
* merge into master branch
* run locally:
  * `./tasks set_version` to set version in CHANGELOG and chart version files to
  the version from OVersion backend
  * e.g. `./tasks set_version 1.2.3` to set version in CHANGELOG and chart version
   files and in OVersion backend to 1.2.3
* push to master onto private git server
1. CI server (GoCD) tests and releases.
