cache_path = Chef::Config['file_cache_path'] 
source_version = node['mysql']['source']['version']

case node['platform_family']
when 'rhel', 'amazon'
  # download installer
  remote_file File.join(node['mysql']['source']['conf_dir'], "mysql57-community-release-el#{source_version}.noarch.rpm") do
    source "http://dev.mysql.com/get/mysql57-community-release-el#{source_version}.noarch.rpm"
    mode 0755
    #checksum node['mysql']['source']['checksum']
    notifies :run, "bash[install mysqlserver]", :immediately
  end

  bash "install mysqlserver" do
    cwd node['mysql']['source']['conf_dir']
    code <<-EOH
sudo yum update -y
yum -y install ./mysql57-community-release-el#{source_version}.noarch.rpm
yum -y install mysql-community-server
EOH
    action :nothing 
  end

end

service "mysql" do
    service_name node['mysql']['source']['service_name']
    action :start
end