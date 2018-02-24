module SonosSlackBot::Actors
  class Player
    class SpeakerEvent
      include Celluloid

      include SonosSlackBot::Formatters
      include SonosSlackBot::ActorHelpers

      attr_reader :speaker

      def initialize(speaker)
        @speaker = speaker
      end

      def process
        update_channel_topic
        send_channel_track_stats if speaker.playing?
      end

      private

      def update_channel_topic
        slack_actor.async.set_topic TopicFormatter.new(speaker)
      end

      def send_channel_track_stats
        track_play_count = redis_pool_actor.track_play_count(track)

        if track_play_count % 25 #% 1
          #slack_actor.async.send_message
        end
      end
    end
  end
end
