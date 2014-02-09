require File.join(File.dirname(__FILE__), '../spec_helper')
require 'git_shizzle'

describe 'Git Repository' do

  let(:git) { GitShizzle::Git::Git.new(repo) }
  subject { GitShizzle::QuickGit.new(git) }

  context 'when invoking a command outside a Git repository' do
    it 'should fail' do
      FileUtils.rm_rf '.git'
      expect { subject.run(:track) }.to raise_error(GitShizzle::Git::GitExecuteError, /Not a git repository/)
    end
  end
end
