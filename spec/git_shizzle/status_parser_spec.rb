require 'git_shizzle'

describe 'File index, status and path parsed from `git status`' do

  let(:git) { GitShizzle::Git::Git.new(repo) }
  subject { GitShizzle::QuickGit.new(git) }

  context 'when file name does not contain spaces' do
    it 'should be able to parse' do
      create 'file-name'

      expect(git.status.count).to eq(1)
    end
  end

  context 'when file name contains spaces' do
    it 'should be able to parse' do
      create 'file name'

      expect(git.status.count).to eq(1)
    end
  end

  context 'when two files are untracked' do
    it 'should be able to parse' do
      create 'file-1'
      create 'file-2'

      expect(git.status.count).to eq(2)
    end
  end

  context 'when tracked file was renamed and staged' do
    context 'no other files exist' do
      it 'should be able to parse indexes' do
        create 'file'
        stage
        `git commit -m 'added file'`
        move 'file', 'renamed-file'
        stage

        expect(git.status.count).to eq(1)
      end
    end

    context 'untracked files exist' do
      it 'should be able to parse indexes' do
        create 'file'
        stage
        `git commit -m 'added file'`
        move 'file', 'renamed-file'
        stage
        create 'untracked'

        expect(git.status.count).to eq(2)
      end
    end
  end
end
