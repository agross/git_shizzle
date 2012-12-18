require File.join(File.dirname(__FILE__), '../spec_helper')
require 'git-shizzle'

describe "Track a file by index" do

  let(:git) { stub }
  subject { GitShizzle::QuickGit.new(git) }

  context "When the git status contains a single new file" do
    it "should run git add with the file" do
      git.stub(:status).and_return [
        stub(:type => nil, :untracked => true, :path => "TEST_FILE"),
      ]
      git.should_receive(:add).with ["TEST_FILE"]
      subject.track [1]
    end
  end
end
