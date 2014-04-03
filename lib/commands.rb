# -*- encoding: utf-8 -*-

desc 'stage files'
command :stage do
  applies_to do |index, work_tree|
    work_tree == :modified || work_tree == :deleted
  end

  action do |index, work_tree, path|
    case work_tree
      when :modified
        ['add --', path]
      when :deleted
        ['rm --', path]
    end
  end
end

desc 'stage patches'
command :stage_with_patch do
  applies_to do |index, work_tree|
    work_tree == :modified
  end

  action do |index, work_tree, path|
    case work_tree
      when :modified
        ['add --patch --', path]
    end
  end
end

desc 'track files'
command :track do
  applies_to do |index, work_tree|
    index == :untracked || work_tree == :untracked
  end

  action do |index, work_tree, path|
    ['add --', path] if work_tree == :untracked
  end
end

desc 'diff files'
command :diff do
  applies_to do |index, work_tree|
    work_tree == :modified || work_tree == :deleted
  end

  action do |index, work_tree, path|
    ['diff --', path]
  end
end

desc 'diff cached (staged) files'
command :diff_cached do
  applies_to do |index, work_tree|
    index == :modified || index == :deleted
  end

  action do |index, work_tree, path|
    ['diff --cached --', path]
  end
end

desc 'checkout files'
command :checkout do
  applies_to do |index, work_tree|
    work_tree == :modified || work_tree == :deleted
  end

  action do |index, work_tree, path|
    ['checkout --', path]
  end
end

desc 'unstage files'
command :unstage do
  applies_to do |index, work_tree|
    index == :modified || index == :deleted || index == :added
  end

  action do |index, work_tree, path|
    ['reset HEAD --', path]
  end
end
