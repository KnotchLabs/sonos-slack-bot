%w[BOT_ENV SLACK_API_TOKEN SONOS_ADDR REDIS_URL].each do |key|
  abort "#{key} environment variable must be defined" unless ENV.key? key
end

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
require 'sonos_slack_bot/redis_keys'

require 'sonos_slack_bot/formatters/topic'
require 'sonos_slack_bot/formatters/track'

require 'sonos_slack_bot/models'
require 'sonos_slack_bot/models/track'
require 'sonos_slack_bot/models/speaker'

require 'sonos_slack_bot/actors/bot'
require 'sonos_slack_bot/actors/message'
require 'sonos_slack_bot/actors/player'
require 'sonos_slack_bot/actors/player/sonos'
require 'sonos_slack_bot/actors/redis'
require 'sonos_slack_bot/actors/slack'

#$CELLULOID_DEBUG = true

Slack.configure do |config|
  config.token = ENV.fetch('SLACK_API_TOKEN')
end

Slack::RealTime.configure do |config|
  config.concurrency = Slack::RealTime::Concurrency::Celluloid
end

module SonosSlackBot
  Lock = Mutex.new

  def self.start!
    Lock.synchronize do
      @running = true

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
    @config ||= OpenStruct.new({
      admins: %w[U85DPN02D],
      channel: '#sonos',
      sonos_addr: ENV['SONOS_ADDR']
    })
  end
end
