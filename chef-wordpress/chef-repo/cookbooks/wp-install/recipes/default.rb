require 'shellwords'

execute "mysql-install-wp-privileges" do
  command "/usr/bin/mysql -u root -p\"#{node['wp-install']['server_root_password']}\" < #{node['wp-install']['conf_dir']}/wp-grants.sql"
  action :nothing
end

template "#{node['wp-install']['conf_dir']}/wp-grants.sql" do
  source "grants.sql.erb"
  owner "vagrant"
  group "vagrant"
  mode "0600"
  variables(
    :user     => node['wp-install']['dbuser'],
    :password => node['wp-install']['dbpassword'],
    :database => node['wp-install']['dbname']
  )
  notifies :run, "execute[mysql-install-wp-privileges]", :immediately
end

execute "create wordpress database" do
  command "/usr/bin/mysqladmin -u root -p\"#{node['wp-install']['server_root_password']}\" create #{node['wp-install']['dbname']}"
  notifies :create, "ruby_block[save node data]", :immediately unless Chef::Config[:solo]
end

# save node data after writing the MYSQL root password, so that a 
# failed chef-client run that gets this far doesn't cause an unknown password to get applied to the box without being saved in the node data.
unless Chef::Config[:solo]
  ruby_block "save node data" do
    block do
      node.save
    end
    action :create
  end
end

bash "wordpress-core-download" do
  user "vagrant"
  group "vagrant"
  code "sudo wp core download --path=#{Shellwords.shellescape(node['wp-install']['wpdir'])} --force --allow-root"
end

file "#{node['wp-install']['wpdir']}/wp-config.php" do
  action :delete
  backup false
end

bash "wordpress-core-config" do
  user "vagrant"
  group "vagrant"
  cwd node['wp-install']['wpdir']
  code <<-EOH
    sudo wp core config \\
    --dbhost=#{Shellwords.shellescape(node['wp-install']['dbhost'])} \\
    --dbname=#{Shellwords.shellescape(node['wp-install']['dbname'])} \\
    --dbuser=#{Shellwords.shellescape(node['wp-install']['dbuser'])} \\
    --dbpass=#{Shellwords.shellescape(node['wp-install']['dbpassword'])} \\
    --dbprefix=#{Shellwords.shellescape(node['wp-install']['dbprefix'])} \\
    --allow-root
EOH
end

if node['wp-install']['always_reset'] == true then
    bash "wordpress-db-reset" do
      user "vagrant"
      group "vagrant"
      cwd node['wp-install']['wpdir']
      code 'sudo wp db reset --yes --allow-root'
    end
end

bash "wordpress-core-install" do
  user "vagrant"
  group "vagrant"
  cwd node['wp-install']['wpdir']
  code <<-EOH
    sudo wp core install \\
    --url=#{Shellwords.shellescape(node['wp-install']['url']).sub(/\/$/, '')} \\
    --title=#{Shellwords.shellescape(node['wp-install']['title'])} \\
    --admin_user=#{Shellwords.shellescape(node['wp-install']['admin_user'])} \\
    --admin_password=#{Shellwords.shellescape(node['wp-install']['admin_password'])} \\
    --admin_email=#{Shellwords.shellescape(node['wp-install']['admin_email'])} \\
    --allow-root
  EOH
end


if node['wp-install']['locale'] == 'ja' then
  bash "wordpress-plugin-ja-install" do
    user "vagrant"
    group "vagrant"
    cwd node['wp-install']['wpdir']
    code 'sudo wp plugin activate wp-multibyte-patch --allow-root'
  end
end


node['wp-install']['default_plugins'].each do |plugin|
  bash "WordPress #{plugin} install" do
    user "vagrant"
    group "vagrant"
    cwd node['wp-install']['wpdir']
    code "sudo wp plugin install #{Shellwords.shellescape(plugin)} --activate --allow-root"
  end
end

if node['wp-install']['default_theme'] != '' then
    bash "WordPress #{node['wp-install']['default_theme']} install" do
      user "vagrant"
      group "vagrant"
      cwd node['wp-install']['wpdir']
      code "sudo wp theme install #{Shellwords.shellescape(node['wp-install']['default_theme'])} --activate --allow-root"
    end
end

if node['wp-install']['is_multisite'] == true then
    bash "Setup multisite" do
      user "vagrant"
      group "vagrant"
      cwd node['wp-install']['wpdir']
      code "sudo wp core multisite-convert --allow-root"
    end
end

if node['wp-install']['theme_unit_test'] == true then
    remote_file node['wp-install']['theme_unit_test_data'] do
      source node['wp-install']['theme_unit_test_data_url']
      mode 0644
      action :create
    end

    bash "Import theme unit test data" do
      user "vagrant"
      group "vagrant"
      cwd node['wp-install']['wpdir']
      code "sudo wp plugin install wordpress-importer --activate --allow-root"
    end

    bash "Import theme unit test data" do
      user "vagrant"
      group "vagrant"
      cwd node['wp-install']['wpdir']
      code "sudo wp import --authors=create #{Shellwords.shellescape(node['wp-install']['theme_unit_test_data'])} --allow-root"
    end
else
    bash "Update post WordPress" do
    user "vagrant"
    group "vagrant"
    cwd node['wp-install']['wpdir']
    code "sudo wp post update 1 --post_title='Implementación Vagrant y Chef!!' --post_name='Implementación Vagrant y Chef!!' --post_content='Este es el resultado de la implementación de la actividad 2 del MÁSTER UNIVERSITARIO EN DESARROLLO Y OPERACIONES (MUDEVOPS) – PER5740 2022-2023!' --allow-root"
  end
end
