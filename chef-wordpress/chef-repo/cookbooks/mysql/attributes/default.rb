case node['platform_family']
    when 'rhel', 'amazon'
        default['mysql']['mysql_paquete'] = []
        default['mysql']['install_method']="source"
    when 'debian', 'ubuntu'
        default['mysql']['mysql_paquete'] = ["mysql-server"]
        default['mysql']['service_name'] = "mysql"
        default['mysql']['install_method']="package"
end