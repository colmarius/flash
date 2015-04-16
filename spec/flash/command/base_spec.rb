require 'spec_helper'
require 'flash/command/base'

RSpec.describe Flash::Command::Base, :fakefs do
  subject { described_class.new }

  before { write_config_file }

  describe '#config' do
    let(:config) { subject.config }

    it 'should be of correct kind' do
      expect(config).to be_an_instance_of(Flash::Config)
    end

    it 'should behave as Hash' do
      expect(config).to respond_to(:[])
    end
  end

  describe '#valid_group?' do
    it 'responds true for valid groups' do
      expect(subject.valid_group?('projects')).to be_truthy
      expect(subject.valid_group?('libraries')).to be_truthy
    end

    it 'responds false otherwise' do
      expect(subject.valid_group?('unknkown')).to be_falsey
    end
  end
end
