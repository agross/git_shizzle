require 'git_shizzle'

describe "Staging a modified file by index" do

  let(:git) {stub}
  subject { GitShizzle::QuickGit.new(git) }

  it "should add the file" do
    git.stub(:status).and_return [[:none, :modified, "TEST_FILE"]]
    git.should_receive(:add).with("TEST_FILE")
    subject.stage 1
  end
end
