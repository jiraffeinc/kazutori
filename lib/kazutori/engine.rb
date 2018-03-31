module Kazutori
  class Engine < ::Rails::Engine
    isolate_namespace Kazutori
    config.generators do |g|
      g.test_framework :rspec
    end
  end
end
