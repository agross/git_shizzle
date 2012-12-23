require File.join(File.dirname(__FILE__), '../spec_helper')
require 'git_shizzle'

describe "Commands specified on the CLI" do

  let(:git) { GitShizzle::Git::Git.new(repo) }
  subject { GitShizzle::QuickGit.new(git) }

  context "when invoking a command that does not exist" do
    it "should fail" do
      expect { subject.run(:blah) }.to raise_error(GitShizzle::Dsl::CommandNotFound, "Could not find 'blah' command.")
    end
  end
end