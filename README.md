# docker-hexo-dojo

[Dojo](https://github.com/ai-traders/dojo) docker image with [Hexo](https://hexo.io/) blog tools.

## Usage
1. Setup docker.
2. Install [Dojo](https://github.com/ai-traders/dojo) binary.
3. Provide a Dojofile:
```
DOJO_DOCKER_IMAGE="kudulab/hexo-dojo:1.0.0"
```
4. Create and enter the container by running `dojo` at the root of project.
```bash
dojo hexo --version
```

By default, current directory in docker container is `/dojo/work`.

## License

Copyright 2019 Ewa Czechowska, Tomasz Sętkowski

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
