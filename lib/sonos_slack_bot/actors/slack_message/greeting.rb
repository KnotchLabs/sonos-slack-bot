module SonosSlackBot::Actors
  class SlackMessage
    class Greeting < Base
      def process
        "Hello #{user_info.profile.display_name} :wave:"
      end
    end
  end
end
