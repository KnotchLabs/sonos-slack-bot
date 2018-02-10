require 'bundler/setup'
require 'sonos_slack_bot'

Dir[File.join(File.expand_path('..', __FILE__), 'support', '**')].each do |file|
  require file
end

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.include Module.new do
    def redis
      Redis.new url: ENV['REDIS_URL']
    end
  end
end
