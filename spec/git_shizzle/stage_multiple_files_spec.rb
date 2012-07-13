require 'git_shizzle'

describe "Staging multiple files by index" do

  let(:git) {stub}
  subject { GitShizzle::QuickGit.new(git) }

  context "When the git status contains modified files" do
    context "and more than one index is specified" do
      it "should run git add for all specified files" do
        git.stub(:status).and_return [
          [nil, :modified, "TEST_FILE"],
          [nil, :modified, "TEST_FILE2"],
        ]
        git.should_receive(:add).with("TEST_FILE", "TEST_FILE2")
        subject.stage(1,2)
      end
    end
  end
end
