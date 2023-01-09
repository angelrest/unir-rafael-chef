apt_update 'Update the apt cache daily' do
  frequency 86400
  action :periodic
end

packages = %w{git subversion}

packages.each do |pkg|
  package pkg do
    action [:install, :upgrade]
  end
end

# create wpcli dir
directory node['wp-cli']['wpcli-dir'] do
  recursive true
end

# download installer
remote_file File.join(node['wp-cli']['wpcli-dir'], 'wp-cli.phar') do
  source 'https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar'
  mode 0755
  action :create_if_missing
  notifies :run, "bash[install wp-cli]", :immediately
end

bin = ::File.join(node['wp-cli']['wpcli-dir'], 'bin', 'wp')

bash "install wp-cli" do
  cwd node['wp-cli']['wpcli-dir']
  code "sudo mv wp-cli.phar /usr/local/bin/wp"
  creates bin
  action :nothing 
end

# link wp bin
link node['wp-cli']['wpcli-link'] do
  to bin
end