require 'spec_helper'
require 'flash/config'

RSpec.describe Flash::Config, :fakefs do
  subject { described_class.new }

  describe '#initialize' do
    it 'can load from a file' do
      write_config_file
      expect(subject['projects']).to eq %w(foo bar buz)
    end

    it 'will exit with error message if no config file found' do
      output = capture_stdout do
        expect { subject }.to raise_error SystemExit
      end
      expect(output).to match(/ERROR: .flash.yml does not exist.\n/)
    end
  end
end
