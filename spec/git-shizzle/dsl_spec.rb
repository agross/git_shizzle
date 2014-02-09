require File.join(File.dirname(__FILE__), '../spec_helper')
require 'git_shizzle'

describe "Command DSL" do

  context "when reading commands" do
    it "should not accept commands without a definition" do
      commands = GitShizzle::Dsl::CommandCollection.new
      command_spec = <<-EOF
command :foo
      EOF

      expect { commands.load command_spec }.to raise_error(GitShizzle::Dsl::CommandDefinitionError, "Command 'foo': #command requires a block.")
    end
  end

  it "should not accept duplicate identifiers" do
    commands = GitShizzle::Dsl::CommandCollection.new
    command_spec = <<-EOF
command :foo do end
command :foo do end
    EOF

    expect { commands.load command_spec }.to raise_error(GitShizzle::Dsl::DuplicateCommandDefinitionError, "The 'foo' command was specified twice.")
  end

  it "should not accept empty filters" do
    commands = GitShizzle::Dsl::CommandCollection.new
    command_spec = <<-EOF
command :foo do
  applies_to
end
    EOF

    expect { commands.load command_spec }.to raise_error(GitShizzle::Dsl::CommandDefinitionError, "Command 'foo': #applies_to requires a block.")
  end

  it "should not accept empty actions" do
    commands = GitShizzle::Dsl::CommandCollection.new
    command_spec = <<-EOF
command :foo do
  action
end
    EOF

    expect { commands.load command_spec }.to raise_error(GitShizzle::Dsl::CommandDefinitionError, "Command 'foo': #action requires a block.")
  end
end
