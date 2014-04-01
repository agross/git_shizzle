# git_shizzle

[![Gem Version](https://badge.fury.io/rb/git_shizzle.png)](http://badge.fury.io/rb/git_shizzle) [![Dependency Status](https://gemnasium.com/agross/git_shizzle.png)](https://gemnasium.com/agross/git_shizzle) [![Code Climate](https://codeclimate.com/github/agross/git_shizzle.png)](https://codeclimate.com/github/agross/git_shizzle)

git_shizzle lets you quickly operate on the file lists printed by `git status`. Imagine a number before each line of the status output and use that index to specify the file you want to operate on. For example, to stage the first file in the list of "Changes not staged for commit", run `quick-git stage 1`.

* Tested against Ruby 2.0.0 and 2.1.0

## Installation

```bash
$ gem install git_shizzle
```

## Usage

```bash
$ quick-git help
```

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
