# git_shizzle

[![Gem Version](https://badge.fury.io/rb/git_shizzle.png)](http://badge.fury.io/rb/git_shizzle) [![Build Status](https://travis-ci.org/agross/git_shizzle.png?branch=master)](https://travis-ci.org/agross/git_shizzle) [![Dependency Status](https://gemnasium.com/agross/git_shizzle.png)](https://gemnasium.com/agross/git_shizzle) [![Code Climate](https://codeclimate.com/github/agross/git_shizzle.png)](https://codeclimate.com/github/agross/git_shizzle) [![Coverage Status](https://coveralls.io/repos/agross/git_shizzle/badge.png)](https://coveralls.io/r/agross/git_shizzle)

git_shizzle lets you quickly operate on the file lists printed by `git status`. Imagine a number before each line of the status output and use that index to specify the file you want to operate on. For example, to stage the first file in the list of "Changes not staged for commit", run `quick-git stage 1`.

* Tested against Ruby 1.9.3, 2.0.0 and 2.1.0

## Installation

```bash
$ gem install git_shizzle
```

## Usage

```bash
$ quick-git help
```

### Examples

```bash
# Stage modified file 1 (first in output of git status).
$ quick-git stage 1

# Stage modified file 1, 2, 3 and 4, as in output of git status.
$ quick-git stage 1 2 3 4

# Stage files 1 to 3. Used like a Ruby range.
$ quick-git stage 1..3

# Stage all modified files.
$ quick-git stage .

# Show diff of modified file 1.
$ quick-git diff 1

# Remove staged file 1 from the index.
$ quick-git unstage 1

# Add untracked file 1 to the index.
$ quick-git track 1

# Discard working copy changes of modified file 1.
$ quick-git checkout 1
```

### git aliases

I recommend you set up git aliases like `git config --global alias.qa quick-git stage`. See some examples in [my dotfiles repository](https://github.com/agross/dotfiles/blob/master/profiles/cygwin/git/gitconfig#L18).

## Development

* Source hosted at [GitHub](https://github.com/agross/git_shizzle)
* Report issues/Questions/Feature requests on [GitHub Issues](https://github.com/agross/git_shizzle/issues)

Pull requests are very welcome! Make sure your patches are well tested. Please create a topic branch for every separate change you make.

## Contributing

1. Fork it (http://github.com/agross/git_shizzle/fork)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
