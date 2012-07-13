require 'git_shizzle'

describe "Staging a file by index" do

  let(:git) {stub}
  subject { GitShizzle::QuickGit.new(git) }

  context "When the git status contains only a single modification of a tracked file" do
    it "should run the git add command with the related file" do
      git.stub(:status).and_return [[:none, :modified, "TEST_FILE"]]
      git.should_receive(:add).with("TEST_FILE")
      subject.stage(1)
    end
  end
end
