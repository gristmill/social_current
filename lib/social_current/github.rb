module SocialCurrent
  class Github < Service
    include HTTParty
    base_uri "https://api.github.com"

    # Returns more useful information about the user as a JSON object.
    def raw_user
      @raw_user ||= fetch("/users/#{@user}", "#{@user}_github_raw_user.json")
    end

    # Returns all events as a JSON Response.
    def raw_stream
      @raw_stream ||= fetch("/users/#{@user}/events", "#{@user}_github_raw_stream.json")
    end

    def stream
      @stream ||= raw_stream.collect do |s|
        { :message => format_message(s), :created_at => Time.parse(s["created_at"]).utc }
      end
    end

    private

    def format_message(event)
      case event["type"]
      when "PushEvent"
        return "#{self.raw_user["name"]} pushed to <a href='http://github.com/#{event["repo"]["name"]}'>#{event["repo"]["name"]}</a>."
      when "FollowEvent"
        return "#{self.raw_user["name"]} followed <a href='#{event["payload"]["target"]["html_url"]}'>#{event["payload"]["target"]["name"]}</a>."
      when "CreateEvent"
        return "#{self.raw_user["name"]} created <a href='http://github.com/#{event["repo"]["name"]}'>#{event["repo"]["name"]}</a>."
      when "WatchEvent"
        return "#{self.raw_user["name"]} started watching <a href='http://github.com/#{event["repo"]["name"]}'>#{event["repo"]["name"]}</a>."
      end
    end
  end
end
