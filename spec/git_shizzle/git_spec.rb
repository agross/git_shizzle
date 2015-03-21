require 'git_shizzle'

describe 'Git repository' do

  let(:git) { GitShizzle::Git::Git.new(repo) }
  subject { GitShizzle::QuickGit.new(git) }

  context 'when invoking a command in a subdirectory of the Git repository' do
    let(:subdir) { 'sub-directory' }
    it 'should succeed' do
      FileUtils.touch 'file'
      FileUtils.mkdir subdir

      Dir.chdir(subdir) do
        subject.run(:track, 1)
      end
    end
  end

  context 'when invoking a command for a file with spaces' do
    it 'should succeed' do
      FileUtils.touch 'file with spaces'

      subject.run(:track, 1)
     end
  end

  context 'when invoking a command outside a Git repository' do
    it 'should fail' do
      FileUtils.rm_rf '.git'
      expect { subject.run(:track) }.to raise_error(GitShizzle::Git::GitExecuteError, /Not a git repository/)
    end
  end
end
