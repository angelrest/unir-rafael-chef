  apt_update 'Update the apt cache daily' do
    frequency 86400
    action :periodic
  end
  #Instalacion de apache
  package node['web']['paquete']

  #Instalacion de Php
  node['web']['php'].each do |pkg|
    package pkg do
      action :install
    end
  end

  service 'apache2' do
    case node['platform_family']
      when 'rhel'
        service_name "httpd"
      when 'debian', 'ubuntu'
        service_name "apache2"
    end
    supports :status => true
    action :nothing
  end
  
  case node['platform_family']
    when "rhel"
      directory "#{node['web']['dir']}/sites-enabled/" do
        recursive true
      end
      directory "#{node['web']['dir']}/sites-available/" do
        recursive true
      end
  end

  file "#{node['web']['dir']}/sites-enabled/000-default.conf" do
    action :delete
  end
  
  template "#{node['web']['dir']}/sites-available/vagrant.conf" do
    source 'virtual-hosts.conf.erb'
    notifies :restart, resources(:service => "apache2")
  end
  
  template "#{node['web']['dir']}/sites-available/wordpress.conf" do
    source 'virtual-hosts.conf.erb'
    notifies :restart, resources(:service => "apache2")
  end

  link "#{node['web']['dir']}/sites-enabled/vagrant.conf" do
    to "#{node['web']['dir']}/sites-available/vagrant.conf"
    notifies :restart, resources(:service => "apache2")
  end

  