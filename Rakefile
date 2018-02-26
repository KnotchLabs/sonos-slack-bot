require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

task :deploy, [:host, :user] do |_, args|
  require 'net/ssh'

  def log(msg)
    print "#{msg}..."
    yield
    print " done.\n"
  end

  abort 'Host argument is required' unless args[:host]

  host = args[:host]
  user = args[:user] || 'sonos-bot'

  Net::SSH.start host, user do |ssh|
    log 'Setting up project' do
      ssh.exec! '[ -d sonos-slack-bot ] git clone git@github.com:KnotchLabs/sonos-slack-bot.git'
      ssh.exec! 'cd sonos-slack-bot/ && git pull origin master'
    end

    log 'Setting up gems' do
      ssh.exec! 'bundle install --path vendor/bundle --without test development deploy'
    end
  end
end
