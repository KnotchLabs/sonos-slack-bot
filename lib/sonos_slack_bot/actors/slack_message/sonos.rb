module SonosSlackBot::Actors
  class SlackMessage
    class Sonos < Base
      TEXT_PATTERN = %r[\Asonos \w+].freeze

      def process
        case message_text
        when /\Asonos pause/, /\Asonos play/
          sonos_actor.future.toggle_play
        when /\Asonos stop/
          sonos_actor.future.stop_play
        end

        "You got it #{user_info.profile.display_name}! :thumbsup:"
      end
    end
  end
end
