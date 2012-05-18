module SocialCurrent
  class Twitter < Service
    include HTTParty
    base_uri "https://api.twitter.com/1"

    def raw_user
      @raw_user ||= fetch("/users/show.json?screen_name=#{@user}", "#{@user}_twitter_raw_user.json")
    end

    def raw_stream
      @raw_stream ||= fetch("/statuses/user_timeline.json?&screen_name=#{@user}", "#{@user}_twitter_raw_stream.json")
    end

    def stream
      @stream ||= raw_stream.collect do |s|
        { :message => format_message(s), :created_at => Time.parse(s["created_at"]).utc, :service => "twitter" }
      end
    end

    private

    def format_message(status)
      "#{raw_user["name"]} said \"#{status["text"]}\""
    end
  end
end
