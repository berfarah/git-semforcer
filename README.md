# GitSemverCop

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'git-semver-cop'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install git-semver-cop

## Usage

```
git semver-cop init
# makes a pre-commit hook that enforces semantic versioning

git semver-cop destroy
# removes said hook
```

You are prompted before your commit goes through:
```
$ git add .
$ git commit
Choose a version increment for this commit:
[patch|minor|major|none]
$ none
# Nothing happened
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/berfarah/git-semver-cop.

