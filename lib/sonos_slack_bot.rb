require 'digest'

require 'active_support'
require 'active_support/core_ext'
require 'celluloid/current'
require 'celluloid/pool'
require 'celluloid/supervision'
require 'celluloid/io'
require 'celluloid/redis'
require 'slack-ruby-client'
require 'sonos'

require 'sonos_slack_bot/version'
require 'sonos_slack_bot/configuration'
require 'sonos_slack_bot/redis_keys'
require 'sonos_slack_bot/actor_helpers'

require 'sonos_slack_bot/formatters'
require 'sonos_slack_bot/formatters/empty_history_formatter'
require 'sonos_slack_bot/formatters/topic_formatter'
require 'sonos_slack_bot/formatters/track_formatter'
require 'sonos_slack_bot/formatters/track_stats_formatter'
require 'sonos_slack_bot/formatters/stats_formatter'

require 'sonos_slack_bot/models'
require 'sonos_slack_bot/models/track'
require 'sonos_slack_bot/models/speaker'

require 'sonos_slack_bot/actors/bot'
require 'sonos_slack_bot/actors/player'
require 'sonos_slack_bot/actors/player/sonos'
require 'sonos_slack_bot/actors/player/speaker_event'
require 'sonos_slack_bot/actors/redis'
require 'sonos_slack_bot/actors/slack'
require 'sonos_slack_bot/actors/slack_message'
require 'sonos_slack_bot/actors/slack_message/base'
require 'sonos_slack_bot/actors/slack_message/greeting'
require 'sonos_slack_bot/actors/slack_message/history'
require 'sonos_slack_bot/actors/slack_message/stats'
require 'sonos_slack_bot/actors/slack_message/sonos'
require 'sonos_slack_bot/actors/slack_message/unknown'

#$CELLULOID_DEBUG = true

module SonosSlackBot
  Lock = Mutex.new

  def self.start!
    Lock.synchronize do
      @running = true

      Slack.configure do |slack_conf|
        slack_conf.token = config[:slack][:token]
      end

      Slack::RealTime.configure do |config|
        config.concurrency = Slack::RealTime::Concurrency::Celluloid
      end

      Celluloid.logger.level = 0
      Celluloid.boot
    end

    while @running
      supervisor = SonosSlackBot::Actors::Bot.run!

      sleep 2 while supervisor.alive?
    end
  end

  def self.stop!
    Lock.synchronize do
      @running = false

      Celluloid::Actor[:bot].shutdown
      Celluloid::Actor[:bot].terminate!
    end
  end

  def self.config
    @config ||= Configuration.load(File.join(Dir.pwd, 'config.yml'))
  end
end
