require 'git_shizzle'

describe GitShizzle::Dsl::CommandCollection do
  context 'when reading commands' do
    it 'should not accept commands without a definition' do
      command_spec = <<-EOF
command :foo
      EOF

      expect { subject.load command_spec }.to raise_error(GitShizzle::Dsl::CommandDefinitionError, "Command 'foo': #command requires a block.")
    end
  end

  it 'should not accept duplicate identifiers' do
    command_spec = <<-EOF
command :foo do end
command :foo do end
    EOF

    expect { subject.load command_spec }.to raise_error(GitShizzle::Dsl::DuplicateCommandDefinitionError, "The 'foo' command was specified twice.")
  end

  it 'should not accept empty filters' do
    command_spec = <<-EOF
command :foo do
  applies_to
end
    EOF

    expect { subject.load command_spec }.to raise_error(GitShizzle::Dsl::CommandDefinitionError, "Command 'foo': #applies_to requires a block.")
  end

  it 'should not accept empty actions' do
    command_spec = <<-EOF
command :foo do
  action
end
    EOF

    expect { subject.load command_spec }.to raise_error(GitShizzle::Dsl::CommandDefinitionError, "Command 'foo': #action requires a block.")
  end
end
