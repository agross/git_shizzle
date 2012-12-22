require File.join(File.dirname(__FILE__), '../spec_helper')
require 'git-shizzle'

describe "Stage files by index" do

  let(:git) { GitShizzle::Git::Git.new(repo) }
  subject { GitShizzle::QuickGit.new(git) }

  context "repository with modified files" do
    before (:each) do
      %w{ deleted modified }.each { |f| create f; stage f }
      `git commit --message "Blah"`

      delete "deleted"
      modify "modified"

      git.status[0].work_tree_status.should == :deleted
      git.status[1].work_tree_status.should == :modified
    end

    context "when a deleted file is staged" do
      it "should run git rm" do
        subject.stage 1

        git.status[0].index_status.should == :deleted
        git.status[1].index_status.should be_nil
      end
    end

    context "when a modified file is staged" do
      it "should run git add" do
        subject.stage 2

        git.status[0].index_status.should be_nil
        git.status[1].index_status.should == :modified
      end
    end

    context "when a modified and a deleted file is staged" do
      it "should run git add and git rm" do
        subject.stage 1, 2

        git.status[0].index_status.should == :deleted
        git.status[1].index_status.should == :modified
      end
    end
  end

  context "staged file has been modified" do
    context "when the file is staged" do
      before do
        %w{ modified }.each { |f| create f; stage f }
        `git commit --message "Blah"`

        %w{ modified }.each { |f| modify f; stage f; modify f }

        git.status[0].index_status.should == :modified
        git.status[0].work_tree_status.should == :modified
      end

      it "should run git add" do
        subject.stage 1

        git.status[0].index_status.should == :modified
        git.status[0].work_tree_status.should be_nil
      end
    end
  end

  context "when the repository contains no modified files" do
    it "should fail" do
      expect { subject.stage 1 }.to raise_error
    end
  end
end
