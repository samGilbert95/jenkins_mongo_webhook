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

    it 'should install mongodb' do
      expect(chef_run).to upgrade_package 'mongodb-org'
    end

    it 'should add mongo to the source list' do
      expect(chef_run).to add_apt_repository('mongodb-org')
    end

    it 'should update all sources' do
      expect(chef_run).to update_apt_update('update')
    end

    it 'enables the mongod service' do
      expect(chef_run).to enable_service 'mongod'
    end

    it 'starts the mongodb service' do
      expect(chef_run).to start_service 'mongod'
    end

  end
end
