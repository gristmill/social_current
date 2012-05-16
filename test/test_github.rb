require "test_helper"

class TestGithub < Test::Unit::TestCase
  def setup
    @github = SocialCurrent::Github.new("tristanoneil")
  end

  def test_initialize
    assert_instance_of SocialCurrent::Github, @github
    assert_respond_to @github, :raw_stream
  end

  def test_raw_user
    assert_equal "Tristan O'Neil", @github.raw_user["name"]
  end

  def test_raw_stream
    assert_equal @github.raw_stream[0]["type"], "PushEvent"
  end

  def test_stream
    assert_equal "Tristan O'Neil pushed to <a href='http://github.com/tristanoneil/tristanoneil.github.com'>tristanoneil/tristanoneil.github.com</a>.", @github.stream[0][:message]
    assert_equal "2012-05-11 20:17:30 UTC", @github.stream[0][:created_at].to_s
    assert_equal 30, @github.stream.size
  end

  def test_format_message
    assert_equal "Tristan O'Neil pushed to <a href='http://github.com/tristanoneil/tristanoneil.github.com'>tristanoneil/tristanoneil.github.com</a>.", @github.format_message(@github.raw_stream[0])
    assert_equal "Tristan O'Neil followed <a href='https://github.com/mikefowler'>Mike Fowler</a>.", @github.format_message(@github.raw_stream[1])
    assert_equal "Tristan O'Neil created <a href='http://github.com/tristanoneil/strike-water'>tristanoneil/strike-water</a>.", @github.format_message(@github.raw_stream[3])
    assert_equal "Tristan O'Neil started watching <a href='http://github.com/gristmill/gauge'>gristmill/gauge</a>.", @github.format_message(@github.raw_stream[9])
  end
end
