#
# Cookbook:: mysql
# Recipe:: default
#
# Copyright:: 2023, The Authors, All Rights Reserved.

begin
  include_recipe "mysql::#{node['mysql']['install_method']}" rescue 
  Chef::Exceptions::RecipeNotFound
    Chef::Log.warn"A #{node['mysql']['install_method']} recipe does not exist for the PLATFORM FAMILY: #{node['platform_family']}"
end