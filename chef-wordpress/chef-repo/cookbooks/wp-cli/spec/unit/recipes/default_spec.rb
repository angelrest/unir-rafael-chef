#
# Cookbook:: wp-cli
# Spec:: default
#
# Copyright:: 2021, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'wp-cli::default' do
    [
        { platform: 'ubuntu', version: '18.04' },
        { platform: 'centos', version: '7' },
    ].each do |platform|
     
      let(:chef_run) { ChefSpec::SoloRunner.new(platform: "#{platform[:platform]}", version: "#{platform[:version]}", file_cache_path: '/var/chef/cache')do |node|
        node.normal['wp-cli']['install_method'] = 'package'
      end.converge(described_recipe) }

      it 'includes the `wp-cli` recipe' do
        Chef::Log.warn "include_recipe = #{platform[:platform]} #{platform[:version]}"
        expect(chef_run).to include_recipe('wp-cli::default')
      end
      context "directorio wp-cli #{platform[:platform]} #{platform[:version]}" do
        platform "#{platform[:platform]}","#{platform[:version]}"
          it 'creates directory for wp-cli' do
            Chef::Log.warn "directory = #{platform[:platform]} #{platform[:version]}"
            expect(chef_run).to create_directory('/usr/share/wp-cli')
          end
      end
    end
end


