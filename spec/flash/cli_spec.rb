require 'spec_helper'
require 'flash/cli'

describe Flash::CLI, :fakefs do
  subject { described_class }

  describe '.is_thor_reserved_word?' do
    it 'should allow "run" to be defined as command' do
      expect(subject.is_thor_reserved_word?('run', :command)).to be_falsey
    end
  end

  describe '#clone' do
    before { write_config_file_with_clone }

    describe 'flash clone projects' do
      let(:output) { flash('clone projects') }

      it 'should show done cloning messages' do
        expect_any_instance_of(Flash::Command::Clone)
          .to receive(:clone_single).exactly(3).times.and_return(nil)

        expect(output).to match(/\[foo\] Done cloning project\./)
        expect(output).to match(/\[bar\] Done cloning project\./)
        expect(output).to match(/\[buz\] Done cloning project\./)
      end
    end
  end

  describe '#info' do
    before { write_config_file }

    describe 'flash info' do
      let(:output) { flash('info') }

      it 'should print all info from config file' do
        expect(output).to match(/projects/)
        expect(output).to match(/foo/)
        expect(output).to match(/bar/)
        expect(output).to match(/buz/)
        expect(output).to match(/libraries/)
        expect(output).to match(/cippa/)
        expect(output).to match(/lippa/)
      end
    end

    describe 'flash info projects' do
      let(:output) { flash('info projects') }

      it 'should print info from config file for "projects" group' do
        expect(output).to match(/foo/)
        expect(output).to match(/bar/)
        expect(output).to match(/buz/)
      end
    end

    describe 'flash info blabla' do
      let(:output) { flash('info blabla') }

      it 'should print unknown group' do
        expect(output).to match(/Unknown group "blabla" in .flash.yml config.\n/)
      end
    end
  end

  describe '#version' do
    let(:output) { flash('version') }

    it 'should print version number' do
      expect(output).to match(/#{Flash::VERSION}\n/)
    end
  end
end
