#
# Cookbook:: mysql
# Spec:: default
#
# Copyright:: 2021, The Authors, All Rights Reserved.

# require 'spec_helper'

# describe 'mysql::default' do
#   context 'When all attributes are default, on Ubuntu 20.04' do
#     # for a complete list of available platforms and versions see:
#     # https://github.com/chefspec/fauxhai/blob/master/PLATFORMS.md
#     platform 'ubuntu', '20.04'

#     it 'converges successfully' do
#       expect { chef_run }.to_not raise_error
#     end
#   end

#   context 'When all attributes are default, on CentOS 7' do
#     # for a complete list of available platforms and versions see:
#     # https://github.com/chefspec/fauxhai/blob/master/PLATFORMS.md
#     platform 'centos', '7'

#     it 'converges successfully' do
#       expect { chef_run }.to_not raise_error
#     end
#   end
# end

require 'spec_helper'

describe 'mysql::default' do

  context 'with default attributes ubuntu' do
    platform 'ubuntu','20.04'
    it "should have default install_method 'package'" do
     Chef::Log.warn "::1"
     expect(chef_run.node['mysql']['install_method']).to eq('package')
    end

    it "should include the mysql::package recipe when install_method='package'" do
      Chef::Log.warn "::2"
      expect(chef_run).to include_recipe('mysql::package')
    end
  end

  # context "with 'source' as install_method centos" do
  #   platform 'centos','7'
  #   override_attributes['mysql']['install_method'] = 'source'

  #   it "should include the mysql::source recipe when install_method='source'" do
  #     Chef::Log.warn "::3"
  #     expect(chef_run).to include_recipe('mysql::source')
  #   end

  # end

end


