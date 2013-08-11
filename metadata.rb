name             'dev-box'
maintainer       'Torben Knerr'
maintainer_email 'mail@tknerr.de'
license          'All rights reserved'
description      'Installs/Configures dev-box'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

supports "ubuntu"

depends "apt", "1.3.2"
depends "vagrant", "0.2.0"
