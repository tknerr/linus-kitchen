name 'vm'
maintainer 'Torben Knerr'
maintainer_email 'mail@tknerr.de'
license 'MIT'
description 'Installs/Configures the Linus Kitchen VM'
# long_description IO.read(File.join(File.dirname(__FILE__), '../../README.md'))
version '0.2.0'
issues_url 'https://github.com/tknerr/linus-kitchen/issues'
source_url 'https://github.com/tknerr/linus-kitchen'

chef_version '~> 14'

supports 'ubuntu'

depends 'apt', '7.1.1'
depends 'ark', '4.0.0'
depends 'bashd', '0.3.0'
depends 'chef-apt-docker', '2.0.6'
depends 'chef-sugar', '4.1.0'
depends 'docker', '4.6.7'
