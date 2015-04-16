require 'spec_helper'
require 'flash/command/clone'

RSpec.describe Flash::Command::Clone, :fakefs do
  subject { described_class.new(@group) }

  before { write_config_file }

  describe '#execute' do
    context 'with invalid group' do
      it 'with nil group' do
        @group = nil
        expect { subject.execute }.to raise_error ArgumentError
      end

      it 'with empty group' do
        @group = ''
        output = capture_stdout do
          expect { subject.execute }.to raise_error SystemExit
        end
        expect(output).to match(/Unknown group "" in .flash.yml config./)
      end

      it 'with unknown group' do
        @group = 'unknown'
        output = capture_stdout do
          expect { subject.execute }.to raise_error SystemExit
        end
        expect(output).to match(/Unknown group "unknown" in .flash.yml config./)
      end
    end

    context 'with valid group' do
      before { @group = 'projects' }

      describe 'without clone git endpoint' do
        it 'should raise error' do
          output = capture_stdout do
            expect { subject.execute }.to raise_error SystemExit
          end
          expect(output).to match(/Missing clone git URL defined in .flash.yml config./)
        end
      end

      describe 'with clone git endpoint' do
        before { write_config_file_with_clone }

        it 'should clone projects in group' do
          expect(subject).to receive(:clone_projects).with(@group).once
          subject.execute
        end
      end
    end
  end
end
