source 'https://rubygems.org'

if (puppetversion = ENV['PUPPET_GEM_VERSION'])
    gem 'puppet', puppetversion, :require => false
else
    gem 'puppet', '~> 4.10', :require => false
end
gem 'facter', '>= 1.7.0', :require => false
gem 'librarian-puppet', :require => false
gem 'metadata-json-lint', '<= 2.0.1', :require => false
gem 'puppetlabs_spec_helper', '>= 0.1.0', :require => false
gem 'puppet-lint', '>= 0.3.2', :require => false
gem 'puppet-syntax', :require => false
gem 'rake', :require => false
gem 'requests', :require => false
gem 'rspec', :require => false
gem 'rspec-puppet', :require => false
gem 'rspec-puppet-facts', :require => false

# json_pure 2.0.2 added a requirement on ruby >= 2. We pin to json_pure 2.0.1
# if using ruby 1.x
gem 'json_pure', '<= 2.0.1', :require => false if RUBY_VERSION =~ /^1\./
