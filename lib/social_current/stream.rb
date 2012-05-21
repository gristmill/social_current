module SocialCurrent
  class Stream
    def initialize(options)
      @options = options.reject { |k, v| !SUPPORTED_INTEGRATIONS.include?(k) }
    end

    def build
      @stream ||= @options.collect do |k, v|
        eval("SocialCurrent::" + k.to_s.capitalize + "Service").new(v).stream
      end.flatten.sort_by { |k, v| k[:created_at] }.reject { |k, v| k[:message].nil? }.reverse
    end
  end
end
