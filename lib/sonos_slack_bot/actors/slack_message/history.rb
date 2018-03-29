module SonosSlackBot::Actors
  class SlackMessage
    class History < Base
    TEXT_PATTERN = %r[\Ahistory\z].freeze

      def process
        track = redis_pool_actor.future.last_track.value
        return empty_history_message unless track

        history = redis_pool_actor.future.track_history(track).value
        return empty_history_message unless history && !history.empty?

        TrackStatsFormatter.new track, history, as_event: false
      end
    end
  end
end
