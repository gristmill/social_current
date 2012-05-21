require "test_helper"

class TestTwitter < Test::Unit::TestCase
  def setup
    @twitter = SocialCurrent::TwitterService.new("tristanoneil")
  end

  def test_initialize
    assert_instance_of SocialCurrent::TwitterService, @twitter
    assert_respond_to @twitter, :raw_stream
  end

  def test_raw_user
    assert_equal "Tristan O'Neil", @twitter.raw_user["name"]
  end

  def test_raw_stream
    assert_equal @twitter.raw_stream[0]["text"], "Was thinking @gristmilled should put on a \"How to write a Ruby Gem\" course. It may just directly benefit me. Any interest in #btv?"
  end

  def test_stream
    assert_equal "Tristan O'Neil said \"Was thinking @<a class=\"tweet-url username\" href=\"https://twitter.com/gristmilled\" rel=\"nofollow\">gristmilled</a> should put on a \"How to write a Ruby Gem\" course. It may just directly benefit me. Any interest in <a href=\"https://twitter.com/#!/search?q=%23btv\" title=\"#btv\" class=\"tweet-url hashtag\" rel=\"nofollow\">#btv</a>?\"",  @twitter.stream[0][:message]
    assert_equal "2012-05-16 13:59:57 UTC", @twitter.stream[0][:created_at].to_s
    assert_equal 13, @twitter.stream.size
  end
end
