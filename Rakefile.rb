require 'oversion'
require 'kitchen'
require 'dockerimagerake'

image_dir = File.expand_path("#{File.dirname(__FILE__)}/image")

# This can be easily done in bash
desc 'Gets next_version from Consul and saves to version file'
task :save_version do
  version = OVersion.get_version()
  version_file = "#{image_dir}/etc_ide.d/variables/60-variables.sh"
  text = File.read(version_file)
  new_contents = text.gsub(/IMAGE_VERSION/, version)
  File.open(version_file, "w") {|file| file.puts new_contents }
end

# This can be easily done in bash
# This is in order to make tests fail fast. It can be hard to set ide configs
# correctly: to map all the files from /ide/identity into /ide/home.
# This step is not obligatory.
desc 'Builds docker image using correct base image and installs ide configs'
task :build_configs_image do
  Dir.chdir(image_dir) do
    Rake.sh('docker build -t hexoide_configs:temp -f Dockerfile_ide_configs .')
  end
end
task build_configs_image: [:save_version]

# This is in order to make tests fail fast.
# We cannot use `kitchen test`, because it would demand installing Chef-Client
# to install serverspec.
desc 'Tests the docker image with ide configs installed'
task :test_ide_configs do
  ENV['KITCHEN_YAML'] = File.expand_path("#{File.dirname(__FILE__)}/.kitchen.yml")
  loader = ::Kitchen::Loader::YAML.new(
    project_config: ENV['KITCHEN_YAML'],
    local_config: ENV['KITCHEN_LOCAL_YAML'],
    global_config: ENV['KITCHEN_GLOBAL_YAML']
  )
  kitchen_config = ::Kitchen::Config.new(
    loader: loader
  )
  kitchen_config.instances.each do |instance|
    instance.create()
    Rake.sh("kitchen exec #{instance.name} -c \"bats /tmp/bats\"")
    instance.destroy()
  end
end
# To test 1 instance:
# ide # run interactively
# chef exec bundle install
# chef exec bundle exec kitchen converge configs-docker
# chef exec bundle exec kitchen exec configs-docker -c "rspec --pattern --color --format documentation /tmp/serverspec/*_spec.rb"
# chef exec bundle exec kitchen destroy configs-docker

opts = DockerImageRake::Options.new(
  cookbook_dir: image_dir,
  repo_dir: File.expand_path("#{File.dirname(__FILE__)}"),
  image_name: 'docker-registry.ai-traders.com/hexoide',
  dry_run: false)
DockerImageRake::DockerImage.new(opts)
task build: [:save_version]

desc 'Run Test-Kitchen tests on built image'
task :kitchen do
  Rake.sh(". #{image_dir}/imagerc && export KITCHEN_YAML='#{File.dirname(__FILE__)}/.kitchen.image.yml' && kitchen converge default-docker-image && kitchen exec default-docker-image -c \"bats /tmp/bats\" && kitchen destroy default-docker-image")
end

task :install_ide do
  Rake.sh('sudo bash -c "`curl -L https://raw.githubusercontent.com/ai-traders/ide/0.5.0/install.sh`"')
end

desc 'Run end user tests'
RSpec::Core::RakeTask.new(:end_user) do |t|
  # env variables like AIT_DOCKER_IMAGE_NAME are set by dockerimagerake gem
  t.rspec_opts = [].tap do |a|
    a.push('--pattern test/integration/end_user/spec/**/*_spec.rb')
    a.push('--color')
    a.push('--tty')
    a.push('--format documentation')
    a.push('--format h')
    a.push('--out ./rspec.html')
  end.join(' ')
end
