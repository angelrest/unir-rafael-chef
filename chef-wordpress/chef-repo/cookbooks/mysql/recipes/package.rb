#
# Cookbook:: mysql
# Recipe:: package
#
# Copyright:: 2023, The Authors, All Rights Reserved.

case node['platform_family']
when 'debian', 'ubuntu'
  node['mysql']['mysql_paquete'].each do |package_name|
    package package_name do
      action :install
      notifies :start, "service[mysql]", :immediately
    end
  end
end

service "mysql" do
    service_name node['mysql']['service_name']
    action :start
end