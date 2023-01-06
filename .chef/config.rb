# See https://docs.chef.io/workstation/config_rb/ for more information on knife configuration options

current_dir = File.dirname(__FILE__)
log_level                :info
log_location             STDOUT
node_name                "asantana"
client_key               "#{current_dir}/asantana.pem"
chef_server_url          "https://api.chef.io/organizations/asantana"
cookbook_path            ["#{current_dir}/../cookbooks"]
