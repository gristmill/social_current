require "test_helper"

class TestStream < Test::Unit::TestCase
  def setup
    @stream = SocialCurrent::Stream.new({ :twitter => "tristanoneil", :github => "tristanoneil" })
  end

  def test_initialize
    assert_instance_of SocialCurrent::Stream, @stream
    assert_equal 2, SocialCurrent::Stream.new({ :twitter => "tristanoneil", :github => "tristanoneil", :instagram =>  "tristanoneil"}).instance_variable_get("@options").size
  end

  def test_build
    assert_equal "Tristan O'Neil said \"Was thinking @gristmilled should put on a \"How to write a Ruby Gem\" course. It may just directly benefit me. Any interest in #btv?\"", @stream.build[0][:message]
    assert_equal 43, @stream.build.size
  end
end
