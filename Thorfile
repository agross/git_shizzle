require 'thor'

class GitQuick < ::Thor
  USAGE = <<-EOH
    Usage: thor git_quick:[add|new|rm|checkout|head] index [, index, ...]

    Where index is the line number in the output of `git status`, starting at 1.
    The index starts at 1 for each of the "changes to be committed",
    "changed but not updated" and "untracked files" sections.
  EOH

  [:add, :new, :rm, :checkout, :head].each do |cmd|
    desc "#{cmd} index [, index, ...]", USAGE
    method_options :dry_run => :boolean
    define_method(cmd) do |*indexes|
    end
  end

  desc "Displays the help", ""
  def help
    puts USAGE
  end
end

