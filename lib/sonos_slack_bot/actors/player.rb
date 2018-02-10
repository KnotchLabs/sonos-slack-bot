module SonosSlackBot::Actors
  class Player
    include Celluloid

    include SonosSlackBot::Models
    include SonosSlackBot::Formatters

    attr_reader :speaker, :track

    def initialize
      Actor[:sonos] = Sonos.new

      @speaker = Actor[:redis_pool].future.speaker_state.value

      setup_poll_sonos!
    end

    private

    def speaker=(speaker)
      Actor[:redis_pool].async.speaker_state = speaker

      @speaker = speaker
    end

    def setup_poll_sonos!
      every 4 do
        speaker_result = Actor[:sonos].future.now_playing.value

        p speaker_result
        p @speaker
        p speaker_result == @speaker

        # Do we have a new speaker state?
        unless speaker_result == @speaker
          self.speaker = speaker_result

          Actor[:slack].async.set_topic TopicFormatter.new(speaker)
          Actor[:redis_pool].async.add_track(speaker.track) if speaker.playing?
        end
      end
    end
  end
end
