require 'spec_helper'
require 'flash/config'

describe Flash::Config, :fakefs  do
  subject { Flash::Config.new }

  it 'can load from a file' do
    write_config_file
    expect(subject['projects']).to eq %w(foo bar buz)
  end
end
