require "test_helper"

class TestGitHub < Test::Unit::TestCase
  def setup
    @stream = SocialCurrent::GitHub.new("tristanoneil")
  end

  def test_initialize
    assert_instance_of SocialCurrent::GitHub, @stream
    assert_respond_to @stream, :raw_stream
  end

  def test_raw_user
    assert_equal "Tristan O'Neil", @stream.raw_user["name"]
  end

  def test_raw_stream
    assert_respond_to @stream.raw_stream, :body
    assert_equal @stream.raw_stream[0]["type"], "PushEvent"
  end

  def test_messages
    assert_equal "Tristan O'Neil pushed to <a href='http://github.com/tristanoneil/tristanoneil.github.com'>tristanoneil/tristanoneil.github.com</a>.", @stream.messages[0][:message]
    assert_equal "2012-05-11T20:17:30Z", @stream.messages[0][:created_at]
    assert_equal 30, @stream.messages.size
  end

  def test_format
    assert_equal "Tristan O'Neil pushed to <a href='http://github.com/tristanoneil/tristanoneil.github.com'>tristanoneil/tristanoneil.github.com</a>.", @stream.format_message(@stream.raw_stream[0])
    assert_equal "Tristan O'Neil followed <a href='https://github.com/mikefowler'>Mike Fowler</a>.", @stream.format_message(@stream.raw_stream[1])
    assert_equal "Tristan O'Neil created <a href='http://github.com/tristanoneil/strike-water'>tristanoneil/strike-water</a>.", @stream.format_message(@stream.raw_stream[3])
    assert_equal "Tristan O'Neil started watching <a href='http://github.com/gristmill/gauge'>gristmill/gauge</a>.", @stream.format_message(@stream.raw_stream[9])
  end
end
