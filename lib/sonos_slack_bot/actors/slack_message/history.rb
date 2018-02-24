module SonosSlackBot::Actors
  class SlackMessage
    class History < Base
      def process
        track = redis_pool_actor.future.last_track.value
        return no_track_history_message unless track

        history = redis_pool_actor.future.track_history(track).value
        return no_track_history_message unless history && !history.empty?

        TrackStatsFormatter.new track, history, as_event: false
      end

      private

      def no_track_history_message
        "Sorry #{user_info.profile.display_name}, no tracks have been played yet."
      end
    end
  end
end
