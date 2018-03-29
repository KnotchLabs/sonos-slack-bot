module SonosSlackBot::Actors
  class SlackMessage
    class Stats < Base
      TEXT_PATTERN = %r[stats].freeze

      def process
        tracks = redis_pool_actor.future.tracks_by_count.value
        return empty_history_message unless tracks.size > 0

        top_5 = tracks.first(5).map do |track_id, count|
          [redis_pool_actor.future.get_track(track_id).value, count]
        end

        StatsFormatter.new(tracks.size, top_5)
      end
    end
  end
end
