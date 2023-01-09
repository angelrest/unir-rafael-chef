#require 'spec_helper'

# InSpec test for recipe vim_pruebas_chef::default

# The InSpec reference, with examples and extensive documentation, can be
# found at https://www.inspec.io/docs/reference/resources/
# This is an example test, replace it with your own test.
  describe port(80), :skip do
    it { should_not be_listening }
  end

  describe port(80) do
    it { should be_listening }
    its('protocols') { should cmp 'tcp' }
  end

  describe command("php") do
    it { should exist }
  end

  describe os.family do
    it { should eq 'debian' }
  end

  if os.family == 'debian'
    describe service("apache2") do
      it { should be_enabled }
      it { should be_running }
    end
  end

  if os.family == 'redhat'
    describe service("httpd") do
      #it { should be_enabled }
      it { should be_running }
    end
  end