# Github Activity

Makes it easy to integrate the Github activity stream into your application.

## Installation

Add this line to your application's Gemfile:

    gem 'github_activity'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install github_activity

## Usage

Within your view.

    <%= GithubActivity::Stream.new("tristanoneil").as_html %>

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
