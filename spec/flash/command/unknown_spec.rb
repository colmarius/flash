require 'spec_helper'
require 'flash/command/unknown'

describe Flash::Command::Unknown do
  describe '#setup' do
    describe 'when the given command is not allowed' do
      it 'returns an error' do
        output = flash 'lorem'
        expect(output).to match(/ERROR: Flash does not know command: lorem./)
      end
    end
  end
end
