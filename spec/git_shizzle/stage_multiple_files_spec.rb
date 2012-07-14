require 'git_shizzle'

describe "Staging multiple files by index" do
  let(:git) {stub}
  subject { GitShizzle::QuickGit.new(git) }

  context "When the git status contains modified files" do
    it "should run git add for all specified files" do
      git.stub(:status).and_return [
        stub(:type => 'M', :untracked => false, :path => "TEST_FILE"),
        stub(:type => 'M', :untracked => false, :path => "TEST_FILE2")
      ]
      git.should_receive(:add).with ["TEST_FILE", "TEST_FILE2"]
      subject.stage(1,2)
    end
  end

  context "When the git status contains deleted files" do
    it "should run git rm for all specified files" do
      git.stub(:status).and_return [
        stub(:type => 'D', :untracked => false, :path => "TEST_FILE"),
        stub(:type => 'D', :untracked => false, :path => "TEST_FILE2"),
      ]
      git.should_receive(:rm).with ["TEST_FILE", "TEST_FILE2"]
      subject.stage(1,2)
    end
  end

  context "When the git status contains new files" do
    it "should not run git rm or add for all specified files" do
      git.stub(:status).and_return [
        stub(:type => '', :untracked => true, :path => "TEST_FILE"),
        stub(:type => '', :untracked => true, :path => "TEST_FILE2"),
      ]
      git.should_not_receive(:rm).with("TEST_FILE", "TEST_FILE2")
      git.should_not_receive(:add).with("TEST_FILE", "TEST_FILE2")
      subject.stage(1,2)
    end
  end

end
