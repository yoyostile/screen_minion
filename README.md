# ScreenMinion

Automatically uploads files from certain dirs matching a certain pattern. Magic. 🔮

## Prerequisites

* Install mc for your minio. (eg. `brew install minio-mc`)
* Configure mc
* Create a `~/.screen_minion.yml` like this:

```
mc: "/usr/local/bin/mc"
host: "s3"
targets:
- path: "~/Desktop/"
  only: "^Screen"
  bucket_path: "random/"
```

## Usage

Right now sth. like this:

```
$ bundle install
$ bin/screen_minion &
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/yoyostile/screen_minion.
