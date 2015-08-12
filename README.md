# GitSemforcer

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'git-semforcer'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install git-semforcer

## Usage

```
git semforcer init
# makes a pre-commit hook that enforces semantic versioning

git semforcer destroy
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

Bug reports and pull requests are welcome on GitHub at https://github.com/berfarah/git-semforcer.

