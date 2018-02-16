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
        channel: SonosSlackBot.config.channel, topic: topic.to_s
      )
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
      %i[hello message].each do |event|
        @rt_client.on(event) do |event|
          Actor[:message_pool].async.process event
        end
      end

      @rt_client.on(:close) { Celluloid.logger.info 'Disconnecting real-time slack client' }
      @rt_client.on(:closed) { Celluloid.logger.info 'Disconnected real-time slack client' }
    end
  end
end
