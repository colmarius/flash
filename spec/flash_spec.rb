require 'spec_helper'
require 'flash'

describe Flash do

  describe '#version' do
    subject { Flash::VERSION }
    it { should be_a String }
  end
end
