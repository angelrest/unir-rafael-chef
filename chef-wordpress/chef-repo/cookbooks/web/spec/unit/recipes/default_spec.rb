#
# Cookbook:: web
# Spec:: default
#
# Copyright:: 2021, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'web::default' do
  platform 'centos','7'
  let(:chef_run) { ChefSpec::SoloRunner.new(platform: "centos", version: "7", file_cache_path: '/var/chef/cache').converge(described_recipe) }

  it 'deletes a file with an explicit action centos' do
    expect(chef_run).to delete_file("/etc/httpd/sites-enabled/000-default.conf")
  end
  it 'creates a template with the default action' do
    expect(chef_run).to create_template('/etc/httpd/sites-available/vagrant.conf')
  end
  it 'executes actions' do
    expect(chef_run).to_not disable_service('apache2')
  end
end

describe 'web::default' do
  platform 'ubuntu','18.04'
  let(:chef_run) { ChefSpec::SoloRunner.new(platform: "ubuntu", version: "18.04", file_cache_path: '/var/chef/cache').converge(described_recipe) }
  it 'deletes a file with an explicit action ubuntu' do
    expect(chef_run).to delete_file("/etc/apache2/sites-enabled/000-default.conf")
  end
  it 'creates a template with the default action' do
    expect(chef_run).to create_template('/etc/apache2/sites-available/vagrant.conf')
  end
  it 'executes actions' do
    expect(chef_run).to_not disable_service('apache2')
  end
end



