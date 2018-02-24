module SonosSlackBot
  module ActorHelpers
    def slack_actor
      Celluloid::Actor[:slack]
    end

    def redis_pool_actor
      Celluloid::Actor[:redis_pool]
    end

    def sonos_actor
      Celluloid::Actor[:sonos]
    end
  end
end
