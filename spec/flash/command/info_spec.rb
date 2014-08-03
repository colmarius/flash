require 'spec_helper'
require 'flash/command/info'

describe Flash::Command::Info, :fakefs do
  subject { described_class.new(group) }

  before { write_config_file }

  describe '#execute' do
    let(:group) { 'projects' }

    it 'calls output method with group' do
      expect(subject).to receive(:output).with(group).once
      subject.execute
    end
  end
end
