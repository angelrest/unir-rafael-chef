case node['platform_family']
    when 'rhel', 'amazon'
        default['web']['install_method']="package"
        default['web']['paquete'] = 'httpd'
        default['web']['dir'] = "/etc/httpd"
        default['web']['php'] = ['php','php-cli','php-curl','php-mbstring','php-gd','php-xml','php-mysql']
        default['web']['document_root'] = "/var/www/wordpress"
    when 'debian', 'ubuntu'
        default['web']['install_method']="package"
        default['web']['paquete'] = 'apache2'
        default['web']['php'] = ['php','php-cli','php-curl','php-mbstring','php-gd','php-xml','php-mysql']
        default['web']['dir'] = "/etc/apache2"
        default['web']['document_root'] = "/var/www/wordpress"
end