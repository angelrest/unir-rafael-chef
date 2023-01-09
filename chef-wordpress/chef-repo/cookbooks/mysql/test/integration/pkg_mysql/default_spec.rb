#require 'spec_helper'

# InSpec test for recipe vim_pruebas_chef::default

# The InSpec reference, with examples and extensive documentation, can be
# found at https://www.inspec.io/docs/reference/resources/
# This is an example test, replace it with your own test.
describe package('mysql-server') do
  it { should be_installed }
end

describe port(3306) do
  it { should be_listening }
end


if os.family == 'debian'
  describe service("mysql.service") do
    it { should be_enabled }
    it { should be_running }
  end
end