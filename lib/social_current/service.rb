module SocialCurrent
  class Service
    def initialize(user)
      @user = user
    end

    def fetch(remote, local)
      @contents = if cache_valid?(local)
        JSON.parse(Tempfile.read(local))
      else
        write_cache(local, JSON.parse(self.class.get(remote).body))
      end
    end

    private

    def write_cache(local, contents)
      Tempfile.new(local) do |f|
        f.write(contents.to_json)
      end
      contents
    end

    def cache_valid?(cache)
      Tempfile.open(cache) && Tempfile.open(cache).mtime > Time.now - 3000
    end
  end
end
