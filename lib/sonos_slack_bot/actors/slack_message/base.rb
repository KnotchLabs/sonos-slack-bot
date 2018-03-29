module SonosSlackBot::Actors
  class SlackMessage
    class Base
      attr_reader :message_text, :user_info

      include SonosSlackBot::ActorHelpers
      include SonosSlackBot::Formatters

      def initialize(message_text, user_info)
        @message_text = message_text
        @user_info = user_info
      end

      def process
        raise NotImplementedError
      end

      private

      def empty_history_message
        EmptyHistory.new(user_info)
      end
    end
  end
end
