module SonosSlackBot
  module RedisKeys
    REDIS_BASE_KEY = "sonos_slack_bot:#{ENV['BOT_ENV']}".freeze

    %w[speaker tracks user_favs].each do |name|
      class_eval <<-RUBY_EVAL
        def #{name}_redis_key
          "#{REDIS_BASE_KEY}:#{name}"
        end
      RUBY_EVAL

      def track_redis_key(track)
        "#{REDIS_BASE_KEY}:track:#{track.id}"
      end

      def history_redis_key(track)
        "#{REDIS_BASE_KEY}:track_history:#{track.id}"
      end
    end
  end
end
