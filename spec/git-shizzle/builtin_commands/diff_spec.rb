require File.join(File.dirname(__FILE__), '../../spec_helper')
require 'git_shizzle'

describe "Diff files by index" do

  let(:git) { GitShizzle::Git::Git.new(repo) }
  subject { GitShizzle::QuickGit.new(git) }

  context "repository with modified files" do
    before (:each) do
      %w{ deleted modified }.each { |f| create f; stage f }
      `git commit --message Blah`

      delete "deleted"
      modify "modified"

      git.status[0].work_tree_status.should == :deleted
      git.status[1].work_tree_status.should == :modified
    end

    context "when a modified file is diffed" do
      it "should run git diff" do
        git.stub(:command).and_call_original
        git.stub(:command).with(/diff/, anything)

        expect(git).to receive(:command).with('diff --', ['modified'])

        subject.diff 2
      end
    end

    context "when a deleted file is diffed" do
      it "should run git diff" do
        git.stub(:command).and_call_original
        git.stub(:command).with(/diff/, anything)

        expect(git).to receive(:command).with('diff --', ['deleted'])

        subject.diff 1
      end
    end
  end

  context "when the repository contains no modified files" do
    it "should fail" do
      expect { subject.diff 1 }.to raise_error
    end
  end
end
