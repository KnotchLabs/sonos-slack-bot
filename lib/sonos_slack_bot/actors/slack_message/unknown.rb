module SonosSlackBot::Actors
  class SlackMessage
    class Unknown < Base
      def process
        <<-MSG
Unknown command: #{message_text.inspect}\n
#{user_info.profile.display_name} the available commands are:
- history
- stats
- sonos [play|pause|stop]
        MSG
      end
    end
  end
end
