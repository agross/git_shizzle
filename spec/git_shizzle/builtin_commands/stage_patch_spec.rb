require 'git_shizzle'

describe 'Stage patches by index', :draft => true do

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

    before do
      allow(git).to receive(:command).and_call_original
      allow(git).to receive(:command).with(/add/, anything)
    end

    context 'when a modified file is staged' do
      it 'should run git add --patch' do
        subject.stage_with_patch 2

        expect(git).to have_received(:command).with('add --patch --', ['modified'])
      end
    end
  end
end
