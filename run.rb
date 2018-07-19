God.watch do |w|
  w.name = 'sonos-bot'
  w.start = 'bundle exec ./exe/sonos_slack_bot'
  w.keepalive
end
