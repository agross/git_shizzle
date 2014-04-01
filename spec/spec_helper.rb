# -*- encoding: utf-8 -*-
require 'helpers/git_repository'
require 'coveralls'

Coveralls.wear!

RSpec.configure do |config|
  config.include GitRepository

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
