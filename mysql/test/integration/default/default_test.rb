# Chef InSpec test for recipe mysql::default

# The Chef InSpec reference, with examples and extensive documentation, can be
# found at https://docs.chef.io/inspec/resources/

  describe package('mysql-server') do
    it { should be_installed }
  end

  describe port(3306) do
    it { should be_listening }
  end

  describe service("mysql.service") do
      it { should be_enabled }
      it { should be_running }
    end