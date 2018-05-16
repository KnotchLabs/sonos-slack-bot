module SonosSlackBot::Actors
  class Slack
    include Celluloid
    include Celluloid::Internals::Logger

    finalizer :disconnect

    def initialize
      @rt_client = ::Slack::RealTime::Client.new
      @web_client = ::Slack::Web::Client.new

      setup_callbacks
      start_client
    end

    def disconnect
      @rt_client.stop! if @rt_client.started?
    end

    def set_topic(topic)
      @web_client.channels_setTopic(
        channel: SonosSlackBot.config.slack.channel_name, topic: topic.to_s
      )
    end

    def send_message(text, as_user: true)
      @web_client.chat_postMessage(
        channel: SonosSlackBot.config.slack.channel_name, text: text, as_user: as_user
      )
    end

    # TODO cache the users_info results
    def get_user_info(user_id)
      @web_client.users_info(user: user_id)
    end

    private

    def client_id_prefix
      @client_id_prefix ||= "<@#{@rt_client.self.id}> ".freeze
    end

    def client_id
      @rt_client.self.id
    end

    def start_client
      @rt_client.start_async
    end

    def setup_callbacks
      @rt_client.on :message do |event|
        user_id = event.user

        next if event.hidden
        next if user_id == client_id

        message = { at: false, im: false, user_id: user_id, text: event.text }

        # TODO figure out how to detect an IM
        if message[:text].start_with? client_id_prefix
          message[:at] = true
          message[:text].slice! 0..(client_id_prefix.size - 1)
        end

        Actor[:slack_message_pool].async.process message
      end

      @rt_client.on(:closed) do
        Celluloid.logger.info 'Disconnected real-time slack client'

        start_client
      end

      @rt_client.on(:hello) { Celluloid.logger.info "Connected real-time slack client; client_id=#{client_id}" }
      @rt_client.on(:close) { Celluloid.logger.info 'Disconnecting real-time slack client' }
    end
  end
end
