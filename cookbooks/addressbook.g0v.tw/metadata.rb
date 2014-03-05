name             'addressbook.g0v.tw'
maintainer       'hychen'
maintainer_email 'ossug.hychen@gmail.com'
license          'BSD'
description      'Installs/Configures api.addressbook.g0v.tw endpoint'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

depends "runit"
depends "database"
depends "cron"
depends "nginx"
