require "test/unit"
require "fakeweb"
require "social_current"

FakeWeb.register_uri(:get, "https://api.github.com/users/tristanoneil/events",
  :body         => File.open("test/support/events.json").read,
  :content_type => "application/json")

FakeWeb.register_uri(:get, "https://api.github.com/users/tristanoneil",
  :body         => File.open("test/support/user.json").read,
  :content_type => "application/json")
