#!/usr/bin/env bash

rpm -Uvh http://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm
rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-puppetlabs-PC1
rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-puppet-PC1
rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-nightly-puppetlabs-PC1
yum -y install git puppet-agent vim
mv /tmp/Gemfile /etc/puppetlabs/code/
mv /tmp/hiera.yaml /etc/puppetlabs/code/
mkdir -p /etc/puppetlabs/code/hieradata
touch /etc/puppetlabs/code/hieradata/global.yaml
gem install bundle rake --no-rdoc --no-ri
bundle config --global silence_root_warning 1
cd /etc/puppetlabs/code/modules/avamar || exit
rm -f Gemfile.lock
bundle install
rm -f Puppetfile.lock
librarian-puppet install --verbose --path=/etc/puppetlabs/code/modules
