module SonosSlackBot::Actors
  class SlackMessage
    class Stats < Base
      TEXT_PATTERN = %r[stats].freeze

      def process
        total_count = redis_pool_actor.future.tracks_count.value
        return empty_history_message unless total_count && total_count > 0

        tracks = redis_pool_actor.future.tracks_by_count.value
        tracks_top_5 = tracks.first(5).map do |track_id, count|
          [redis_pool_actor.future.get_track(track_id).value, count]
        end

        StatsFormatter.new(total_count, tracks.size, tracks_top_5)
      end
    end
  end
end
