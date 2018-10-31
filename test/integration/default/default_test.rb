# # encoding: utf-8

# Inspec test for recipe mongoDB::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

# Tests that checks what process and address is running on this course
describe port(27017) do
  it { should be_listening }
  its('processes'){should include 'mongod'}
  its('addresses'){should include '0.0.0.0'}
end
#Tests that mongod installed and version 3.2.*
describe package 'mongodb-org' do
  it { should be_installed }
  its('version') {should match /3.2\./}
end
#Tests that mongod is running and enabled
describe service 'mongod' do
  it { should be_enabled }
  it { should be_running }
end
