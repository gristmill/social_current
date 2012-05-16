module SocialCurrent
  class Twitter
    include HTTParty
    base_uri "https://api.twitter.com/1"

    def initialize(user)
      @user = user
    end

    # Returns more user information as a HTTParty Response.
    def raw_user
      @raw_user ||= self.class.get("/users/show.json?screen_name=#{@user}")
    end

    # Returns all events as a HTTParty Response.
    def raw_stream
      @raw_stream ||= self.class.get("/statuses/user_timeline.json?&screen_name=#{@user}")
    end

    def stream
      @stream ||= raw_stream.collect do |s|
        { :message => format_message(s), :created_at => Time.parse(s["created_at"]).utc }
      end
    end

    def format_message(status)
      "#{raw_user["name"]} said \"#{status["text"]}\""
    end
  end
end
