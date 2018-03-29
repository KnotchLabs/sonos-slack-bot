module SonosSlackBot::Actors
  class SlackMessage
    class Greeting < Base
      TEXT_PATTERN = %r[\Ahi|\Ahey|\Ahello].freeze

      def process
        "Hello #{user_info.profile.display_name} :wave:"
      end
    end
  end
end
