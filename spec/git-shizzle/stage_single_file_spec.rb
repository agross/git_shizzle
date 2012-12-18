require File.join(File.dirname(__FILE__), '../spec_helper')
require 'git-shizzle'

describe "Staging a file by index" do

  let(:git) { stub }
  subject { GitShizzle::QuickGit.new(git) }

  context "When the git status contains a single modified file" do
    it "should run git add with the file" do
      git.stub(:status).and_return [stub(:type => 'M', :untracked => false, :path => "TEST_FILE")]
      git.should_receive(:add).with ["TEST_FILE"]
      subject.stage [1]
    end
  end

  context "When the git status contains a single deleted file" do
    it "should run git rm with the file" do
      git.stub(:status).and_return [stub(:type => 'D', :untracked => false, :path => "TEST_FILE")]
      git.should_receive(:remove).with ["TEST_FILE"]
      subject.stage [1]
    end
  end

  context "When the git status contains a new file" do
    it "should not run git add or git rm for it" do
      git.stub(:status).and_return [stub(:type => '', :untracked => true, :path => "TEST_FILE")]
      git.should_not_receive(:rm).with ["TEST_FILE"]
      git.should_not_receive(:add).with ["TEST_FILE"]
      subject.stage [1]
    end
  end
end

