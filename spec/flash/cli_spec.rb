require 'spec_helper'
require 'flash/cli'

describe Flash::CLI do
  subject { Flash::CLI }

  describe '.is_thor_reserved_word?' do
    it 'should allow "run" to be defined as command' do
      expect(subject.is_thor_reserved_word?('run', :command)).to be_falsey
    end
  end

  describe '#version' do
    let(:output) { flash('version') }

    it 'should print version number' do
      expect(output).to match(/#{Flash::VERSION}\n/)
    end
  end
end
