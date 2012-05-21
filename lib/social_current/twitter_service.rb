module SocialCurrent
  class TwitterService < Service
    include HTTParty
    include Twitter::Autolink

    base_uri "https://api.twitter.com/1"

    def raw_user
      fetch("/users/show.json?screen_name=#{@user}", "#{@user}_twitter_raw_user.json")
    end

    def raw_stream
      fetch("/statuses/user_timeline.json?&screen_name=#{@user}", "#{@user}_twitter_raw_stream.json")
    end

    def stream
      raw_stream.collect do |s|
        { :message => format_message(s), :created_at => Time.parse(s["created_at"]).utc, :service => "twitter" }
      end
    end

    private

    def format_message(status)
      auto_link("#{raw_user["name"]} said \"#{status["text"]}\"")
    end
  end
end
