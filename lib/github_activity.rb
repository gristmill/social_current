require "github_activity/version"
require "httparty"

module GithubActivity
  class Stream
    include HTTParty
    base_uri "https://api.github.com"

    def initialize(user)
      @user = user
    end

    # Returns more useful information about the user as a JSON object.
    def user_info
      @user_info ||= self.class.get("/users/#{@user}")
    end

    # Returns all stream events as a HTTParty Response.
    def fetch
      @fetch ||= self.class.get("/users/#{@user}/events")
    end

    # Returns all stream events as a JSON object.
    def as_json
      self.fetch.body
    end

    # Returns all stream events as an HTML unordered list.
    def as_html
      events = ["<ul>"]
      events << self.fetch.collect do |event|
        self.format(event)
      end
      events << "</ul>"
      events.join
    end

    def format(event)
      case event["type"]
      when "PushEvent"
        return "<li>#{self.user_info["name"]} pushed to <a href='http://github.com/#{event["repo"]["name"]}'>#{event["repo"]["name"]}</a>.</li>"
      when "FollowEvent"
        return "<li>#{self.user_info["name"]} followed <a href='#{event["payload"]["target"]["html_url"]}'>#{event["payload"]["target"]["name"]}</a>.</li>"
      when "CreateEvent"
        return "<li>#{self.user_info["name"]} created <a href='http://github.com/#{event["repo"]["name"]}'>#{event["repo"]["name"]}</a>.</li>"
      when "WatchEvent"
        return "<li>#{self.user_info["name"]} started watching <a href='http://github.com/#{event["repo"]["name"]}'>#{event["repo"]["name"]}</a>.</li>"
      end
    end
  end
end
