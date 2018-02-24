module SonosSlackBot::Actors
  class Player
    include Celluloid

    include SonosSlackBot::ActorHelpers

    attr_reader :speaker, :track

    def initialize
      Actor[:sonos] = Sonos.new

      @speaker = redis_pool_actor.future.speaker_state.value

      setup_poll_sonos!
    end

    private

    def speaker=(speaker)
      # Set object state
      @speaker = speaker

      # Process the speaker event and update Slack
      SpeakerEvent.new(speaker).process

      # Persist state to redis
      redis_pool_actor.async.speaker_state = speaker
    end

    def setup_poll_sonos!
      every 4 do
        #speaker_result = sonos_actor.future.now_playing.value
        speaker_result = SonosSlackBot::Models::Speaker.new(
          #track: SonosSlackBot::Models::Track
          connected: true
        )

        # Do we have a new speaker state?
        unless speaker_result == @speaker
          self.speaker = speaker_result
        end
      end
    end
  end
end
