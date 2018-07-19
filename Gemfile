source "https://rubygems.org"

git_source(:github) {|repo_name| "https://github.com/#{repo_name}" }

# Specify your gem's dependencies in knotch-sonos-slack-bot.gemspec
gemspec

gem 'god'
gem 'ssdp', github: 'daumiller/ssdp'
gem 'sonos', github: 'gotwalt/sonos'

group :development, :test do
  gem 'guard'
  gem 'guard-rspec'
end

group :deploy do
  gem 'net-ssh'
end
