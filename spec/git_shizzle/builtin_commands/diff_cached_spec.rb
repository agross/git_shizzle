require 'git_shizzle'

describe 'Diff staged/cached files by index' do

  let(:git) { GitShizzle::Git::Git.new(repo) }
  subject { GitShizzle::QuickGit.new(git) }

  before do
    allow($stdout).to receive(:puts)
  end

  describe 'repository with staged files' do
    before do
      %w{ deleted modified }.each { |f| create f; stage f }
      `git commit --message Blah`

      delete 'deleted'
      stage 'deleted'
      modify 'modified'
      stage 'modified'

      expect(git.status[0].work_tree_status).to eq(nil)
      expect(git.status[0].index_status).to eq(:deleted)
      expect(git.status[1].work_tree_status).to eq(nil)
      expect(git.status[1].index_status).to eq(:modified)
    end

    before do
      allow(git).to receive(:command).and_call_original
      allow(git).to receive(:command).with(/diff/, anything)
    end

    context 'when a staged modified file is diffed' do
      it 'should run git diff --cached' do
        subject.diff_cached 2

        expect(git).to have_received(:command).with('diff --cached --', ['modified'])
      end
    end

    context 'when a staged deleted file is diffed' do
      it 'should run git diff --cached' do
        subject.diff_cached 1

        expect(git).to have_received(:command).with('diff --cached --', ['deleted'])
      end
    end
  end

  describe 'repository without staged files' do
    it 'should fail' do
      expect { subject.diff_cached 1 }.to raise_error
    end
  end
end
