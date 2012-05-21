module SocialCurrent
  class Github < Service
    include HTTParty
    base_uri "https://api.github.com"

    def raw_user
      fetch("/users/#{@user}", "#{@user}_github_raw_user.json")
    end

    def raw_stream
      fetch("/users/#{@user}/events", "#{@user}_github_raw_stream.json")
    end

    def stream
      raw_stream.collect do |s|
        { :message => format_message(s), :created_at => Time.parse(s["created_at"]).utc, :service => "github" }
      end
    end

    private

    def format_message(event)
      case event["type"]
      when "PushEvent"
        "#{self.raw_user["name"]} pushed #{event["payload"]["commits"].collect { |c| "<a href='http://github.com/#{event["repo"]["name"]}/commit/#{c["sha"]}'>" + c["sha"] + "</a>" }.join(", ")} to <a href='http://github.com/#{event["repo"]["name"]}'>#{event["repo"]["name"]}</a>."
      when "FollowEvent"
        "#{self.raw_user["name"]} followed <a href='#{event["payload"]["target"]["html_url"]}'>#{event["payload"]["target"]["name"]}</a>."
      when "CreateEvent"
        "#{self.raw_user["name"]} created a new #{event["payload"]["ref_type"]}, #{event["payload"]["ref"]} for <a href='http://github.com/#{event["repo"]["name"]}'>#{event["repo"]["name"]}</a>."
      when "WatchEvent"
        "#{self.raw_user["name"]} started watching <a href='http://github.com/#{event["repo"]["name"]}'>#{event["repo"]["name"]}</a>."
      end
    end
  end
end
