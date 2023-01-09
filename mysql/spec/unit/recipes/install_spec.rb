#
# Cookbook:: mysql
# Spec:: install
#
# Copyright:: 2023, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'mysql::install' do
  context 'When all attributes are default, on Ubuntu 20.04' do
    # for a complete list of available platforms and versions see:
    # https://github.com/chefspec/fauxhai/blob/main/PLATFORMS.md
    platform 'ubuntu', '20.04'

    package_checks = {
      'ubuntu' => {
        '20.04' => ['mysql-server'],
      }
    }

    # Proceso de actualización--------------------------------------------------
    describe 'updates apt repo' do
      it { is_expected.to update_apt_update('update_repo') }
    end
    # --------------------------------------------------------------------------

    package_checks.each do |platform, versions|
      versions.each do |version, packages|
        packages.each do |package_name|
          it "should install #{package_name} on #{platform} #{version}" do
            chef_run = ChefSpec::SoloRunner.new(platform: platform, version: version, file_cache_path: '/var/chef/cache') do |node|
              node.normal['source']['install_method_one'] = 'package'
            end.converge(described_recipe)
            Chef::Log.warn" package_name = #{package_name}"
            expect(chef_run).to install_package(package_name)
          end
        end
      end
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end
  end

  context 'When all attributes are default, on CentOS 8' do
    # for a complete list of available platforms and versions see:
    # https://github.com/chefspec/fauxhai/blob/main/PLATFORMS.md
    platform 'centos', '8'

    # it "should include the mysql'" do
    #   expect(chef_run).to include_recipe('mysql::install')
    # end

    # it 'converges successfully' do
    #   expect { chef_run }.to_not raise_error
    # end
  end
end
