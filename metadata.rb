name             "ec2-consistent-snapshot"
maintainer       "Trae Robrock"
maintainer_email "trae@outright.com"
license          "MIT"
description      "Installs/Configures ec2-consistent-snapshot"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.3.0"

depends "yum"
depends "xfs"
depends "cpan"
