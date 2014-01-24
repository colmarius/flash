require 'spec_helper'
require 'flash'

describe Flash do

  describe "VERSION" do
    subject { Flash::VERSION }
    it { should be_a String }
  end
end
