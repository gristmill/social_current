require "test_helper"

class TestStream < Test::Unit::TestCase
  def setup
    @stream = GithubActivity::Stream.new("tristanoneil")
  end

  def test_initialize
    assert_instance_of GithubActivity::Stream, @stream
    assert_respond_to @stream, :fetch
  end

  def test_user_info
    assert_equal "Tristan O'Neil", @stream.user_info["name"]
  end

  def test_fetch
    assert_respond_to @stream.fetch, :body
    assert_equal @stream.fetch[0]["type"], "PushEvent"
  end

  def test_as_json
    assert_match /tristanoneil@gmail.com/, @stream.as_json
  end

  def test_as_html
    assert_match /<ul>.*<\/ul>/, @stream.as_html
    assert_match /Tristan O'Neil pushed to/, @stream.as_html
  end

  def test_format
    assert_equal "<li>Tristan O'Neil pushed to <a href='http://github.com/tristanoneil/tristanoneil.github.com'>tristanoneil/tristanoneil.github.com</a>.</li>", @stream.format(@stream.fetch[0])
    assert_equal "<li>Tristan O'Neil followed <a href='https://github.com/mikefowler'>Mike Fowler</a>.</li>", @stream.format(@stream.fetch[1])
    assert_equal "<li>Tristan O'Neil created <a href='http://github.com/tristanoneil/strike-water'>tristanoneil/strike-water</a>.</li>", @stream.format(@stream.fetch[3])
    assert_equal "<li>Tristan O'Neil started watching <a href='http://github.com/gristmill/gauge'>gristmill/gauge</a>.</li>", @stream.format(@stream.fetch[9])
  end
end
