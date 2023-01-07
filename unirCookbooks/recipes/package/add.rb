apt_repository 'default_action' do
    uri 'ppa:ansible/ansible'
  end

  apt_repository 'explicit_action' do
    uri 'ppa:ansible/ansible'
    action :add
  end