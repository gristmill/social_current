module SocialCurrent
  class Service
    def initialize(user)
      @user = user
    end

    def fetch(remote, local)
      @contents = if File.exists?(local)
        JSON.parse(File.read(local))
      else
        write_cache(local, JSON.parse(self.class.get(remote).body))
      end
    end

    private

    def write_cache(local, contents)
      File.open("/tmp/#{local}", "w") do |f|
        f.write(contents.to_json)
      end
      contents
    end
  end
end
