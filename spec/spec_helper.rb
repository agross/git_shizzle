require "rspec"
require "tmpdir"
require "fileutils"
require "securerandom"

module GitRepository
  extend RSpec::SharedContext

  let(:repo) {
    @repo_dir
  }

  before(:all) {
    create_sample_repo
  }

  after(:all) {
    remove_sample_repo
  }

  def create_sample_repo
    @repo_dir = Dir.mktmpdir "git-shizzle"
    puts "Creating sample Git repository in #{@repo_dir}"
    Dir.chdir(@repo_dir) do
      `git init`

      %w{modified modified-and-staged modified-staged-and-modified}.each{ |f| create f; stage f }
      `git commit --message "Adding tracked files"`

      %w{modified modified-and-staged modified-staged-and-modified}.each { |f| modify f }
      %w{modified-and-staged modified-staged-and-modified}.each { |f| stage f }
      %w{modified-staged-and-modified}.each { |f| modify f }

      %w{new-and-staged}.each { |f| create f; stage f }
      %w{new-staged-and-modified}.each { |f| create f; stage f; modify f }
      %w{untracked-1 untracked-2}.each { |f| create f }
    end
  end

  def create(file)
    puts "Creating #{file}"
    FileUtils.touch file
  end

  def modify(file)
    File.write file, ::SecureRandom.uuid
  end

  def stage(file = nil)
    `git add #{file || '--all'}`
  end

  def remove_sample_repo
    FileUtils.rm_rf @repo_dir
  end
end

RSpec.configure { |config|
  config.include GitRepository
}
