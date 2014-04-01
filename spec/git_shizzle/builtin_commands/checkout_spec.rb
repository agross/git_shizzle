require 'git_shizzle'

describe 'Checkout files by index' do

  let(:git) { GitShizzle::Git::Git.new(repo) }
  subject { GitShizzle::QuickGit.new(git) }

  describe 'repository with modified files' do
    before do
      %w{ deleted modified }.each { |f| create f; stage f }
      `git commit --message Blah`

      delete 'deleted'
      modify 'modified'

      expect(git.status[0].work_tree_status).to eq(:deleted)
      expect(git.status[1].work_tree_status).to eq(:modified)
    end

    before do
      allow(git).to receive(:command).and_call_original
      allow(git).to receive(:command).with(/checkout/, anything)
    end

    context 'when a modified file is checked out' do
      it 'should run git checkout' do
        subject.checkout 2

        expect(git).to have_received(:command).with('checkout --', ['modified'])
      end
    end

    context 'when a deleted file is checked out' do
      it 'should run git checkout' do
        subject.checkout 1

        expect(git).to have_received(:command).with('checkout --', ['deleted'])
      end
    end
  end

  describe 'repository without modified files' do
    it 'should fail' do
      expect { subject.checkout 1 }.to raise_error
    end
  end
end
