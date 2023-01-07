#
# Cookbook:: ansible
# Spec:: source
#
# Copyright:: 2023, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'ansible::source' do
  context 'When all attributes are default, on Ubuntu 20.04' do
    # for a complete list of available platforms and versions see:
    # https://github.com/chefspec/fauxhai/blob/main/PLATFORMS.md
    platform 'ubuntu', '20.04'

    package_checks = {
      'ubuntu' => {
        '20.04' => ['ansible'],
      }
    }

    describe 'adds a apt_repository with default action' do
      it { is_expected.to add_apt_repository('default_action') }
      it { is_expected.to_not add_apt_repository('not_default_action') }
    end

    describe 'installs a apt_repository with an explicit action' do
      it { is_expected.to add_apt_repository('explicit_action_ubuntu') }
    end

    describe 'removes a apt_repository with default action' do
      it { is_expected.to remove_apt_repository('explicit_remove_action') }
    end

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
end
