lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sonos_slack_bot/version'

Gem::Specification.new do |spec|
  spec.name          = 'sonos_slack_bot'
  spec.version       = SonosSlackBot::VERSION
  spec.authors       = ['Knotch']
  spec.email         = ['engineering@knotch.it']

  spec.summary       = %q{Knotch's Sonos Slack bot}
  spec.description   = %q{A Slack bot that works with Sonos. Tracks stats, favorites and other features. Built by Knotch}
  spec.homepage      = 'https://github.com/KnotchLabs/sonos_slack_bot'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'activesupport'
  spec.add_dependency 'celluloid', '~> 0.18.0.pre'
  spec.add_dependency 'celluloid-pool'
  spec.add_dependency 'celluloid-supervision'
  spec.add_dependency 'celluloid-io'
  spec.add_dependency 'celluloid-redis'
  spec.add_dependency 'slack-ruby-client'
  #spec.add_dependency 'ssdp'
  #spec.add_dependency 'sonos'

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency "rspec", "~> 3.0"
end
