#
# Cookbook:: mysql
# Recipe:: install
#
# Copyright:: 2023, The Authors, All Rights Reserved.

case node['platform_family']
    when 'rhel'
        remote_file '/home/vagrant/' do
            source 'curl -sSLO https://dev.mysql.com/get/mysql80-community-release-el8-4.noarch.rpm'
            mode '0755'
            checksum '72a4647a99c7ac1e3a8efb874b1d4af4'
        end
        bash "install mysqlserver" do
            cwd '/home/vagrant/'
            code <<-EOH
                    md5sum mysql80-community-release-el8-4.noarch.rpm
                    sudo rpm -ivh mysql80-community-release-el8-4.noarch.rpm
                    sudo yum install mysql-server
                    sudo systemctl start mysqld
                EOH
            action :nothing
        end
    when 'debian'
        apt_update 'update_repo' do
            action :update
        end
        package 'mysql-server' do
            action :install
        end
end