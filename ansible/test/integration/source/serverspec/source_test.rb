# require 'spec_helper'

# if os[:family] == 'ubuntu'
#     describe package('ansible') do
#         it {should be_installed}
#     end
# end

# # realizamos un ping sobre el equipo con ansible--------------
# describe command('ansible localhost -m ping ') do
#   its('stdout') { should match /bin/ }
#   its('exit_status') { should eq 0 }
#   its('stderr') { should eq '' }
# end
# # ------------------------------------------------------------