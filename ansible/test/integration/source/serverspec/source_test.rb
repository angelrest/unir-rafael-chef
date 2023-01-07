# Chef InSpec test for recipe ansible::source

# The Chef InSpec reference, with examples and extensive documentation, can be
# found at https://docs.chef.io/inspec/resources/

# unless os.windows?
#   # This is an example test, replace with your own test.
#   describe user('root'), :skip do
#     it { should exist }
#   end
# end

# # This is an example test, replace it with your own test.
# describe port(80), :skip do
#   it { should_not be_listening }
# end

# execute 'host' do
#   command 'cat /etc/ansible/hosts'
#   live_stream true
#   action :run
# end

require'spec_helper'

if os[:family] == 'ubuntu'
    describe package('ansible') do
        it {should be_installed}
    end
end

describe command('ansible localhost -m setup ') do
  its('stdout') { should match /source/ }
end
