name             'vm'
maintainer       'Torben Knerr'
maintainer_email 'mail@tknerr.de'
license          'All rights reserved'
description      'Installs/Configures the Linus Kitchen VM'
long_description IO.read(File.join(File.dirname(__FILE__), '../../README.md'))
version          '0.1.0'

supports "ubuntu"

depends "apt", "2.8.2"
depends "bashd", "0.3.0"
depends "vagrant", "0.3.1"
depends "chef-dk", "3.1.0"
depends "atom", "0.1.1"
depends "docker", "1.0.21"
