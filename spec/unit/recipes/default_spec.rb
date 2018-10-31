#
# Cookbook:: mongoDB
# Spec:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'mongoDB::default' do
  context 'When all attributes are default, on Ubuntu 16.04' do
    let(:chef_run) do
      # for a complete list of available platforms and versions see:
      # https://github.com/customink/fauxhai/blob/master/PLATFORMS.md
      runner = ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '16.04')
      runner.converge(described_recipe)
    end

    # Check if mongdd is installed and upgraded
    it 'should install mongodb' do
      expect(chef_run).to upgrade_package 'mongodb-org'
    end

    # Add to source list, a list of urls for different additional addons
    it 'should add mongo to the source list' do
      expect(chef_run).to add_apt_repository('mongodb-org')
    end

    # Update all files in source list
    it 'should update all sources' do
      expect(chef_run).to update_apt_update('update')
    end

    # Delete mongod.conf file
    it "should delete /etc/mongod/mongod.conf " do
     expect(chef_run).to delete_link('/etc/mongod/mongod.conf')
    end

    # Delete mongod.service file
    it "should delete /etc/systemd/system/mongod.service " do
     expect(chef_run).to delete_link('/etc/systemd/system/mongod.service')
    end

    # Create new mongod conf file in etc
    it "should create file mongod.conf in /etc" do
      expect(chef_run).to create_template('/etc/mongod.conf')
    end

    # create new mongod.service file in etc file path
    it "should create file mongod.service in /etc/systemd/system/mongod.service" do
     expect(chef_run).to create_template('/etc/systemd/system/mongod.service')
    end

    # Enable the mongod Service
    it 'enables the mongod service' do
      expect(chef_run).to enable_service 'mongod'
    end

    # Start the mongod service
    it 'starts the mongodb service' do
      expect(chef_run).to start_service 'mongod'
    end

  end
end
