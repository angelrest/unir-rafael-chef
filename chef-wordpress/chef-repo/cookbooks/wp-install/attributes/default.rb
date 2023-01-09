default['wp-install']['server_root_password'] = 'wordpress'

case node['platform_family']
when 'rhel', 'amazon'
    default['wp-install']['conf_dir'] = '/etc'
when 'debian', 'ubuntu'
    default['wp-install']['conf_dir'] = '/etc/mysql'
else
    default['wp-install']['conf_dir'] = '/etc/mysql'
end

default['wp-install']['locale'] = ""
default['wp-install']['wp_version'] = "latest"

default['wp-install']['url'] = "http://192.168.33.40"
default['wp-install']['wpdir'] = "/var/www/wordpress"
default['wp-install']['title'] = "Bienvenido a WordPress"

default['wp-install']['dbhost'] = "localhost"
default['wp-install']['dbname'] = "wordpress"
default['wp-install']['dbpassword'] = "wordpress"
default['wp-install']['dbuser'] = "wordpress"
default['wp-install']['dbprefix'] = "wp_"

default['wp-install']['admin_user'] = "admin"
default['wp-install']['admin_password'] = "admin"
default['wp-install']['admin_email'] = "vagrant@example.com"

default['wp-install']['default_plugins'] = []

default['wp-install']['default_theme'] = "twentysixteen"
default['wp-install']['debug_mode'] = true
default['wp-install']['theme_unit_test'] = false
default['wp-install']['theme_unit_test_data_url'] = 'https://wpcom-themes.svn.automattic.com/demo/theme-unit-test-data.xml'
default['wp-install']['theme_unit_test_data'] = '/tmp/theme-unit-test-data.xml'

default['wp-install']['is_multisite'] = false
default['wp-install']['force_ssl_admin'] = false
default['wp-install']['always_reset'] = true
