require File.join(File.dirname(__FILE__), '../../spec_helper')
require 'git_shizzle'

describe 'Stage patches by index', :draft => true do

  let(:git) { GitShizzle::Git::Git.new(repo) }
  subject { GitShizzle::QuickGit.new(git) }

  context 'repository with modified files' do
    before (:each) do
      %w{ deleted modified }.each { |f| create f; stage f }
      `git commit --message Blah`

      delete 'deleted'
      modify 'modified'

      git.status[0].work_tree_status.should == :deleted
      git.status[1].work_tree_status.should == :modified
    end

    context 'when a modified file is staged' do
      it 'should run git add --patch' do
        git.stub(:command).and_call_original
        git.stub(:command).with(/add/, anything)

        expect(git).to receive(:command).with('add --patch --', ['modified'])

        subject.stage_with_patch 2
      end
    end
  end
end
