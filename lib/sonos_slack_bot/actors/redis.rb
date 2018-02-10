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
      @connection = ::Redis.new(driver: :celluloid)
    end

    def speaker_state=(speaker)
      @connection.set speaker_redis_key, speaker.to_json
    end

    def speaker_state
      Speaker.parse @connection.get(speaker_redis_key)
    end

    def add_track(track)
      @connection.set track_redis_key(track), track.to_json
      @connection.lpush tracks_redis_key, track.id
      @connection.lpush history_redis_key(track), Time.now.to_i
    end

    def last_track
      Track.parse @connection.lindex(tracks_redis_key, 0)
    end

    def track_history(track)
      @connection.lrange history_redis_key(track), 0, -1
    end

    def track_play_count(track)
      @connection.llen history_redis_key(track)
    end
  end
end
