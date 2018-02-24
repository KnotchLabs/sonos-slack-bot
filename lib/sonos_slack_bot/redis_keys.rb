module SonosSlackBot
  module RedisKeys
    def self.base_key
      @base_key ||= "sonos_slack_bot:#{SonosSlackBot.config.env}".freeze
    end

    %w[speaker tracks user_favs].each do |name|
      class_eval <<-RUBY_EVAL
        def self.#{name}_redis_key
          @#{name}_key = "\#{base_key}:#{name}".freeze
        end

        def #{name}_redis_key
          RedisKeys.#{name}_redis_key
        end
      RUBY_EVAL

      def track_redis_key(track)
        "#{RedisKeys.base_key}:track:#{determine_track_id track}"
      end

      def history_redis_key(track)
        "#{RedisKeys.base_key}:track_history:#{determine_track_id track}"
      end

      private

      def determine_track_id(track)
        case track
        when String, Symbol then track
        when Models::Track then track.id
        else raise ArgumentError.new "Cannot determine track id from #{track.inspect}"
        end
      end
    end
  end
end
