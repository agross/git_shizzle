# -*- encoding: utf-8 -*-

desc 'stage files'
command :stage do
  applies_to do |index, work_tree|
    work_tree == :modified || work_tree == :deleted
  end

  action do |index, work_tree, path|
    case work_tree
      when :modified
        [:add, path]
      when :deleted
        [:remove, path]
    end
  end
end

desc 'stage patches'
command :stage_with_patch do
  applies_to do |index, work_tree|
    work_tree == :modified || work_tree == :deleted
  end

  action do |index, work_tree, path|
    case work_tree
      when :modified
        [:add_patch, path]
      when :deleted
        [:remove_patch, path]
    end
  end
end

desc 'track files'
command :track do
  applies_to do |index, work_tree|
    index == :untracked || work_tree == :untracked
  end

  action do |index, work_tree, path|
     [:add, path] if work_tree == :untracked
  end
end
