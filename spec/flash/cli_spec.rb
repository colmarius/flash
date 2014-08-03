require 'spec_helper'
require 'flash/cli'

describe Flash::CLI, :fakefs do
  subject { Flash::CLI }

  describe '.is_thor_reserved_word?' do
    it 'should allow "run" to be defined as command' do
      expect(subject.is_thor_reserved_word?('run', :command)).to be_falsey
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
