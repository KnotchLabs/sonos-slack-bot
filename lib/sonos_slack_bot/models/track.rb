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
  end
end
