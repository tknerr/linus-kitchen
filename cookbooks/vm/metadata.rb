name 'vm'
maintainer 'Torben Knerr'
maintainer_email 'mail@tknerr.de'
license 'All rights reserved'
description 'Installs/Configures the Linus Kitchen VM'
long_description IO.read(File.join(File.dirname(__FILE__), '../../README.md'))
version '0.2.0'
issues_url 'https://github.com/tknerr/linus-kitchen/issues'
source_url 'https://github.com/tknerr/linus-kitchen'

supports 'ubuntu'

depends 'apt', '2.9.2'
depends 'bashd', '0.3.0'
depends 'vagrant', '0.5.0'
depends 'apt-docker', '0.3.0'
depends 'docker', '2.6.8'
depends 'chef-sugar', '3.3.0'
