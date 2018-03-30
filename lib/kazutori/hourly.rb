require 'kazutori/base'

module Kazutori
  class Hourly < Base
    def key_for(time)
      time.beginning_of_hour.to_i
    end
  end
end
