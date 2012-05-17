module SocialCurrent
  class Service
    def initialize(user)
      @user = user
    end

    def fetch(remote, local)
      @contents = if cache_valid?("#{Dir.tmpdir}/#{local}")
        JSON.parse(File.read("#{Dir.tmpdir}/#{local}"))
      else
        write_cache(local, JSON.parse(self.class.get(remote).body))
      end
    end

    private

    def write_cache(local, contents)
      File.open("#{Dir.tmpdir}/#{local}", "w") do |f|
        f.write(contents.to_json)
      end
      contents
    end

    def cache_valid?(cache)
      File.exists?(cache) && File.new(cache).mtime > Time.now - 3000
    end
  end
end
