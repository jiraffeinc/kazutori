require "bundler/setup"
require "kazutori"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
  ENV["REDIS_URL"] = "redis://127.0.0.1:6379/0"
  Time.zone = "Tokyo"
end
