# encoding: utf-8

# This is an InSpec test, that will be successful the first run. If it is
# executed the second time, the test will fail
path = "/usr/share/wp-cli"
file = "/usr/local/bin/wp"
describe file(file) do
  it { should exist }
end

describe directory(path) do
  it { should exist }
end

#WP-CLI 0.24.1
describe command("wp cli version") do
  its (:stdout) {should match "" }
end