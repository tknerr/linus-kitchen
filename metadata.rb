name             'dev-box'
maintainer       'Torben Knerr'
maintainer_email 'mail@tknerr.de'
license          'All rights reserved'
description      'Installs/Configures dev-box'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

supports "ubuntu"

depends "apt", "1.7.0"
depends "bashd", "0.3.0"
depends "vagrant", "0.2.0"
depends "chef-dk", "3.0.0"
depends "atom", "0.1.1"
