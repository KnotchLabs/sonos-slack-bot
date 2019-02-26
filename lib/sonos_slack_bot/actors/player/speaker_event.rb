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
        history = redis_pool_actor.future.track_history(speaker.track).value

        return if history.empty?
        return unless history.size == 5 || (history.size % 10).zero?

        slack_actor.async.send_message TrackStatsFormatter.new(speaker.track, history, as_event: true)
      end
    end
  end
end
