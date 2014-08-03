require 'spec_helper'
require 'flash/cli'

describe Flash::CLI do
  subject { Flash::CLI }

  describe '.is_thor_reserved_word?' do
    it 'should allow "run" to be defined as command' do
      expect(subject.is_thor_reserved_word?('run', :command)).to be_falsey
    end
  end
end
