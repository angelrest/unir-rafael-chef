describe command('echo 1') do
  its('stdout') { should match (/[0-9]/) }
end