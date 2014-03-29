require 'spec_helper'
require 'flash/cli'

describe Flash::CLI do
  describe '#start' do
    describe 'when command is missing' do
      it 'returns an error' do
        output = flash ''
        expect(output).to match(/ERROR: Flash requires a command to run./)
      end
    end

    describe 'when the given command is not allowed' do
      it 'it returns an error' do
        output = flash 'lorem'
        expect(output).to match(/ERROR: Flash does not know command: lorem./)
      end
    end
  end
end
