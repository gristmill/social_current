# Social Current

Makes it easy to integrate a social activity stream into your application from third party APIs. Social Current currently only supports GitHub and Twitter but feel free to contribute additional integrations.

![Social Current Example](http://f.cl.ly/items/3V2J2E0F1q3N401H1w3x/social_current.png)

## Installation

Add this line to your application's Gemfile:

    gem 'social_current'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install social_current

## Usage

You may use Social Current directly within your view like.

```ruby
<% SocialCurrent::Stream.new({ :twitter => "tristanoneil", :github => "tristanoneil" }).build.each do |item| %>
  <%= item[:message] >
<% end %>
```

Though it's probably a better idea to add a method to a class or model like.

```ruby
class User < ActiveRecord::Base
  def stream
    SocialCurrent::Stream.new({ :twitter => twitter_username, :github => github_username }).build
  end
end
```

Then you can easily access this from within your view like.

```ruby
<% @user.stream.each do |item| %>
  <%= item[:message] %>
<% end %>
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
