require "bundler/setup"
require "kazutori"
require 'active_model'
require 'timecop'

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

GlobalID.app = "kazutori"
class Item
  attr_reader :id
  def initialize(id)
    @id = id
  end

  def to_global_id
    GlobalID.create(Item.new(1))
  end

  def self.unscoped
    Item
  end

  def self.find_in_batches
    yield [Item.new(1)]
  end

  def self.primary_key
    :id
  end

  def _read_attribute(attr)
    instance_variable_get("@#{attr}")
  end

  def self.base_class
    Item
  end

  def marked_for_destruction?
    false
  end
end
