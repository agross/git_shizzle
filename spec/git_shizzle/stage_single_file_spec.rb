require 'git_shizzle'

describe "Staging a file by index" do

  let(:git) {stub}
  subject { GitShizzle::QuickGit.new(git) }

  context "When the git status contains a single modified file" do
    it "should run git add with the file" do
      git.stub(:status).and_return [[nil, :modified, "TEST_FILE"]]
      git.should_receive(:add).with("TEST_FILE")
      subject.stage(1)
    end
  end

  context "When the git status contains a single deleted file" do
    it "should run git rm with the file" do
      git.stub(:status).and_return [[nil, :deleted, "TEST_FILE"]]
      git.should_receive(:rm).with("TEST_FILE")
      subject.stage(1)
    end
  end

  context "When the git status contains a single new file" do
    it "should run git rm with the file" do
      git.stub(:status).and_return [[:new, :new, "TEST_FILE"]]
      git.should_receive(:add).with("TEST_FILE")
      subject.stage(1)
    end
  end
end
