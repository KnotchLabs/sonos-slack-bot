module SonosSlackBot::Actors
  class SlackMessage
    include Celluloid

    def initialize
      @message_classes = (Base.subclasses - [Unknown]).freeze
    end

    def process(text:, user_id:, at: false, im: false)
      Celluloid.logger.info "[SlackMessage] at=#{at} im=#{im} text=#{text.inspect}"

      return unless at || im

      user_info = Actor[:slack].future.get_user_info(user_id).value

      if user_info.ok
        send_response message_klass(text).new(text, user_info.user).process
      else
        Celluloid.logger.fatal "[SlackMessage] Failed to load users_info; msg=#{users_info.inspect}"
      end
    end

    private

    attr_reader :message_classes

    def message_klass(text)
      message_classes.find { |klass| klass::TEXT_PATTERN =~ text } || Unknown
    end

    def send_response(reply_text)
      Actor[:slack].async.send_message reply_text
    end
  end
end
