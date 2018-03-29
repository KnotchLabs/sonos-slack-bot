module SonosSlackBot::Models
  class Track
    include Comparable
    include Jsonable

    model_attr :title, :artist, :album

    def initialize(title:, artist:, album:)
      @title = title
      @artist = artist
      @album = album
    end

    def id
      @id ||= Digest::MD5.hexdigest(to_json)
    end

    def <=>(other)
      id <=> other.id
    end

    def self.parse_details(now_playing)
      details = now_playing

      if now_playing[:title].starts_with? 'x-sonosapi'
        details = now_playing[:info].split('|').each.with_object({}) do |part, memo|
          key, value = part.split(/\s+/, 2)

          memo[key.downcase.to_sym] = value
        end
      end

      details.slice(:title, :artist, :album) if details[:title].present? && details[:artist].present?
    end
  end
end
