name 'vm'
maintainer 'Torben Knerr'
maintainer_email 'mail@tknerr.de'
license 'MIT'
description 'Installs/Configures the Linus Kitchen VM'
long_description IO.read(File.join(File.dirname(__FILE__), '../../README.md'))
version '0.2.0'
issues_url 'https://github.com/tknerr/linus-kitchen/issues'
source_url 'https://github.com/tknerr/linus-kitchen'

chef_version '~> 12'

supports 'ubuntu'

depends 'apt', '6.0.1'
depends 'ark', '3.0.0'
depends 'bashd', '0.3.0'
depends 'chef-apt-docker', '1.1.1'
depends 'docker', '2.15.4'
depends 'chef-sugar', '3.4.0'
