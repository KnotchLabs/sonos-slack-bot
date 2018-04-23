module SonosSlackBot::Actors
  class Player::Sonos
    include Celluloid
    include SonosSlackBot::Models

    def now_playing
      speaker = self.class.request_speaker

      return Speaker.new connected: false unless speaker
      return Speaker.new connected: true unless speaker.is_playing?

      details = Track.parse_details(speaker.now_playing)

      if details then Speaker.new track: Track.new(details)
      else Speaker.new connected: true
      end
    end

    private

    # This is some really hacky stuff
    def self.request_speaker
      ip = SonosSlackBot.config.sonos.address

      Sonos::Device::Speaker.new(ip).tap do |speaker|
        speaker.define_singleton_method(:group_master) { OpenStruct.new(ip: ip) }
      end

    rescue Errno::ECONNREFUSED, Errno::EHOSTUNREACH, Net::OpenTimeout
      nil
    end
  end
end
