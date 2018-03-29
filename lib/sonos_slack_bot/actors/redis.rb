module SonosSlackBot::Actors
  class Redis
    include Celluloid

    include SonosSlackBot::Models
    include SonosSlackBot::RedisKeys

    # redis structures used
    # - set/get for speaker_redis_key
    # - list for tracks_redis_key (track ids in order played)
    # - list with dynamic history key for date times played

    def initialize
      @connection = ::Redis.new(url: SonosSlackBot.config.redis.url, driver: :celluloid)
    end

    def speaker_state=(speaker)
      @connection.set speaker_redis_key, speaker.to_json
    end

    def speaker_state
      Speaker.parse @connection.get(speaker_redis_key)
    end

    def add_track(track)
      @connection.set track_redis_key(track), track.to_json
      @connection.lpush history_redis_key(track), Time.now.utc.to_i
      @connection.lpush tracks_redis_key, track.id
    end

    def tracks_count
      @connection.llen tracks_redis_key
    end

    def tracks_by_count
      tracks = @connection.lrange(tracks_redis_key, 0, -1)
      tracks.each_with_object(Hash.new(0)) { |id, counts| counts[id] += 1 }.to_a.tap do |counts|
        counts.sort_by!(&:last)
        counts.reverse!
      end
    end

    def get_track(track_id)
      track_data = @connection.get(track_redis_key(track_id))
      Track.parse track_data if track_data
    end

    def last_track
      track_id = @connection.lindex(tracks_redis_key, 0)
      return unless track_id

      get_track(track_id)
    end

    def track_history(track)
      @connection.lrange history_redis_key(track), 0, -1
    end

    def track_play_count(track)
      @connection.llen history_redis_key(track)
    end
  end
end
