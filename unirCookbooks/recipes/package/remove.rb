apt_repository 'explicit_remove_action' do
    uri 'ppa:ansible/ansible'
    action :remove
  end