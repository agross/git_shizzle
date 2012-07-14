require 'git_shizzle'

describe "Tracking  multiple files by index" do
  let(:git) {stub}
  subject { GitShizzle::QuickGit.new(git) }

  context "When the git status contains new files" do
    it "should run git add for all specified files" do
      git.stub(:status).and_return [
        stub(:type => '', :untracked => true, :path => "TEST_FILE"),
        stub(:type => '', :untracked => true, :path => "TEST_FILE2")
      ]
      git.should_receive(:add).with ["TEST_FILE", "TEST_FILE2"]
      subject.track [1,2]
    end
  end
end
