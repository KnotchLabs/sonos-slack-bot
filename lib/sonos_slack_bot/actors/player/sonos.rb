module SonosSlackBot::Actors
  class Player::Sonos
    include Celluloid
    include SonosSlackBot::Models

    def now_playing
      speaker = self.class.request_speaker

      return Speaker.new connected: false unless speaker
      return Speaker.new connected: true unless speaker.is_playing?

      # TODO ensure speaker.now_playing returns a hash with expected keys

      details = self.class.parse_track(speaker.now_playing)

      if details then Speaker.new track: Track.new(details)
      else Speaker.new connected: true
      end
    end

    private

    def self.parse_track(now_playing)
      details = now_playing

      if now_playing[:title].starts_with? 'x-sonosapi'
        details = now_playing[:info].split('|').each.with_object({}) do |part, memo|
          key, value = part.split(/\s+/, 2)

          memo[key.downcase.to_sym] = value
        end
      end

      details.slice(:title, :artist, :album) if details[:title].present? && details[:artist].present?
    end

    # This is some really hacky stuff
    def self.request_speaker
      return if SonosSlackBot.config.sonos.mock

      ip = SonosSlackBot.config.sonos.address

      Sonos::Device::Speaker.new(ip).tap do |speaker|
        speaker.define_singleton_method(:group_master) { OpenStruct.new(ip: ip) }
      end

    rescue Errno::ECONNREFUSED, Net::OpenTimeout
      nil
    end
  end
end
