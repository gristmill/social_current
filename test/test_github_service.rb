require "test_helper"

class TestGithub < Test::Unit::TestCase
  def setup
    @github = SocialCurrent::GithubService.new("tristanoneil")
  end

  def test_initialize
    assert_instance_of SocialCurrent::GithubService, @github
    assert_respond_to @github, :raw_stream
  end

  def test_raw_user
    assert_equal "Tristan O'Neil", @github.raw_user["name"]
  end

  def test_raw_stream
    assert_equal @github.raw_stream[0]["type"], "PushEvent"
  end

  def test_stream
    assert_equal "Tristan O'Neil pushed <a href='http://github.com/tristanoneil/tristanoneil.github.com/commit/c1e38d24268245b9336e2734e6864c7266c79284'>c1e38d24268245b9336e2734e6864c7266c79284</a> to <a href='http://github.com/tristanoneil/tristanoneil.github.com'>tristanoneil/tristanoneil.github.com</a>.", @github.stream[0][:message]
    assert_equal "2012-05-11 20:17:30 UTC", @github.stream[0][:created_at].to_s
    assert_equal 30, @github.stream.size
  end
end
