require File.join(File.dirname(__FILE__), '../spec_helper')
require 'git-shizzle'

describe "Track files by index" do

  let(:git) { GitShizzle::Git::Git.new(@repo) }
  subject { GitShizzle::QuickGit.new(git) }

  context "repository with untracked files" do
    before (:each) do
      create "untracked-1"
      create "untracked-2"

      git.status[0].work_tree_status.should == :untracked
      git.status[1].work_tree_status.should == :untracked
    end

    context "when a single file is tracked" do
      it "should run git add for the file" do
        subject.track 1

        git.status[0].index_status.should == :added
        git.status[1].index_status.should == :untracked
      end
    end

    context "when multiple files are tracked" do
      it "should run git add for all specified files" do
        subject.track 1, 2

        git.status.each { |entry| entry.index_status.should == :added }
      end
    end
  end

  context "when the repository contains no untracked files" do
    it "should fail" do
      lambda { subject.track 1 }.should raise_error
    end
  end
end
