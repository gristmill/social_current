require "test/unit"
require "fakeweb"
require "mocha"
require "social_current"

File.stubs(:exists?).returns(false)

FakeWeb.register_uri(:get, "https://api.github.com/users/tristanoneil/events",
  :body         => File.open("test/support/github/stream.json").read,
  :content_type => "application/json")

FakeWeb.register_uri(:get, "https://api.github.com/users/tristanoneil",
  :body         => File.open("test/support/github/user.json").read,
  :content_type => "application/json")

FakeWeb.register_uri(:get, "https://api.twitter.com/1/users/show.json?screen_name=tristanoneil",
  :body         => File.open("test/support/twitter/user.json").read,
  :content_type => "application/json")

FakeWeb.register_uri(:get, "https://api.twitter.com/1/statuses/user_timeline.json?&screen_name=tristanoneil",
  :body         => File.open("test/support/twitter/stream.json").read,
  :content_type => "application/json")
