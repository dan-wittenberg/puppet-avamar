require 'spec_helper'

describe 'avamar', :type => :class do
    on_supported_os.each do |os, facts|
        context "on #{os}" do
            let(:facts) do
                facts
            end

            context 'with defaults for all parameters' do
                it { is_expected.to compile.with_all_deps }
                it { is_expected.to contain_class('avamar') }
                it {
                    is_expected.to contain_package('AvamarClient').with({
                        'name'   => 'AvamarClient',
                        'ensure' => 'installed',
                    })
                }
                it {
                    is_expected.to contain_exec('AVRegister').with({
                        'command' => '/usr/local/avamar/etc/avagent.d register ben061012.example.com ben1253',
                        'path'    => ['/usr/bin', '/sbin', '/bin', '/usr/sbin'],
                        'unless'  => "/usr/local/avamar/etc/avagent.d status | grep 'activated' | grep 'ben061012.example.com'",
                        'user'    => 'root',
                    })
                }
                it {
                    is_expected.to contain_exec('AVRegister').
                        that_requires('Package[AvamarClient]')
                }
                it {
                    is_expected.to contain_service('AvamarService').with({
                        'ensure' => 'running',
                        'enable' => true,
                        'name'   => 'avagent',
                    })
                }
                it {
                    is_expected.to contain_service('AvamarService').
                        that_subscribes_to('Package[AvamarClient]')
                }
            end

            context 'with class_enabled = false' do
                let(:params) { { :class_enabled => false } }

                it { is_expected.to compile.with_all_deps }
                it { is_expected.to contain_class('avamar') }
                it { is_expected.not_to contain_package('AvamarClient') }
                it { is_expected.not_to contain_exec('AVRegister') }
                it { is_expected.not_to contain_service('AvamarService') }
            end

            context 'with admin_server set' do
                let(:params) { { :admin_server => 'the-server' } }

                it {
                    is_expected.to contain_exec('AVRegister').with({
                        'command' => '/usr/local/avamar/etc/avagent.d register the-server ben1253',
                        'unless' => "/usr/local/avamar/etc/avagent.d status | grep 'activated' | grep 'the-server'"
                    })
                }
            end

            context 'with manage_package = false' do
                let(:params) { { :manage_package => false } }

                it { is_expected.not_to contain_package('AvamarClient') }
                it { is_expected.to contain_exec('AVRegister') }
                it {
                    is_expected.to contain_service('AvamarService').with({
                        'subscribe' => nil,
                    })
                }
            end

            context 'with manage_register = false' do
                let(:params) { { :manage_register => false } }

                it { is_expected.to contain_package('AvamarClient') }
                it { is_expected.not_to contain_exec('AVRegister') }
                it { is_expected.to contain_service('AvamarService') }
            end

            context 'with manage_service = false' do
                let(:params) { { :manage_service => false } }

                it { is_expected.to contain_package('AvamarClient') }
                it { is_expected.to contain_exec('AVRegister') }
                it { is_expected.not_to contain_service('AvamarService') }
            end

            context 'with package_ensure = absent' do
                let(:params) { { :package_ensure => 'absent' } }

                it {
                    is_expected.to contain_package('AvamarClient').
                        with_ensure('absent')
                }
            end

            context 'with package_name = testname' do
                let(:params) { { :package_name => 'testname' } }

                it {
                    is_expected.to contain_package('AvamarClient').
                        with_name('testname')
                }
            end

            context 'with rman_package_ensure = installed' do
                let(:params) { { :rman_package_ensure => 'installed' } }

                it {
                    is_expected.to contain_package('AvamarRMAN').with({
                        'name'   => 'AvamarRMAN',
                        'ensure' => 'installed',
                    })
                }
            end

            context 'with rman_package_ensure = installed, rman_package_name = testname' do
                let(:params) { {
                    :rman_package_ensure => 'installed',
                    :rman_package_name => 'testname',
                } }

                it {
                    is_expected.to contain_package('AvamarRMAN').with({
                        'name'   => 'testname',
                        'ensure' => 'installed',
                    })
                }
            end

            context 'with server_domain set' do
                let(:params) { { :server_domain => 'the_domain' } }

                it {
                    is_expected.to contain_exec('AVRegister').
                        with_command('/usr/local/avamar/etc/avagent.d register ben061012.example.com the_domain')
                }
            end

            context 'with service_enable = false' do
                let(:params) { { :service_enable => false } }

                it {
                    is_expected.to contain_service('AvamarService').with({
                        'ensure' => 'running',
                        'enable' => false,
                        'name'   => 'avagent',
                    })
                }
                it {
                    is_expected.to contain_service('AvamarService').
                        that_subscribes_to('Package[AvamarClient]')
                }
            end

            context 'with service_ensure = stopped' do
                let(:params) { { :service_ensure => 'stopped' } }

                it {
                    is_expected.to contain_service('AvamarService').with({
                        'ensure' => 'stopped',
                        'enable' => true,
                        'name'   => 'avagent',
                    })
                }
                it {
                    is_expected.to contain_service('AvamarService').
                        that_subscribes_to('Package[AvamarClient]')
                }
            end

            context 'with service_name = avamar2' do
                let(:params) { { :service_name => 'avamar2' } }

                it {
                    is_expected.to contain_service('AvamarService').with({
                        'ensure' => 'running',
                        'enable' => true,
                        'name'   => 'avamar2',
                    })
                }
                it {
                    is_expected.to contain_service('AvamarService').
                        that_subscribes_to('Package[AvamarClient]')
                }
            end

            context "data errors that should cause failures" do
                context 'with admin_server set to undef' do
                    let(:params) { { :admin_server => '' } }

                    it {
                        is_expected.to compile.
                            and_raise_error(/admin_server is required./)
                    }
                end

                context 'with server_domain set to undef' do
                    let(:params) { { :server_domain => '' } }

                    it {
                        is_expected.to compile.
                            and_raise_error(/server_domain is required./)
                    }
                end
            end
        end
    end

    context "on non-Linux kernel" do
        let(:facts) { {
            :kernel                    => 'FreeBSD',
            :operatingsystem           => 'FreeBSD',
            :operatingsystemmajrelease => '11',
            :operatingsystemrelease    => '11.1-RELEASE-p1',
            :osfamily                  => 'FreeBSD',
        } }

        context 'with defaults for all parameters' do
            it {
                is_expected.to compile.
                    and_raise_error(/Kernel FreeBSD not supported./)
            }
        end
    end
end
