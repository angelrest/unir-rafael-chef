#
# Cookbook:: ansible
# Recipe:: source
#
# Copyright:: 2023, The Authors, All Rights Reserved.

    apt_repository 'default_action' do
        uri 'ppa:ansible/ansible'
    end

    apt_repository 'explicit_remove_action' do
        uri 'ppa:ansible/ansible'
        action :remove
    end

    apt_repository 'explicit_action_ubuntu' do
        uri 'ppa:ansible/ansible'
        action :add
    end

    apt_update 'update_repo' do
        action :update
    end

    package 'mysql-server' do
        action :install
    end

