require 'git_shizzle'

describe 'Track files by index' do

  let(:git) { GitShizzle::Git::Git.new(repo) }
  subject { GitShizzle::QuickGit.new(git) }

  describe 'repository with untracked files' do
    before do
      create 'untracked-1'
      create 'untracked-2'

      expect(git.status[0].work_tree_status).to eq(:untracked)
      expect(git.status[1].work_tree_status).to eq(:untracked)
    end

    context 'when a single file is tracked' do
      it 'should run git add for the file' do
        subject.track 1

        expect(git.status[0].index_status).to eq(:added)
        expect(git.status[1].index_status).to eq(:untracked)
      end
    end

    context 'when multiple files are tracked' do
      it 'should run git add for all specified files' do
        subject.track 1, 2

        git.status.each { |entry| expect(entry.index_status).to eq(:added) }
      end
    end
  end

  describe 'repository without untracked files' do
    it 'should fail' do
      expect { subject.track 1 }.to raise_error
    end
  end
end
