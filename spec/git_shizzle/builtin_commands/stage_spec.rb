require 'git_shizzle'

describe 'Stage files by index' do

  let(:git) { GitShizzle::Git::Git.new(repo) }
  subject { GitShizzle::QuickGit.new(git) }

  before do
    allow($stdout).to receive(:puts)
  end

  describe 'repository with modified files' do
    before do
      %w{ deleted modified }.each { |f| create f; stage f }
      `git commit --message Blah`

      delete 'deleted'
      modify 'modified'

      expect(git.status[0].work_tree_status).to eq(:deleted)
      expect(git.status[1].work_tree_status).to eq(:modified)
    end

    context 'when a deleted file is staged' do
      it 'should run git rm' do
        subject.stage 1

        expect(git.status[0].index_status).to eq(:deleted)
        expect(git.status[1].index_status).to be_nil
      end
    end

    context 'when a modified file is staged' do
      it 'should run git add' do
        subject.stage 2

        expect(git.status[0].index_status).to be_nil
        expect(git.status[1].index_status).to eq(:modified)
      end
    end

    context 'when a modified and a deleted file is staged' do
      it 'should run git add and git rm' do
        subject.stage 1, 2

        expect(git.status[0].index_status).to eq(:deleted)
        expect(git.status[1].index_status).to eq(:modified)
      end
    end
  end

  context 'staged file has been modified' do
    context 'when the file is staged' do
      before do
        %w{ modified }.each { |f| create f; stage f }
        `git commit --message Blah`

        %w{ modified }.each { |f| modify f; stage f; modify f }

        expect(git.status[0].index_status).to eq(:modified)
        expect(git.status[0].work_tree_status).to eq(:modified)
      end

      it 'should run git add' do
        subject.stage 1

        expect(git.status[0].index_status).to eq(:modified)
        expect(git.status[0].work_tree_status).to be_nil
      end
    end
  end

  context 'repository without modified files' do
    it 'should fail' do
      expect { subject.stage 1 }.to raise_error
    end
  end
end
