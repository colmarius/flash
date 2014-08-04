require 'spec_helper'
require 'flash/command/run'

describe Flash::Command::Run, :fakefs do
  subject { described_class.new(@command, @group) }

  before { write_config_file }

  describe '#execute' do

    context 'with invalid args' do

      it 'command and group are nil' do
        @command, @group = [nil, nil]
        expect { subject.execute }.to raise_error ArgumentError
      end

      it 'command and group are empty strings' do
        @command, @group = ['', '']
        output = capture_stdout do
          expect { subject.execute }.to raise_error SystemExit
        end
        expect(output).to match(/Unknown group "" in \.flash\.yml config\./)
      end

      it 'unknown group' do
        @command = ''
        @group = 'unknown'
        output = capture_stdout do
          expect { subject.execute }.to raise_error SystemExit
        end
        expect(output).to match(/Unknown group "unknown" in \.flash\.yml config\./)
      end
    end

    context 'with valid args' do

      it 'example run ls command on projects group' do
        @command = 'ls'
        @group = 'projects'
        expect_any_instance_of(described_class)
          .to receive(:system).exactly(12).times
        subject.execute
      end

      it 'calls run command in group once' do
        @command = 'ls'
        @group = 'projects'
        expect_any_instance_of(described_class)
          .to receive(:run_command_in_group).with(@command, @group).once
        subject.execute
      end
    end
  end
end
