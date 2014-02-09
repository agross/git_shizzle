require File.join(File.dirname(__FILE__), '../../spec_helper')
require 'git_shizzle'

describe "Unstage staged/cached files by index" do

  let(:git) { GitShizzle::Git::Git.new(repo) }
  subject { GitShizzle::QuickGit.new(git) }

  context "repository with modified files" do
    before (:each) do
      %w{ deleted modified }.each { |f| create f; stage f }
      `git commit --message Blah`

      delete "deleted"
      stage "deleted"
      modify "modified"
      stage "modified"
      create "untracked"
      stage "untracked"

      git.status[0].work_tree_status.should == nil
      git.status[0].index_status.should == :deleted
      git.status[1].work_tree_status.should == nil
      git.status[1].index_status.should == :modified
      git.status[2].work_tree_status.should == nil
      git.status[2].index_status.should == :added
    end

    context "when a staged modified file is unstaged" do
      it "should run git reset HEAD" do
        git.stub(:command).and_call_original
        git.stub(:command).with(/reset/, anything)

        expect(git).to receive(:command).with('reset HEAD --', ['modified'])

        subject.unstage 2
      end
    end

    context "when a staged deleted file is unstaged" do
      it "should run git reset HEAD" do
        git.stub(:command).and_call_original
        git.stub(:command).with(/reset/, anything)

        expect(git).to receive(:command).with('reset HEAD --', ['deleted'])

        subject.unstage 1
      end
    end

    context "when a staged new file is unstaged" do
      it "should run git reset HEAD" do
        git.stub(:command).and_call_original
        git.stub(:command).with(/reset/, anything)

        expect(git).to receive(:command).with('reset HEAD --', ['untracked'])

        subject.unstage 3
      end
    end
  end

  context "when the repository contains no staged files" do
    it "should fail" do
      expect { subject.unstage 1 }.to raise_error
    end
  end
end
