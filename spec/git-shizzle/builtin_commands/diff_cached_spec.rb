require File.join(File.dirname(__FILE__), '../../spec_helper')
require 'git_shizzle'

describe "Diff staged/cached files by index" do

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
      
      git.status[0].work_tree_status.should == nil
      git.status[0].index_status.should == :deleted
      git.status[1].work_tree_status.should == nil
      git.status[1].index_status.should == :modified
    end

    context "when a staged modified file is diffed" do
      it "should run git diff --cached" do
        git.stub(:command).and_call_original
        git.stub(:command).with(/diff/, anything)

        expect(git).to receive(:command).with('diff --cached --', ['modified'])

        subject.diff_cached 2
      end
    end

    context "when a staged deleted file is diffed" do
      it "should run git diff --cached" do
        git.stub(:command).and_call_original
        git.stub(:command).with(/diff/, anything)

        expect(git).to receive(:command).with('diff --cached --', ['deleted'])

        subject.diff_cached 1
      end
    end
  end

  context "when the repository contains no staged files" do
    it "should fail" do
      expect { subject.diff_cached 1 }.to raise_error
    end
  end
end
