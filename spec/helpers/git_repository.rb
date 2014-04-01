require 'tmpdir'
require 'fileutils'
require 'securerandom'

module GitRepository
  extend RSpec::SharedContext

  let(:repo) { @repo }
  before { create_sample_repo }
  after { remove_sample_repo }

  def create_sample_repo
    @previous_dir = Dir.pwd
    @repo = Dir.mktmpdir 'git_shizzle'
    Dir.chdir(@repo)
    `git init`
    `git config user.name somebody`
    `git config user.email somebody@example.com`
  end

  def create(file)
    FileUtils.touch file
    modify(file)
  end

  def modify(file)
    File.write file, ::SecureRandom.uuid
  end

  def move(src, dst)
    FileUtils.mv src, dst, :verbose => true
  end

  def delete(file)
    FileUtils.rm file
  end

  def stage(file = nil)
    `git add --all #{file}`
  end

  def remove_sample_repo
    Dir.chdir(@previous_dir)
    FileUtils.rm_rf @repo
  end
end
