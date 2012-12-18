require "rspec"
require "tmpdir"
require "fileutils"
require "securerandom"

module GitRepository
  extend RSpec::SharedContext

  let(:repo) {
    @repo
  }

  before(:each) {
    create_sample_repo
  }

  after(:each) {
    remove_sample_repo
  }

  def create_sample_repo
    @previous_dir = Dir.pwd

    @repo = Dir.mktmpdir "git-shizzle"
    Dir.chdir(@repo)
    `git init`

    #%w{modified modified-and-staged modified-staged-and-modified deleted}.each{ |f| create f; stage f }
    #`git commit --message "Adding tracked files"`
    #
    #%w{modified modified-and-staged modified-staged-and-modified}.each { |f| modify f }
    #%w{modified-and-staged modified-staged-and-modified}.each { |f| stage f }
    #%w{modified-staged-and-modified}.each { |f| modify f }
    #%w{deleted}.each { |f| delete f }
    #
    #%w{new-and-staged}.each { |f| create f; stage f }
    #%w{new-staged-and-modified}.each { |f| create f; stage f; modify f }
    #%w{untracked-1 untracked-2}.each { |f| create f }
  end

  def create(file)
    FileUtils.touch file
  end

  def modify(file)
    File.write file, ::SecureRandom.uuid
  end

  def delete(file)
    FileUtils.rm file
  end

  def stage(file = nil)
    `git add #{file || '--all'}`
  end

  def remove_sample_repo
    Dir.chdir(@previous_dir)
    FileUtils.rm_rf @repo
  end
end

RSpec.configure { |config|
  config.include GitRepository
}
