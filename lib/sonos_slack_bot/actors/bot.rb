module SonosSlackBot::Actors
  class Bot < Celluloid::Supervision::Container
    def initialize(*args)
      super(*args) do |actor|
        Actor[:bot] = actor

        pool Redis, as: :redis_pool, size: 4
        pool SlackMessage, as: :slack_message_pool, size: 4

        supervise type: Slack, as: :slack
        supervise type: Player, as: :player
      end

      setup_signal_handling
    end

    def process_signal(signal)
      case signal
      when :INT, :TERM
        Celluloid.logger.info "Signal #{signal} received; shutting down"

        SonosSlackBot.stop!
      end
    end

    # def restart_actor(actor, reason)
    # # TODO notify admin on slack ??
    # super
    # end

    private

    def setup_signal_handling
      @signals = []

      %i[INT TERM].each do |signal|
        trap(signal) { @signals << signal }
      end

      every 2 do
        while signal = @signals.shift
          async.process_signal signal
        end
      end
    end
  end
end
