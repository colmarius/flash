require 'spec_helper'
require 'flash/cli'

describe Flash::CLI do
  describe '#setup' do
    describe 'when command is missing' do
      it 'returns an error' do
        output = flash ''
        expect(output).to match(/ERROR: Flash requires a command to run./)
      end
    end

  end
  describe '#setup' do
    describe 'when the given command is allowed' do
      it 'returns a Flash class instance' do
        output = Flash::CLI.new(['run']).setup
        expect(output).to be_a_kind_of(Flash::Command::Run)
      end
    end
  end
end
