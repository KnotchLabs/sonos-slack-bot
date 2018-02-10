module SonosSlackBot::Actors
  class Message
    include Celluloid

    def initialize
      #@web_client = Slack::Web::Client.new
    end

    def process(message)
      p 'message pool'
      p message
    end
  end
end
